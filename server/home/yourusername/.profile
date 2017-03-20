# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

#if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# ^^ Above code is the original. I removed some comments
# Below code is what is pertains to monero. Ignore the stuff above

# If repository downloaded
PATH="$PATH:$HOME/Downloads/monero-master/build/release/bin"

# If repository cloned (git clone https://...)
#PATH="$PATH:$HOME/Downloads/monero/build/release/bin"

# Since server will run rpc, calls to monerod require rpc ip, port, and maybe login
# Edit /etc/monerod.conf to switch ip & port for connecting  to internal network < -- > external network
MONEROPREFIX="sudo monerod --config-file=/etc/monerod.conf"
alias monerodstart='$MONEROPREFIX --detach --no-igd --confirm-external-bind' # --restricted-rpc
alias monerodstartnodetach='$MONEROPREFIX --confirm-external-bind --no-igd'
alias monerodstop='$MONEROPREFIX exit'
