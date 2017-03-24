# Configure server's firewall
This doesn't configure the router. Which will also need to do

Run the following commands from the terminal
```
sudo ufw enable
sudo ufw allow 53/udp
sudo ufw allow 18080/tcp
sudo ufw allow 18081/tcp
```

Run this command to see firewall rules
`sudo ufw status verbose`

Status: active

Logging: on (low)

Default: deny (incoming), allow(outgoing), disabled (routed)

New Profiles: skip


| To | Action | From |

| __ | _____ | ____ |

| 53 | ALLOW IN | Anywhere |

| 18080 | ALLOW IN | Anywhere |

| 18081 | ALLOW IN | Anywhere |

| 53 (v6) | ALLOW IN | Anywhere (v6) |

| 18080 (v6) | ALLOW IN | Anywhere (v6) |

| 18081 (v6) | ALLOW IN | Anywhere (v6) |


If need to restart ufw

    sudo service ufw restart
