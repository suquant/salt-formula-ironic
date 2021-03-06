
==================================
ironic
==================================

Service ironic description

Sample pillars
==============

Single ironic service

.. code-block:: yaml

  ironic:
    api:
      enabled: true
      version: mitaka
      bind:
        address: 0.0.0.0
        port: 6385
      database:
        engine: mysql
        host: localhost
        port: 3306
        name: ironic
        user: ironic
        password: password
      identity:
        engine: keystone
        region: RegionOne
        host: localhost
        port: 35357
        user: ironic
        password: password
        tenant: service
      message_queue:
        engine: rabbitmq
        host: localhost
        port: 5672
        user: openstack
        password: password
        virtual_host: '/openstack'
    conductor:
      enabled: true
      version: mitaka
      database:
        engine: mysql
        host: localhost
        port: 3306
        name: ironic
        user: ironic
        password: password
      message_queue:
        engine: rabbitmq
        host: localhost
        port: 5672
        user: openstack
        password: password
        virtual_host: '/openstack'

Standalone ironic without keystone

.. code-block:: yaml

  ironic:
    api:
      version: mitaka
      enabled: true
      bind:
        address: 0.0.0.0
        port: 6385
      database:
        engine: mysql
        host: localhost
        port: 3306
        name: ironic
        user: ironic
        password: password
      identity:
        engine: noauth
      message_queue:
        engine: rabbitmq
        host: localhost
        port: 5672
        user: openstack
        password: password
        virtual_host: '/openstack'
    conductor:
      enabled: true
      version: mitaka
      database:
        engine: mysql
        host: localhost
        port: 3306
        name: ironic
        user: ironic
        password: password
      message_queue:
        engine: rabbitmq
        host: localhost
        port: 5672
        user: openstack
        password: password
        virtual_host: '/openstack'
