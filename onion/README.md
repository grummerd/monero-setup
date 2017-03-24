**This is a work in progress. Not working yet**

Everything concerning how to allow monero-wallet-cli connect via an onion file

Install tor
-------------

    sudo apt-cache policy tor
    sudo apt-get install tor

Configure torrc
-----------------

    sudo vim /etc/tor/torrc

Find the HiddenServerDir and HiddenServicePort lines. Uncomment and change to

    HiddenServerDir /var/lib/tor/monerod-rpc
    HiddenServerPort 18081 127.0.0.1:18081
    
HiddenServerPort syntax
`HiddenServerPort [tor accessible port] [local ip]:[local port]`

tor will make `/var/lib/tor/monero-rpc` folder

From the terminal

    sudo service tor restart
    
monerod rpc onion
-------------------

Write down the .onion file name. `monero-wallet-cli` will connect to it

    sudo less /var/lib/tor/monerod-rpc/hostname
    
Configure server's firewall
-----------------------------

Check the ufw status

`sudo ufw status verbose` or `sudo ufw status numbered`

If disabled...

    sudo ufw enable

Open tor port. Router does not need any port forwarding set up

    sudo ufw allow 18081/tcp
    
ufw restart

    sudo service ufw restart

If not using ufw and using iptables, here is the same command

    sudo iptables -I OUTPUT 2 -p tcp -d 127.0.0.1 -m tcp --dport 18081 -j ACCEPT

[how to save iptables settings](http://askubuntu.com/questions/119393/how-to-save-rules-of-the-iptables)

monerod
---------

In `~/.profile`

    alias onionstart='DNS_PUBLIC=tcp TORSOCKS_ALLOW_INBOUND=1 torsocks monerod --config-file=/etc/monerod.conf --restricted-rpc --detach --no-igd --confirm-external-bind'

In terminal, `source ~/.profile`

In `/etc/monerod.conf`

    data-dir=/var/lib/monero
    log-file=/var/log/monero/monerod.log
    log-level=1
    #My server has a cpu with 8 threads. Check yours using, lscpu
    max-concurrency=7
    limit-rate-down=1000
    limit-rate-up=300
    rpc-login=[login:password]
    p2p-bind-ip=127.0.0.1
    rpc-bind-ip=127.0.0.1
    
This sets login credentials on the monerod level. It's also possible on the [onion level](https://garlicgambit.wordpress.com/2017/01/15/monero-how-to-connect-wallet-to-tor-onion-service-node/)

monero-wallet-cli
-------------------

In `~/.profile`

    WALLET="--wallet-file=$HOME/.monero/personal.xmr.wallet --password=[your wallet password]"
    MAXTHREADS="--max-concurrency=3"
    DAEMONAUTH="--daemon-login=[login:password]"
    EXTERNAL="--daemon-host=[ur .onion host]:18081"
    CLIEXTERNAL="$DAEMONAUTH $EXTERNAL --trusted-daemon"
    CLI="$HOME/Downloads/monero/build/release/bin/monero-wallet-cli"
    CLILOG="--log-level=1 --log-file=$HOME/.monero/cli.log"
    alias cli="torsocks $CLI $CLILOG $CLIEXTERNAL $WALLET $MAXTHREADS"

In terminal, `source ~/.profile`

To open monero cli wallet which connects using the onion host  

    cli

monero GUI
-------------

`torsocks ./start-gui.sh --daemon-host [tor-hostname.onion]`

trouble shooting
------------------

Will lists the tor control port #. Which seems to be randomized. Was hoping to find 9050 in this list. But no luck

    sudo netstat -anp | grep LISTEN
    
Test torsocks is working

    torsocks curl --silent https://check.torproject.org/ | grep Congratulations

[Ubuntu Using tor beginner guide](https://www.linux.com/blog/beginners-guide-tor-ubuntu)

[Source](https://people.debian.org/~lunar/blog/posts/tor_only_outgoing_firewall/)

Guy with same error

[torsocks monerod Operation not permitted](https://bitcointalk.org/index.php?topic=583449.msg11649248#msg11649248)
[torsocks monerod more verbose errors](https://bitcointalk.org/index.php?topic=583449.msg11650205#msg11650205)
[tor not torsocks solution](https://bitcointalk.org/index.php?topic=583449.msg11657029#msg11657029)

[route dns thru tor](https://trac.torproject.org/projects/tor/wiki/doc/TransparentProxy#TransparentlyDoingDNSandRoutingfor.onionTraffic)

Added to `/etc/ufw/before.rules`
Before section "allow all on loopback"
    
    -A ufw-before-output -t nat -p tcp -d 10.192.0.0/10 -j REDIRECT --to-ports 9040
    
