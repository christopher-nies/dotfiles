#!/bin/bash

if ifconfig tun0 > /dev/null 2>&1; then
    echo "<span id='vpn-up'>VPN: up</span>"
elif ifconfig wg_config > /dev/null 2>&1; then
    echo "<span id='vpn-up'>VPN: up</span>"
else 
    echo "<span id='vpn-down'>VPN: down</span>"
fi
