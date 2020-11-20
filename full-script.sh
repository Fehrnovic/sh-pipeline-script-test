# Partition drive
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

# Install docker
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install to login to docker
i.	sudo apt install gnupg2 pass -y
