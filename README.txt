= refacebook

* http://github.com/abhiyerra/refacebook/

== DESCRIPTION:

ReFacebook is a small facebook library tailored toward usage with Sinatra.
Currently it works with fbml as that seems to be the easiest route to go.

== TODO:

* Need to document the code.
* Need helpers to make life easier.
* Abstract the session store so it's not reliant on the set and get. Also,
  remove the :store option eventually since that seems like a copout method
  and doesn't add simplicity. 
* Make the api spit out an exception if call returns error.
* Have a better example application with fbml, api, and all that good stuff.
* Write unit tests
* Test with ruby 1.9, remove json dep if 1.9 since json is included.


== SYNOPSIS:

To see how to use the library please look at examples/example.rb

== REQUIREMENTS:

RubyGems
* json
* memcache-client

== INSTALL:

sudo gem sources -a http://gems.github.com
sudo gem install abhiyerra-refacebook

== LICENSE:

(The MIT License)

Copyright (c) 2009 Abhi Yerra <abhi@traytwo.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
