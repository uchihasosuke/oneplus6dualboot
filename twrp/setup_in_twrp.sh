#!/bin/bash
echo "Setting up Permissions==================="
chmod +x parted
chmod +x mkfs.ext4
echo "--------- Done ----------"

echo "Setting up Storage============="
echo "1> Resizing Current userdata partition (End: 39.132GB)"
./parted /dev/block/sda "resizepart 17 39.132GB"
echo "--------- Done ----------"
sleep 0.5

echo "2> Creating Partition for Kali Nethunter (End: 59.132GB)"
./parted /dev/block/sda "mkpart primary ext4 39.132GB 59.132GB"
sleep 0.5
./parted /dev/block/sda "name 18 userdata_kali"
echo "--------- Done ----------"

echo "3> Creating Partition for tools (End: 59.632GB)"
./parted /dev/block/sda "mkpart primary ext4 59.132GB 59.632GB"
sleep 0.5
./parted /dev/block/sda "name 19 tools"
echo "--------- Done ----------"

echo "Formatting new partitions==============="
./mkfs.ext4 /dev/block/sda17
sleep 0.5
./mkfs.ext4 /dev/block/sda18
sleep 0.5
./mkfs.ext4 /dev/block/sda19
sleep 0.5

echo "Creating mountpoint for tools ==========="
mkdir /tmp/tools
echo "--------- Done ----------"
sleep 0.5

echo "Mounting Tools partition ==============="
mount /dev/block/sda19 /tmp/tools
echo "--------- Done ----------"
sleep 0.5

echo "Copying tools =========================="
cp ./parted /tmp/tools/
cp ./mkfs.ext4 /tmp/tools/
echo "--------- Done ----------"

echo "Backing up boot & dtbo partitions ======"
mkdir /tmp/tools/android
mkdir /tmp/tools/kali
chmod +x kali.sh
cp ./kali.sh /sbin/
dd if=/dev/block/by-name/boot_b of=/tmp/tools/android/boot_b.img
dd if=/dev/block/by-name/dtbo_b of=/tmp/tools/android/dtbo_b.img
sleep 0.5
echo "--------- Done ----------"

echo "Copying script(s) ======================="
cp ./kali.sh /tmp/tools/
cp ./kali.sh /data/
sleep 0.5
echo "--------- Done ----------"

echo "Setup Complete ========================="
