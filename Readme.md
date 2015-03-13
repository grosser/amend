Data amend service ... for when yu have multiple servers that need to share something.

```
curl -X POST -d whatever https://amend.herokuapp.com/amend/some_random_key
# => Amended key some_random_key which was 0 bytes with 8 bytes

curl -X POST -d whatever https://amend.herokuapp.com/amend/some_random_key
# => Amended key some_random_key which was 8 bytes with 8 bytes

curl https://amend.herokuapp.com/amend/some_random_key
# => whateverwhatever
```

up to ~1MB and as long as the cache holds ...

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/amend.png)](https://travis-ci.org/grosser/amend)
