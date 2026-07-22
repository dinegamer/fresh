# Odoo Deployment Blueprint

Containerized deployment configuration for an **Odoo 17** environment backed by PostgreSQL.

## Included

- Odoo 17 Python dependency
- Docker and Docker Compose configuration
- Render deployment blueprint
- Database initialization and maintenance scripts
- Custom add-ons directory
- Environment-based database configuration

## Security

Credentials are intentionally excluded from the repository. Configure `DB_HOST`, `DB_USER`, `DB_PASSWORD` and `DB_NAME` as secret environment variables in the deployment platform.

## Local setup

1. Create a local `.env` file from your own secure values.
2. Start the services:

```bash
docker compose up --build
```

3. Open Odoo on the port configured for the service.

## Author

**Chamsoudine THIENTA (Shams)** — Software Engineer & Data Analyst  
[Portfolio](https://shamsi-dev.vercel.app) · [LinkedIn](https://www.linkedin.com/in/chamsoudine-thienta)
