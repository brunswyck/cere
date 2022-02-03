Role Name
=========
Fetches the required info from your validator

Requirements
------------

curl on remote and jmespath pip3 package on ansible controller

Role Variables
--------------

defaults.yml:
 geoapi: https://ipinfo.io/json
 jsonrpc_port: 9933

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

  - name: get validators info
    hosts: cere
    gather_facts: True

    roles:
      - role: server_info


License
-------

GPLv3

Author Information
------------------

Patrick Brunswyck
