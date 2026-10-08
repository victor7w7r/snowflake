;;; ide.el -*- lexical-binding: t; -*-

;;
;; Treemacs
(setq treemacs-width 30)
(lsp-treemacs-sync-mode 1)

;;
;; Projectile
(after! projectile
  (add-hook 'projectile-after-switch-project-hook
            (lambda ()
              (treemacs-add-and-display-current-project)
              (treemacs-select-window))))

(setq projectile-project-search-path '("~/repositories/"))
