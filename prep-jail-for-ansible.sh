#!/bin/sh
echo --- adding user ikke
echo "ikke:1017::::::/home/ikke:/bin/sh:" > /tmp/users.txt
/usr/sbin/adduser -f /tmp/users.txt
rm /tmp/users.txt
/usr/bin/grep ikke /etc/passwd

echo --- setting up .ssh/authorized_keys
/bin/mkdir -v -m 700 /home/ikke/.ssh
/bin/cp /tmp/authorized_keys /home/ikke/.ssh/.
/bin/chmod 644 /home/ikke/.ssh/authorized_keys
/usr/sbin/chown -R ikke:ikke /home/ikke

echo --- adding user ikke to group wheel
/usr/sbin/pw usermod -n ikke -G wheel
/usr/bin/grep wheel /etc/group

echo --- enabling sshd in /etc/rc.conf
/usr/bin/sed -i .bak 's/sshd_enable="NO"/sshd_enable="YES"/' /etc/rc.conf
/usr/bin/grep sshd_enable /etc/rc.conf
echo --- starting sshd
/usr/sbin/service sshd start

echo --- upgrading packages
/usr/sbin/pkg upgrade -y
echo --- installing bash and sudo
/usr/sbin/pkg install -y bash sudo

echo --- allowing group wheel to sudo in /usr/local/etc/sudoers
/usr/bin/sed -i .bak 's/^#[[:space:]]\{1,\}\(%wheel[[:space:]]\{1,\}ALL=(ALL)[[:space:]]\{1,\}NOPASSWD:[[:space:]]\{1,\}ALL\)/\1/' /usr/local/etc/sudoers
/usr/bin/grep wheel /usr/local/etc/sudoers

echo --- installing python2
/usr/sbin/pkg install -y python2 lang/python
