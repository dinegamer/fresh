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

# Créer l'utilisateur admin si non existant
psql postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME} << EOF
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT * FROM res_users WHERE login='admin') THEN
        INSERT INTO res_users (login, password, active, company_id, partner_id)
        VALUES ('admin', 'admin', true, 1, 1);
    END IF;
END
\$\$;
EOF

# Démarrer Odoo
exec odoo --config=/etc/odoo/odoo.conf