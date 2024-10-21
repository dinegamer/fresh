#!/bin/bash

# Attendre que la base de données soit prête
until PGPASSWORD=${DB_PASSWORD} psql -h ${DB_HOST} -U ${DB_USER} -d ${DB_NAME} -c '\q' 2>/dev/null; do
  echo "Waiting for PostgreSQL..."
  sleep 5
done

echo "PostgreSQL is up - executing command"

# Initialisation de la base de données
odoo --stop-after-init \
     --config=/etc/odoo/odoo.conf \
     --load-language=fr_FR \
     -d ${DB_NAME} \
     --db_host=${DB_HOST} \
     --db_user=${DB_USER} \
     --db_password=${DB_PASSWORD}

# Démarrage d'Odoo
exec odoo --config=/etc/odoo/odoo.conf