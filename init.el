
;; Package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Theme
(load-theme 'sanityinc-tomorrow-eighties t)

;; Maximize
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Simpler startup
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Dunno
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Other elisp files
(add-to-list 'load-path "~/.emacs.d/misc/")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(package-selected-packages
   (quote
    (multi-term dired-subtree proof-general color-theme-sanityinc-tomorrow sublimity diff-hl dimmer ess markdown-mode smooth-scroll afternoon-theme zenburn-theme blacken elpy flycheck flycheck-mypy exec-path-from-shell)))
 '(pixel-scroll-mode t)
 '(proof-assistants (quote (coq)))
 '(proof-electric-terminator-enable t)
 '(proof-splash-time 1)
 '(proof-toolbar-enable nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Buffer switcher hotkey
(global-set-key "\C-x\C-b" 'ibuffer)
(put 'dired-find-alternate-file 'disabled nil)

;; Dunno
(ido-mode 'buffers)

;; Simplify UI
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Do not wrap long lines
(set-default 'truncate-lines t)
;; And don't display the truncated line indicator
(setq-default fringe-indicator-alist (assq-delete-all 'truncation fringe-indicator-alist))

;; Use line numbers when programming
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Dired stuff
(require 'dired)
(define-key dired-mode-map "c" 'dired-do-copy)
(define-key dired-mode-map "r" 'dired-do-rename)
;; (add-hook 'dired-load-hook
;; 	  (function (lambda ()
;; 		      (load "dired-x")
;; 		      )))
;; (require 'dired+)
;; (setq diredp-hide-details-initially-flag nil)
;; (setq diredp-hide-details-propagate-flag nil)

;; Better scrolling at margins
(setq scroll-conservatively 10000)

;; (require 'smooth-scroll)
;; (smooth-scroll-mode 1)
;; (setq smooth-scroll/vscroll-step-size 5)

;; Dims unselected buffers
(require 'dimmer)
(dimmer-mode t)

;; Windmove, use M-arrow keys to move between buffers
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings 'meta))

;; Git diff indicator
(global-diff-hl-mode)
;; Display in folders
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
;; Add to margin so it doesn't conflict with linters
(diff-hl-margin-mode)
;; Update in real-time
(diff-hl-flydiff-mode)

;; UI bits stolen from Sublime
;; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; (sublimity-mode 1)
;; (sublimity-map-set-delay 0)
;; (setq sublimity-map-fraction 0.15)
;; (setq sublimity-scroll-weight 10
;;       sublimity-scroll-drift-length 5)

;; Highlight parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Delete whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Dunno
(setq comint-input-ring-size 300)

;; Display col/line numbers in modeline
(line-number-mode 1)
(column-number-mode 1)

(blink-cursor-mode 0)

;; Find file at point
(require 'ffap)
(ffap-bindings)

;; Turn off C-click dialog
(define-key global-map (kbd "<C-down-mouse-1>") 'ignore)
(define-key global-map (kbd "<C-mouse-1>") 'mouse-set-point)

;; Handle duplicate buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Use C-x p as opposite of C-x o
(define-key global-map (kbd "C-x p") (lambda () (interactive) (other-window -1)))

;; elpy configuration
;; Turn on elpy
(elpy-enable)
;; Configure so it knows to use python3
(setq elpy-rpc-virtualenv-path 'system)
(setq elpy-rpc-python-command "/usr/local/bin/python3")
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "-i")

;; Set up with flycheck
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
;; flake8 is set to run after mypy in flycheck by default
;; So we switch the first checker to mypy
(add-hook 'elpy-mode-hook (lambda () (setq flycheck-checker 'python-mypy)))

;; Automatically run black on buffer save
(add-hook 'elpy-mode-hook 'blacken-mode)


;; Tab into trees in dired
(require 'dired-subtree)
(define-key dired-mode-map (kbd "<tab>") 'dired-subtree-insert)
(define-key dired-mode-map (kbd "S-<tab>") 'dired-subtree-remove)

;; Multiple shell windows
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(defalias 'term 'multi-term)
(defalias 'shell 'multi-term)
(defalias 'unix 'multi-term)
(setq multi-term-buffer-name "unix")

;; TODO: redefine end-of-buffer as something other than M->
