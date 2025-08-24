# mc01 — Memcached (Manual Setup)

Commands executed on **mc01** to install and expose Memcached. Note the binding to `0.0.0.0` and TCP/UDP ports.

```bash
vagrant ssh mc01
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install memcached -y
sudo systemctl enable memcached
sudo systemctl start memcached
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
sudo systemctl restart memcached
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=11211/tcp
sudo firewall-cmd --runtime-to-permanent 
sudo firewall-cmd --add-port=11111/udp 
sudo firewall-cmd --runtime-to-permanent 
sudo memcached -p 11211 -U 11111 -u memcached -d
```
