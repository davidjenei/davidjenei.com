tags: #linux #terminal
title: Shell scripts
description: I found these useful at some point

Shell script
============

Some links
----------

* http://shellhaters.org/
* https://www.usenix.org/sites/default/files/conference/protected-files/lisa19_maheshwari.pdf
* https://github.com/jlevy/the-art-of-command-line

Daemon
------

    #!/bin/sh
    
    PID="/var/run/my-script.pid"
    DAEMON="/root/my-script.sh"
    
    case "$1" in
    start)
    	start-stop-daemon -S -b -m -p $PID -a $DAEMON
    	[ $? = 0 ] && echo "OK" || echo "FAIL"
    	;;
    stop)
    	start-stop-daemon -K -p $PID
    	[ $? = 0 ] && echo "OK" || echo "FAIL"
    	;;
    restart | reload)
    	"$0" stop
    	"$0" start
    	;;
    *)
    	echo "Usage: $0 {start|stop|restart}"
    	exit 1
    	;;
    esac
    exit $?

S11firstboot
------------

    #!/bin/sh

    LOGGER_TAG=firstboot
    FLAG=/mnt/data/.firstboot

    test -f $FLAG && exit

    case "$1" in
    start)
    	# perform setup steps, extend data partition, etc.
    	touch $FLAG && sync
    	;;
    *)
    	echo "Usage: $0 {start}"
    	exit 1
    	;;
    esac

    exit $?

S20qmi
------

    #!/bin/sh

    NAME=modem
    CONFIG=/etc/qmi-network.conf

    if [ ! -f $CONFIG ]; then
    	logger -t $NAME -s "$CONFIG is not found"
    	exit 1
    fi

    . $CONFIG || logger -t $NAME -s "Failed to load $CONFIG"

    if [ -z "$PIN" ]; then
    	logger -t $NAME -s "PIN is not defined in $CONFIG"
    	exit 1
    fi

    verify_pin() {
    	logger -s -t $NAME "Verifying PIN code (--dms-uim-verify-pin)..."
    	set -o pipefail
    	qmicli -d /dev/cdc-wdm0 --dms-uim-verify-pin=PIN,${PIN} 2>&1 | logger -t $NAME
    	if [ $? != 0 ]; then
    		logger -s -t $NAME "Pin verification: FAIL, retry (--uim-verify-pin)..."
    	fi
    	qmicli -d /dev/cdc-wdm0 --uim-verify-pin=PIN1,${PIN} 2>&1 | logger -t $NAME
    	if [ $? != 0 ]; then
    		logger -s -t $NAME "Pin verification: FAIL, exiting..."
    		exit 1
    	fi
    }

    signal_strength() {
    	qmicli -d /dev/cdc-wdm0 --nas-get-signal-strength 2>&1 | logger -t $NAME
    }

    set_raw_ip() {
    	qmicli -d /dev/cdc-wdm0 --device-open-sync --wda-set-data-format=raw-ip 2>&1 |
    		logger -t $NAME
    }

    case "$1" in
    start)
    	for _ in $(seq 1 5); do
    		test -c /dev/cdc-wdm0 && break
    		sleep 1
    		logger -t $NAME -s "Waiting for modem device..."
    	done

    	if [ -f /dev/cdc-wdm0 ]; then
    		logger -s -t $NAME "Modem device is not found"
    		exit 1
    	fi

    	verify_pin
    	signal_strength
    	set_raw_ip
    	;;
    stop) ;;

    restart | reload)
    	"$0" stop
    	qmicli -d /dev/cdc-wdm0 --uim-sim-power-off=1 | logger -t $NAME
    	qmicli -d /dev/cdc-wdm0 --uim-sim-power-on=1 | logger -t $NAME
    	sleep 1
    	"$0" start
    	;;
    *)
    	echo "Usage: $0 {start|stop|restart}"
    	exit 1
    	;;
    esac

    exit $?

