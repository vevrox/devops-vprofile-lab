# Architecture & Ports (Project 1)

**Hosts**
- `db01` — MySQL/MariaDB (TCP 3306)
- `mc01` — Memcached (TCP 11211, UDP 11111)
- `rmq01` — RabbitMQ (TCP 5672)
- `app01` — Tomcat (TCP 8080)
- `web01` — Nginx (TCP 80 → upstream `app01:8080`)

**Flow**
Client → `web01:80` (Nginx) → `app01:8080` (Tomcat) → caches (`mc01:11211`) and DB (`db01:3306`); async tasks via `rmq01:5672`.

This matches the manual bring-up order you’ll see in `project-1-manual/commands/`.
