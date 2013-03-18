# README

## About

vim-rubyhash is a plugin that can convert the keys of a Ruby hash literal to one of the following formats:

* symbols
* strings
* Ruby-1.9 format 

## Usage

To perform linewise conversions, the following are the default mappings:

* <Leader>rs to convert all keys to symbols
* <Leader>rt to convert all keys to strings
* <Leader>rr to convert all keys to Ruby 1.9 format

The defaults can be overridden - details in the docs.

## Caveat Emptor

The regular expressions that recognise hash keys are geared towards phrases containing only letters, numbers and
underscores. This is admittedly, very limited, but I am hoping that, for now it will suffice for 80% of use cases. 

## Installation

It is recommended that you use Pathogen and include the git repo for this plugin as a submodule in the bundle directory.

In addition, seeing as this plugin is written in Ruby, you will need a version of vim that is compiled with Ruby. An easy way to
check is to inspect the output of `vim --version` for the text `+ruby`. The plugin has been tested against Ruby-1.8.7 and should
work with 1.9.x as well, but I have yet to test this assumption.

## Acknowledgements

This plugin is based on an idea provided by [@sheldonh](https://twitter.com/#!/sheldonh). He would have built it himself, but he is 
currently busy completing his [TPS reports](http://www.youtube.com/watch?v=Fy3rjQGc6lA&feature=related).

## License

rubyhash is licensed under the MIT license

Copyright (C) 2011 by Rory McKinley

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

