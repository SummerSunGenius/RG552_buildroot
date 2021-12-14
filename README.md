git submodule init
git submodule update

make O=$PWD/output/rockpro64 BR2_EXTERNAL=$PWD -C $PWD/buildroot anbernic-rockpro64_defconfig
cd output/rockpro64
make
