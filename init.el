;;; -*- coding: iso-2022-7bit; tab-width: 8 -*-

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; keyboad

;; C-h: backspace
;;(keyboard-translate ?\C-h ?\C-?)
;; M-C-/
(define-key esc-map [?\C-_] 'dabbrev-completion)

;; global key map
;; (define-key global-map (kbd "<f3>") 'isearch-forward)
;; (define-key isearch-mode-map (kbd "<f3>") 'isearch-repeat-forward)
;; (define-key minibuffer-local-isearch-map (kbd "<f3>") 'isearch-forward-exit-minibuffer)
;; (define-key global-map (kbd "<S-f3>") 'isearch-backward)
;; (define-key isearch-mode-map (kbd "<S-f3>") 'isearch-repeat-backward)
;; (define-key minibuffer-local-isearch-map (kbd "<S-f3>") 'isearch-reverse-exit-minibuffer)
(global-set-key (kbd "<f5>") 'keyboard-escape-quit)
(global-set-key (kbd "<f6>") 'other-window)
(global-set-key (kbd "<f7>") 'ibuffer)
(global-set-key (kbd "<f8>") 'goto-scratch)
(global-set-key (kbd "<f9>") 'kill-buffer)
(global-set-key (kbd "C-TAB") 'next-buffer)
(global-set-key (kbd "C-S-TAB") 'previous-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; goto scratch
(defun goto-scratch (&optional pop)
  (interactive "P")
  (if pop
      (pop-to-buffer "*scratch*")
    (switch-to-buffer "*scratch*")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; show minibuffer history
(defun show-minibuffer-history ()
  "show current minibuffer history in buffer `*minibuffer history*'."
  (interactive)
  (let ((buffer (get-buffer-create "*minibuffer history*")))
	(with-current-buffer buffer
	  (erase-buffer)
	  (mapc (lambda (x) (insert (format "%s\n" x))) (symbol-value minibuffer-history-variable)))
	(display-buffer buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mouse
(when (not (window-system))
  (xterm-mouse-mode 1)
  (load "mwheel")
  (mouse-wheel-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; fix some keymap that not working properly in tmux
(if (and (getenv "TMUX") (not window-system))
    (setq tty-setup-hook
	  (lambda ()
	    (define-key input-decode-map "\eOM" (kbd "<kp-enter>"))
	    (define-key input-decode-map "\eO2M" (kbd "<S-kp-enter>"))
	    (define-key input-decode-map "\eO3M" (kbd "<M-kp-enter>"))
	    (define-key input-decode-map "\eO4M" (kbd "<M-S-kp-enter>"))
	    (define-key input-decode-map "\e[1;5l" (kbd "C-,"))
	    (define-key input-decode-map "\e[1;5n" (kbd "C-."))
	    (define-key input-decode-map "\e[1;6l" (kbd "C-<"))
	    (define-key input-decode-map "\e[1;6n" (kbd "C->"))
	    (define-key input-decode-map "\e[1;7l" (kbd "M-C-,"))
	    (define-key input-decode-map "\e[1;7n" (kbd "M-C-."))
	    (define-key input-decode-map "\e[1;8l" (kbd "M-C-<"))
	    (define-key input-decode-map "\e[1;8n" (kbd "M-C->"))
	    (define-key input-decode-map "\e[1;5k" (kbd "C-;"))
	    (define-key input-decode-map "\e[1;6k" (kbd "C-:"))
	    (define-key input-decode-map "\e[1;5m" (kbd "C--"))
	    (define-key input-decode-map "\e[1;5p" (kbd "C-0"))
	    (define-key input-decode-map "\e[1;5q" (kbd "C-1"))
	    (define-key input-decode-map "\e[1;5r" (kbd "C-2"))
	    (define-key input-decode-map "\e[1;5s" (kbd "C-3"))
	    (define-key input-decode-map "\e[1;5t" (kbd "C-4"))
	    (define-key input-decode-map "\e[1;5u" (kbd "C-5"))
	    (define-key input-decode-map "\e[1;5v" (kbd "C-6"))
	    (define-key input-decode-map "\e[1;5w" (kbd "C-7"))
	    (define-key input-decode-map "\e[1;5x" (kbd "C-8"))
	    (define-key input-decode-map "\e[1;5y" (kbd "C-9"))
	    (define-key input-decode-map "\e[1;6m" (kbd "C-S--"))
	    (define-key input-decode-map "\e[1;6p" (kbd "C-S-0"))
	    (define-key input-decode-map "\e[1;6q" (kbd "C-S-1"))
	    (define-key input-decode-map "\e[1;6r" (kbd "C-S-2"))
	    (define-key input-decode-map "\e[1;6s" (kbd "C-S-3"))
	    (define-key input-decode-map "\e[1;6t" (kbd "C-S-4"))
	    (define-key input-decode-map "\e[1;6u" (kbd "C-S-5"))
	    (define-key input-decode-map "\e[1;6v" (kbd "C-S-6"))
	    (define-key input-decode-map "\e[1;6w" (kbd "C-S-7"))
	    (define-key input-decode-map "\e[1;6x" (kbd "C-S-8"))
	    (define-key input-decode-map "\e[1;6y" (kbd "C-S-9"))
	    (define-key input-decode-map "\e[1;5I" (kbd "C-TAB"))
	    (define-key input-decode-map "\e[1;6I" (kbd "C-S-TAB"))
	    )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; buffer selection
;;(require 'ido)
;;(ido-mode t)
;;(icomplete-mode)
(setq read-buffer-completion-ignore-case t)
(setq completion-cycle-threshold t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; etc...

(add-to-list 'load-path "~/.emacs.d/lisp")
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq inhibit-startup-screen t)
(if (functionp 'global-display-line-numbers-mode)
    (global-display-line-numbers-mode 1)
  (when (functionp 'global-linum-mode)
    (setq linum-format "%5d ")
    (global-linum-mode 1)))
(column-number-mode 1)
(show-paren-mode 1)
(setq view-read-only t)
(setq grep-save-buffers nil)
(setq compilation-window-height 10)
(setq delete-active-region nil)
(setq vc-follow-symlinks t)

;; https://www.emacswiki.org/emacs/IndentingC
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)

;;(global-whitespace-mode 1)
;;(setq next-line-add-newlines t)
;;(setq viper-mode t)
;;(require 'viper)
;;(viper-go-away)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom
(setq custom-file (concat (getenv "HOME") "/.emacs.d/my-custom.el"))
(load custom-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; package
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(global-undo-tree-mode 1)
;;(evil-mode 1)
(require 'evil-numbers)
(global-set-key (kbd "C-c +") 'evil-numbers/inc-at-pt)
(global-set-key (kbd "C-c -") 'evil-numbers/dec-at-pt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; cc-mode
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))

(defun my-c-mode-common-hook ()
  (setq show-trailing-whitespace t))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; dired-x
(add-hook 'dired-load-hook
	  (lambda ()
	    (load "dired-x")
	    ;; Set dired-x global variables here.  For example:
	    ;; (setq dired-guess-shell-gnutar "gtar")
	    ;; (setq dired-x-hands-off-my-keys nil)
	    (advice-add 'dired-next-line :after #'dired-head-file-function)
	    ;;(advice-remove 'dired-next-line #'dired-head-file-function)
	    (define-key dired-mode-map "b" 'dired-toggle-head-file)
	    ))
(add-hook 'dired-mode-hook
	  (lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    ;; (setq dired-omit-files "^\\.?#\\|^\\.$\\|^\\.\\.$")
	    (setq dired-omit-files "^\\.")
	    ;; (dired-omit-mode 1)
	    (setq dired-dwim-target t)
	    ))

;; display head of file
(defvar dired-head-file nil
  "used by `dired-head-file-function'")

(defvar dired-head-file-byte 1024
  "byte size of file that display for.")

(defun dired-head-file-function (&rest args)
  "display head of file."
  (if dired-head-file
      (let ((filename (dired-get-filename))
	    (buffer (get-buffer-create "*head*")))
	(with-current-buffer buffer
	  (setq buffer-read-only nil)
	  (erase-buffer)
	  (if (file-directory-p filename)
	      ;; list directory
	      (insert-directory filename "-a" nil t)
	    ;; insert head of file content if file size is greater than 0
	    (if (< 0 (nth 7 (file-attributes filename)))
		(insert-file-contents filename nil 0 dired-head-file-byte)))
	  (goto-char (point-min))
	  (view-mode)
	  (display-buffer buffer)
	  ))))

(defun dired-toggle-head-file (&optional arg)
  (interactive "P")
  (setq dired-head-file
	(if (null arg)
	    (not dired-head-file)
	  (> (prefix-numeric-value arg) 0)))
  (if dired-head-file
      (dired-head-file-function)
    (quit-windows-on "*head*")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; echo pinyin
(defun echo-pinyin-point ()
  (interactive)
  (require 'pinyin)
  (let ((lst (pinyin
	      (string-to-char (buffer-substring-no-properties
			       (point) (1+ (point))))
	      'TONE3)))
    (when lst (message "%s" lst))))

(define-minor-mode echo-pinyin-mode
  "Toggle echo area display of pinyin at cursor position's hanzi."
  :init-value nil
  :lighter " Echo-Pinyin"
  (if echo-pinyin-mode
      (add-hook 'post-command-hook #'echo-pinyin-point nil t)
    (remove-hook 'post-command-hook #'echo-pinyin-point t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-comphist nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mark symbol
(defun mark-symbol ()
  (interactive)
  (let ((bounds (find-tag-default-bounds)))
    (when bounds
      (push-mark (car bounds) nil t)
      (goto-char (cdr bounds)))))
(global-set-key "\C-cs" 'mark-symbol)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; revert buffer without query
(defun my-revert-buffer ()
	(interactive)
  (revert-buffer nil t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; enable disabled command
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
