monerod Tor setup
-------------------

**This is a work in progress**

Advantages
-------------

- The advantage of tor over rpc is wallets can connect to server from anywhere. Both on the same network as the server and remote connections

- tor onions are not linked to ip address. Home networks IP addresses may change. Murphys law. It'll happen. We want to be remote, so need to severe the chains of being tied down to an IP address

Once (korvi) i2p support comes out, use that, not tor. In the meantime, lets piece together how to configure monerod server and cli wallet thru tor

p2pstate.bin (Tor session)
----------------------------

Each daemon has a node ID stored in the p2pstate.bin file. If you switch between Tor and clearnet, this node ID can be used to link the two, associating an IP address with your Tor session.

To avoid this issue either:

    Always run over Tor, never over clearnet (not even one time); or
    When switching between Tor and clearnet (in either direction), delete the p2pstate file. This will generate a brand new random node ID.

Even when using method No. 1 you still may wish to periodically delete p2pstate.bin to avoid having your Tor sessions potentially associated with each other

[Source](https://www.reddit.com/r/Monero/comments/4z3ced/guide_to_using_monero_with_tor_correctly/)

links
-------
[monerod / tor instructions](https://github.com/monero-project/monero#using-tor)

[Some guidence on monerod & whonix](https://github.com/moneroexamples/compile-monero-whonix)

[Whonix](https://www.whonix.org/wiki/Comparison_with_Others)
--------

Its the gateway that makes it so powerful.

Tails is made to boot your system up as the host operation system, where all internet connections at a lower level go through a TOR gateway only.

Whonix is two virtual machines, one is the gateway that connects to TOR, and the other is an OS where all connections go through the gateway. So the result is similar such that everything you do is going through TOR, and nothing can escape the double VM sandbox.

Whonix is convenient in that it can be run in a window, in your normal OS, not interrupting your faster clearnet activities.

Running Tails in a VM would be dangerous.

[Source](https://www.reddit.com/r/Monero/comments/4z3ced/guide_to_using_monero_with_tor_correctly/)
