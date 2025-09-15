# Smart Emacs Setup  
### One-command install for auto-completion, header insertion, and productivity tweaks.  

**Quick Start:**  
```bash
wget https://raw.githubusercontent.com/gsidh761/smart-emacs-setup/refs/heads/main/setup.sh && chmod +x setup.sh && ./setup.sh```

**Current Issues**
1. Auto header insertion seems to be broken

**How It Works**  
1. Copies the old `init.el` file to the `smart-emacs-setup` folder.  
2. Downloads the latest modified `init.el` from this GitHub repo.  
3. Copies it to the `~/.emacs.d/` folder.  
4. Installs missing packages such as `company-mode` using Emacs.  
