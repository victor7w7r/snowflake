;;; ai.el -*- lexical-binding: t; -*-

(after! copilot
  (defun copilot--infer-indentation-offset ()
    (or (and (boundp 'tab-width) tab-width)
        2)))
