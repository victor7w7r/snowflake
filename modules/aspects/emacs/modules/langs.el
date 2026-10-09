;;; langs.el -*- lexical-binding: t; -*

;;
;; ENV
(setenv "PATH" (concat (getenv "PATH") ":$HOME/.local/share/mise/shims"))
(setq exec-path (append exec-path '("~/.local/share/mise/shims")))

;;
;; LSP
(after! lsp-mode
  (setq lsp-enable-snippet t
        lsp-headerline-breadcrumb-enable t
        lsp-modeline-code-actions-enable t)
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-show-with-mouse t))

(after! lsp-ui
  (setq lsp-ui-doc-position 'at-point
        lsp-ui-doc-delay 0.1
        lsp-ui-doc-border (face-foreground 'default)))

;; Nix
(after! lsp-nix
  (setq lsp-nix-nil-formatter ["nixfmt"])
  (setq lsp-disabled-clients '(nil))
  (setq lsp-nix-executable "nixd"))

;; Kotlin
(defun kotlin-setup ()
  (when (and (projectile-project-p)
             (or (projectile-verify-file "build.gradle")
                 (projectile-verify-file "build.gradle.kts")))
    (when (fboundp 'lsp)
      (lsp))
    (let ((default-directory (projectile-project-root)))
      (compile "gradle tasks --quiet"))))

(add-hook 'projectile-after-switch-project-hook #'kotlin-setup)

(use-package flymake-ktlint
  :ensure t
  :config
  (setq ktlint-flymake-args '("--android")))

;; Rust
(set-formatter! 'rustfmt
  '("rustfmt"
    "--quiet"
    "--emit" "stdout"
    (ignore-errors
      (when-let* ((res
                   (with-temp-buffer
                     (and (equal (call-process "cargo" nil t nil "metadata" "--format-version=1" "--no-deps" "--frozen")
                                 0)
                          (progn (goto-char (point-min))
                                 (json-parse-buffer)))))
                  (packages (gethash "packages" res))
                  (first (seq-first packages))
                  (edition (gethash "edition" first))
                  ((string-match-p (rx bos digit digit digit digit eos) edition)))
        (list "--edition" edition)))))

;; Shell
(after! sh-script
  (set-formatter! 'shfmt
    '("shfmt"
      ("-i" "%d" (unless indent-tabs-mode tab-width))
      ("-ln" "%s" "bash"))))

(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  (add-hook 'sh-mode-hook 'flymake-shellcheck-load))

;; Web
(set-formatter!
  'oxfmt
  `(,(expand-file-name "~/.bun/bin/oxfmt")
    (format "--stdin-filepath=%s" (or buffer-file-name mode-result "")))
  :modes '(
    css-mode
    html-mode
    js-json-mode
    js-mode
    svelte-mode
    typescript-mode
    typescript-ts-mode
    typescript-tsx-mode
    vue-mode
  ))

(set-formatter!
  'biome
  (alist-get 'biome apheleia-formatters)
  :modes '(astro-ts-mode))

(after! flycheck
  (flycheck-define-checker javascript-oxlint
    "Lint JavaScript / TypeScript with oxlint (oxc.rs)."
    :command ("oxlint" "--format=unix" source-original)
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ":" (message) line-end))
    :modes (
      css-mode
      html-mode
      js-json-mode
      js-mode
      svelte-mode
      typescript-mode
      typescript-ts-mode
      typescript-tsx-mode
      vue-mode
    ))
  (add-to-list 'flycheck-checkers 'javascript-oxlint)
  (flycheck-add-next-checker 'javascript-eslint 'javascript-oxlint 'append))
