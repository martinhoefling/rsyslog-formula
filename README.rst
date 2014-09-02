rsyslog-formula
===============

Configures and starts rsyslog service. Currently the log file schema is based on the debian default. The formula allows
control if rsyslog should listen for tcp / udp connections. Further ikml logging (kernel) logging can be disabled, e.g. for lxc containers and logs can be redirected to an other server.

.. note::

   Contributions are welcome.

Available states
================

.. contents::
    :local:

``rsyslog``
------------

Install and configure the ``rsyslog`` package and enable the service.
