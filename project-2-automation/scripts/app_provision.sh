# Update the system
echo "Updating the system..."
sudo dnf update -y
echo "System update completed."

# Install necessary packages
echo "Installing epel-release, Java 11, Git, Maven, and Wget..."
sudo dnf install epel-release -y
sudo dnf install java-11-openjdk java-11-openjdk-devel git maven wget -y
echo "Required packages installed."

# Download and set up Apache Tomcat
echo "Downloading and setting up Apache Tomcat..."
cd /tmp/
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
tar xzvf apache-tomcat-9.0.75.tar.gz
cd apache-tomcat-9.0.75
sudo useradd tomcat -md /usr/local/tomcat -s /sbin/nologin
sudo cp * /usr/local/tomcat/ -r
sudo chown -R tomcat:tomcat /usr/local/tomcat
echo "Apache Tomcat installed and configured."

# Create and configure the Tomcat service
echo "Configuring the Tomcat service..."
sudo bash -c 'cat > /etc/systemd/system/tomcat.service <<EOF
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
EOF'
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
echo "Tomcat service configured, started, and enabled."

# Start and configure the firewall
echo "Starting and configuring the firewall..."
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
echo "Firewall configured for Tomcat."

# Clone the project repository
echo "Cloning the project repository..."
cd /tmp
git clone -b main https://github.com/hkhcoder/vprofile-project.git
echo "Project repository cloned."

# Build the project with Maven
echo "Building the project with Maven..."
cd /tmp/vprofile-project
mvn install
echo "Project built successfully."

# Deploy the application to Tomcat
echo "Deploying the application to Tomcat..."
sudo systemctl stop tomcat
sudo rm -rf /usr/local/tomcat/webapps/ROOT
sudo cp /tmp/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /usr/local/tomcat/webapps -R
sudo systemctl start tomcat
echo "Application deployed to Tomcat."

# Remove unnecessary Java versions
echo "Removing unnecessary Java versions..."
sudo rpm -qa | grep java
sudo dnf remove java-17-openjdk-17.0.13.0.11-4.el9.x86_64 -y
sudo rpm -qa | grep java
sudo dnf remove java-17-openjdk-headless-17.0.13.0.11-4.el9.x86_64 -y
echo "Unnecessary Java versions removed."

# Final deployment verification
echo "Verifying and redeploying application to Tomcat..."
sudo cp /tmp/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war
sudo systemctl stop tomcat
sudo systemctl start tomcat
echo "Final deployment and verification complete."

echo "Provisioning for app01 is complete!"