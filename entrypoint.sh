#!/bin/bash
odoo --stop-after-init --config=/etc/odoo/odoo.conf -i base
exec odoo --config=/etc/odoo/odoo.conf