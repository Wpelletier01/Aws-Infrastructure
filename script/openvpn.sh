
apt update -y 

wget -O openvpn.sh https://get.vpnsetup.net/ovpn


# client pour glpi
bash openvpn.sh <<ANSWERS
n
1
1194
4
admin
y
ANSWERS

