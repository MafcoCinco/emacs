;; disable the toolbar
;;
(tool-bar-mode -1)

;; Set the opacity of the frame
(set-frame-parameter (selected-frame) 'alpha '(85 100))
(add-to-list 'default-frame-alist '(alpha 85 100))

;; Set default directory
(setq command-line-default-directory "~/Projects/")

;;;;
;; Packages
;;;;

;; Initialize package repo
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t)
  (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Download the color-theme, if necessary
(unless (package-installed-p 'color-theme)
  (package-install 'color-theme))

;; Download clojure-mode, if necessary
(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

;; Download Interactively Do Things package, if necessary
(unless (package-installed-p 'ido-vertical-mode)
  (package-install 'ido-vertical-mode))

;; Download CIDER, if necessary
(unless (package-installed-p 'cider)
  (package-install 'cider))

;; Download which-key, if necessary
(unless (package-installed-p 'which-key)
  (package-install 'which-key))

;; Download company, if necessary
(unless (package-installed-p 'company)
  (package-install 'company))

;; Download Clojure Refactor tool, if necessary
(unless (package-installed-p 'clj-refactor)
  (package-install 'clj-refactor))

;; Download Rainbow Delims (for paredit), if necessary
(unless (package-installed-p 'rainbow-delimiters)
  (package-install 'rainbow-delimiters))

;; Download YAML mode, if necessary
(unless (package-installed-p 'yaml-mode)
  (package-install 'yaml-mode))

;; Download JSON mode, if necessary
(unless (package-installed-p 'json-mode)
  (package-install 'json-mode))

;; Download Markdown mode, if necessary
(unless (package-installed-p 'markdown-mode)
  (package-install 'markdown-mode))

;; set color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

;; Define he following variables to remove the compile-log warnings
;; when defining ido-ubiquitous
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)
(defvar predicate nil)
(defvar inherit-input-method nil)

;; Enable IDO
(require 'ido)
(ido-mode t)

;; Enabled IDO vertical mode
(require 'ido-vertical-mode)
(ido-vertical-mode t)

;; Enable Which Key
(require 'which-key)
(which-key-mode)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "/usr/local/bin/markdown")
 '(package-selected-packages
   (quote
    (color-theme flymake-json hcl-mode groovy-mode yaml-mode tagedit smex rainbow-delimiters projectile paredit markdown-preview-mode magit ido-vertical-mode ido-ubiquitous exec-path-from-shell clojure-mode-extra-font-locking auto-complete-c-headers auto-complete-auctex ac-cider))))

;;
;; Customizations
;;

;; Make sure emacs can find lein
(add-to-list 'exec-path "/usr/local/bin")

;; Activate company-mode for Clojure dev (company-mode provides type-ahead resolution)
(global-company-mode)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)

;; Activate rainbow-delimiters for Clojure dev
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)

;; Activate paredite-mode for Clojure dev
(add-hook 'clojure-mode-hook #'paredit-mode)

;; Enabled refactoring for Clojure dev
(require 'clj-refactor)
(defun clojure-mode-refactoring-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1)) ; for adding require/use/import statements
;; This choice of keybinding leaves cider-macroexpand-1 unbound
(add-hook 'clojure-mode-hook #'clojure-mode-refactoring-hook)
(cljr-add-keybindings-with-prefix "C-c C-m")

;; Adjust indentation of json-mode
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
