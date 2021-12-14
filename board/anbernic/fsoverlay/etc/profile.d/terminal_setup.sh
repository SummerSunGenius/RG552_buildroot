# Set vt100 as terminal enviroment
TERM=vt100

# Add ANBERNIC logo and some alias, sourcing of $HOME/.bashrc can be added to $HOME/.profile
echo '

    _          _                     _
   / \   _ __ | |__   ___ _ __ _ __ (_) ___
  / _ \ | |_ \| |_ \ / _ \  __|  _ \| |/ __|
 / ___ \| | | | |_) |  __/ |  | | | | | (__
/_/   \_\_| |_|_.__/ \___|_|  |_| |_|_|\___|

                   RK3399
'
echo
echo "-- type 'anbernic-check-updates' to check for stable branch --"
echo "-- add 'beta' switch to check for latest arch developments  --"
echo
anbernic-info 2>/dev/null
echo "OS version: $(cat /usr/share/anbernic/anbernic.version)"
echo

# ---- ALIAS VALUES ----
alias mc='mc -x'
alias anbernic-check-updates='anbernic-es-swissknife --update'
