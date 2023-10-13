## Spinning up new server

### > If user or SSH key doesn't already exist on server
1. Create <new_user> on server before running playbook

   On server:
   ```bash
   adduser <new_user>
   ```

2. Add <new_user> to sudo group before running playbook

   On server:
   ```bash
   usermod -aG sudo <new_user>
   ```

3. Generate SSH key

    `-b = encryption type`

    `-C = comment/description`

    `-f = filename`

   On computer:
   ```bash
   ssh-keygen -b 4096 -C "user: <new_user> - <server_name>" -f "<server_name>"
   ```

4. Copy SSH key to server

   On computer:
   ```bash
   ssh-copy-id -i ~/.ssh/<new_user_ssh_key_name>.pub <new_user>@<host_ip>
   ```


### > Else go right to first-install.yaml
---

## How to run playbook
Go to ansible root directory

### Run playbook
```bash
ansible-playbook playbook_name.yaml -vvvv
```

If ansible user already exists, uncomment `ansible_ssh_private_key_file` in ansible_default_vars.yaml


---

## Ansible file encryption
To use `ansible-vault`, a password file must be stored somewhere on the system. In addition, the following line must be added to the ansible.cfg file:
```bash
vault_password_file = <path/to/password_file>
```
### Encrypt files
```bash
ansible-vault encrypt <path/to/file.yaml>
```

### Decrypt files
```bash
ansible-vault decrypt <path/to/file.yaml>
```

### Edit encrypted files
```bash
ansible-vault edit <path/to/file.yaml>
```

### View encrypted files
```bash
ansible-vault view <path/to/file.yaml>
```


### Encrypt/Decrypt files from VsCode
`control + option + 0`

[Ansible encryption docs](https://docs.ansible.com/ansible/latest/vault_guide/vault_encrypting_content.html#encrypting-existing-files)
