;; Setup environment
(setq inhibit-startup-message t)
(tooltip-mode -1)
(menu-bar-mode -1)
(setq visible-bell t)
(recentf-mode 1)
(save-place-mode 1)
(setq tab-width 4)
(setq truncate-lines t)

;; Turn on line and column numbers globally
(column-number-mode)
(global-display-line-numbers-mode t)

;; Turn off line numbers in specific modes
(defun disable-line-numbers()
  (display-line-numbers-mode 0))

(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode #'disable-line-numbers))

;; global key bindings
(global-set-key [select] 'end-of-line)
(global-set-key "\eOn" ".")
(global-set-key (kbd "C-M-r") 'recentf-open-files)

;; setup packages
(require 'package)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish ivy-mode
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :init (ivy-mode 1))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
		 ("C-x b" . counsel-ibuffer)
		 ("C-x C-f" . counsel-find-file)
		 :map minibuffer-local-map
		 ("C-r" . 'counsel-minibuffer-history))
  :config (setq ivy-initial-inputs-alist nil)) ;; do not start search with ^

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.3))

(use-package doom-themes
;;  :init (load-theme 'doom-dark+ t) ;; use doom-* themes to ensure minibuffers have correct style
)

(use-package doom-modeline
  :init (doom-modeline-mode 1))
(setq doom-modeline-icon nil) ;; turns off doom mode icons

;;for c++ compiles
(defun cplusplus-compile-command(comm)
  (make-local-variable 'compile-command)
  (if (or (file-exists-p "makefile")
           (file-exists-p "Makefile"))
       (setq compile-command "make -k all ")
       (setq compile-command
         (concat comm " "
                   (file-name-nondirectory buffer-file-truename)
                   " -pedantic-errors -Wall -Wconversion -o "
                   (file-name-sans-extension (file-name-nondirectory buffer-file-truename) )))))

;;for java compile
(defun java-compile-command()
  (make-local-variable 'compile-command)
  (setq compile-command (concat "javac " (file-name-nondirectory buffer-file-truename)))
)

;;for php lint
(defun php-compile-command()
  (make-local-variable 'compile-command)
  (setq compile-command (concat "php -l " (file-name-nondirectory buffer-file-truename)))
)

(add-hook 'c++-mode-hook (lambda() (cplusplus-compile-command "g++")))
(add-hook 'c-mode-hook (lambda() (cplusplus-compile-command "gcc")))
(add-hook 'asm-mode-hook (lambda() (cplusplus-compile-command "gcc")))
(add-hook 'java-mode-hook (lambda() (java-compile-command)))
(add-hook 'php-mode-hook (lambda() (php-compile-command)))

(defun c-c++-header ()
  (interactive)
  (let ((c-file (concat (substring (buffer-file-name) 0 -1) "c")))
    (if (file-exists-p c-file)
        (c-mode)
      (c++-mode))))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-c++-header))

(defun my-c-style ()
  "loads my custom c-style."
  (c-set-style "stroustrup")
  (c-set-offset 'inline-open '0)
  (setq c-indent-comments-syntactically-p t
	indent-tabs-mode nil
        case-fold-search nil
        c-recognize-knr-p nil
        c-auto-newline nil))
(add-hook 'c-mode-common-hook 'my-c-style)

;; customize compilation buffer
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" default)))
 '(package-selected-packages (quote (counsel which-key ivy-rich ivy use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
