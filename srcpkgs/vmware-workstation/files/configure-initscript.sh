#!/bin/sh

action="$1" # add, remove, or status
serviceName="$2"
startLevel="$3"
stopLevel="$4"

# Notes:
# This package does not need a vmware service to make VMware usable, so
# this script says that vmware service is always started.
# vmware-workstation-server service is named vmware-hostd in this package.

addService() {
    if [ "$serviceName" != "vmware" ]; then
        ln -sf /etc/sv/"$serviceName" /var/service/"$serviceName"
    fi
}

removeService() {
    if [ "$serviceName" != "vmware" ]; then
        rm -f /var/service/"$serviceName"
    fi
}

# Check to see whether a program is set to start on boot.
checkService() {
    if [ "$serviceName" = "vmware" ]; then
        echo 'on'
        exit 5
    fi

    if [ -L /var/service/"$serviceName" ] && \
       sv check /var/service/"$serviceName" > /dev/null 2>&1; then
        echo 'on'
        exit 5
    else
        echo 'off'
        exit 6
    fi
}

usage() {
    echo "Syntax for this script is as follows:"
    echo ""
    echo " $0 <action> <serviceName>"
    echo ""
    echo " action      - add or remove"
    echo " serviceName - The name of the service"
    echo ""
    echo ""
    echo " $0 status <serviceName>"
    echo " serviceName - The name of the service"
    echo ""
}

case $action in
    add)
        # Don't allow any empty arguments for add
        if [ $# -lt 4 ]; then
            usage
            exit 1
        fi
        addService
        ;;
    remove)
        # Don't allow any empty arguments for remove
        if [ $# -lt 4 ]; then
            usage
            exit 1
        fi
        removeService
        ;;
    status)
        # We only need the serviceName to check status
        if [ $# -lt 2 ]; then
            usage
            exit 1
        fi
        checkService
        ;;
    *)
        usage
        exit 1
        ;;
esac
