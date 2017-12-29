# salt-state-extenda-repo

This salt state is used to configure an Extenda private Yum repo hosted on AWS S3. The S3 bucket is named `extenda-packages`. Each customer has their own top level folder in this bucket. For example, Auchan's repository base URL is `https://s3-eu-west-1.amazonaws.com/extenda-packages/auc`.

## tf-module-repo-users
The [tf-module-repo-users](https://github.com/extenda/tf-module-repo-user) Terraform module is used to create an AWS IAM user for each customer. This IAM user is configured with an IAM Policy which allows it to fetch objects (RPMs) from their repository. The IAM user does not have *any* additional rights on AWS. Each customer IAM user is associated with a unique IAM access keypair.

## files
### extenda-s3.py
This is a yum plugin written in Python. Its purpose is to sign http requests with the customer's unique IAM access keypair. It is installed in `/usr/lib/yum-plugins/extenda-s3.py`

### extenda-s3.conf
This is the configuration file associated with the yum plugin. It contains settings, including the IAM `access_key` and `secret_key`. It is installed in `/etc/yum/pluginconf.d/extenda.conf`. We store each customer's `access_key` and `secret_key` as static Pillar data in Vault.

## testing
We use `test kitchen` for testing our salt state. The `.kitchen.yml` file contains a grain for a ficticious customer named `bar`. It also contains pillar data for the IAM `access_key` and `secret_key` associated with the `bar` user on our AWS account. Yes, this is a real IAM keypair. But the only thing you can do with it is to download a canonical RPM package named `bello`.

To run tests, you will need to be running `Ruby v2.3.3` or later, [Vagrant](https://www.vagrantup.com), and [VirtualBox](https://www.virtualbox.org). At a minimum, you will also need to have the `bundler` gem installed -- `gem install bundler`. Once these requirements are met, you can run `bundle install` from the root of this repo. This will install all required gems for running `test-kitchen`.

We use TDD for this project. So if you want to make changes, first write a test using [ServerSpec](http://serverspec.org) and then run `kitchen verify` and watch it fail. Then write the code that will make your test pass. You will need to apply this code to your test VM using a `kitchen converge`. Then you can run another `kitchen verify`. Repeat this pattern until all tests pass.
