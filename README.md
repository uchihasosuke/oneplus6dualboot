# oneplus 6 dualboot Nethunter pro with android

# Partitioning Script for Android, Kali Nethunter pro, and Tools

This script is designed to partition the internal storage of a device into three parts:
1. **Android Userdata Partition** (Resizable, remaining storage after allocation)
2. **Kali Nethunter pro Partition** (Fixed 20GB)
3. **Tools Partition** (Fixed 500MB)

## How the Partitioning Works

The script utilizes `parted` to resize and create partitions on `/dev/block/sda` as follows:

### 1. Resizing Android Userdata Partition
- The existing userdata partition is resized to end at **39.132GB**.
- This ensures that the remaining space is available for the other partitions.

```bash
./parted /dev/block/sda "resizepart 17 39.132GB"
```

### 2. Creating Partition for Kali Nethunter pro
- A new partition is created starting from **39.132GB** and ending at **59.132GB**.
- This allocates exactly **20GB** for Kali Nethunter pro.

```bash
./parted /dev/block/sda "mkpart primary ext4 39.132GB 59.132GB"
./parted /dev/block/sda "name 18 userdata_kali"
```

### 3. Creating Partition for Tools
- A small **500MB** partition is created, starting from **59.132GB** and ending at **59.632GB**.
- This will store essential tools required for system operations.

```bash
./parted /dev/block/sda "mkpart primary ext4 59.132GB 59.632GB"
./parted /dev/block/sda "name 19 tools"
```

## Summary of Partition Allocation
| Partition | Start | End | Size |
|-----------|--------|------|------|
| Android Userdata | 0GB | 39.132GB | ~39.132GB |
| Kali Nethunter pro | 39.132GB | 59.132GB | 20GB |
| Tools | 59.132GB | 59.632GB | 500MB |

## Usage Instructions
1. Copy the script to the target device.
2. Grant execution permissions:
   ```bash
   chmod +x setup_in_twrp.sh
   ```
3. Run the script:
   ```bash
   ./setup_in_twrp.sh
   ```

## Notes
- Ensure you have backups before modifying partitions.
- The script assumes the device storage is around **60GB**.
- Any existing data on the resized partitions **may be lost**, so proceed with caution.

