sed -i -e "s/O2/Og/" Makefile
mkdir build
cd build
make -C ".." O=$(pwd) defconfig
echo "CONFIG_DEBUG_INFO=y" >> .config
echo "CONFIG_DEBUG_INFO_REDUCED=n" >> .config
echo "CONFIG_DEBUG_INFO_SPLIT=n" >> .config
echo "CONFIG_DEBUG_INFO_DWARF4=n" >> .config
echo "CONFIG_GDB_SCRIPTS=n" >> .config
make CFLAGS='-Og' -j2

for i in `find . -name '*.ko'`;do mkdir -p $INSTALL_TO/`dirname $i` && cp -f $i $INSTALL_TO/$i;done
cp -f vmlinux $INSTALL_TO
