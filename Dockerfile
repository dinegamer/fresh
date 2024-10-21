FROM odoo:17.0

USER root

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Configuration des répertoires et permissions
RUN mkdir -p /var/lib/odoo/.local/share/Odoo/filestore \
    && chown -R odoo:odoo /var/lib/odoo

# Copie des fichiers de configuration
COPY --chown=odoo:odoo ./config/odoo.conf /etc/odoo/
COPY --chown=odoo:odoo ./entrypoint.sh /
COPY --chown=odoo:odoo ./addons /mnt/extra-addons/

# Rendre le script executable
RUN chmod +x /entrypoint.sh

# Configuration pour Render
ENV PORT=8069
ENV HOST=0.0.0.0
ENV WORKERS=2

# Exposition du port
EXPOSE ${PORT}

# Retour à l'utilisateur odoo
USER odoo

# Configuration du healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:${PORT}/web/health || exit 1

ENTRYPOINT ["/entrypoint.sh"]