# Saif Desk Script 🖥️

Automated setup for:

- Chrome Remote Desktop
- XFCE Desktop Environment
- Google Chrome

## 🔧 Installation (Manual)

```bash
wget https://raw.githubusercontent.com/YOUR_USERNAME/saif-desk-script/main/setup.sh
chmod +x setup.sh
./setup.sh
```

You will be asked to enter your Chrome Remote Desktop Auth Code from:

👉 https://remotedesktop.google.com/headless

## 🔄 Automatic Execution (via GitHub Actions)

On every push to `main`, GitHub will automatically attempt to run `setup.sh`.

> ⚠️ Works on self-hosted runners only. GUI/Remote Desktop needs access to display manager.
