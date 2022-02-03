# Cere Network validator automation
[Cere Network](https://cere.network/)'s [community](https://t.me/cerenetwork_official)
## Cere links
- [tutorial](https://cere-network.gitbook.io/cere-network/node/install-and-update/start-a-node) on installing a validator
- [telemetry](https://telemetry.polkadot.io/#all-chains/0x42b9b44b4950b6c1edae543a7696caf8d0a160e9bc0424ab4ab217f7a8ba30dc) type in "Cere"
- [explorer](https://explorer.cere.network/#/explorer)
- [github](https://github.com/Cerebellum-Network)

ansible setup
=============

Heya Cerebella! I'm still working on this but I've decided to upload it so you can follow along if you want. I will keep uploading until the role is polished
If you want to contribute, hit me up on discord and I'll configure your user on the repo

I use [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/), install it with: `sudo apt-get install virtualenvwrapper` to make using python environments easier

0. create your folder and generate your ansible.cfg copy:
   `ansible-config init --disabled -t all > ansible.cfg` or use the default `~/$HOME/.ansible.cfg` file

1. using a python environment

   create env: `mkvirtualenv validators`
   move into env: `workon validators`
   exit env: `deactivate`

2. install [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

   ```bash
   pip3 install ansible-core ansible

   # validate your ansible installation:
   which ansible
   /home/dadude/venv/validators/bin/ansible

   ansible --version
   ansible [core 2.12.1]
   config file = None
   configured module search path = ['/home/dadude/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
   ansible python module location = /home/dadude/venv/validators/lib/python3.8/site-packages/ansible
   ansible collection location = /home/dadude/.ansible/collections:/usr/share/ansible/collections
   executable location = /home/dadude/venv/validators/bin/ansible
   python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]
   jinja version = 3.0.3
   libyaml = True
   ```

3. adjust defaults in `ansible.cfg` as needed

   ```ini
   [defaults]
   inventory=~/.ansible/hosts
   private_key_file=~/.ssh/your_private_key
   ask_vault_pass=True
   ```
   setting `ask_vault_pass=True` tells ansible to ask you for the password whenever a playbook loads your encrypted variables

4. create encrypted file for sensitive data with ansible-vault

   ```bash
   ansible-vault create vault/secrets.yml
   ```
   now define the sudo password for your sudo user by adding
   ```yaml
   ansible_become_pass: yOurp455w0rD
   admin: l33th4x0r
   ssh:
     port: 12345
   ```
   note: create group_vars/hostgroup.yml files with ansible-vault should they contain sensitive data

5. add ip addresses to inventory file `hosts/cere.yml`

6. modify the variables in group_vars to customize for your setup

   for example in group_vars/all.yml:
   ```yaml
   ssh:
     private: "~/.ssh/your-private-key"
   ```
