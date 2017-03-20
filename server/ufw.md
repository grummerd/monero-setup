# Configure server's firewall
This doesn't configure the router. Which will also need to do

Run the following commands from the terminal
```
sudo ufw enable
sudo ufw allow 53/udp
sudo ufw allow 18080/tcp
sudo ufw allow 18081/tcp
```
