Client laptop setup
---------------------

Minimum Requirements
----------------------

- lubuntu 16.04 LTS or better
The dependencies are often a little ahead of ubuntu. libboost-all-dev v1.9 works although monero web site says v2.0

If you try to install lubuntu 14.04 LTS it won't end well. Old Ubuntu releases dependency packages versions are often behind later ubuntu releases.

Don't waste your time finding this out.

Time saved: 1 day

- OS on usb2 or better. 32GB usb is enough. Don't buy the cheapest one

- laptop `Lenovo Thinkpad` hereinafter referred to as `the Frisbee`

Cuz if it ever breaks: remove usb, throw out bldg window. Buy new Frisbee. Put in usb. In BIOS, make usb bootable. Forget about old Frisbee

Do not attempt to run `monerod` on a Frisbee. The Frisbee is way under spec for that. Plus `the hole point is` to be **mobile**. 

Get out of the house. Live life!!

Monero install
--------------

Follow server setup instructions

- install dependencies

https://github.com/grummerd/monero-setup/tree/master/server#install-the-dependancies

- install monero

https://github.com/grummerd/monero-setup/tree/master/server#install-monero

Setup alias in `~/.profile`
-----------------------------

https://github.com/grummerd/monero-setup/blob/master/client/.profile

All the config is in `~/.profile`

There is no `config-file`

In ~/.profile, replace

- `[your external ip]`

- `[your wallet password]`

- Change networks
On the line which begins with, `alias cli...`, can switch out $CLIINTERNAL <--> $CLIEXTERNAL
So internal network same as the server use $CLIINTERNAL
Outside seeing the world, teaching the bitchez what monero is, $CLIEXTERNAL

- rpc login
If the rpc monero server has this setup (in /etc/monerod.conf), uncomment `DAEMONAUTH` and set the login:password

START Wallet!!
------------------

cli
