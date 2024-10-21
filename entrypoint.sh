#!/bin/bash
# Attendre que la base de données soit prête
until psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME} -c '\q'; do
  echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "Postgres is up - executing command"

# Initialiser la base de données et créer l'utilisateur admin
odoo --stop-after-init --config=/etc/odoo/odoo.conf -i base --load-language=fr_FR --init=base \
  --database=${DB_NAME} \
  --db_host=${DB_HOST} \
  --db_password=${DB_PASSWORD} \
  --db_user=${DB_USER} \
  --no-database-list

# Restaurer les données si nécessaire (ajoutez cette partie)
if [ -f "/mnt/extra-addons/backup.sql" ]; then
    echo "Restauration des données..."
    psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME} < /mnt/extra-addons/backup.sql
fi

# Nettoyer le cache et reconstruire les assets
echo "Nettoyage du cache..."
rm -rf /var/lib/odoo/.local/share/Odoo/sessions/*
echo "Reconstruction des assets..."
odoo --stop-after-init --config=/etc/odoo/odoo.conf -d ${DB_NAME} -u base --no-http

# Démarrer Odoo
exec odoo --config=/etc/odoo/odoo.conf