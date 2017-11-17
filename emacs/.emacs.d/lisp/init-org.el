(use-package org
    :ensure t)

(use-package org-plus-contrib
    :ensure t)

(use-package org-bullets
    :ensure t)

(use-package ox-md
    :ensure t)

(use-package ox-twbs
    :ensure t)

(use-package ox-beamer
    :ensure t)

(setq org-agenda-window-setup (quote current-window))

(setq org-blank-before-new-entry (quote ((heading) (plain-list-item))))

(setq org-enforce-todo-dependencies t)

(setq org-agenda-files '("D:/Documents/JVD Docs/Documents/School/UVIC/2017"))

;; (setq org-ellipsis " ⤵")
(setq org-ellipsis ".")

(setq org-todo-keywords
    '((sequence "STUDY" "TODO" "IN-PROGRESS" "NEAR-COMPLETION"
                "WAITING" "REVIEW" "|" "DONE" "CANCELED")))

(setq org-log-done (quote time))
(setq org-log-redeadline (quote time))
(setq org-log-reschedule (quote time))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-hide-leading-stars t)
(setq org-src-window-setup 'current-window)

(defun org-mark-done-and-archive ()
    "Mark the state of an org-mode item as DONE and archive it."
    (interactive)
    (org-todo 'done)
    (org-archive-subtree))

(define-key global-map "\C-cl" 'org-store-link)

(define-key global-map "\C-ca" 'org-agenda)

(provide 'init-org)
