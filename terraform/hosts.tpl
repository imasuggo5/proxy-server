---
all:
  hosts:
    proxy-server:
      domain: imasuggo5.com
      ansible_host: ${ansible_host}
      ansible_user: ${ansible_user}
      ansible_ssh_private_key_file: ${ansible_ssh_private_key_file}
