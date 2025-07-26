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

echo "📡 Installing NetworkManager..."
sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes network-manager network-manager-gnome

echo "▶️ Enabling and starting NetworkManager (if supported)..."
if pidof systemd &>/dev/null; then
    sudo systemctl enable NetworkManager
    sudo systemctl start NetworkManager
else
    echo "⚠️ systemd is not running (likely GitHub Actions or a container). Skipping enable/start."
fi

echo "🛠 Setting Chrome Remote Desktop session..."
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

echo "⬇️ Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo ""
echo "✅ System setup complete."
echo "🔚 Now open the following page on your browser to register Chrome Remote Desktop:"
echo "🔗 https://remotedesktop.google.com/headless"
echo "📋 Select 'Debian Linux' and run the provided command manually."
echo ""
