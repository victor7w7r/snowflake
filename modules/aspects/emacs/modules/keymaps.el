;;; keymaps.el -*- lexical-binding: t; -*-

(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "C-'") 'toggle-quotes)

;; ============================ BUFFERS ============================

(map!
 :leader
 :desc "Delete split"
 "b c" #'delete-window

 :leader
 :desc "Delete all buffers"
 "b D" #'doom/kill-all-buffers)

(defun my/split-vertical-blank ()
  "Vertical split function"
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

 :leade
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

;; ============================ MULTICURSOR  ============================

(map!
 :leader
 :desc "Multi: Match Next"
 "m n" #'evil-mc-make-and-goto-next-match

 :leader
 :desc "Multi: Match Prev"
 "m p" #'evil-mc-make-and-goto-prev-match

 :leader
 :desc "Multi: Match Skip"
 "m e" #'evil-mc-skip-and-goto-next-match

 :leader
 :desc "Multi: Match All"
 "m a" #'evil-mc-make-all-cursors

 :leader
 :desc "Multi: Toggle Cursor"
 "m t" #'evil-mc-toggle-cursor-here)

;; ============================ LINES ============================

;;(setq evil-disable-insert-state-bindings t)

(defun indent-keybind ()
  "Indent Keybind"
  (interactive)
  (if (use-region-p)
      (indent-rigidly (region-beginning) (region-end) (- tab-width))
    (indent-rigidly (line-beginning-position) (line-end-position) (- tab-width))))

(global-set-key (kbd "<backtab>") #'indent-keybind)

(map!
 :nv "M-j" #'drag-stuff-down
 :nv "M-k" #'drag-stuff-up
 :nv "M-down" #'drag-stuff-down
 :nv "M-up" #'drag-stuff-up
 :i "<backtab>" #'indent-keybind
 :vx "<backtab>"  #'indent-keybind
 :nvig "M-S-<up>" #'duplicate-line-or-region-above
 :nvig "M-K" #'duplicate-line-or-region-above
 :nvig "M-S-<down>" #'duplicate-line-or-region-below
 :nvig "M-J" #'duplicate-line-or-region-below)

(defun duplicate-line-or-region-above (&optional reverse)
  "Duplicate current line or region above."
  (interactive)
  (let ((original-column (current-column))
        duplicate-content)
    (if mark-active
        (let ((region-start-pos (region-beginning))
              (region-end-pos (region-end)))
          (setq region-start-pos (progn
                                   (goto-char region-start-pos)
                                   (line-beginning-position)))
          (setq region-end-pos (progn
                                 (goto-char region-end-pos)
                                 (line-end-position)))
          (setq duplicate-content (buffer-substring region-start-pos region-end-pos))
          (if reverse
              (progn
                (goto-char region-end-pos)
                (forward-line +1))
            (goto-char region-start-pos)))
      (setq duplicate-content (buffer-substring
                               (line-beginning-position)
                               (line-end-position)))
      (and reverse (forward-line 1))
      (beginning-of-line))
    (open-line 1)
    (insert duplicate-content)
    (move-to-column original-column t)))

(defun duplicate-line-or-region-below ()
  "Duplicate current line or region below."
  (interactive)
  (duplicate-line-or-region-above t))

(defun duplicate-line-above-comment (&optional reverse)
  "Duplicate current line above, and comment current line."
  (interactive)
  (if reverse
      (duplicate-line-or-region-below)
    (duplicate-line-or-region-above))
  (save-excursion
    (if reverse
        (forward-line -1)
      (forward-line +1))
    (comment-or-uncomment-region+)))

(defun duplicate-line-below-comment ()
  "Duplicate current line below, and comment current line."
  (interactive)
  (duplicate-line-above-comment t))

(defun comment-or-uncomment-region+ ()
  "This function is to comment or uncomment a line or a region."
  (interactive)
  (let (beg end)
    (if mark-active
        (progn
          (setq beg (region-beginning))
          (setq end (region-end)))
      (setq beg (line-beginning-position))
      (setq end (line-end-position)))
    (save-excursion
      (comment-or-uncomment-region beg end))))

(provide 'duplicate-line)
