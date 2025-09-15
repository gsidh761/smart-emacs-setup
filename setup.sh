echo "Creating directories..."
mkdir smart-emacs-setup 
cd smart-emacs-setup
mkdir backup
echo "Backing up old init.el file..."
cp ~/.emacs.d/init.el ./backup/
echo "Downloading new init.el file..."
curl https://raw.githubusercontent.com/gsidh761/smart-emacs-setup/refs/heads/main/init.el --output init.el
echo "Copying new init.el file to ~/.emacs.d/..."
cp init.el ~/.emacs.d/ 
rm init.el
echo "Installing Packages..."
emacs --batch --eval "
(require 'package)
(add-to-list 'package-archives '(\"melpa\" . \"https://melpa.org/packages/\") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install 'company)
(package-install 'cpp-auto-include)
"
echo "Done..."

