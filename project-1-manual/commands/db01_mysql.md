# db01 — MySQL (Manual Setup)

The following commands were executed on **db01** to install and configure MariaDB/MySQL, initialize the `accounts` database, and open firewall ports.

```bash
vagrant ssh db01 
sudo  dnf update -y 
sudo dnf install epel-release -y 
sudo dnf install git mariadb-server -y 
sudo systemctl enable mariadb --now 
sudo mysql 
USE mysql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
exit
sudo mysql_secure_installation
admin123
n
n
y
n
y
y
mysql -u root -padmin123
create database accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'admin123';
FLUSH PRIVILEGES;
exit
git clone -b main https://github.com/hkhcoder/vprofile-project.git 
mysql -u root -padmin123 accounts < vprofile-project/src/main/resources/db_backup.sql
sudo systemctl restart mariadb
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl restart mariadb
```
