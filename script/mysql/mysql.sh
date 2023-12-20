

apt update -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


apt install apt-transport-https ca-certificates curl gnupg lsb-release -y 
apt update -y

apt install docker-ce docker-ce-cli containerd.io -y

systemctl enable docker && systemctl start docker

usermod -aG docker will

docker build -t tpfinal-sql server-sql




