echo "Creating directories..."
mkdir smart-emacs-setup 
cd smart-emacs-setup
mkdir backup
echo "Backing up old init.el file..."
cp ~/.emacs.d/init.el ./backup/
echo "Downloading new init.el file..."
wget https://raw.githubusercontent.com/gsidh761/smart-emacs-setup/refs/heads/main/init.el
echo "Copying new init.el file to ~/.emacs.d/..."
cp init.el ~/.emacs.d/ 
rm init.el
echo "Done..."

