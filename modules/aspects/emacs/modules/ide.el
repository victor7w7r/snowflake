;;; ide.el -*- lexical-binding: t; -*-

;;
;; Super Save
(use-package! super-save
  :config
  (super-save-mode t)

  (setq super-save-silent t)
  (setq super-save-remote-files nil)
  (setq super-save-auto-save-when-idle t)
  (setq super-save-idle-duration 1.0
  (add-to-list 'super-save-triggers 'focus-out-hook)
  (add-to-list 'super-save-triggers 'switch-to-buffer)
  (add-hook 'evil-insert-state-exit-hook #'super-save-command))

;;
;; Treemacs
(setq treemacs-width 30)
(lsp-treemacs-sync-mode 1)
(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

;;
;; Projectile
(after! projectile
  (add-hook 'projectile-after-switch-project-hook
            (lambda ()
              (treemacs-add-and-display-current-project)
              (treemacs-select-window))))

(setq projectile-project-search-path '("~/repositories/"))
