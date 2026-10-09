;;; keymaps.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "C-'") 'toggle-quotes)

(map!
 :leader
 :desc "Close all buffers and go to dashboard"
 "q a" (cmd! (doom/kill-all-buffers t)
  (treemacs)))

;; ============================ BUFFERS ============================

(map!
 :leader
 :desc "Delete split"
 "b c" #'delete-window

 :leader
 :desc "Delete all buffers"
 "b D" #'doom/kill-all-buffers)

(defun my/split-vertical-blank ()
  "Abre un split vertical con un buffer en blanco (*scratch*) enfocado en modo Evil."
  (interactive)
  (split-window-right)
  (select-window (next-window))
  (switch-to-buffer "*scratch*")
  (when (fboundp 'evil-normal-state)
    (evil-normal-state)))

(map!
 :leader
 :desc "Vertical split"
 "b v" #'my/split-vertical-blank)

;; ============================ TOGGLE ============================

(map!
 :leader
 :desc "Toggle treemacs"
 "t n" #'treemacs

 :leader
 :desc "Toggle terminal"
 "t t" #'+vterm/toggle

 :leader
 :desc "Commands history"
 "t h" #'consult-complex-command

 :leader
 :desc "Show magit"
 "t d" #'magit-status

 :leader
 :desc "Close magit"
 "t D" #'magit-mode-bury-buffer)

;; ============================ FILES/FIND ============================

(map!
 :leader
 :desc "Search files by name"
 "f f" #'+default/search-cwd

 :leader
 :desc "Search files by contents"
 "f g" #'+default/search-project

 :leader
 :desc "Search content in current buffers"
 "f j" #'consult-line-multi

 :leader
 :desc "Undo menu"
 "f u" #'vundo

 :leader
 :desc "History search"
 "f h" #'consult-history

 :leader
 :desc "Search lines in file"
 "f d" #'consult-line

 :leader
 :desc "GrugFar (Search & Replace project)"
 "f s" #'+default/search-project

 :leader
 :desc "GrugFar current line"
 "f r" #'+default/search-project-for-symbol-at-point)

;; ============================ CODE / DIAGNOSTICS ============================

(map!
 :leader
 :desc "Show lsp definition/docs in floating window"
 "c d" #'+lookup/documentation

 :leader
 :desc "Load lsp definition in new buffer"
 "c D" #'+lookup/definition

 :leader
 :desc "Diagnostics"
 "c x" #'+default/diagnostics

 :leader
 :desc "Comment"
 "c u" #'comment-line)

;; ============================ LINES ============================

(map!
 :nv "M-j" #'drag-stuff-down
 :nv "M-k" #'drag-stuff-up

 :map evil-visual-state-map
 "M-S-<down>" (cmd! (evil-yank-line (region-beginning) (region-end))
                    (evil-paste-after 1)
                    (evil-visual-restore))
 "M-J"        (cmd! (evil-yank-line (region-beginning) (region-end))
                    (evil-paste-after 1)
                    (evil-visual-restore))

 :map evil-visual-state-map
 "M-S-<up>"   (cmd! (evil-yank-line (region-beginning) (region-end))
                    (evil-paste-before 1)
                    (evil-visual-restore))
 "M-K"        (cmd! (evil-yank-line (region-beginning) (region-end))
                    (evil-paste-before 1)
                    (evil-visual-restore)))

 :n "M-S-<up>" (cmd! (save-excursion (beginning-of-line) (insert (thing-at-point 'line t))))
 :n "M-K"      (cmd! (save-excursion (beginning-of-line) (insert (thing-at-point 'line t))))

 :i "<backtab>" (cmd! (indent-for-tab-command -1))
 :n "<backtab>" #'evil-shift-left-line

 :map evil-visual-state-map
 "<tab>"     (cmd! (call-interactively #'evil-shift-right)
                   (evil-normal-state)
                   (evil-visual-restore))
 "<backtab>" (cmd! (call-interactively #'evil-shift-left)
                   (evil-normal-state)
                   (evil-visual-restore)))

;; ============================ MULTICURSOR  ============================

(map!
 :leader
 (:prefix ("m" . "multicursor")
   :desc "Multi: Match Next"     "n"      #'evil-mc-make-and-goto-next-match
   :desc "Multi: Match Prev"     "p"      #'evil-mc-make-and-goto-prev-match
   :desc "Multi: Match Skip"     "s"      #'evil-mc-skip-and-goto-next-match
   :desc "Multi: Match All"      "a"      #'evil-mc-make-all-cursors
   :desc "Multi: Toggle Cursor"  "t"      #'evil-mc-toggle-cursor-here)

 :n "<C-mouse-1>" #'evil-mc-make-cursor-at-pos)
