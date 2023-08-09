### Prepare

1. Create a GCP account
2. Create a GCP project
3. Add a payment account for the project
4. Enable Compute Engine API for the project
5. Create a service account with editor role in the project
6. Create a private key of the service account in JSON format and download the file
7. Set the GOOGLE_APPLICATION_CREDENTIALS environment variable in the local to the path of the file


### Run
```
./run.sh
```


### Reference

- [Terraform](https://developer.hashicorp.com/terraform)
- [Terraform tutorial for GCP](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started)
- [Terraform google provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network.html?product_intent=terraform)
- [.gitignore templates](https://github.com/github/gitignore)
- [GCE free tier](https://cloud.google.com/free/docs/free-cloud-features?hl=ja#compute)
- [GCE images](https://console.cloud.google.com/compute/images?project=imasuggo5)
- [GCE meta data](https://cloud.google.com/compute/docs/metadata/default-metadata-values?hl=ja)
- [frp](https://github.com/fatedier/frp)
- [Terraform + Ansible example](https://gitlab.com/to-be-continuous/samples/terraform-ansible-on-aws)
- [Why .terraform.lock.hcl should commit?](https://stackoverflow.com/questions/67963719/should-terraform-lock-hcl-be-included-in-the-gitignore-file)


### TODO
- [ ] Optimize SELinux

- [ ] Executing terraform, hanged up before. Search the cause if this is occured again.
