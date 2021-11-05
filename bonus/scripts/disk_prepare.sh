set -e
set -x

if [ -f /etc/disk_added_date ]
then
   echo "disk already added so exiting."
   exit 0
fi

sudo fdisk -u /dev/sda <<EOF
d
y
n
p
1


t
83
w
EOF

xfs_growfs /dev/sda1

date > /etc/disk_added_date