# web01 — Nginx Reverse Proxy (Manual Setup)

Commands executed on **web01** to install Nginx and configure a reverse proxy upstream to `app01:8080`.

```bash
vagrant ssh web01
sudo apt update
sudo apt install nginx -y
sudo vim /etc/nginx/sites-available/vproapp
--------------------------------------
press i 
paste this:


upstream vproapp {
server app01:8080;
}
server {
listen 80;
location / {
proxy_pass http://vproapp;
}
}

press esc
press :wq
-------------------------------------------
sudo rm -rf /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
sudo systemctl restart nginx
```
