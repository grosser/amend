Data amend service ... for when yu have multiple servers that need to share something.

```
curl -X POST -d $'foo\n' https://amend.herokuapp.com/amend/some_random_key
# => Amended key some_random_key which was 0 bytes with 4 bytes

curl -X POST -d $'bar\n' https://amend.herokuapp.com/amend/some_random_key
# => Amended key some_random_key which was 4 bytes with 4 bytes

curl https://amend.herokuapp.com/amend/some_random_key
# => foo
# => bar
```

for bigger things, write them to a file and upload the file content:

```
curl -X POST --data-binary @data.log https://amend.herokuapp.com/amend/some_random_key
```

up to ~1MB and as long as the cache holds ...

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/amend.png)](https://travis-ci.org/grosser/amend)
