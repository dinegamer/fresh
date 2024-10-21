FROM odoo:17.0

USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y postgresql-client

# Copie des addons personnalisés
COPY ./addons /mnt/extra-addons/

# Copie de la configuration
COPY ./config/odoo.conf /etc/odoo/

# Créer le script d'initialisation
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN chown -R odoo:odoo /etc/odoo/odoo.conf /entrypoint.sh

# Configuration du port
ENV PORT=8069
ENV HOST=0.0.0.0
EXPOSE ${PORT}

USER odoo

# Commande de démarrage
ENTRYPOINT ["/entrypoint.sh"]