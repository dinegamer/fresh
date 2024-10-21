#!/bin/bash
# Attendre que la base de données soit prête
until psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME} -c '\q'; do
  echo "Postgres is unavailable - sleeping"
  sleep 1
done

echo "Postgres is up - executing command"

# Initialiser la base de données si nécessaire
odoo --stop-after-init --config=/etc/odoo/odoo.conf -i base

# Démarrer Odoo
exec odoo --config=/etc/odoo/odoo.conf