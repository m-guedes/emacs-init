;;; init-keybindings.el --- Global keybindings  -*- lexical-binding: t; -*-

;; Copyright (C) 2015-2026 Miguel Guedes

;; Author: Miguel Guedes <miguel.a.guedes@gmail.com>
;; Keywords: tools
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Code:

(global-set-key (kbd "C-x k")         #'kill-current-buffer)
;; `C-c f' copies the project-relative path, or `~/...' outside a project;
;; a prefix argument copies the absolute path.  Dired uses the entry at point.
(global-set-key (kbd "C-c f")         #'my/copy-file-path)
;; Symbol in programming modes, word elsewhere; `0' forces word, `C-u' symbol.
(global-set-key (kbd "C-c w")         #'my/copy-thing-at-point)
(global-set-key (kbd "C-c y")         #'browse-kill-ring)
(global-set-key (kbd "M-Q")           #'my/unfill-paragraph)

;; Buffer-related
;; Cycle through window-width wrapping, fill-column wrapping, and truncation.
(global-set-key (kbd "C-S-w")         #'my/cycle-line-wrapping)
(global-set-key (kbd "M-r")           #'revert-buffer)
(global-set-key (kbd "C-x C-b")       #'ibuffer)
; C-c g runs counsel-git-grep but we favour our own version since counsel was
; found to hang too frequently and cause memory leaks.
(global-set-key (kbd "C-c g")         #'my/git-grep)
(global-set-key (kbd "C-c G")         #'find-grep)
(global-set-key (kbd "C-x /")         #'bury-buffer)

;; Redefine C-h (help) as C-x h and define backspace as C-h. Note that Emacs
;; help feature can still be accessed via F1.
(global-set-key (kbd "C-h")           #'delete-backward-char)

;; Replace mark-paragraph
(global-set-key (kbd "M-h")           #'backward-kill-word)

;; Ensure that C-left is bound to `backward-word' and `forward-word' so that
;; keys work consistently when subword-mode is active.
(global-set-key (kbd "C-<left>")      #'backward-word)
(global-set-key (kbd "C-<right>")     #'forward-word)

;; Define miscellaneous shortcuts.
(defun my/terminal ()
  "Open a terminal buffer.
Runs `vterm' if available, otherwise falls back to `shell'.
With a prefix argument, creates a new terminal buffer."
  (interactive)
  (if (fboundp 'vterm)
      (if current-prefix-arg
          (vterm t)
        (vterm))
    (shell (when current-prefix-arg
             (generate-new-buffer-name "*shell*")))))
(global-set-key (kbd "C-c t")         #'my/terminal)

(provide 'init-keybindings)

;;; init-keybindings.el ends here
