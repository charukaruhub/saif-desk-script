#!/bin/bash
set -e

echo "🔄 Updating package lists..."
sudo apt-get update

echo "🔧 Fixing missing dependencies..."
sudo apt-get --fix-missing install -y

echo "⬇️ Downloading Chrome Remote Desktop..."
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install -y ./chrome-remote-desktop_current_amd64.deb

echo "🖥 Installing XFCE..."
sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver

echo "🛠 Setting Chrome Remote Desktop session..."
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

echo "🚫 Disabling lightdm..."
sudo systemctl disable lightdm.service

echo "⬇️ Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

echo ""
read -p "🔐 Enter your Chrome Remote Desktop auth code: " AUTH_CODE

echo "🚀 Registering remote desktop host..."
DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="$AUTH_CODE" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)

echo "✅ Setup complete. You can now connect via Chrome Remote Desktop!"
