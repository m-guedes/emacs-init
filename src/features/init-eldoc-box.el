;;; init-eldoc-box.el --- Configure eldoc-box  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Miguel Guedes

;; Author: Miguel Guedes <miguel.a.guedes@gmail.com>
;; Keywords: tools
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Code:

(use-package eldoc-box
  :after eglot
  :bind (:map eglot-mode-map
              ("C-c l h" . eldoc-box-help-at-point))
  :custom
  (eldoc-box-clear-with-C-g t))

(provide 'init-eldoc-box)

;;; init-eldoc-box.el ends here
