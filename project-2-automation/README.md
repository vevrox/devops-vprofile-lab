# Project 2 — Automating Build of Multi-Tier Java Web Application On-Prem Using Shell Scripts

This project turns the manual steps from Project 1 into **shell-provisioned VMs** using Vagrant.

## Hosts & Roles
- `db01` — MariaDB
- `mc01` — Memcached
- `rmq01` — RabbitMQ
- `app01` — Tomcat + Java app deploy (Maven build)
- `web01` — Nginx reverse proxy (Ubuntu)

## Quickstart
1. Install **VirtualBox** and **Vagrant**.
2. (Optional) install the host manager plugin to auto-manage `/etc/hosts`:
   ```bash
   vagrant plugin install vagrant-hostmanager
   ```
3. From this folder:
   ```bash
   vagrant up
   ```
   This launches 5 VMs and runs the provisioner scripts in `./scripts/`.

## Notes
- Secrets/passwords in the scripts are **examples only**. Change them before running in any shared or public environment.
- Scripts are intentionally close to the manual baseline; they may not be fully idempotent (re-running may require small tweaks).
- `web01` uses Ubuntu (APT) to match its Nginx config style; other nodes use RHEL-like (DNF/YUM). Adjust base boxes as needed.
