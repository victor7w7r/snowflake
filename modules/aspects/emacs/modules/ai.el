;;; ai.el -*- lexical-binding: t; -*-

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(after! copilot
  (defun copilot--infer-indentation-offset ()
    (or (and (boundp 'tab-width) tab-width)
        2)))

(use-package! copilot-chat
  :after copilot
  :config

  (map! (:prefix ("C-c C-a")
         :desc "Copilot Chat" "C-a"
         :desc "Copilot Chat Send" "C-c" 
         :desc "Copilot Chat Explain" "C-e" 
         :desc "Copilot Chat Review" "C-r"
         :desc "Copilot Chat Doc" "C-d"
         :desc "Copilot Chat Fix" "C-f"
         :desc "Copilot Chat Optimize" "C-o"
         :desc "Copilot Chat Test" "C-t"
         :desc "Copilot Chat Commit" "C-m" 
         :desc "Copilot Chat Custom Prompt" "C-p"))

  (setq copilot-chat-window-config
        '((display-buffer-in-side-window)
          (side . right)
          (window-width . 0.5))))
