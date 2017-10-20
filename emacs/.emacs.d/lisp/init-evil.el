
;;
;; init-evil.el
;; Config File to Enable VIM like Behavior
;;

;; Install Evil Related Plug-Ins
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (setq evil-want-C-u-scroll t)
  
  (use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode))

  (use-package evil-jumper
  :ensure t
  :config
  (global-evil-jumper-mode))

  (use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))

  (use-package evil-indent-textobject
  :ensure t)
)

;; Enable Emulated VIM Search
(evil-mode 1)
(add-hook 'occur-mode-hook
          (lambda ()
            (evil-add-hjkl-bindings occur-mode-map 'emacs
              (kbd "/")       'evil-search-forward
              (kbd "n")       'evil-search-next
              (kbd "N")       'evil-search-previous
              (kbd "C-d")     'evil-scroll-down
              (kbd "C-u")     'evil-scroll-up
              (kbd "C-w C-w") 'other-window)))

;; Move Block of Text
(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1))))
)

;; Move Down Block of Text
(defun move-text-down (arg)
    "Move region (transient-mark-mode active) or current line
     arg lines down."
    (interactive "*p")
    (move-text-internal arg)
)

;; Move Up Block of Text
(defun move-text-up (arg)
    "Move region (transient-mark-mode active)
    or current linearg lines up."
    (interactive "*p")
    (move-text-internal (- arg))
)

;; Shift Left or Right
(defun unindent-dwim (&optional count-arg)
  "Keeps relative spacing in the region.  Unindents to the next multiple of the current tab-width"
  (interactive)
  (let ((deactivate-mark nil)
        (beg (or (and mark-active (region-beginning)) (line-beginning-position)))
        (end (or (and mark-active (region-end)) (line-end-position)))
        (min-indentation)
        (count (or count-arg 1)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (add-to-list 'min-indentation (current-indentation))
        (forward-line)))
    (if (< 0 count)
        (if (not (< 0 (apply 'min min-indentation)))
            (error "Can't indent any more.  Try `indent-rigidly` with a negative arg.")))
    (if (> 0 count)
        (indent-rigidly beg end (* (- 0 tab-width) count))
      (let (
            (indent-amount
             (apply 'min (mapcar (lambda (x) (- 0 (mod x tab-width))) min-indentation))))
        (indent-rigidly beg end (or
                                 (and (< indent-amount 0) indent-amount)
                                 (* (or count 1) (- 0 tab-width))))))))

;; Move Text Up and Down
(define-key evil-normal-state-map (kbd "C-k") 'move-text-up)
(define-key evil-normal-state-map (kbd "C-j") 'move-text-down)

;; Key Bindings
(with-eval-after-load 'evil-maps

  ;; Remap Prompt
  (define-key evil-motion-state-map ";" 'evil-ex)
  (define-key evil-motion-state-map ":" nil)

  ;; Remap Insert Keys
  (define-key evil-normal-state-map "o" 'evil-append)
  (define-key evil-normal-state-map "O" 'evil-append-line)
  (define-key evil-visual-state-map "O" 'evil-append)
  (define-key evil-normal-state-map "i" 'evil-insert)
  (define-key evil-normal-state-map "I" 'evil-insert-line)
  (define-key evil-visual-state-map "O" 'evil-insert)
  (define-key evil-normal-state-map "a" 'evil-open-below)
  (define-key evil-normal-state-map "A" 'evil-open-above)

  ;; Unbind Arrow Keys
  (define-key evil-motion-state-map [left] nil)
  (define-key evil-motion-state-map [right] nil)
  (define-key evil-motion-state-map [up] nil)
  (define-key evil-motion-state-map [down] nil)

  ;; Indent Block Left or Right
  (define-key evil-normal-state-map "\C-l" (lambda () (interactive) (unindent-dwim -1)))
  (define-key evil-normal-state-map "\C-h" 'unindent-dwim)

  ;; VIM like Tab Behavoir
  (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

  ;; Unmap Ctrl N
  (define-key evil-normal-state-map "\C-n" nil)

  ;; Start at Beginening of Text Rather Than Line
  (define-key evil-motion-state-map "j" 'evil-next-line-first-non-blank)
  (define-key evil-motion-state-map "k" 'evil-previous-line-first-non-blank)

  ;; Navigate Splits
  (define-key evil-motion-state-map "\M-j" 'evil-window-down)
  (define-key evil-motion-state-map "\M-k" 'evil-window-up)
  (define-key evil-motion-state-map "\M-h" 'evil-window-left)
  (define-key evil-motion-state-map "\M-l" 'evil-window-right)

  (define-key evil-motion-state-map "\M-J" 'evil-window-increase-height)
  (define-key evil-motion-state-map "\M-K" 'evil-window-decrease-height)
  (define-key evil-motion-state-map "\M-H" 'evil-window-increase-width)
  (define-key evil-motion-state-map "\M-L" 'evil-window-decrease-width)


  ;; Home Goes to Start of Text
  (define-key evil-motion-state-map (kbd "<home>") 'evil-first-non-blank-of-visual-line)
)

;; Neotree Binds
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter-vertical-split)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "/C-n") 'neotree-toggle)

(provide 'init-evil)
