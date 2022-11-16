Data amend service ... for when you have multiple servers that need to share something.
Not race-condition safe, but it kinda works :)

```
curl -X POST -d $'foo\n' https://amend.onrenderapp.com/amend/some_random_key
# => Amended key some_random_key which was 0 bytes with 4 bytes

curl -X POST -d $'bar\n' https://amend.onrenderapp.com/amend/some_random_key
# => Amended key some_random_key which was 4 bytes with 4 bytes

curl https://amend.onrender.com/amend/some_random_key
# => foo
# => bar
```

for bigger things, write them to a file and upload the file content:

```
curl -X POST --data-binary @data.log https://amend.onrenderapp.com/amend/some_random_key
```

up to ~1MB and as long as the cache holds ... for infinite cache use https://github.com/anamartinez/large_object_store

# Testing

Memcached: `rake test`
Redis: `REDIS_SERVERS=redis://127.0.0.1:6379 rake`

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT
