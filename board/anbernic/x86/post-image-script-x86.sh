#!/bin/bash -e

# HOST_DIR = host dir
# BOARD_DIR = board specific dir
# BUILD_DIR = base dir/build
# BINARIES_DIR = images dir
# TARGET_DIR = target dir
# ANBERNIC_BINARIES_DIR = anbernic binaries sub directory
# ANBERNIC_TARGET_DIR = anbernic target sub directory

HOST_DIR=$1
BOARD_DIR=$2
BUILD_DIR=$3
BINARIES_DIR=$4
TARGET_DIR=$5
ANBERNIC_BINARIES_DIR=$6
ANBERNIC_TARGET_DIR=$7

# /boot
rm -rf "${BINARIES_DIR:?}/boot"     || exit 1
mkdir -p "${BINARIES_DIR}/boot"     || exit 1
cp "${BOARD_DIR}/boot/syslinux.cfg" "${BINARIES_DIR/}/boot/syslinux.cfg" || exit 1
cp "${BINARIES_DIR}/bzImage" "${BINARIES_DIR}/boot/linux" || exit 1
cp "${BINARIES_DIR}/initrd.gz" "${BINARIES_DIR}/boot" || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs" "${BINARIES_DIR}/boot/anbernic.update" || exit 1
cp -pr "${BINARIES_DIR}/tools"       "${BINARIES_DIR}/boot/"                || exit 1

# get UEFI files
mkdir -p "${BINARIES_DIR}/EFI/syslinux" || exit 1
cp "${BOARD_DIR}/boot/syslinux.cfg" "${BINARIES_DIR/}/EFI/syslinux/syslinux.cfg" || exit 1

# boot.tar.xz
# it must include the squashfs version with .update to not erase the current squashfs while running
echo "creating ${ANBERNIC_BINARIES_DIR}/boot.tar.xz"
(cd "${BINARIES_DIR}" && tar -I "xz -T0" -cf "${ANBERNIC_BINARIES_DIR}/boot.tar.xz" tools EFI boot anbernic-boot.conf) || exit 1

# anbernic.img
# rename the squashfs : the .update is the version that will be renamed at boot to replace the old version
mv "${BINARIES_DIR}/boot/anbernic.update" "${BINARIES_DIR}/boot/anbernic" || exit 1
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
rm -rf "${GENIMAGE_TMP}" || exit 1
cp "${BOARD_DIR}/genimage-boot.cfg" "${BINARIES_DIR}" || exit 1
echo "creating ${BINARIES_DIR}/anbernic-boot.img"
genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${BINARIES_DIR}" --config="${BINARIES_DIR}/genimage-boot.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
syslinux -i "${BINARIES_DIR}/anbernic-boot.img" -d /boot/syslinux
rm -rf "${GENIMAGE_TMP}" || exit 1
cp "${BOARD_DIR}/genimage.cfg" "${BINARIES_DIR}" || exit 1
echo "creating ${ANBERNIC_BINARIES_DIR}/anbernic.img"
genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${ANBERNIC_BINARIES_DIR}" --config="${BINARIES_DIR}/genimage.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
rm -f "${BINARIES_DIR}/anbernic-boot.img" || exit 1
rm -f "${ANBERNIC_BINARIES_DIR}/userdata.ext4" || exit 1
sync || exit 1

