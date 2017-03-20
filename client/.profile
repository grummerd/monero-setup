# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

################################
# common xmr options
################################
WALLET="--wallet-file=$HOME/.monero/personal.xmr.wallet --password=[your wallet password]"
MAXTHREADS="--max-concurrency=3"
#DAEMONAUTH="--daemon-login=[login:passwd]"
INTERNAL="--daemon-address=192.168.11.253:18081"
EXTERNAL="--daemon-address=[your external ip]:18081"
CLIINTERNAL="$DAEMONAUTH $INTERNAL --trusted-daemon"
CLIEXTERNAL="$DAEMONAUTH $EXTERNAL --trusted-daemon"

RPCINTERNAL="$DAEMONAUTH $INTERNAL --trusted-daemon"
RPCEXTERNAL="$DAEMONAUTH $EXTERNAL --trusted-daemon"

################################
# Create new xmr wallet
################################

CLI="$HOME/Downloads/monero/build/release/bin/monero-wallet-cli"
#CREATEWALLET="--generate-new-wallet=$HOME/.monero/personal.xmr.wallet --password=[yourpassword]"
CLILOG="--log-level=1 --log-file=$HOME/.monero/cli.log"
# To switch from internal network to outside network (aka the big wide world)
# Change CLIEXTERNAL < --- > CLIINTERNAL
alias cli="$CLI $CLILOG $CLIEXTERNAL $WALLET $MAXTHREADS"
