#!/bin/bash

# CONFIGURATION
LOCAL_DIR="/path/to/your/local/site/"       # <-- change to your local site path
REMOTE_USER="your-username"                 # <-- change to your SSH username
REMOTE_HOST="your.server.com"               # <-- change to your server address
REMOTE_DIR="/var/www/html/"                 # <-- change to your destination directory on the server. Ensure you have write permission to upload into this directory. # ON THE SERVER RUN
# sudo chown -R your-username:www-data /var/www/html
# sudo chmod -R 775 /var/www/html

# To know your username: RUN
# whoami

SSH_PORT=22                                 # <-- change this if your server uses a different SSH port
SSH_KEY_PEM="/path/to/your/key-pair.pem"  # <-- change this to the location of your key-pair .pem file

EXCLUDES=(
  "--exclude=.git"
  "--exclude=node_modules"
  "--exclude=.env"
  "--exclude=*.log"
)

# DEPLOYMENT
echo "...Starting upload to $REMOTE_USER@$REMOTE_HOST..."

rsync -avz -e "sudo ssh -i $SSH_KEY_PEM -p $SSH_PORT" "${EXCLUDES[@]}" "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

if [ $? -eq 0 ]; then
  echo "✅ Deployment successful!"
else
  echo "❌ Deployment failed. Check your connection and paths."
fi

