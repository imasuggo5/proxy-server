resource "local_file" "proxy_server_pem" {
  content         = tls_private_key.proxy_server.private_key_pem
  filename        = "${path.module}/../ansible/.ssh/proxy_server.pem"
  file_permission = "0600"
}

data "template_file" "hosts" {
  template = file("hosts.tpl")
  vars = {
    ansible_host                 = local.remote_host
    ansible_user                 = local.remote_user
    ansible_ssh_private_key_file = local.remote_key_file
  }
}

resource "local_file" "hosts" {
  content  = data.template_file.hosts.rendered
  filename = "${path.module}/../ansible/hosts"
}
