# iot-provisioning
Provisioning my IoT system

## Install ansible
```bash
sudo apt-get update
sudo apt-get -y install python3-pip
sudo pip3 install virtualenv
virtualenv ansible
source ansible/bin/activate
pip install ansible
```

### Active environments
```bash
source ansible/bin/activate
```

## Password (in case I forget)
My default password

## Commands
### Provisioning tunnel server
```bash
ansible-playbook -i inventory/hosts --ask-vault-pass tunnel.yml
```

### Provisioning monitor server
```bash
ansible-playbook -i inventory/hosts --ask-vault-pass monitor.yml
```

## TODO
* Provisioning for my curtain bot
