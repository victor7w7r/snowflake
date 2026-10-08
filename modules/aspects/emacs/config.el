;;; $DOOMDIR/config.el -*- lexical-binding: t; -*

(load! "modules/ai")
(load! "modules/dashboard")
(load! "modules/editor")
(load! "modules/ide")
(load! "modules/keymaps")
(load! "modules/langs")
(load! "modules/ui")

(global-set-key [mouse-4] 'scroll-down-line)
(global-set-key [mouse-5] 'scroll-up-line)
(setq display-line-numbers-type 'relative)
(setq mouse-drag-copy-region t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(xterm-mouse-mode 1)

