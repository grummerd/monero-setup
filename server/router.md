# port forwarding

| name | external port / protocol | internal ip / port / protocol |

| monerop2p | 18080 tcp | 192.168.11.253 18080 tcp |

| monerorpc | 18081 tcp | 192.168.11.253 18081 tcp |

| dns       | 53 udp    | 192.168.11.253 53 udp |

Setup port forwarding with the above settings

On my router (BBR-4HG), to setup port forwarding is
1. Click Advanced button
2. Click Network Settings -> Port forwarding
3. Add
4. Save

# What is open port

`Open port` means the router and your computer are allowing packets thru **AND** there is a daemon running/listening on that port
Only then will a port scanner show those ports as open
