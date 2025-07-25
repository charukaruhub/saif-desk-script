#!/bin/bash
set -e

echo "🔄 Updating package lists..."
sudo apt-get update

echo "🔧 Fixing missing dependencies..."
sudo apt-get --fix-missing install -y

echo "⬇️ Downloading Chrome Remote Desktop..."
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo apt install -y ./chrome-remote-desktop_current_amd64.deb
rm chrome-remote-desktop_current_amd64.deb

echo "🖥 Installing XFCE desktop environment..."
sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver

echo "🛠 Setting Chrome Remote Desktop session..."
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

echo "🚫 Disabling lightdm to prevent conflict with CRD..."
sudo systemctl disable lightdm.service

echo "⬇️ Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo ""
echo "✅ System setup complete. Now you need to register this machine with Chrome Remote Desktop."

echo "📋 Please go to: https://remotedesktop.google.com/headless"
echo "🔐 Select 'Debian Linux' and copy the entire registration command starting with:"
echo "    DISPLAY= /opt/google/chrome-remote-desktop/start-host ..."
echo ""
read -p "👉 Paste the full registration command here: " FULL_CMD

echo "🚀 Running your registration command..."
eval "$FULL_CMD"

echo ""
echo "✅ Chrome Remote Desktop setup is now complete!"
echo "💡 You can now access this machine remotely from your Google account."
