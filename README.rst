rsyslog-formula
===============

Configures and starts rsyslog service. Currently the log file schema is based on the debian default. The formula allows
control if rsyslog should listen for tcp / udp connections. Further ikml logging (kernel) logging can be disabled, e.g. for lxc containers.
It supports both a client only (sending all logs to another machine) and a server side (receiving logs from mulitple other machines).

.. note::

   Contributions are welcome.

Available states
================

.. contents::
    :local:

``rsyslog``
------------

Install and configure the ``rsyslog`` package and enable the service. See the `pillar.example` file for configuration.

Changelog
================
Recently the default rules were moved from `rsyslog.conf` to `50-default.conf`. This file will be loaded if the `rsyslog:custom` pillar isnt set. However, if your `rsyslog:custom` specifies other files to include, you must add the `50-default.conf` as well!
