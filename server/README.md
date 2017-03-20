This is a step-by-step guide on setting up monerod server

You will be able to run monerod either in internal network or external network modes. But not both at the same time

Minimum System Requirements
------------------------------

- ubuntu server amd64 (meaning 64bit OS) 16.04 xenial LTS

- 500GB ssd (not an usb)

Blockchain takes up ~ 200GB

- 8GB RAM

- Kickass CPU (i have 8 threads)

- Install monerod
Use `git clone [repository url]` don't download the repository! I made that mistake.


Follow the instructions
https://github.com/monero-project/monero
- Install the dependancies

- Install monero

`cd monero`

`sudo monero -j3`

j (Total Amount of RAM / 2GB) -1 . Is the max # of threads you can compile with.
For me, 8GB / 2GB = 4 - 1 = 3. My CPU has 8 threads. Compiled using 3 threads
 
 - Setup static IP
 sudo vim /etc/network/interfaces
 
 https://github.com/grummerd/monero-setup/blob/master/server/etc/network/interfaces 
 
 - Setup monerod config file
 
 `sudo vim /etc/monerod.conf`
 
 https://github.com/grummerd/monero-setup/blob/master/server/etc/monerod.conf
 
 - Make some alias in ~/.profile
 
 `vim ~/.profile`
 
 https://github.com/grummerd/monero-setup/blob/master/server/home/yourusername/.profile
 
 `source ~/.profile`
 
 You will now have the commands: `monerodstart`, `monerodstartnodetach`, `monerodstop`
 
 - Open ports in server's firewall
 
 https://github.com/grummerd/monero-setup/blob/master/server/ufw.md
 
 - Port forwarding in router
 
 https://github.com/grummerd/monero-setup/blob/master/server/router.md
 
 - start monerod
 
 `monerodstartnodetach`
 
 Took ~3 hours to sync. Had to stop (Ctrl+c), a few times. If you are getting nothing but ERRORS and no sync status INFO msgs. 
 Stop the sync and restart
 
 - monerod log file
 
 `sudo cat /var/log/monero.log | less`
 
 View last 50 lines
 
 `sudo cat /var/log/monero.log | tail -n 50 | less`
 
 - delete monerod log file
 
 This will empty the log file. Do this before running a configuration test
 
 ```
 sudo rm -rf /var/log/monero.log
 sudo touch /var/log/monero.log
 ```
