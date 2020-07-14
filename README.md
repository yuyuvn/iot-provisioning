# iot-provisioning
Provisioning my IoT system

## Password (in case I forget)
My default password

## Commands
### Provisioning tunnel server
```bash
ansible-playbook -i inventory/hosts --ask-vault-pass tunnel.yml
```

### Provisioning iot server
```bash
ansible-playbook -i inventory/hosts --ask-vault-pass iot.yml
```

## TODO
* Create terraform to create GCP project and oauth2 credencials
* Provisioning for my curtain bot
