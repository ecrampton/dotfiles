;;; -*- lisp -*-
;;;
;;; Here's my collection of Emacs related stuff that I've collected
;;; since I started using Emacs around 1994.

;; ----------------------------------------------------------------------
;; LOAD PATH SETUP
;; ----------------------------------------------------------------------

; Local Lisp configuration.
(add-to-list 'load-path "~/dotfiles/lisp")

;; ----------------------------------------------------------------------
;; WHERE AM I?
;; ----------------------------------------------------------------------

; At work, I'm the more formal 'ecrampton'.
(defun esc-at-bats ()
  (file-directory-p "/home/ecrampton"))

; At home, I'm 'esc'.
(defun esc-at-home ()
  (file-directory-p "/home/esc"))

;; ----------------------------------------------------------------------
;; SIMPLE CUSTOMIZATIONS
;; ----------------------------------------------------------------------

; Turn menu-bar, tool-bar, and scroll-bar modes off. We don't need
; these, they only take up valuable screen real estate.
(if (not (eq window-system nil))
    (progn
      (tool-bar-mode 0)
      (menu-bar-mode 0)
      (scroll-bar-mode nil)))

; We definitely don't need fancy splash screens. These are
; particularly slow over a remote connection.
(defun use-fancy-splash-screens-p nil)

; Turn on highlighting of region between point and mark
(transient-mark-mode t)

; Show column numbers in the mode line.
(column-number-mode t)

; Turn off backup files. We don't need these all over the filesystem.
(setq make-backup-files nil)
(setq vc-make-backup-file nil)

; Set the scroll step like I like it.
(setq scroll-step 5)

; Show completions in the minibuffer as you type.
(icomplete-mode)

; Remove minor mode indicators which I don't care about.
(setq minor-mode-alist
      (delq (assq 'hscroll-mode minor-mode-alist)
            minor-mode-alist))
(setq minor-mode-alist
      (delq (assq 'abbrev-mode minor-mode-alist)
            minor-mode-alist))

; Make auto-fill default to 'on' for text-mode
(add-hook 'text-mode-hook
          (lambda ()
            (turn-on-auto-fill)
            (set-fill-column 120)))

; Turn on global font-lock and decorations
(cond ((fboundp 'global-font-lock-mode)
           (global-font-lock-mode t)
           (setq font-lock-maximum-decoration t)))

;; ----------------------------------------------------------------------
;; ADDITIONAL MODES
;; ----------------------------------------------------------------------

; Require Auc-TeX. (Too bad I don't get to use LaTeX as much as I used
; to.)
(add-to-list 'load-path "~/software/auctex/site-lisp")
(require 'tex-site)

; Switch file
(require 'switch-file)
(add-to-list 'auto-mode-alist '("\\.ipp$" . c++-mode))
(add-to-list 'switch-major-mode-alist '(c++-mode (".ipp")))

; WAF
(setq auto-mode-alist (cons '("wscript" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("wscript_build" . python-mode) auto-mode-alist))

; Provides ability to mark things in a buffer based on a regexp
(require 'himark)

; Folding mode lets you selectively show and hide parts of a document.
(require 'folding)

; Better scrolling for Emacs
(require 'pager)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [next]     'pager-page-down)
(global-set-key "\ev"      'pager-page-up)
(global-set-key [prior]    'pager-page-up)

; Some nice functions for finding and displaying information about
; faces.
(require 'face-list)

; Turn on highline mode globally.
;(global-highline-mode)

(require 'highlight-symbol)
(global-set-key "\M-p"  'highlight-symbol-at-point)
(global-set-key "\M-s"  'highlight-symbol-next)
(global-set-key "\M-r"  'highlight-symbol-prev)

(require 'dedicated)

;; ----------------------------------------------------------------------
;; CC-MODE CUSTOMIZATIONS
;; ----------------------------------------------------------------------

; Setup C++ indentation like I like it.
(setq-default indent-tabs-mode nil)

; Added in 2008.
(defun bats-c-mode-common-hook ()
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro 8)
  (c-set-offset 'arglist-close 4)
  (c-set-offset 'case-label 0)
  (c-set-offset 'inclass 4)
  (c-set-offset 'comment-intro 0)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'namespace-open 0)
  (c-set-offset 'namespace-close 0)
  (c-set-offset 'template-args-cont 4)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'statement-case-intro 4)
  (c-set-offset 'member-init-intro 4)
  (c-set-offset 'member-init-cont -2)
  (c-set-offset 'inher-cont 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'brace-list-intro 4)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'statement-block-intro 4)
  (c-set-offset 'defun-block-intro 4)
  (c-set-offset 'case-label 4)
  (c-set-offset 'access-label -4)
  (show-paren-mode t)
  (setq truncate-lines nil)
; (auto-fill-mode)
  (setq fill-column 120)
  )

; Added in late 1999. Thanks, Chris!
(defun atd-c-mode-common-hook ()
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-intro 8)
  (c-set-offset 'arglist-close 4)
  (c-set-offset 'case-label 0)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'innamespace 0)
  (c-set-offset 'namespace-open 0)
  (c-set-offset 'namespace-close 0)
  (c-set-offset 'template-args-cont 4)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'member-init-cont -2)
  (c-set-offset 'inher-cont 0)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'case-label 4)
  (c-set-offset 'defun-block-intro 4)
  (c-set-offset 'statement-block-intro 4)
  (show-paren-mode t)
  (setq truncate-lines nil)
; (auto-fill-mode)
  )

(add-hook 'c-mode-common-hook 'bats-c-mode-common-hook)

; Treat .h files as C++ code.
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

; Sourcepair stuff.
;(load "~/dotfiles/lisp/sourcepair.el")
;(define-key global-map "\C-c\C-f" 'sourcepair-load)

; File switching.
(defvar my-cpp-other-file-alist
  '(("\\.cpp\\'"      (".h"))
    ("_inline\\.h\\'" (".cpp"))
    ("\\.h\\'"        ("_inline.h"))))

(setq-default ff-other-file-alist 'my-cpp-other-file-alist)

(define-key global-map "\C-c\C-f" 'ff-find-other-file)

;; ----------------------------------------------------------------------
;; FILE CACHE SETUP
;; ----------------------------------------------------------------------

(require 'filecache)

(defun file-cache-delete-svn ()
  (file-cache-delete-file-regexp ".*\\.svn.*"))

(if (esc-at-bats)
    (defun bats-file-cache ()
      (interactive)
      (progn
        (file-cache-clear-cache)
        (file-cache-add-directory-using-find "/opt/ecn/users/ecrampton/source/ecn/source/cpp")
        (file-cache-delete-svn))))

(if (esc-at-home)
    (defun home-file-cache ()
      (interactive)
      (progn
        (file-cache-clear-cache)
        (file-cache-add-directory-using-find "/home/esc/qf")
        (file-cache-delete-svn))))

;; ----------------------------------------------------------------------
;; FACE/FONT SETUP
;; ----------------------------------------------------------------------

; Color-theme allows easy setup and selection of different Emacs color
; themes.
(require 'color-theme)
(require 'zenburn)
(load "~/dotfiles/lisp/color-theme-subdued.el")
(color-theme-subdued)
;(color-theme-zenburn)

; Only run these if we're running in X11.
(if (eq window-system 'x)
    (set-face-font 'default "-*-terminus-medium-r-normal-*-14-*-*-*-*-*-*-*")
)

;; Show trailing whitespace in certain modes.
(mapc (lambda (mode)
        (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
                  (lambda () (setq show-trailing-whitespace t))))
      '(emacs-lisp python shell))

;; ----------------------------------------------------------------------
;; KEYBINDINGS
;; ----------------------------------------------------------------------

; Make a goto-line keybinding like in XEmacs.
(global-set-key "\M-g" 'goto-line)

; Force a buffer to be reverted without asking for confirmation.
(global-set-key "\C-c\M-r" (lambda () (interactive) (revert-buffer t t)))

; For the days when I'm doing C or C++ development.
(global-set-key "\C-\M-p" 'compile)
(setq compilation-scroll-output t)

; Make Emacs ask me if I want to exit. I have a tendency to hit C-x
; C-c by accident sometimes. When I'm on a machine without this and
; I'm using Emacs, I end up cursing myself.
(global-set-key "\C-x\C-c"
		(lambda () (interactive)
		  (if (string-equal "y" (read-string "Exit Emacs (y/n)? "))
		      (save-buffers-kill-emacs))))

; Font locking sometimes gets hosed up. Here's a keybinding to quickly
; re-font lock the current buffer.
(global-set-key "\C-c\C-v"
		'font-lock-fontify-buffer)

; Mark text matching a regexp in the current buffer. (And, unmark it,
; too.)
(global-set-key "\C-c\C-h" 'himark-regexp)
(global-set-key "\C-c\C-u" 'himark-unset)

;; ----------------------------------------------------------------------
;; CUSTOM FUNCTIONS I LIKE
;; ----------------------------------------------------------------------

; Set the execute bit on a file if it has a shebang in the first line.
(if (< emacs-major-version 22)
    ; For Emacs earlier than version 22.
    (add-hook 'after-save-hook
              '(lambda ()
                 (progn
                   (and (save-excursion
                          (save-restriction
                            (widen)
                            (goto-char (point-min))
                            (save-match-data
                              (looking-at "^#!"))))
                        (shell-command (concat "chmod a+x " buffer-file-name))
                        (message (concat "Saved as script: " buffer-file-name))
                        ))))
  ; For Emacs version 22 or later.
  (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p))

;; ----------------------------------------------------------------------
;; ORG MODE
;; ----------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; ----------------------------------------------------------------------
;; CUSTOMIZE VARIABLES
;; ----------------------------------------------------------------------
