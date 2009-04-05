= refacebook

* http://github.com/abhiyerra/refacebook/

== DESCRIPTION:

ReFacebook is a small facebook library tailored toward usage with Sinatra.
Currently it works with fbml as that seems to be the easiest route to go.

== FEATURES/PROBLEMS:

Problems:
* Need to document the code.
* Need helpers to make life easier.
* Session needs to be stored so we can keep state without constantly recreating the ReFacebook::Session.
* Currently everything is a POST request since facebook sends a post request even if it is a get request
  to the actual app. Need to modify rack so when a "fb_sig_request_method = GET" param is received that
  we convert the actual request to GET request. 

== SYNOPSIS:

To see how to use the library please look at examples/example.rb

== REQUIREMENTS:

* Need json library.

== INSTALL:

gem sources -a http://gems.github.com
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
