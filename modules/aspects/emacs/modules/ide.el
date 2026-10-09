;;; ide.el -*- lexical-binding: t; -*-

;;
;; Super Save
(use-package! super-save
  :config
  (setq super-save-silent t)
  (setq super-save-remote-files nil)
  (setq super-save-auto-save-when-idle nil)
  (add-to-list 'super-save-hook-triggers 'find-file-hook)
  (add-to-list 'super-save-triggers 'ace-window 'delete-window)
  (add-to-list 'super-save-triggers '+default/search-project)
  (super-save-mode t))

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
