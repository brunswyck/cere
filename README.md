# Cere Network validator automation
[Cere Network](https://cere.network/)'s [community](https://t.me/cerenetwork_official)
## Cere links
- [tutorial](https://cere-network.gitbook.io/cere-network/node/install-and-update/start-a-node) on installing a validator
- [telemetry](https://telemetry.polkadot.io/#all-chains/0x42b9b44b4950b6c1edae543a7696caf8d0a160e9bc0424ab4ab217f7a8ba30dc) type in "Cere"
- [explorer](https://explorer.cere.network/#/explorer)
- [github](https://github.com/Cerebellum-Network)

ansible setup
=============

I use [virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/), install it with: `sudo apt-get install virtualenvwrapper` to make using python environments easier

0. create your own ansible folder or use the default `~/.ansible` directory
1. use of python environment

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
3. adjust defaults in `~/.ansible/ansible.cfg` as you wish

   ```ini
   [defaults]<
   inventory       = ~/.ansible/inventory
   private_key_file = ~/.ssh/
   vault_password_file = vault.txt
   ```
