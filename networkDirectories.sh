#!/bin/bash
var=user
i='uid=1234567890'

touch /home/$var/.smbcredentials
echo username=$var@nso.ru > /home/$var/.smbcredentials
echo password=******* >> /home/$var/.smbcredentials
chown $var:$var /home/$var/.smbcredentials
chmod 711 /home/$var/.smbcredentials

[ ! -d "/media/catalog1" ] && mkdir -m 777 /media/catalog1
[ ! -d "/media/catalog2" ] && mkdir -m 777 /media/catalog2
[ ! -d "/media/catalog3" ] && mkdir -m 777 /media/catalog3
chown -R $var /media/ksvn /media/gsnsrv /media/dsl

if ! grep -q '//share.domain/share' "/etc/fstab"; then
	echo //share.domain/share	/media/catalog1	cifs	x-systemd.automount,credentials=/home/NSO.LOC/$var/.smbcredentials,rw,$i,iocharset=utf8,file_mode=0777,dir_mode=0777,nofail,_netdev	0	0 >> /etc/fstab
	echo Директория catalog1 успешно добавлена
fi

if ! grep -q '//user2.domain/share' "/etc/fstab"; then
	echo //user2.domain/share	/media/catalog2	cifs	x-systemd.automount,credentials=/home/NSO.LOC/$var/.smbcredentials,rw,$i,iocharset=utf8,file_mode=0777,dir_mode=0777,nofail,_netdev	0	0 >> /etc/fstab
	echo Директория catalog2 успешно добавлена
fi

if ! grep -q '//user3.domain/share' "/etc/fstab"; then
	echo //user3.domain/share	/media/catalog3	cifs	x-systemd.automount,credentials=/home/NSO.LOC/$var/.smbcredentials,rw,$i,iocharset=utf8,file_mode=0777,dir_mode=0777,nofail,_netdev	0	0 >> /etc/fstab
	echo Директория catalog3 успешно добавлена
fi

mount -a
