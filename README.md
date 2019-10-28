workshop
=====

A GRiSP application

Build
-----

Building VM from source
-----------------------

```bash
$ rebar3 grisp build --clean true --configure true
$ rebar3 compile
```

Local dependencies
-----

In the root directory of the project :

```bash
$ mkdir _checkouts && cd _checkouts
$ git clone https://github.com/grisp/rebar3_grisp
$ git clone https://github.com/grisp/grisp_tools
```
Deploy
------

`$ rebar3 grisp deploy -n=<name> -v=<vsn>`

Connecting over Wifi to the GRiSP board
---------------------------------------

You need to modify some files in [grisp/grisp_base/files](https://github.com/achlysproject/workshop/tree/master/grisp/grisp_base/files) :

- erl_inetrc :
    - in the line 4 `{host, {X,X,X,X}, ["<host>"]}.`, replace `{X,X,X,X}` by your local ip address, for example `{192,168,1,57}`, and `<host>` by the hostname of you computer (you can see it with the command `$ hostname -s`)
- grisp.ini.mustache :
    - in line 5 replace `MyCookie` by your own cookie
    - in line 10 replace `my_grisp_board` by your own grisp board name
- wpa_supplicant.conf :
    - replace `<wifi_name>` by your wifi name (this name is case sensitive)
    - replace `<pwd>` by your wifi password

You also need to add to the `/etc/hosts/` file:
```
X.X.X.X my_grisp_board
```
where `X.X.X.X` is the local ip of your grisp_board and `my_grisp_board` the name you give to it.

Then to connect to a board you need to enter this command in a command prompt:

``` bash
$ erl -sname my_remote_shell -remsh project@my_grisp_board -setcookie MyCookie
```
by replacing *project*, *my_grisp_board* and *MyCookie* with you own values.