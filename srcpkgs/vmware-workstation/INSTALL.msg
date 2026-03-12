Before starting VMware you must have the vmw_vmci and vmmon kernel
modules loaded. Either reboot, or load them now as root:

  modprobe -a vmw_vmci vmmon

Two runit services are provided:

  vmware-networks      - required for network access inside VMs
  vmware-usbarbitrator - required for USB device passthrough

To start a service and enable it at boot:

  ln -s /etc/sv/vmware-networks /var/service/
  ln -s /etc/sv/vmware-usbarbitrator /var/service/

To allow building the kernel modules against your current kernel,
ensure the matching linux-headers package is installed.
