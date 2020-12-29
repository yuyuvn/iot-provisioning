PiDDNS
=========

This role install and configure your own Dynamic DNS service in a web hosting running CPanel and
the dynamic dns client running in a Raspberry Pi with Raspbian.

Requirements
------------

This role requires Ansible 2.0 or higher and the dynamic DNS record to update must be already created in your CPanel. For a quicker propagation of your dynamic DNS record, configure that with TTL=60.

Role Variables
--------------

The variables that can be passed to this role and a brief description about
them are as follows.

([defaults/main.yml](defaults/main.yml))

```yaml
# Some of the ftp connection settings
# ATTENTION: Turn false the secure setting can incurs on a high security risk since your credentials are passed out in plain text.
# Change ONLY if web hosting provider doesn't support TLS.
ftp_port: 21
ftp_secure: true

```

([defaults/config.yml](defaults/config.yml))

```yaml
# CPanel configuration details
cpanel:
  url: "https://<your_cpanel_url>:2083"
  user: "<your_cpanel_username>"

# DynDNS configuration details
dyndns:
  domain: "<your_public_domain>" 	# The domain of the DynDNS hostname. E.g. domain.com
  hostname: "<your_dyndns_hostname>" 	# The hostname to update. The FQDN must be already created in your DNS server. E.g. dyndns.domain.com
  phpuser: "<dyndns_username_to_use>" 	# The username you want to use for the DynDNS page (PHP Authentication). E.g. dyndnsuser
  url: "<your_dyndns_url>" 		# The base URL to host the DynDNS page: E.g. www.domain.com (DON'T add http(s)://)
  page: "<your_dyndns_page>" 		# The DynDNS PHP page to create. Recommended: dyndns.php

# FTP connection detauls
ftp:
  hostname: "<your_ftp_server>" 	# E.g. ftp.domain.com
  user: "<your_ftp_username>"
  path: "<your_full_website_path>" 	# The website path to upload the PHP page. E.g. /public_html/www.domain.com"

```

[(defaults/passwords.yml](defaults/passwords.yml))

```yaml
# You can use Ansible Vault to encrypt your password file. Also, change the file permissions to 0600
# 	ansible-vault encrypt <role_path>/defaults/passwords.yml
cpanel_pass: "<your_cpanel_password>"

dyndns_phppass: "<your_dyndns_password>"

ftp_pass: "<your_ftp_password>"
```

Dependencies
------------

None

Example Playbook
----------------

If you encrypt the passwords.yml file, remember to run your playbook with the flag '--ask-vault-pass'.

    - hosts: pi
      gather_facts: false
      role: pipoe2h.piddns
      post_tasks:
        - name: Check ddclient has updated successfuly the dynamic DNS record
          wait_for:
            path: /var/cache/ddclient/ddclient-piddns.cache
            search_regex: 'status=good'
            delay: 10
            timeout: 300
          register: result
          ignore_errors: yes

        - debug: msg="ddclient has updated your dynamic DNS {{ dyndns.hostname }} successfuly"
          when: result|success

        - debug: msg="ddclient couldn't updated your dynamic DNS. Please check the /var/log/syslog file to get more information"
          when: result|failed

License
-------

MIT

Author Information
------------------

* [Jose Gomez](https://github.com/pipoe2h) | [www](http://www.joseluisgomez.com) | [twitter](http://twitter.com/pipoe2h)
