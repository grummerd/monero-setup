This is a step-by-step guide on setting up monerod server

You will be able to run monerod either in internal network or external network modes. But not both at the same time

Minimum System Requirements
------------------------------

- ubuntu server amd64 (meaning 64bit OS) 16.04 xenial LTS

- 500GB ssd (not an usb)

Blockchain takes up ~ 200GB

- 8GB RAM

- Kickass CPU (i have 8 threads)

Get monerod
------------------------------

Use `git clone [repository url]` don't download the repository! I made that mistake.

Install the dependancies
------------------------------

[Follow the instructions](https://github.com/monero-project/monero)

If you followed the System Requirements section, the the minimum versions of each dependancy will be available

Shows installed/available versions

`sudo apt-cache policy [package name]`

Install dependency package

`sudo apt-get install -y [package name]`

Install monero
------------------------------

`cd monero`

`sudo monero -j3`

j (Total Amount of RAM / 2GB) -1 . Is the max # of threads you can compile with.
For me, 8GB / 2GB = 4 - 1 = 3. My CPU has 8 threads. Compiled using 3 threads
 
 Setup static IP
 ------------------------------
 
 `sudo vim /etc/network/interfaces`
 
 [/etc/network/interfaces](https://github.com/grummerd/monero-setup/blob/master/server/etc/network/interfaces)
 
 `ifconfig` to show updated network interfaces
 
 Setup monerod config file
 ------------------------------
  
 `sudo vim /etc/monerod.conf`
 
 [/etc/monerod.conf](https://github.com/grummerd/monero-setup/blob/master/server/etc/monerod.conf)

[Credit](http://monero.stackexchange.com/questions/3063/no-igd-port-mapping)

 Make some alias in `~/.profile`
 ------------------------------
  
 `vim ~/.profile`
 
 [~/.profile](https://github.com/grummerd/monero-setup/blob/master/server/home/yourusername/.profile)
 
 `source ~/.profile`
 
 You will now have the commands: `monerodstart`, `monerodstartnodetach`, `monerodstop`
 
 Open ports in server's firewall
 ------------------------------
 
 [ufw configuration](https://github.com/grummerd/monero-setup/blob/master/server/ufw.md)
 
 Port forwarding in router
 ------------------------------
 
 [router configuration](https://github.com/grummerd/monero-setup/blob/master/server/router.md)
 
 start monerod
 ------------------------------
 
 `monerodstartnodetach`
 
 Took ~3 hours to sync. Had to stop (Ctrl+c), a few times. If you are getting nothing but ERRORS and no sync status INFO msgs. 
 Stop the sync and restart
 
 monerod log file
 ------------------------------
 
 `sudo cat /var/log/monero.log | less`
 
 View last 50 lines
 
 `sudo cat /var/log/monero.log | tail -n 50 | less`
 
 delete monerod log file
 ------------------------------
 
 This will empty the log file. Do this before running a configuration test
 
 ```
 sudo rm -rf /var/log/monero.log
 sudo touch /var/log/monero.log
 ```
Mitigate bandwidth limitations
-------------------------------

[Default monerod bandwidth usage limits](https://github.com/monero-project/monero/blob/master/src/p2p/net_node.inl)

- Upload 2048 KB/s

- Download 8192 KB/s

On a slow network, these defaults can prevent web access by everyone else on the same network

To prevent hysterical phone calls at inappropriate hours, lets determine what to set these values to. We care about resource limitations, not the philosophical question about other extreme.

Install speedtest -- web bandwidth tester (cli)

```
sudo apt-cache policy python-pip
sudo apt-get install python pip
pip install speedtest-cli
speedtest --bytes
```

These are a real example results (before running monerod)

    Retrieving speedtest.net configuration...
    Testing from J:COM ([external ip address])...
    Retrieving speedtest.net server list...
    Selecting best server based on ping...
    Hosted by satoweb (Sakai) [13.02 km]: 177.248 ms
    Testing download speed................................................................................
    Download: 4.94 Mbyte/s
    Testing upload speed....................................................................................................
    Upload: 0.66 Mbyte/s

Assuming speedtest is accurate enough, guessimated 1MBytes/sec download and 300KBytes/sec upload can be dedicated to monerod without crippling other users' web access

In `/etc/monerod.conf` set

```

limit-rate-down=1000
limit-rate-up=300

```

These are real example results with this configuration and while running `monerod`

    Retrieving speedtest.net configuration...
    Testing from J:COM ([external ip address])...
    Retrieving speedtest.net server list...
    Selecting best server based on ping...
    Hosted by rxy (individual) (Osaka) [1.83 km]: 181.656 ms
    Testing download speed................................................................................
    Download: 2.46 Mbyte/s
    Testing upload speed....................................................................................................
    Upload: 0.36 Mbyte/s

Lets see what bandwidth is left for other users

**DOWNLOAD**
4.94 - 1.00 = 3.94 MBytes/sec

Yet speedtest says **2.46M Bytes/sec** remain

**UPLOAD**

0.66 - 0.30 = 0.36 MBytes / sec

Speedtest also reports **0.36 MBytes / sec**

**Conclusion**

Could we set the bandwidth consumption a little higher? Maybe. We can be sure now that `monerod` bandwidth consumption is under control. And the disaster of bringing the network to it's knees has been averted.
