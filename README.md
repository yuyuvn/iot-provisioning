# iot-provisioning
Provisioning my IoT system

## Install ansible
```bash
sudo apt-get update
sudo apt-get -y install python3-pip python3-virtualenv
virtualenv ansible
source ansible/bin/activate
pip install ansible
```

Create `.vault_pass` file contain vaul password

### Active environments
```bash
source ansible/bin/activate
```

## Password (in case I forget)
My default password

## Commands
### Provisioning pi server
```bash
ansible-playbook iot.yml
```

### Provisioning proxy server
```bash
ansible-playbook proxy.yml
```
