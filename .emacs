;;; package --- this is a summary.
;;; Commentary:

;;; Code:
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq package-archives '(("ELPA"."http://tromey.com/elpa/")
                         ("gnu"."http://elpa.gnu.org/packages/")
			 ("marmalade". "http://marmalade-repo.org/packages/") ) )
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)


(setq inhibit-startup-message t)

(setq-default indent-tabs-mode nil)
(setq-default column-number-mode t)

(setq make-backup-files nil)
(add-hook 'python-mode-hook 'jedi:setup)

;;(load-theme 'deeper-blue t)
;;(set-background-color "#383838")

(require 'ido)
(ido-mode t)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

;; enable jedi autocompletion
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;; fix the PATH variable  -- from http://clojure-doc.org/articles/tutorials/emacs.html
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))
;; ends clojure tutorial extract

;; enable eldoc in clj buffers
(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)
;; hid *nrepl-connection* and *nrepl-server* buffers from appearing in
;; buffer switching cmds
(setq nrepl-hide-special-buffers t)
;; pressing spc after cmd will switch-to-buffer visible
;; always invisible list-buffers C-x C-b
(setq nrepl-popup-stacktraces nil)
(setq nrepl-popup-stacktraces-in-repl t)
(add-to-list 'same-window-buffer-names "*repl*") ;; C-c C-z switch to
;; repl

(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

;;(require 'rainbow-delimiters)  ;; produces error
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)

(provide '.emacs)
;;; .emacs ends here
