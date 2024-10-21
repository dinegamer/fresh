FROM odoo:17.0

USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y postgresql-client

# Copie des addons personnalisés
COPY ./addons /mnt/extra-addons/

# Copie de la configuration
COPY ./config/odoo.conf /etc/odoo/

COPY ./init.sql /docker-entrypoint-initdb.d/
# Créer un script d'initialisation
RUN echo '#!/bin/bash\n\
odoo --stop-after-init --config=/etc/odoo/odoo.conf -i base\n\
exec odoo --config=/etc/odoo/odoo.conf\n'\
> /entrypoint.sh && chmod +x /entrypoint.sh

RUN chown -R odoo /etc/odoo/odoo.conf /entrypoint.sh

# Configuration du port
ENV PORT=8069
EXPOSE ${PORT}
EXPOSE ${PORT}/tcp

USER odoo

# Utiliser le nouveau script comme point d'entrée
CMD ["/entrypoint.sh"]