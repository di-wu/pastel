;; Initial (blank) screen.
(setq inhibit-startup-message t) ; Removes startup message.
(scroll-bar-mode -1)             ; Removes toolbars.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; A (placeholder) dark theme. 
(load-theme 'deeper-blue)
;; TODO: Replace with custom theme.
;; Type `M-x load-theme` to see a list of available themes.

;; Package sources.
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
; Checks whether a package archive are already installed.
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))      ; Refreshes the contents.
; Installs use-package if not already exists.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)             ; Loads use-package.
(setq use-package-always-ensure t) ; Ensure all packages are installed.

;; Ivy (completion)
;; Manual: https://oremacs.com/swiper
(use-package counsel
  :config
  (ivy-mode 1)
  (counsel-mode 1))
(use-package ivy-rich
  :config
  (ivy-rich-mode 1))

;; Cancel prompt with ESC
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Line Numbers
(global-display-line-numbers-mode t)
(column-number-mode)
;; Disable line numbers in the following modes.
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Which Key
(use-package which-key
  :config
  (which-key-mode))

;; Modes

;; Golang
(use-package go-mode
  :ensure t
  :bind (
	 :map go-mode-map
	      ("C-c C-f . gofmt"))
  :config (add-hook 'before-save-hook 'gofmt-before-save))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode) ; GitHub flavored Markdown files.
         ("\\.md\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Prolog
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))
