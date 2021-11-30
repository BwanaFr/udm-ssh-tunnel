#/bin/bash
DEST_DIR=/mnt/data/sshtunnel

echo "Installing UDM-SSH-TUNNEL"
if [ ! -f "/etc/systemd/system/udm-boot.service" ]; then
	echo "Installing udm-boot script"
	cp udm-boot.service /etc/systemd/system
	mkdir -p /mnt/data/on_boot.d
fi

echo "Installing script files"
mkdir -p $DEST_DIR
cp -n sshd_config $DEST_DIR
cp -n ssh_tunnel.sh /mnt/data/on_boot.d/05-ssh-tunnel.sh
chmod +x /mnt/data/on_boot.d/05-ssh-tunnel.sh

echo "Configuring ssh tunnel"
read -p 'SSH username [sshuser]: ' username
username=${username:-sshuser}
stty -echo
read -p 'SSH password : ' password
stty echo
password=${password:-myPassw0rd}
echo 
read -p 'SSH port [2222]: ' sshport
sshport=${sshport:-2222}

sed -i "s/USER='.*'/USER='$username'/" /mnt/data/on_boot.d/05-ssh-tunnel.sh
sed -i "s/PASS='.*'/PASS='$password'/" /mnt/data/on_boot.d/05-ssh-tunnel.sh
sed -i "s/Port [0-9]*/Port $sshport/" $DEST_DIR/sshd_config

#Start udm-boot
echo "Starting udm-boot"
#systemctl daemon-reload
#systemctl enable udm-boot
#systemctl start udm-boot
