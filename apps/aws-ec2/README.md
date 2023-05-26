# aws-ec2

Creates an EC2 (Elastic Compute Cloud) on AWS with SSH access for a quick dev box.

## Note

To get your ssh key file, use the following command:

``` bash
$ terraform output -json | jq -r  '.instance_key_pair_private_tls_key.value' > instance-key-pair.pem; chmod 400 instance-key-pair.pem
```
