FROM odoo:17.0

USER root

# Copie des addons personnalisés
COPY ./addons /mnt/extra-addons/

# Copie de la configuration
COPY ./config/odoo.conf /etc/odoo/
RUN chown -R odoo /etc/odoo/odoo.conf

USER odoo