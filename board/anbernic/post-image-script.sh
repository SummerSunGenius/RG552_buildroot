#!/bin/bash -e

# PWD = source dir
# BASE_DIR = build dir
# BUILD_DIR = base dir/build
# HOST_DIR = base dir/host
# BINARIES_DIR = images dir
# TARGET_DIR = target dir

ANBERNIC_BINARIES_DIR="${BINARIES_DIR}/anbernic"
ANBERNIC_TARGET_DIR="${TARGET_DIR}/anbernic"

if [ -d "${ANBERNIC_BINARIES_DIR}" ]; then
	rm -rf "${ANBERNIC_BINARIES_DIR}"
fi

mkdir -p "${ANBERNIC_BINARIES_DIR}" || { echo "Error in creating '${ANBERNIC_BINARIES_DIR}'"; exit 1; }

ANBERNIC_TARGET=$(grep -E "^BR2_PACKAGE_ANBERNIC_TARGET_[A-Z_0-9]*=y$" "${BR2_CONFIG}" | grep -vE "_ANY=" | sed -e s+'^BR2_PACKAGE_ANBERNIC_TARGET_\([A-Z_0-9]*\)=y$'+'\1'+)
BATO_DIR="${BR2_EXTERNAL_ANBERNIC_PATH}/board/anbernic"

echo -e "\n----- Generating images/anbernic files -----\n"

ANBERNIC_POST_IMAGE_SCRIPT=""

case "${ANBERNIC_TARGET}" in
	RPI0|RPI1|RPI2)
	BOARD_DIR="${BATO_DIR}/rpi"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-rpi012.sh"
	;;

	RPI3)
	BOARD_DIR="${BATO_DIR}/rpi"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-rpi3.sh"
	;;

	RPI4)
	BOARD_DIR="${BATO_DIR}/rpi4"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-rpi4.sh"
	;;

	S905)
	BOARD_DIR="${BATO_DIR}/amlogic/s905"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-s905.sh"
	;;

	S912)
	BOARD_DIR="${BATO_DIR}/amlogic/s912"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-s912.sh"
	;;

	X86|X86_64)
	BOARD_DIR="${BATO_DIR}/x86"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-x86.sh"
	;;

	XU4)
	BOARD_DIR="${BATO_DIR}/odroidxu4"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-odroidxu4.sh"
	;;

	ODROIDC2)
	BOARD_DIR="${BATO_DIR}/amlogic/odroidc2"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-odroidc2.sh"
	;;

	ODROIDC4)
        BOARD_DIR="${BATO_DIR}/amlogic/odroidc4"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-odroidc4.sh"
	;;

	ODROIDN2)
        BOARD_DIR="${BATO_DIR}/amlogic/odroidn2"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-odroidn2.sh"
	;;

	ODROIDGOA)
	BOARD_DIR="${BATO_DIR}/rockchip/odroidgoa"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-odroidgoa.sh"
	;;

	ROCKPRO64)
	BOARD_DIR="${BATO_DIR}/rockchip/rk3399/rockpro64"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-rockpro64.sh"
	;;

	ROCK960)
	BOARD_DIR="${BATO_DIR}/rockchip/rk3399/rock960"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-rock960.sh"
	;;

	TINKERBOARD)
	BOARD_DIR="${BATO_DIR}/rockchip/rk3288/tinkerboard"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-tinkerboard.sh"
	;;

	MIQI)
	BOARD_DIR="${BATO_DIR}/rockchip/rk3288/miqi"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-miqi.sh"
	;;

	VIM3)
	BOARD_DIR="${BATO_DIR}/amlogic/vim3"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-vim3.sh"
	;;

	LIBRETECH_H5)
	BOARD_DIR="${BATO_DIR}/libretech-h5"
	ANBERNIC_POST_IMAGE_SCRIPT="${BOARD_DIR}/post-image-script-libretech-h5.sh"
	;;

	*)
	echo "Outch. Unknown target ${ANBERNIC_TARGET} (see copy-anbernic-archives.sh)" >&2
	bash
	exit 1
esac

# run image script for specific target
bash "${ANBERNIC_POST_IMAGE_SCRIPT}" "${HOST_DIR}" "${BOARD_DIR}" "${BUILD_DIR}" "${BINARIES_DIR}" "${TARGET_DIR}" "${ANBERNIC_BINARIES_DIR}" "${ANBERNIC_TARGET_DIR}"

# common

# renaming
SUFFIXVERSION=$(cat "${TARGET_DIR}/usr/share/anbernic/anbernic.version" | sed -e s+'^\([0-9\.]*\).*$'+'\1'+) # xx.yy version
SUFFIXTARGET=$(echo "${ANBERNIC_TARGET}" | tr A-Z a-z)
SUFFIXDATE=$(date +%Y%m%d)
SUFFIXIMG="-${SUFFIXVERSION}-${SUFFIXTARGET}-${SUFFIXDATE}"
mv "${ANBERNIC_BINARIES_DIR}/anbernic.img" "${ANBERNIC_BINARIES_DIR}/anbernic${SUFFIXIMG}.img" || exit 1

cp "${TARGET_DIR}/usr/share/anbernic/anbernic.version" "${ANBERNIC_BINARIES_DIR}" || exit 1


# gzip image
gzip "${ANBERNIC_BINARIES_DIR}/anbernic${SUFFIXIMG}.img" || exit 1

#
for FILE in "${ANBERNIC_BINARIES_DIR}/boot.tar.xz" "${ANBERNIC_BINARIES_DIR}/anbernic${SUFFIXIMG}.img.gz"
do
	echo "creating ${FILE}.md5"
	CKS=$(md5sum "${FILE}" | sed -e s+'^\([^ ]*\) .*$'+'\1'+)
	echo "${CKS}" > "${FILE}.md5"
	echo "${CKS}  $(basename "${FILE}")" >> "${ANBERNIC_BINARIES_DIR}/MD5SUMS"
done

# pcsx2 package
if grep -qE "^BR2_PACKAGE_PCSX2=y$" "${BR2_CONFIG}"
then
	echo "building the pcsx2 package..."
	"${BR2_EXTERNAL_ANBERNIC_PATH}"/board/anbernic/doPcsx2package.sh "${TARGET_DIR}" "${BINARIES_DIR}/pcsx2" "${ANBERNIC_BINARIES_DIR}" || exit 1
fi

# wine package
if grep -qE "^BR2_PACKAGE_WINE_LUTRIS=y$" "${BR2_CONFIG}"
then
	if grep -qE "^BR2_x86_i686=y$" "${BR2_CONFIG}"
	then
		echo "building the wine package..."
		"${BR2_EXTERNAL_ANBERNIC_PATH}"/board/anbernic/doWinepackage.sh "${TARGET_DIR}" "${BINARIES_DIR}/wine" "${ANBERNIC_BINARIES_DIR}" || exit 1
	fi
fi

"${BR2_EXTERNAL_ANBERNIC_PATH}"/scripts/linux/systemsReport.sh "${PWD}" "${ANBERNIC_BINARIES_DIR}"

exit 0
