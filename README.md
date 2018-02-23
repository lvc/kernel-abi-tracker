Linux Kernel ABI Tracker
========================

This is a tool to monitor and analyze ABI changes in new versions of the Linux kernel. It is based on the ABI Dumper, ABI Compliance Checker, ABI Monitor and ABI Tracker tools. The tracker regularly checks https://www.kernel.org/ for new releases, performs backward binary compatibility analysis of all public exported symbols and data types (declared in the `.ksymtab` section of `vmlinux` + system calls) and lists all added/removed symbols.

Live demo for `defconfig/x86_64`: https://abi-laboratory.pro/tracker/timeline/linux/

Requires
--------

* Perl 5
* GNU Binutils
* Elfutils
* ABI Dumper >= 0.99.19: https://github.com/lvc/abi-dumper
* ABICC >= 1.99.25: https://github.com/lvc/abi-compliance-checker
* ABI Monitor >= 1.10: https://github.com/lvc/abi-monitor
* ABI Tracker >= 1.9: https://github.com/lvc/abi-tracker

You can use the installer (https://github.com/lvc/installer) to automatically download and install required ABI tools.

Usage
-----

###### Automated

1. Check for new releases, download and build:

        abi-monitor -get -build-new linux.json

2. Analyze ABI changes:

        abi-tracker -build linux.json

3. Create graph of ABI changes:

        abi-tracker -build linux.json -target graph

4. The report is generated to:

        ./timeline/linux/index.html
        ./compat_report/linux/
        ./objects_report/linux/
        ./graph/linux/
        ./css/

###### Manual

1. Build your kernel binaries with enabled debug info:

   * Add `-Og` instead of `-O2` compilation flag.

   * Add the following configuration options to your `.config` file:

            CONFIG_DEBUG_INFO=y
            CONFIG_DEBUG_INFO_REDUCED=n
            CONFIG_DEBUG_INFO_SPLIT=n
            CONFIG_DEBUG_INFO_DWARF4=n
            CONFIG_GDB_SCRIPTS=n

2. Create ABI dumps of the `vmlinux` binary:

        abi-dumper vmlinux-V1 -kernel-export -output ABI-V1.dump -lver V1
        abi-dumper vmlinux-V2 -kernel-export -output ABI-V2.dump -lver V2

3. Compare ABI dumps to create report:

        abi-compliance-checker -l linux -old ABI-V1.dump -new ABI-V2.dump -limit-affected 2
