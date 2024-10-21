FROM odoo:17.0

USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y postgresql-client

# Copie des addons personnalisés
COPY ./addons /mnt/extra-addons/

# Copie de la configuration
COPY ./config/odoo.conf /etc/odoo/
RUN chown -R odoo /etc/odoo/odoo.conf

# Configuration du port
ENV PORT=8069
EXPOSE 8069

USER odoo

# Commande de démarrage
CMD ["odoo", "--config=/etc/odoo/odoo.conf"]