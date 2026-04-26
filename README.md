# sunshine-capture-buildroot

This is an external buildroot tree which builds a flashable image, for using an
rk3588 board as a Sunshine game streaming server, for playing Nintendo Switch 1
and 2 games remotely.

Currently supported boards:

* [CM3588 NAS Kit](https://wiki.friendlyelec.com/wiki/index.php/CM3588)

See the
[blog post](https://mzimmermann.info/posts/play-switch2-games-with-remote-friends/)
if you want to know how this was developed.

## Build

* Make sure your system fulfils the
  [Buildroot system requirements](https://buildroot.org/downloads/manual/manual.html#requirement).
* Install a recent version of node. Using
  [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)
  is recommended.

Preparations you have to do each time you create a new shell:

```bash
source envsetup.sh
cd buildroot
```

Preparations you have to do on your first build or after deleting `.config`:

```bash
make friendlyelec_cm3588_defconfig
```

(Optional) Speed up rebuilds:

```bash
cat ../development.conf >> .config
make olddefconfig
```

**Build**:

```bash
make
```

## Flash

### On internal storage (eMMC)

One-time setup:

* Build flash tool with `make host-rkdeveloptool`
* Download [MiniLoaderAll.bin](https://github.com/friendlyarm/sd-fuse_rk3588/raw/4e1888d5fa6c80aa74e21e7ffc5415d3d104334d/prebuilt/MiniLoaderAll.bin)
* `alias rkdeveloptool=./output/per-package/host-rkdeveloptool/host/bin/rkdeveloptool`

On every flash:

* Enter Maskrom mode: Hold mask button, tap reset button, release mask button.
* `rkdeveloptool db MiniLoaderAll.bin`
* `rkdeveloptool wl 0x0 output/images/sdcard.img`
* `rkdeveloptool rd`

That's it, now your device boots with the new firmware (make sure to remove the
microSD).

Partial flashes are also supported:

* Bootloader: `rkdeveloptool 0x40 output/images/u-boot-rockchip.bin`
* rootfs: `rkdeveloptool wlx rootfs output/images/rootfs.squashfs`

### On microSD card

Prerequisites:

* Clear the eMMC so there's no Bootloader on it.
  * Alternatively, flash our bootloader to the eMMC:
    `rkdeveloptool 0x40 output/images/u-boot-rockchip.bin`.
    Keep in mind, that this can only boot our images, not the ones provided by
    FriendlyELEC.

**Flash**:

```bash
dd if=output/images/sdcard.img of=/dev/disk/by-id/YOUR_SDCARD status=progress bs=100M
```

### Restore FriendlyELEC bootloader

* Download [MiniLoaderAll.bin](https://github.com/friendlyarm/sd-fuse_rk3588/raw/4e1888d5fa6c80aa74e21e7ffc5415d3d104334d/prebuilt/MiniLoaderAll.bin)
* Download [idbloader.img](https://github.com/friendlyarm/sd-fuse_rk3588/raw/4e1888d5fa6c80aa74e21e7ffc5415d3d104334d/prebuilt/idbloader.img).
* Enter Maskrom mode: Hold mask button, tap reset button, release mask button.
* `rkdeveloptool db MiniLoaderAll.bin`
* `rkdeveloptool wl 0x40 idbloader.img`
* `rkdeveloptool rd`

## Usage

One time setup:

* Set your Switch output mode to 1080p (4K works but has high latency).
* Connect HDMI-RX to your Switch 1/2 dock.
  * You can use an HDMI splitter, if you want to play locally and remotely at
    the same time. Keep in mind that most cheap HDMI splitters use false
    advertising and can't output 4K in full quality.
* Connect CM3588's USB-C port to your Switch 1/2 dock.
* Power on CM3588.
* Put your Switch 1/2 in the dock.
* Now you can pair your Moonlight client.

Start playing:

* Set the resolution in Moonlight to <= 1080p. Otherwise the latency will be
  high.
* The FPS setting is ignored, you always get what the Switch 1/2 outputs.
* All Audio settings are ignored, since the CM3588 can't control what the
  Switch 1/2 outputs.
* Only the H.264 and H.265 codecs are supported.
* Only gamepad input is supported.
  * If you're not using a Nintendo Switch Pro controller, you might want to enable
    `Swap A/B and X/Y gamepad buttons`.
