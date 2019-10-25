workshop
=====

A GRiSP application

Build
-----

Building VM from source
-----------------------
    
    $ rebar3 grisp build --clean true --configure true
    $ rebar3 compile

Local dependencies
-----

In the root directory of the project : 

    $ mkdir _checkouts && cd _checkouts
    $ git clone https://github.com/grisp/rebar3_grisp
    $ git clone https://github.com/grisp/grisp_tools

Deploy
------

    $ rebar3 grisp deploy -n=name -v=vsn
