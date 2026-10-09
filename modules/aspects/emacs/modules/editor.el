;;; editor.el -*- lexical-binding: t; -*-

;; Editor Utils
(auto-rename-tag-mode t)
(drag-stuff-mode t)
(colorful-mode 1)
(global-evil-matchit-mode 1)
(global-hungry-delete-mode)
(rainbow-delimiters-mode t)
(require 'hungry-delete)
(require 'toggle-quotes)

;;
;; Escape mode
(setq evil-escape-key-sequence "jj")
(setq evil-escape-unordered-key-sequence t)
(setq evil-escape-delay 0.2)
(evil-escape-mode t)

;;
;; Symbol Overlay
(use-package! symbol-overlay
  :hook (prog-mode . symbol-overlay-mode)
  :config
  (setq symbol-overlay-idle-time 0.2))

;;
;; Clipboard
(setq wl-copy-process nil
      wl-paste-process nil)

(defun wl-copy (text)
  (setq wl-copy-process (make-process :name "wl-copy"
                                      :buffer nil
                                      :command '("wl-copy" "-f" "-n")
                                      :connection-type 'pipe))
  (process-send-string wl-copy-process text)
  (process-send-eof wl-copy-process))

(defun wl-paste ()
  (if (and wl-paste-process (process-live-p wl-paste-process))
      (with-temp-buffer
        (insert ""))
    (shell-command-to-string "wl-paste -n")))

(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)

;;
;; Minimap
(setq demap-minimap-window-side 'right)
(setq demap-minimap-window-width 15)

;;
;; Modeline
(setq doom-modeline-height 22
      doom-modeline-icon t
      doom-modeline-env-version t
      doom-modeline-buffer-encoding t
      doom-modeline-buffer-file-name-style 'truncate-except-project
      doom-modeline-indent-info t
      doom-modeline-lsp nil
      doom-modeline-lsp-icon nil
      doom-modeline-modal t
      doom-modeline-modal-modern-icon t
      doom-modeline-time-live-icon t
      doom-modeline-vcs-display-function #'doom-modeline-vcs-name
      doom-modeline-vcs-icon t
      doom-modeline-vcs-max-length 15
      doom-modeline-vcs-state-faces-alist
      '((needs-update . (doom-modeline-warning bold))
        (removed . (doom-modeline-urgent bold))
        (conflict . (doom-modeline-urgent bold))
        (unregistered . (doom-modeline-urgent bold)))
      doom-modeline-workspace-name t)
