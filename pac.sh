#!/bin/bash
update() {
	old=`cat phone.pac`
	new="function FindProxyForURL(url, host) { return \"PROXY $1\"; }"
	if [[ "$old" != "$new" ]]; then
		echo $new > phone.pac
		git add phone.pac
		git commit -m "pac -> $1"
		git push
	fi
}
proxy="DIRECT"
if [[ "$1" == "on" ]]; then
	ip=`ifconfig|grep inet|grep netmask|grep broadcast|awk '{print $2}'`
	proxy=$ip:8888
fi
update $proxy
