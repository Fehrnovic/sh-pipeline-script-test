diskname=$(echo $(lsblk -o NAME,HCTL | grep -i "[0-9]:[0-9]:[0-9]:13") | cut -d' ' -f1)
partDisk="/dev/$diskname"
sudo parted $partDisk --script mklabel gpt mkpart xfspart xfs 0% 100%
devDiskName="$partDisk"1
sudo mkfs.xfs $devDiskName
sudo partprobe $devDiskName
sudo mkdir /datadrive
sudo mount $devDiskName /datadrive
uuid=$(sudo blkid -s UUID -o value $devDiskName)
sudo chmod 777 /etc/fstab
sudo echo "UUID=${uuid} /datadrive xfs defaults,nofail 1 2" >> /etc/fstab
