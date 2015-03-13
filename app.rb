require 'sinatra'
require 'dalli'

%w[SERVERS USERNAME PASSWORD].each { |k| ENV["MEMCACHE_#{k}"] ||= ENV["MEMCACHIER_#{k}"] }
STORE = Dalli::Client.new(nil, compress: true)

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

post "/amend/:key" do
  key = params.fetch("key")
  data = request.body.read
  lock key do
    old = STORE.get(key).to_s
    STORE.set(key, old + data)
    "Amended key #{key} which was #{old.bytesize} bytes with #{data.bytesize} bytes"
  end
end

get "/amend/:key" do
  STORE.get(params.fetch("key"))
end
