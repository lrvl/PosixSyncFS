# PosixSyncFS

PosixSyncFS is a set of Bash scripts that allow users to create a real POSIX filesystem and sync it to a remote storage bucket for backup and recovery purposes.

The scripts automate the process of creating sparse files, setting them up as loop devices, and creating a linear mapping using dmsetup. The resulting mapping can then be used to create a real POSIX filesystem like XFS, which can be synced to a remote storage bucket using the included sync script.

## Getting Started

To use PosixSyncFS, you'll need to have Bash installed on your system. You'll also need to create a configuration file named `PosixSyncFS.ini`, which contains the following variables:

- `file_prefix`: the prefix to use when creating sparse files (e.g., `myfiles`).
- `file_number`: the number of sparse files to create (e.g., `100`).
- `mapping_name`: the name to use for the device mapper mapping (e.g., `mypartition`).
- `sync_destination`: the destination for syncing the filesystem (e.g., `s3://mybucket/myfolder`).

Once you've created the configuration file, you can run the scripts in the following order:

1. `PosixSyncFS-step1-create-files.sh`: Creates the sparse files by using the `truncate` command.
2. `PosixSyncFS-step2-losetup.sh`: Setup all sparse files as loop devices by using the `losetup` command.
3. `PosixSyncFS-step3-linear-dmsetup.sh`: Creates a linear mapping using dmsetup and the loop devices.
4. `PosixSyncFS-sync.sh`: Syncs the resulting filesystem to the remote storage bucket using the `rclone` command.

Note that the `rclone` command is used for syncing, so you'll need to have it installed on your system and configured with valid credentials.

After daily use the sync only has to send the partial changes.

## Use Cases

- Backup and Recovery: Use PosixSyncFS to create a real POSIX filesystem and sync it to a remote storage bucket for backup and recovery purposes. The resulting filesystem can be easily synced to the cloud for offsite backup, and restored to the original system in case of data loss.
- Testing and Development: Use PosixSyncFS to quickly create a virtual filesystem for testing and development purposes. The filesystem can be easily modified and synced to the cloud, allowing for easy collaboration and version control.
- File Sharing and Collaboration: Use PosixSyncFS to create a shared filesystem that can be accessed by multiple users on different systems. The filesystem can be easily synced to the cloud, allowing users to access the latest version of the files from anywhere.

# Pros

- Easy to Use: PosixSyncFS is a set of simple Bash scripts that automate the process of creating sparse files, setting them up as loop devices, and creating a linear mapping using dmsetup. The resulting filesystem can be easily synced to a remote storage bucket using the included sync script.
- Flexible: PosixSyncFS allows users to create a real POSIX filesystem using any filesystem type (e.g., XFS, ext4, etc.), making it a flexible solution for a variety of use cases.
- Flexible-remotes: Any cloud storage supported by rclone can be used. Notice that for example WebDAV lacks checksum features, it does work but not efficiently.
- Cost-effective: PosixSyncFS uses sparse files to create the filesystem, which can save disk space and reduce storage costs.

# Cons

- Requires Bash and recommended rclone : may be a barrier to entry for some users
- Might not be suitable for large filesystems: PosixSyncFS uses sparse files to create the filesystem, which may not be suitable for large filesystems or high-performance applications.
- Limited to linear mappings: PosixSyncFS creates a linear mapping using dmsetup, which may not be suitable for complex storage configurations.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Acknowledgments

PosixSyncFS was inspired by similar projects that automate the process of creating sparse files and setting them up as loop devices. Special thanks to the authors of those projects for their contributions to the community.
