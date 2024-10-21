FROM odoo:17.0

USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y postgresql-client

# Copie des addons personnalisés
COPY ./addons /mnt/extra-addons/

# Copie de la configuration et du script d'entrée
COPY ./config/odoo.conf /etc/odoo/
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
RUN chown -R odoo:odoo /etc/odoo/odoo.conf /entrypoint.sh

# Configuration du port
ENV PORT=8069
EXPOSE ${PORT}
EXPOSE ${PORT}/tcp

USER odoo

# Utiliser le script comme point d'entrée
ENTRYPOINT ["/entrypoint.sh"]