
;;
;; .emacs
;; Main emacs Config File
;;

;;
;; Plug-Ins
;;

;; Load Package.el
(require 'package)

;; Load MELPA Repository
(when (>= emacs-major-version 24)
    (require 'package)
    (add-to-list
        'package-archives
        '("melpa" . "http://melpa.milkbox.net/packages/")
        t)
    )

;; Disable Plug-Ins at Startup
(setq package-enable-at-startup nil)

;; Initialize Packages
(package-initialize)

;; Custom File
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(use-package load-dir
    :ensure t)

;; Evil Packages
(load-file "~/.emacs.d/lisp/init-evil.el")
(require 'init-evil)

(use-package telephone-line
    :ensure t)

(use-package powerline
    :ensure t)

(use-package powerline-evil
    :ensure t)

(use-package magit
    :ensure t)

(use-package neotree
    :ensure t)

(use-package org
    :ensure t)

(use-package org-plus-contrib
    :ensure t)

(use-package helm
    :ensure t)

(use-package which-key
    :ensure t)

(use-package highlight-symbol
    :ensure t)

;; Load Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/challenger-deep")
(load-theme 'challenger-deep t)

;; Enable Powerline in VIM Mode
(telephone-line-evil-config)

;; Org Mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Neotree Toggle
(global-set-key (kbd "M-n") 'neotree-toggle)

;; Enable Which Key
(which-key-mode)

;; Highlight?
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;;
;; Behavior
;;

;; Disable Splash Screen and Startup Message
(setq inhibit-splash-screen t
    inhibit-startup-message t
    inhibit-startup-echo-area-message t)

;; Disable Menu and Toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Hide Scroll Bar
(when (boundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

;; Show Matching Pairs of Parentheses
(show-paren-mode 1)

;; Wrapped Lines
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
(setq-default left-fringe-width nil)
(setq-default indicate-empty-lines t)
(setq-default indent-tabs-mode nil)

;; Disable Sounds
(setq visible-bell t)

;; No Warning for Large Files
(setq large-file-warning-threshold nil)

;; Allows Symlinks
(setq vc-follow-symlinks t)

;; Default Split is Vertical
(setq split-width-threshold nil)

;; Allow Custom Themes
(setq custom-safe-themes t)

;; Disable Auto-Save and Auto-Backup
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Set Title Bar
(setq frame-title-format "%b - emacs")

;; Show Tabulators
(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
;;(let ((d (make-display-table)))
;;(aset d 9 (vector ?| ?|))
;;(set-window-display-table nil d))

;; Show Line Numbers
(column-number-mode t)
(global-linum-mode t)

;; Highlight Current Line
(global-hl-line-mode 1)

;; Use Spaces
(setq-default tab-width 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
;;(setq indent-line-function 'insert-tab)
;;(setq tab-stop-list (number-sequence 4 200 4))

;; Set Font
(set-frame-font "Meslo LG M Regular for Powerline 12" nil t)

;;
;; Functions
;;

;; Tab Function
(defun my-insert-tab-char ()
   "Insert a tab char. (ASCII 9, \t)"
   (interactive)
   (insert "\t"))

;; Backspace Function
(defvar my-offset 4 "My indentation offset. ")
(defun backspace-whitespace-to-tab-stop ()
  "Delete whitespace backwards to the next tab-stop, otherwise delete one character."
  (interactive)
  (if (or indent-tabs-mode
          (region-active-p)
          (save-excursion
            (> (point) (progn (back-to-indentation)
                              (point)))))
    (call-interactively 'backward-delete-char-untabify)
    (let ((movement (% (current-column) my-offset))
          (p (point)))
      (when (= movement 0) (setq movement my-offset))
      (setq movement (min (- p 1) movement))
      (save-match-data
        (if (string-match "[^\t ]*\\([\t ]+\\)$" (buffer-substring-no-properties (- p movement) p))
            (backward-delete-char (- (match-end 1) (match-beginning 1)))
          (call-interactively 'backward-delete-char))))))

;; Convert to Spaces on Open
(defvar untabify-this-buffer)
 (defun untabify-all ()
   "Untabify the current buffer, unless `untabify-this-buffer' is nil."
   (and untabify-this-buffer (untabify (point-min) (point-max))))
 (define-minor-mode untabify-mode
   "Untabify buffer on save." nil " untab" nil
   (make-variable-buffer-local 'untabify-this-buffer)
   (setq untabify-this-buffer (not (derived-mode-p 'makefile-mode)))
   (add-hook 'before-save-hook #'untabify-all))
   (add-hook 'prog-mode-hook 'untabify-mode)

;;
;; Mappings
;;

;; Unbind Arrow Keys
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

;; Insert Tab on Tab
;;(global-set-key [tab] 'my-insert-tab-char)

;; Backspace in Tabs like Increments
(global-set-key [backspace] 'backspace-whitespace-to-tab-stop)
