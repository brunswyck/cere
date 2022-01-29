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

0. create your own ansible folder or use the default ~/.ansible directory
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
   ```
