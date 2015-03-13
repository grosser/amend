Data amend service ... for when yu have multiple servers that need to share something.

Just `curl -X POST -d whatever https://amend.herokuapp.com/amend/some_random_key` as much as you want<br/>
and get it back with `curl https://amend.herokuapp.com/amend/some_random_key`<br/>
up to ~1MB and as long as the cache holds ...

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/amend.png)](https://travis-ci.org/grosser/amend)
