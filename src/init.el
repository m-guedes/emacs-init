;;; init.el --- Configuration bootstrap and module loading  -*- lexical-binding: t; -*-

;; Copyright (C) 2014-2026 Miguel Guedes

;; Author: Miguel Guedes <miguel.a.guedes@gmail.com>
;; Keywords: tools
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:

;; ~/.emacs.d/init.el is a symlink to this file, as are early-init.el and
;; user-lisp/.  Settings that must apply before packages activate are in
;; early-init.el.
;;
;; The modules in config/, features/, modes/ and environment/ configure Emacs
;; as they load, in the order they are required below.  user-lisp/ is the
;; User Lisp directory: at startup Emacs byte-compiles the utilities in it and
;; registers their autoloads, so each loads the first time it is used.

;;; Code:

;; Custom saves customizations here rather than in this file.  The file is
;; loaded last, below.
(setopt custom-file (locate-user-emacs-file "custom.el"))

;; Install declared packages that are missing.  Built-in packages opt out with
;; `:ensure nil'.
(setopt use-package-always-ensure t)

;; Make the modules loadable and the themes in themes/ available to
;; `load-theme'.  `file-truename' resolves the symlink this file is loaded
;; through.
(let ((base (file-name-directory
             (file-truename (or load-file-name buffer-file-name)))))
  (dolist (dir '("config" "features" "modes" "environment"))
    (add-to-list 'load-path (expand-file-name dir base)))
  (setopt custom-theme-directory (expand-file-name "themes/" base)))

;; Each module may rely on those required before it.
;; Core settings are independent of package configuration.
(require 'init-consts)
(require 'init-startup)
(require 'init-keybindings)
(require 'init-log)
(require 'init-programming)
(require 'init-settings)
(require 'init-windows)

;; Diminish must be available before declarations that use its keyword.
(require 'init-diminish)
(require 'init-ace-window)
(require 'init-autorevert)
(require 'init-browse-kill-ring)
(require 'init-buffer-move)
(require 'init-dabbrev)
(require 'init-erc)
(require 'init-display-fill-column-indicator)
(require 'init-highlight-parentheses)
(require 'init-flyspell)
(require 'init-gcmh)
(require 'init-marginalia)
(require 'init-recursion-indicator)
(require 'init-savehist)
(require 'init-simple)
(require 'init-subword)
(require 'init-all-the-icons)
(require 'init-all-the-icons-dired)
(require 'init-all-the-icons-completion)
(require 'init-all-the-icons-ibuffer)
(require 'init-ansi-color)
(require 'init-avy)
(require 'init-consult)
(require 'init-copilot)
(require 'init-corfu)
(require 'init-css-eldoc)
(require 'init-desktop)
(require 'init-dired)
(require 'init-dired-x)
(require 'init-display-line-numbers)
(require 'init-eglot)
(require 'init-eldoc)
(require 'init-eldoc-box)
(require 'init-embark)
(require 'init-embark-consult)
(require 'init-flymake)
(require 'init-flymake-ruff)
(require 'init-flymake-eslint)
(require 'init-format-all)
(require 'init-git-commit)
(require 'init-git-gutter-fringe)
(require 'init-git-gutter)
(require 'init-goggles)
(require 'init-grep)
(require 'init-indent-bars)
(require 'init-magit)
(require 'init-neotree)
(require 'init-orderless)
(require 'init-pet)
(require 'init-prettier)
(require 'init-project)
(require 'init-promptivel)
(require 'init-recentf)
(require 'init-ruff-format)
(require 'init-server)
(require 'init-shell)
(require 'init-speedbar)
(require 'init-sqlformat)
(require 'init-vertico)
(require 'init-visual-fill-column)
(require 'init-vterm)
(require 'init-which-key)
(require 'init-window-pulse)
(require 'init-with-editor)
(require 'init-xclip)

(require 'init-modeline)

(require 'init-cc-mode)
(require 'init-csharp-mode)
(require 'init-css-mode)
(require 'init-dart-mode)
(require 'init-go-ts-mode)
(require 'init-html-ts-mode)
(require 'init-jinja2-mode)
(require 'init-js)
(require 'init-json-ts-mode)
(require 'init-elisp-mode)
(require 'init-make-mode)
(require 'init-markdown-mode)
(require 'init-meson-mode)
(require 'init-nxml-mode)
(require 'init-org)
(require 'init-php-ts-mode)
(require 'init-python)
(require 'init-rust-ts-mode)
(require 'init-sh-script)
(require 'init-sql)
(require 'init-text-mode)
(require 'init-typescript-ts-mode)
(require 'init-vala-mode)
(require 'init-web-mode)
(require 'init-yaml-ts-mode)

(require 'init-frames)

;; Identity, mail and per-host settings, kept out of the repository, apply over
;; everything above.
(load (locate-user-emacs-file "personal.el") 'noerror 'nomessage)

(load custom-file 'noerror 'nomessage)

;;; init.el ends here
