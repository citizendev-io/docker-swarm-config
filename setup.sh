curl https://get.docker.com | bash
usermod -aG docker ubuntu
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s $(pwd)/deploy-docker-swarm.sh /usr/local/bin/deploy-docker-swarm
