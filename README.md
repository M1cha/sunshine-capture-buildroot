# sunshine-capture-buildroot

## Build

```bash
source envsetup.sh
cd buildroot
make friendlyelec_cm3588_defconfig
cat ../ccache.conf >> .config
make olddefconfig
make
```
