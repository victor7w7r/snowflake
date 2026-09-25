;;; $DOOMDIR/config.el -*- lexical-binding: t; -*

(setenv "PATH" (concat (getenv "PATH") ":$HOME/.local/share/mise/shims"))
(setq exec-path (append exec-path '("~/.local/share/mise/shims")))
(setenv "JAVA_HOME" "/home/victor7w7r/.local/share/mise/installs/java/openjdk-21")
(setenv "GRADLE_HOME" "/home/victor7w7r/.local/share/mise/installs/gradle/latest")

(setq projectile-project-search-path '("~/repositories/"))

(load! "modules/clipboard")
(load! "modules/layout")
(load! "modules/ai")
(load! "modules/keybindings")
(load! "modules/theme")
(load! "modules/code")

(add-to-list '+dashboard-menu-sections
             '("Salir"
               :icon (nerd-icons-octicon "nf-oct-sign_out" :face '+dashboard-menu-title)
               :key "SPC q q"
               :face (:inherit (+dashboard-menu-title bold))
               :action evil-quit))

(add-to-list '+dashboard-menu-sections
             '("Buscar Texto"
               :icon (nerd-icons-faicon "nf-fa-rectangle_list" :face '+dashboard-menu-title)
               :key "SPC s d"
               :face (:inherit (+dashboard-menu-title bold))
               :action +default/search-cwd))

(add-to-list '+dashboard-menu-sections
             '("Buscar Archivo"
               :icon (nerd-icons-faicon "nf-fa-search" :face '+dashboard-menu-title)
               :key "SPC ."
               :face (:inherit (+dashboard-menu-title bold))
               :action find-file))

(add-to-list '+dashboard-menu-sections
             '("Archivos Recientes"
               :icon (nerd-icons-faicon "nf-fa-copy" :face '+dashboard-menu-title)
               :key "SPC f r"
               :face (:inherit (+dashboard-menu-title bold))
               :action consult-recent-file))

(add-to-list '+dashboard-menu-sections
             '("Proyectos Recientes"
               :icon (nerd-icons-octicon "nf-oct-project_symlink" :face '+dashboard-menu-title)
               :key "SPC p r"
               :face (:inherit (+dashboard-menu-title bold))
               :action projectile-recentf))

(add-to-list '+dashboard-menu-sections
             '("Abrir Proyecto"
               :icon (nerd-icons-codicon "nf-cod-project" :face '+dashboard-menu-title)
               :key "SPC p p"
               :face (:inherit (+dashboard-menu-title bold))
               :action projectile-switch-project))

(add-to-list '+dashboard-menu-sections
             '("Restaurar Sesión"
               :icon (nerd-icons-wicon "nf-weather-refresh" :face '+dashboard-menu-title)
               :key "SPC q l"
               :face (:inherit (+dashboard-menu-title bold))
               :action doom/quickload-session))

(add-to-list '+dashboard-menu-sections
             '("Nuevo"
               :icon (nerd-icons-faicon "nf-fa-file" :face '+dashboard-menu-title)
               :key "SPC b N"
               :face (:inherit (+dashboard-menu-title bold))
               :action +default/new-buffer))

(assoc-delete-all "Open org-agenda" +dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +dashboard-menu-sections)
(assoc-delete-all "Open documentation" +dashboard-menu-sections)
(assoc-delete-all "Recently opened files" +dashboard-menu-sections)
(assoc-delete-all "Reload last session" +dashboard-menu-sections)
(assoc-delete-all "Open project" +dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +dashboard-menu-sections)

(add-hook! '+dashboard-functions :append
  (+dashboard-insert
   (concat "\n"
           (propertize (shell-command-to-string "zsh -fc 'autoload -Uz random-quote random-opts lolquotes bofh && random-quote'")
                       'face '(:foreground "#c678dd")))))

(defun main-greet-art ()
  (let* ((lines '(".oPYo. .oPYo. .pPYo.   .oPYo.                       o   o                 .oPYo.   o              8  o              *"
                  "8  .o8     `8 8        8    8                       8                     8        8              8                 *"
                  "8 .P`8   .oP` 8oPYo.   8      oPYo. .oPYo. .oPYo.  o8P o8 o    o .oPYo.   `Yooo.  o8P o    o .oPYo8 o8 .oPYo. .oPYo."
                  "8.d` 8    `b. 8`  `8   8      8  `` 8oooo8 .oooo8   8   8 Y.  .P 8oooo8       `8   8  8    8 8    8  8 8    8 Yb.."
                  "8o`  8     :8 8.  .P   8    8 8     8.     8    8   8   8 `b..d` 8.             8  8  8    8 8    8  8 8    8   `Yb."
                  "`YooP` `YooP` `YooP`   `YooP` 8     `Yooo` `YooP8   8   8  `YP`  `Yooo`   `YooP`   8  `YooP` `YooP`  8 `YooP` `YooP."
                  ":.....::.....::.....::::.....:..:::::.....::.....:::..::..::...:::.....::::.....:::..::.....::.....::..:.....::.....:"))
         (banner-width (length (car (last lines))))
         (tag "[ victor7w7r ]")
         (pad (max 0 (/ (- banner-width (length tag)) 2)))
         (centered-tag (concat (make-string pad ?\s) tag)))
    (propertize
     (concat (string-join lines "\n") "\n\n" centered-tag "\n")
     'face '+dashboard-banner)))

(setq +dashboard-ascii-banner-fn #'main-greet-art)
(setq display-line-numbers-type 'relative)
