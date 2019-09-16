# SWAPI
  [![Build Status](https://www.travis-ci.com/Guernik/swapi.svg?branch=master)](https://www.travis-ci.com/Guernik/swapi)  
  
  Simple erlang application, implemented as [escript](http://erlang.org/doc/man/escript.html), that given two star wars characters, returns a list of movies both have in common.  
  Data sources is [The Star Wars Api](https://swapi.co/)  


## Prerequsites
You should have the following installed in your system in order to run this application
- [Erlang/OTP 22](https://www.erlang.org/downloads/22.0)
- make
### Dependencies
  Jiffy 1.0.1 is used as json parser.
  It is already included in the repo, you just have to compile it.

## How to build
- First, clone the repo and compile jiffy
 ~~~
 $> git clone https://github.com/guernik/swapi.git
 $> cd swapi/deps/jiffy
 $> rebar3 compile
 ~~~
- Now, compile the source files, and give execution permissions to main erl file
~~~
swapi $> erlc src/http_reqs.erl src/utils.erl src/sw_data.erl
swapi $> chmod a+x swapi.erl
~~~
- The erlang script is now ready to run
 
## Unit tests
To run unit tests:
~~~
swapi $> rebar3 eunit
swapi $> ...
swapi $> Finished in 4.677 seconds
swapi $> 3 tests, 0 failures
~~~

## Usage
* Sample usage:
~~~
swapi $> ./swapi.erl luke c-3po
swapi $>   A New Hope
swapi $>   The Empire Strikes Back
swapi $>   Return of the Jedi
swapi $>   Revenge of the Sith
~~~

* If you want to pass a character with whitespaces, use quotes:
~~~
swapi $> ./swapi.erl "Luke Sky" "Owen Lars"
swapi $>   A New Hope
swapi $>   Revenge of the Sith
~~~

## Validations
 The program makes the following validations:
  - Correct number of parameters
  ~~~
  swapi $> ./swapi.erl luke
  swapi $>  usage: swapi Character AnotherCharacter
  swapi $>  ie: swapi luke leia
  swapi $>  swapi "luke sky" leia
  ~~~
  - Valid Star Wars Characters
  ~~~
  swapi $> ./swapi.erl "Harry Potter" "Spock"
  swapi $>  No Star Wars character found for "Harry Potter"
  swapi $>  No Star Wars character found for "Spock"
  ~~~

