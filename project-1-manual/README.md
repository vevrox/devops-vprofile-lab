# Project 1 — Manual Build (SSH-based)

This directory contains the **exact commands** I used to build a multi-tier Java web app locally on separate VMs.  
It mirrors the order of dependencies and records the final firewall/ports for each service.

## Commands per host
- `commands/db01_mysql.md`
- `commands/mc01_memcache.md`
- `commands/rmq01_rabbitmq.md`
- `commands/app01_tomcat.md`
- `commands/web01_nginx.md`

## Notes
- Replace sample passwords before reusing in other environments.
- If you publish this, consider redacting sensitive values and using environment variables.
