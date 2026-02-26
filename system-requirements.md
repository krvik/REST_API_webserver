1. Docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version

2. Docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.29.6/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
docker compose version

3. GNU Make
sudo yum install make -y
make --version

4. Git
git --version
sudo yum install git -y

5. Python 3.10+
6. Postman/curl


