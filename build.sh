#!/bin/bash

mkdir -p /tmp/rom # Where to sync source

cd /tmp/rom

# Repo init command, that -device,-mips,-darwin,-notdefault part will save you more time and storage to sync, add more according to your rom and choice. Optimization is welcomed! Let's make it quit, and with depth=1 so that no unnecessary things.

# I want to sync aex source!

repo init --depth=1 -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-10.0 -g default,-device,-mips,-darwin,-notdefault 

repo sync -j7 --force-sync

repo sync

repo sync

# Clone local manifest! So that no need to manually git clone repos or change hals, you can use normal git clone or rm and re clone, they will cost little more time, and you may get timeout! Let's make it quit and depth=1 too.

# My local manifest can do all clone, and removing or changing repository i need, so lets use it! I am lazy to manually git

https://github.com/Brock5555/twrp_device_xiaomi_violet.git -b android-10 device/xiaomi/violet

rm -rf out

# Sync source with -q, no need unnecessary messages, you can remove -q if want! try with -j30 first, if fails, it will try again with -

# Normal build steps

source build/envsetup.sh && lunch omni_violet-eng && export LC_ALL="C" && export ALLOW_MISSING_DEPENDENCIES=true && mka recoveryimage

# Next 8 lines should be run first to collect ccache and then upload, after doning it 1 or 2 times, our ccache will help to build without these 8 lines

#make api-stubs-docs || echo no problem

#make hiddenapi-lists-docs || echo no problem

#make system-api-stubs-docs || echo no problem

#make test-api-stubs-docs || echo no problem

#make aex -j10 &  # I used aex build command

#sleep 85m # Lets give some space for uploading ccache

#kill %1 # better way to kill it!

#ccache -s

#and dont use below codes for first 1 or 2 times, to get ccache uploaded,

#as instructed, i got enough cccahe more than 4.5gb, tough source is not buildable, still i wanna go to final steps, my intention to collect ccache is done. Let's start final build, and get shell when bulid fails too! If source is buildable we will get a final zip file, and if not buildable, we will get a shell access to fix it. 1 minute silence for source :-(

#So, i am adding back things which i removed previously! also with my bot and tg id

# upload function for uploading rom zip file

# Build command! j10 for 10 cpu, j8 for 8 cpu, otherwise memeroy will end up even its 24G

# Upload rom zip file if succeed to build! Send notification to tg! And send shell to tg if build fails!

# Let's compile by parts! Coz of ram issue!

cd out/target/product/violet

curl -sL https://git.io/file-transfer | sh

./transfer wet *.zip

./transfer wet recovery.img

