#!/bin/bash

# Attendre que PostgreSQL soit prêt
until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  echo "PostgreSQL n'est pas disponible - attente..."
  sleep 1
done

echo "PostgreSQL est prêt - démarrage d'Odoo"

# Démarrer Odoo
exec odoo --workers=2