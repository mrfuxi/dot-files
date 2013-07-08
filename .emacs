;;; package --- this is a summary.
;;; Commentary:

;;; Code:

;; GUI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; PACKAGES
(setq package-archives '(("ELPA"."http://tromey.com/elpa/")
                         ("gnu"."http://elpa.gnu.org/packages/")
			 ("marmalade". "http://marmalade-repo.org/packages/") ) )
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; PREFERENCES
(setq inhibit-startup-message t)
(setq make-backup-files nil)

(setq-default indent-tabs-mode nil)
(setq-default column-number-mode t)

(setq default-truncate-lines t) ;; disable line wrap
;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)
(global-set-key (kbd "<f12>") 'toggle-truncate-lines)

;;(load-theme 'deeper-blue t)
;;(set-background-color "#383838")


;;
;; VARIOUS PLUGINS
;;

(require 'ido)
(ido-mode t)

(require 'auto-complete)
(global-auto-complete-mode t)

;; yasnippet
(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '(".ssh/config\\'"  . ssh-config-mode))
(add-to-list 'auto-mode-alist '("sshd?_config\\'" . ssh-config-mode))
(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

;; END VARIOUS PLUGINS


;;
;; LANGUAGE CONFIGS
;; 

;; 1 PYTHON
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)
(add-hook 'python-mode-hook 'jedi:setup)
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)
(add-hook 'python-mode-hook
	  (function (lambda ()
		      (setq indent-tabs-mode nil
			    tab-width 4))))


;; 2 nRepl (CLOJURE/LISPS)

(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)
;;(require 'rainbow-delimiters)  ;; produces error
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)  ;; Lisps love rainbows
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)


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
;; hide *nrepl-connection* and *nrepl-server* buffers from appearing in
;; buffer switching cmds
(setq nrepl-hide-special-buffers t)
;; pressing spc after cmd will switch-to-buffer visible
;; always invisible list-buffers C-x C-b
(setq nrepl-popup-stacktraces nil)
(setq nrepl-popup-stacktraces-in-repl t)
(add-to-list 'same-window-buffer-names "*repl*") ;; C-c C-z switch to
;; repl

;; END LANGUAGE CONFIGS


(provide '.emacs)
;;; .emacs ends here
