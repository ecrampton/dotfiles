;;; -*- lisp -*-
;;;
;;; Here's my collection of Emacs related stuff that I've collected
;;; since I started using Emacs around 1994.

;; ----------------------------------------------------------------------
;; LOAD PATH SETUP
;; ----------------------------------------------------------------------

; Local Lisp configuration.
(add-to-list 'load-path "~/dotfiles/lisp")
(add-to-list 'load-path "~/dotfiles/lisp/tomorrow-theme")
(setq yas-snippet-dirs '("~/dotfiles/snippets"))

;; ----------------------------------------------------------------------
;; SITKA
;; ----------------------------------------------------------------------

(add-to-list 'compilation-search-path "/home/esc/sitka/builddir")

;; ----------------------------------------------------------------------
;; PACKAGE MANAGEMENT
;; ----------------------------------------------------------------------

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (setq esc-packages
        '(
          ace-jump-buffer
          ace-window
          ack
          fiplr
          git-gutter+
          gotham-theme
          jazz-theme
          magit
          phoenix-dark-pink-theme
          soft-charcoal-theme
          subatomic256-theme
          tango-2-theme
          yasnippet
          ))
  (when (not package-archive-contents)
    (package-refresh-contents))
  (defun esc-install-packages ()
    (interactive)
    (progn
      (dolist (pkg esc-packages)
        (when (and (not (package-installed-p pkg))
                   (assoc pkg package-archive-contents))
          (package-install pkg)))))
  (defun package-list-unaccounted-packages ()
    "Like `package-list-packages', but shows only the packages that
    are installed and are not in `esc-packages'.  Useful for
    cleaning out unwanted packages."
    (interactive)
    (package-show-package-list
     (remove-if-not (lambda (x) (and (not (memq x esc-packages))
                                     (not (package-built-in-p x))
                                     (package-installed-p x)))
                    (mapcar 'car package-archive-contents)))))
  
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
;; GIT GUTTER
;; ----------------------------------------------------------------------

(global-git-gutter+-mode t)

(eval-after-load 'git-gutter+
  '(progn
     ; Jump between hunks
     (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
     ))

;; ----------------------------------------------------------------------
;; SNIPPETS
;; ----------------------------------------------------------------------

(setq yas-snippet-dirs '("~/dotfiles/snippets"))
(yas-global-mode 1)

;; ----------------------------------------------------------------------
;; SIMPLE CUSTOMIZATIONS
;; ----------------------------------------------------------------------

; Turn menu-bar, tool-bar, and scroll-bar modes off. We don't need
; these, they only take up valuable screen real estate.
(if (not (eq window-system nil))
    (progn
      (tool-bar-mode 0)
      (menu-bar-mode 0)
      (scroll-bar-mode 0)))

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

; I know what I'm doing. Enable narrowing.
(put 'narrow-to-region 'disabled nil)

;; ----------------------------------------------------------------------
;; ADDITIONAL MODES
;; ----------------------------------------------------------------------

; Require Auc-TeX. (Too bad I don't get to use LaTeX as much as I used
; to.)
(add-to-list 'load-path "~/software/auctex/site-lisp")
;(require 'tex-site)

; WAF
(setq auto-mode-alist (cons '("wscript" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("wscript_build" . python-mode) auto-mode-alist))

; Provides ability to mark things in a buffer based on a regexp
(require 'himark)

; Folding mode lets you selectively show and hide parts of a document.
; (require 'folding)

; Better scrolling for Emacs
(require 'pager)
(global-set-key "\C-v"     'pager-page-down)
(global-set-key [next]     'pager-page-down)
(global-set-key "\ev"      'pager-page-up)
(global-set-key [prior]    'pager-page-up)

(global-set-key "\C-j"     'join-line)

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

; fiplr setup
(global-set-key (kbd "\C-x f") 'fiplr-find-file)
(setq fiplr-root-markers '("wscript" ".git"))
(setq fiplr-ignored-globs
      '((directories
         (".git" ".svn" ".hg" ".bzr"))
        (files
         (".#*" "*~" "*.so" "*.jpg" "*.png" "*.gif" "*.pdf" "*.gz" "*.zip" "*.o"))))

; ace-isearch
;(global-ace-isearch-mode +1)
;(setq ace-isearch-use-ace-jump nil)

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
(add-to-list 'auto-mode-alist '("\\.ipp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp$" . c++-mode))

;
;; File switching.
;;(defvar my-cpp-other-file-alist
;;  '(("\\.cpp\\'"      (".h"))
;;    ("_inline\\.h\\'" (".cpp" ".h"))
;;    ("\\.h\\'"        ("_inline.h" ".cpp"))))
;
;(setq cc-other-file-alist
;  '(("\\.cpp\\'"      (".h"))
;    ("_inline\\.h\\'" (".cpp" ".h"))
;    ("\\.h\\'"        ("_inline.h" ".cpp"))))
;
;;(setq-default ff-other-file-alist 'my-cpp-other-file-alist)
;
;(setq ff-always-try-to-create nil)
;(define-key global-map "\C-c\C-f" 'ff-find-other-file)

(defun next-rest (rest)
  (cond
   ((string-equal rest ".h") "_inline.h")
   ((string-equal rest "_inline.h") ".cpp")
   ((string-equal rest ".cpp") ".h")))

(defun next-filename (filename)
  (let ((basename (file-name-base
                   (nth 0 (split-string filename "_inline"))))
        (rest (next-rest
               (if (string-suffix-p "_inline.h" filename)
                   "_inline.h"
                 (file-name-extension filename 1)))))
    (concat (file-name-directory filename) basename rest)))

(defun next-open-file (filename)
  (when (file-readable-p filename)
    (switch-to-buffer (find-file filename))
    (return-from next-open-file t))
  nil)

(defun next-cpp-file ()
  (interactive)
  (let ((filename buffer-file-name))
    (when (file-readable-p filename)
      (let ((nextFilename (next-filename filename)))
        (unless (next-open-file nextFilename)
          (next-open-file (next-filename nextFilename)))))))

(define-key global-map "\C-c\C-f" 'next-cpp-file)

;; File switching.
;(defvar my-cpp-other-file-alist
;  '(("\\.cpp\\'"      (".h"))
;    ("_inline\\.h\\'" (".cpp"))
;    ("\\.h\\'"        ("_inline.h"))))
;
;(setq-default ff-other-file-alist 'my-cpp-other-file-alist)
;
;(define-key global-map "\C-c\C-f" 'ff-find-other-file)

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

(require 'color-theme-tomorrow)

; Setup fonts and themes based on terminal or TTY.
(if (eq window-system 'x)
    (progn
      (tool-bar-mode 0)
      (menu-bar-mode 0)
      (scroll-bar-mode 0)
      (load-theme 'tomorrow-night t)
      (when (member "terminus" (font-family-list))
        (set-face-font 'default "-*-terminus-medium-r-normal-*-14-*-*-*-*-*-*-*"))
      (when (member "Hack" (font-family-list))
        (set-face-font 'default "-*-Hack-medium-r-normal-*-14-*-*-*-*-*-*-*")))
  (progn
    (menu-bar-mode 0)
    (load-theme 'subatomic256 t)))

;; Show trailing whitespace in certain modes.
(mapc (lambda (mode)
        (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
                  (lambda () (setq show-trailing-whitespace t))))
      '(emacs-lisp python shell))

;; ----------------------------------------------------------------------
;; KEYBINDINGS
;; ----------------------------------------------------------------------

; Emacs inside tmux in some environments requires these mappings.
(global-set-key "\M-[1;5A" 'backward-paragraph)
(global-set-key "\M-[1;5B" 'forward-paragraph)
(global-set-key "\M-[1;5C" 'right-word)
(global-set-key "\M-[1;5D" 'left-word)

; Make a goto-line keybinding like in XEmacs.
(global-set-key "\M-g" 'goto-line)

; Force a buffer to be reverted without asking for confirmation.
(global-set-key "\C-c\M-r" (lambda () (interactive) (revert-buffer t t)))

; For the days when I'm doing C or C++ development.
(global-set-key "\C-\M-p" 'compile)
(setq compilation-scroll-output t)

; Correct coloration in the compilation buffer.
(require 'ansi-color)

(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "858a353233c58b69dbe3a06087fc08905df2d8755a0921ad4c407865f17ab52f" "c39ae5721fce3a07a27a685c08e4b856a13780dbc755a569bb4393c932f226d7" "590759adc4a5bf7a183df81654cce13b96089e026af67d92b5eec658fb3fe22f" "f5ef7ddecf161a2951048c204c2c6d9d5be08745b136dce583056ad4b234b861" "b85fc9f122202c71b9884c5aff428eb81b99d25d619ee6fde7f3016e08515f07" "62408b3adcd05f887b6357e5bd9221652984a389e9b015f87bbc596aba62ba48" default)))
 '(package-selected-packages
   (quote
    (gruvbox-theme yaml-mode helm-ag ag yasnippet tango-2-theme subatomic256-theme soft-charcoal-theme rtags phoenix-dark-pink-theme magit jazz-theme gotham-theme git-gutter+ fiplr ack ace-window ace-jump-buffer ace-isearch))))
