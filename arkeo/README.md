# update repositories and install the necessary utilities 
apt update && apt upgrade -y && apt install curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y

# install and configure fail2ban
apt install fail2ban -y && cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local && nano /etc/fail2ban/jail.local && systemctl restart fail2ban

# Install GO
ver="1.20.3"
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && rm "go$ver.linux-amd64.tar.gz" && echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && source $HOME/.bash_profile && go version

# Install docker + docker-compose
apt update && apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && apt update && apt-cache policy docker-ce && sudo apt install docker-ce -y && docker --version && curl -L "https://github.com/docker/compose/releases/download/v2.10.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose && docker-compose version --version

# create a wallet 
arkeod keys add arkeo_provider_wallet --keyring-backend os

# Create docker-compose.yml
mkdir -p archeo-provider && cd archeo-provider && echo 'version: "3"
services:
  sentinel:
    image: ghcr.io/arkeonetwork/arkeo:latest
    container_name: sentinel
    environment:
      NET: "mainnet"
      MONIKER: "n/a"
      WEBSITE: "n/a"
      DESCRIPTION: "n/a"
      LOCATION: "Europe"
      FREE_RATE_LIMIT: 10
      PROVIDER_PUBKEY: "<tarkeopub1add...>"
      SOURCE_CHAIN: "127.0.0.1:1317"
      EVENT_STREAM_HOST: "127.0.0.1:26657"
      CLAIM_STORE_LOCATION: "${HOME}/.arkeo/claims"
      CONTRACT_CONFIG_STORE_LOCATION: "${HOME}/.arkeo/contract_configs"
      ETH_MAINNET_FULLNODE: "<https://ethereum.mainnet.fi>"
    network_mode: host
    entrypoint: sentinel' > docker-compose.yml

# Launch sentinel
`docker-compose up -d`

# Checking the logs
`docker-compose logs -f --tail 100`