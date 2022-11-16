require 'sinatra'


STORE =
  if (redis = ENV["REDIS_SERVERS"])
    require 'redis'
    Redis.new(url: redis)
  else
    require 'dalli'
    %w[SERVERS USERNAME PASSWORD].each { |k| ENV["MEMCACHE_#{k}"] ||= ENV["MEMCACHIER_#{k}"] }
    Dalli::Client.new(nil, compress: true)
  end

def lock(key)
  lock = "#{key}.lock"
  sleep 0.01 until STORE.add(lock, '1', 10) # get the lock
  yield
ensure
  STORE.delete(lock)
end

get "/" do
  headers('Content-Type' => "text/plain")
  "Welcome to amend\nsource is at https://github.com/grosser/amend\njust `curl -X POST -d whatever /amend/some_random_key` as much as you want\nand get it back with curl /amend/some_random_key\nup to ~1MB and as long as the cache holds ..."
end

get "/favicon.ico" do
  halt 404
end

post "/amend/:key" do
  key = params.fetch("key")
  data = request.body.read
  if STORE.respond_to?(:append)
    total = STORE.append(key, data)
    "Amended key #{key} with #{data.bytesize} bytes to be #{total} bytes"
  else
    lock key do
      old = STORE.get(key).to_s
      STORE.set(key, old + data)
      "Amended key #{key} which was #{old.bytesize} bytes with #{data.bytesize} bytes"
    end
  end
end

get "/amend/:key" do
  STORE.get(params.fetch("key"))
end
