# Common Abstract Data Types [![travis](https://secure.travis-ci.org/nebularis/common_adt.png)](http://travis-ci.org/nebularis/common_adt)

Some common ADTs and tests.

## Building from source

Until this project has been bootstrapped to use
[libconf](https://github.com/hyperthunk/libconf), you will need to use either
the embedded version of rebar, or compile it from source using the fork/branch
[here](https://github.com/hyperthunk/rebar/tree/econf).

First you must bootstrap the build system using the `init.config` settings.

    % rebar -C init.config get-deps compile

Then you can fetch and build all the required dependencies:

    % rebar get-deps compile

If you want to run the test suites, you can do so any time after after you've
bootstrapped, like so:

    % rebar -C test.config test -v
