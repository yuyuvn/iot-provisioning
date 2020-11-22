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
* Provisioning for my curtain bot
