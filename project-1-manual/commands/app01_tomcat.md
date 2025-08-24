# app01 — Tomcat & App Deploy (Manual Setup)

Commands executed on **app01** to install JDK/Maven, deploy Tomcat 9.0.75 as a systemd service, build the Java app with Maven, and deploy `ROOT.war`.

```bash
vagrant ssh app01
sudo dnf update -y
sudo dnf install epel-release -y
sudo dnf install java-11-openjdk java-11-openjdk-devel git maven wget -y
cd /tmp/
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
tar xzvf apache-tomcat-9.0.75.tar.gz
cd apache-tomcat-9.0.75
sudo useradd tomcat -md /usr/local/tomcat -s /sbin/nologin
sudo  cp * /usr/local/tomcat/ -r
sudo chown -R tomcat:tomcat /usr/local/tomcat
sudo vim /etc/systemd/system/tomcat.service
-----------------------------------------------
press i
paste this:

[Unit]
Description=Tomcat
After=network.target
[Service]
User=tomcat
WorkingDirectory=/usr/local/tomcat
Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINE_BASE=/usr/local/tomcat
ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh
SyslogIdentifier=tomcat-%i
[Install]
WantedBy=multi-user.target

press esc
press :wq
------------------------------------------------
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload

cd
cd /tmp
git clone -b main https://github.com/hkhcoder/vprofile-project.git

cd vprofile-project
mvn install

sudo systemctl stop tomcat
sudo  rm -rf /usr/local/tomcat/webapps/ROOT
sudo cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
sudo chown tomcat.tomcat /usr/local/tomcat/webapps -R
sudo systemctl start tomcat
sudo rpm -qa | grep java
sudo dnf remove java-17-openjdk-17.0.13.0.11-4.el9.x86_64 -y
sudo rpm -qa | grep java
sudo dnf remove java-17-openjdk-headless-17.0.13.0.11-4.el9.x86_64 -y
sudo cp /tmp/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
sudo -i
cd /usr/local/tomcat/
chown tomcat:tomcat webapps/ROOT.war
systemctl stop tomcat
chown tomcat:tomcat webapps/ROOT.war
systemctl start tomcat
```
