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
(global-set-key (kbd "<f6>") 'switch-to-buffer)
(global-set-key (kbd "<f7>") 'ibuffer)
(global-set-key (kbd "<f8>") 'goto-scratch)
(global-set-key (kbd "<f9>") 'kill-buffer)
(global-set-key (kbd "<C-tab>") 'next-buffer)
(global-set-key (kbd "<C-S-tab>") 'previous-buffer)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-z") (lambda () (interactive) (message "instead of C-z, use C-x C-z to suspend")))
(global-unset-key (kbd "C-\\"))         ; toggle-input-method
;; vim-like window selection
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)
(global-set-key (kbd "C-c l") 'windmove-right)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; goto scratch
(defun goto-scratch (&optional pop)
  "Go to *scratch* buffer.
if POP, $B!F(Bpop-to-buffer$B!G(B, otherwise $B!F(Bswitch-to-buffer$B!G(B."
  (interactive "P")
  (if pop
      (pop-to-buffer "*scratch*")
    (switch-to-buffer "*scratch*")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; show minibuffer history
(defun show-minibuffer-history ()
  "Show current minibuffer history in buffer `*minibuffer history*'."
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
            (define-key input-decode-map "\e[1;5I" (kbd "<C-tab>"))
            (define-key input-decode-map "\e[1;6I" (kbd "<C-S-tab>"))
            (define-key input-decode-map "\e[1;5P" (kbd "<C-f1>"))
            (define-key input-decode-map "\e[1;5Q" (kbd "<C-f2>"))
            (define-key input-decode-map "\e[1;5R" (kbd "<C-f3>"))
            (define-key input-decode-map "\e[1;5S" (kbd "<C-f4>"))
            )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; buffer selection
;;(require 'ido)
;;(ido-mode t)
;;(icomplete-mode)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; in minibuffer, press TAB to cygling completion.
;; if you wish to list candidates, press "?".
(setq completion-cycle-threshold t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; etc...

(add-to-list 'load-path "~/.emacs.d/lisp")
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq inhibit-startup-screen t)
;; (if (functionp 'global-display-line-numbers-mode)
;;     (global-display-line-numbers-mode 1)
;;   (when (functionp 'global-linum-mode)
;;     (setq linum-format "%5d ")
;;     (global-linum-mode 1)))
(column-number-mode 1)
(show-paren-mode 1)
;;(electric-pair-mode 1)                  ; auto pairing (), "", [], ...
(setq view-read-only t)
;; don't ask to save each modified files before grep, don't save
(setq grep-save-buffers nil)
(setq compilation-window-height 10)
;; don't delete region when type DEL, BS
(setq delete-active-region nil)
(setq vc-follow-symlinks t)
;; find-file-at-point
(ffap-bindings)
;; use default find-alternate-file rather than ffap-alternate-filea
(global-set-key "\C-x\C-v" 'find-alternate-file)

;; https://www.emacswiki.org/emacs/IndentingC
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode t)

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

;; smart-tabs-mode
;;(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml)
(smart-tabs-add-language-support perl perl-mode-hook
  ((perl-indent-line . perl-indent-level)))
(smart-tabs-add-language-support javascript js-mode-hook
  ((js-indent-line . js-indent-level)))
(smart-tabs-add-language-support sgml sgml-mode-hook
  ((sgml-indent-line . sgml-basic-offset)))
(smart-tabs-insinuate 'c 'c++ 'javascript 'perl 'sgml)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; whitespace mode
(require 'whitespace)

;; remove unwanted visualization
(dolist (d '(lines indentation space-after-tab))
  (setq whitespace-style (delq d whitespace-style)))

;; full-width space
;;(setq whitespace-space-regexp "\\(\u3000+\\)")

;; display ascii only in non-utf8 environment, where can not display correctly
(let ((lang (getenv "LANG")))
  (if (and (stringp lang) (string-match "UTF-8" lang))
      (setq whitespace-display-mappings
            '((newline-mark ?\n    [?$,1w5(B ?\n] [?$ ?\n])
              (tab-mark     ?\t    [?$(Q)2(B ?\t] [?\\ ?\t])))
    (setq whitespace-display-mappings
          '((newline-mark ?\n [?$ ?\n])
            (tab-mark     ?\t [?\\ ?\t])))
    ))

(global-whitespace-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; program mode
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux")))

(defun my-c-mode-common-hook ()
  "Hook used for $B!F(Bc-mode-common-hook$B!G(B."
  (setq show-trailing-whitespace t))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-lisp-mode-hook ()
  "Hook used for lisp-like mode."
  (setq indent-tabs-mode nil))
(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'scheme-mode-hook 'my-lisp-mode-hook)

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
            ;; suggest command rule
            (setq dired-guess-shell-alist-user
                  (list
                   (list "^a.out$" "PATH=.")
                   (list "\\.c$" "cc")
                   (list "\\.cc$" "c++")
                   (list "\\.C$" "c++")
                   (list "\\.cpp$" "c++")
                   (list "\\.cxx$" "c++")
                   (list "\\.c\\+\\+$" "c++")
                   (list "\\.pl$" "perl")
                   (list "\\.py$" "python")
                   (list "\\.lua$" "lua")
                   (list "\\.tcl$" "wish")
                   ))
            ))

;; display head of file
(defvar dired-head-file nil
  "Used by `dired-head-file-function'.")

(defvar dired-head-file-byte 1024
  "Byte size of file that display for.")

(defun dired-head-file-function (&rest args)
  "Display head of file.
Optional argument ARGS toggle."
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
  "Toggle display *head*.
if prefix ARG, set `dired-head-file' to t."
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
  "Print pinyin at point.  `pinyin' is required."
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
;;; slime
(setq inferior-lisp-program "sbcl")
;;(setq slime-contribs '(slime-fancy))
(setq slime-contribs '(slime-repl))
;; default http://www.lispworks.com/reference/HyperSpec/
(setq common-lisp-hyperspec-root (concat "file://" (getenv "HOME") "/doc/HyperSpec/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mark symbol
(defun mark-symbol ()
  "Mark symbol near point.  like `isearch-forward-symbol-at-point'."
  (interactive)
  (let ((bounds (find-tag-default-bounds)))
    (when bounds
      (push-mark (car bounds) nil t)
      (goto-char (cdr bounds)))))
(global-set-key "\C-cs" 'mark-symbol)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; revert buffer without query
(defun my-revert-buffer ()
  "`revert-buffer' without confirmation."
  (interactive)
  (revert-buffer nil t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; enable disabled command
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'narrow-to-region 'disabled nil)
