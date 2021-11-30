#/bin/sh
GROUP='sshtunnel'
USER=''
PASS=''

#Create group, user and set password
addgroup $GROUP 2> /dev/null
adduser --shell /bin/false --no-create-home --ingroup $GROUP --disabled-password --gecos "ssh tunnel" $USER 2> /dev/null
echo "$USER:$PASS" | chpasswd

#Start sshd
/usr/sbin/sshd -f /mnt/data/sshd_config


