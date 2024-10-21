FROM odoo:17.0
USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y postgresql-client

# Copie des addons personnalisés
COPY ./addons /mnt/extra-addons/

# Copie de la configuration
COPY ./config/odoo.conf /etc/odoo/
RUN chown -R odoo /etc/odoo/odoo.conf

USER odoo

# Le port que Render cherche
ENV PORT=8069

# Commande de démarrage directe d'Odoo
CMD ["odoo", "--config=/etc/odoo/odoo.conf"]