
;;
;; init-helm.el
;; Config File for Helm
;;

(use-package helm
    :ensure t)

(use-package projectile
    :ensure t)

(use-package helm-projectile
    :ensure t)

;; Helm
(helm-mode 1)
(setq helm-buffers-fuzzy-matching t)
(setq helm-autoresize-mode t)
(setq helm-buffer-max-length 40)
(setq helm-split-window-in-side-p t)

;; Projectile
(projectile-mode 1)
(helm-projectile-on)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Keymaps
(define-key helm-map (kbd "S-SPC") 'helm-toggle-visible-mark)
(define-key helm-find-files-map (kbd "C-b") 'helm-find-files-up-one-level)
(define-key helm-find-files-map (kbd "C-f") 'helm-find-files-down-last-level)

;; Helm on Meta X
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "<menu>") #'helm-M-x)

;; Helm Find Files
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x f") 'helm-recentf)

;; Imenu
(global-set-key (kbd "C-x C-r") 'imenu)

;; Git
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-g") 'magit-diff)

;; Ranger
(global-set-key (kbd "C-x C-d") 'ranger)
(global-set-key (kbd "C-x d") 'deer)

;; Quick Switch Buffer
(global-set-key (kbd "C-x b") 'evil-switch-to-windows-last-buffer)
(global-set-key (kbd "C-x C-b") #'helm-mini)

;; Quick Kill Buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x C-k") 'kill-buffer)

;; Eshell
(global-set-key (kbd "C-x C-e") 'eshell)
(global-set-key (kbd "C-x e") 'new-eshell)

(provide 'init-helm)
