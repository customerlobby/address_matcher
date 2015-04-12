# Address Matcher

## What's in an address?

Are `123 Main St., Smalltown, RI` and `123 Main Street, Smalltown, RI` the same
address? `==` says `false`, but `human intuition` says yes. This gem leverages
the excellent [geocoder gem](https://github.com/alexreisner/geocoder) to make a
more educated guess by comparing lat/long of two addresses and returning `true`
if they are close enough.

## Usage

`$ gem install address_matcher`

`require address_matcher`

Create an `AddressLibrary` with all of the "known" address strings that you want
to match against:

```ruby
addresses = ['30 Lincoln Center Plaza, New York, NY 10023',
            '1000 5th Ave, New York, NY 10028',
            '1001 5th Avenue, New York, NY 10028',
            '1002 5th Avenue, New York, NY 10028'
            ]

library = AddressLibrary.build(addresses)
```

Then simply call `match` to find the closest matching address:

```ruby
library.match('1000 5th Avenue, New York, NY 10028')
#=> 1000 5th Ave, New York, NY 10028
```

## License
### MIT

```
Copyright (c) 2015 Stuart Terrett

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
