#Update the system
echo "Updating the system..."
sudo apt update -y
echo "System update completed."

# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y
echo "Nginx installed."

# Configure Nginx with a custom site
echo "Configuring Nginx for vproapp..."
sudo bash -c 'cat > /etc/nginx/sites-available/vproapp <<EOF
upstream vproapp {
    server app01:8080;
}
server {
    listen 80;
    location / {
        proxy_pass http://vproapp;
    }
}
EOF'
echo "Nginx configuration for vproapp created."

# Remove the default site and enable the new configuration
echo "Removing default Nginx site and enabling vproapp..."
sudo rm -rf /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp
echo "Default site removed, and vproapp enabled."

# Restart Nginx to apply changes
echo "Restarting Nginx..."
sudo systemctl restart nginx
echo "Nginx restarted successfully."

echo "Provisioning for web01 is complete!"
