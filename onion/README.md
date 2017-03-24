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

If not using ufw and using iptables, here is the same command

    sudo iptables -I OUTPUT 2 -p tcp -d 127.0.0.1 -m tcp --dport 18081 -j ACCEPT

[how to save iptables settings](http://askubuntu.com/questions/119393/how-to-save-rules-of-the-iptables)

monerod
---------

In `~/.profile`

    alias onionstart='DNS_PUBLIC=tcp TORSOCKS_ALLOW_INBOUND=1 torsocks monerod --config-file=/etc/monerod.conf --restricted-rpc --detach --no-igd --confirm-external-bind'

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

`torsocks ./monero-wallet-cli --daemon-host [tor-hostname.onion]`

monero GUI
-------------

`torsocks ./start-gui.sh --daemon-host [tor-hostname.onion]`
