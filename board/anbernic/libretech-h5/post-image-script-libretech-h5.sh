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

MKIMAGE=${HOST_DIR}/bin/mkimage
# boot
rm -rf "${BINARIES_DIR}/boot"            || exit 1
mkdir -p "${BINARIES_DIR}/boot/boot"     || exit 1
mkdir -p "${BINARIES_DIR}/boot/extlinux" || exit 1
cp "${BINARIES_DIR}/Image"                 "${BINARIES_DIR}/boot/boot/linux"                || exit 1
cp "${BINARIES_DIR}/initrd.gz"             "${BINARIES_DIR}/boot/boot/initrd.gz"            || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs"       "${BINARIES_DIR}/boot/boot/anbernic.update"      || exit 1
cp "${BINARIES_DIR}/sun50i-h5-libretech-all-h3-cc.dtb"  "${BINARIES_DIR}/boot/boot/sun50i-h5-libretech-all-h3-cc.dtb" || exit 1
cp "${BINARIES_DIR}/anbernic-boot.conf"    "${BINARIES_DIR}/boot/anbernic-boot.conf"        || exit 1
cp "${BOARD_DIR}/boot/extlinux.conf" "${BINARIES_DIR}/boot/extlinux"                   || exit 1
cp -pr "${BINARIES_DIR}/tools"       "${BINARIES_DIR}/boot/"                || exit 1

# boot.tar.xz
echo "creating boot.tar.xz"
(cd "${BINARIES_DIR}/boot" && tar -I "xz -T0" -cf "${ANBERNIC_BINARIES_DIR}/boot.tar.xz" extlinux tools boot anbernic-boot.conf) || exit 1

# blobs
for F in u-boot-sunxi-with-spl.bin
do
	cp "${BINARIES_DIR}/${F}" "${BINARIES_DIR}/boot/${F}" || exit 1
done

# anbernic.img
mv "${BINARIES_DIR}/boot/boot/anbernic.update" "${BINARIES_DIR}/boot/boot/anbernic" || exit 1
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
ANBERNICIMG="${ANBERNIC_BINARIES_DIR}/anbernic.img"
rm -rf "${GENIMAGE_TMP}" || exit 1
cp "${BR2_EXTERNAL_ANBERNIC_PATH}/board/anbernic/libretech-h5/genimage.cfg" "${BINARIES_DIR}" || exit 1
echo "generating image"
genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}/boot" --outputpath="${ANBERNIC_BINARIES_DIR}" --config="${BINARIES_DIR}/genimage.cfg" --tmppath="${GENIMAGE_TMP}" || exit 1
rm -f "${ANBERNIC_BINARIES_DIR}/boot.vfat" || exit 1
rm -f "${ANBERNIC_BINARIES_DIR}/userdata.ext4" || exit 1
sync || exit 1

