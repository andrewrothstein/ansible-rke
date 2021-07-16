andrewrothstein.rke
=========
![Build Status](https://github.com/andrewrothstein/ansible-rke/actions/workflows/build.yml/badge.svg)

Installs [RKE](https://github.com/rancher/rke)

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.rke
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