S41wpa
------

    #!/bin/sh

    DAEMON_VERBOSITY="--quiet"

    WPA_IFACE="wlan0"
    WPA_SUP_PNAME="wpa_supplicant"
    WPA_SUP_BIN="/usr/sbin/wpa_supplicant"
    WPA_SUP_PIDFILE="/var/run/wpa_supplicant.${WPA_IFACE}.pid"
    WPA_SUP_OPTIONS="-s -B -P $WPA_SUP_PIDFILE -i $WPA_IFACE -D nl80211,wext"
    WPA_SUP_CONF="-c /etc/wpa_supplicant.conf"

    WPA_CLI_PNAME="wpa_cli"
    WPA_CLI_BIN="/usr/sbin/wpa_cli"
    WPA_CLI_PIDFILE="/var/run/wpa_action.${WPA_IFACE}.pid"
    WPA_CLI_OPTIONS="-B -P $WPA_CLI_PIDFILE -i $WPA_IFACE"
    WPA_ACTION_SCRIPT="/etc/network/wpa_action"

    start() {
    	start-stop-daemon --start --oknodo $DAEMON_VERBOSITY \
    		--name $WPA_SUP_PNAME --startas $WPA_SUP_BIN --pidfile $WPA_SUP_PIDFILE \
    		-- $WPA_SUP_OPTIONS $WPA_SUP_CONF
    	if [ "$?" -ne 0 ]; then
    		logger -s -t $WPA_SUP_PNAME "Couldn't start WPA supplicant"
    		return 1
    	fi
    	start-stop-daemon --start --oknodo $DAEMON_VERBOSITY \
    		--name $WPA_CLI_PNAME --startas $WPA_CLI_BIN --pidfile $WPA_CLI_PIDFILE \
    		-- $WPA_CLI_OPTIONS -a $WPA_ACTION_SCRIPT
    	if [ "$?" -ne 0 ]; then
    		logger -s -t $WPA_CLI_PNAME "Couldn't start WPA cli"
    		return 1
    	fi
    }
    stop() {
    	start-stop-daemon --stop --oknodo $DAEMON_VERBOSITY \
    		--exec $WPA_SUP_BIN --pidfile $WPA_SUP_PIDFILE
    	if [ -f "$WPA_SUP_PIDFILE" ]; then
    		rm -f "$WPA_SUP_PIDFILE"
    	fi
    	start-stop-daemon --stop --oknodo $DAEMON_VERBOSITY \
    		--exec $WPA_CLI_BIN --pidfile $WPA_CLI_PIDFILE
    	if [ -f "$WPA_CLI_PIDFILE" ]; then
    		rm -f "$WPA_CLI_PIDFILE"
    	fi
    }
    reload() {
    	start-stop-daemon --stop --signal HUP \
    		--name "$WPA_SUP_PNAME" --pidfile "$WPA_SUP_PIDFILE"
    }

    case "$1" in
    start)
    	start
    	;;
    stop)
    	stop
    	;;
    reload)
    	reload
    	;;
    *)
    	echo "Usage: $0 {start|stop|reload}"
    	exit 1
    	;;
    esac

    exit $?

## fbv-animation

```
#!/bin/sh

DELAY=1.5
SPLASH=/usr/local/splash/
LOGGER_TAG="animate"

log "Start animation: $1"

# set 720p framebuffer
fbset -s | grep -q 'geometry 1280 720' && return
fbset -g 1280 720 1280 720 32

while true; do
	# display single splash
	if [[ -f ${SPLASH}${1}.jpg ]]; then
		sleep $DELAY | fbv -d 0 ${SPLASH}${1}.jpg
	else
		# display animation
		sleep $DELAY | fbv -f -d 0 ${SPLASH}${1}-1.jpg
		sleep $DELAY | fbv -f -d 0 ${SPLASH}${1}-2.jpg
		sleep $DELAY | fbv -f -d 0 ${SPLASH}${1}-3.jpg
	fi
done
```
