;;; init-python.el --- Configure Python modes  -*- lexical-binding: t; -*-

;; Copyright (C) 2016-2026 Miguel Guedes

;; Author: Miguel Guedes <miguel.a.guedes@gmail.com>
;; Keywords: tools
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:

;; Ruff:
;; `ruff' lints and formats Python, replacing flake8, pyflakes, Black and other
;; tools.  `flymake-ruff' lints every Python buffer
;; (features/init-flymake-ruff.el), so pylsp's linters and formatters are off:
;; they would duplicate ruff, at pycodestyle's 79 columns.  pylsp keeps
;; completion and navigation.
;;
;; Saving formats with ruff when the project installs ruff, but not Black, in
;; its virtualenv or `pre-commit' hooks.  A project declares its formatter by
;; depending on it, the rule features/init-prettier.el applies to node_modules.
;; Ruff on PATH does not count: formatting a project that never chose ruff
;; rewrites whole files of someone else's code on the first save.  Black in the
;; environment means ruff only lints.  A project overrides detection from the
;; .dir-locals.el at its root:
;;
;;   ((python-base-mode . ((init/python/format-on-save . nil))))
;;
;; Python is never formatted through Eglot: pylsp would use autopep8 or yapf,
;; which projects do not declare.  `pet' (features/init-pet.el) points
;; `ruff-format' and `flymake-ruff' at the project's own ruff, which reads the
;; project's configuration.
;;
;; Language server:
;; Eglot starts pylsp itself, so it only needs installing.  `pet' prefers a
;; pylsp in the project's virtualenv over the one on PATH, such as a
;; distribution package like Debian's python3-pylsp; system Pythons often refuse
;; pip installs (PEP 668).

;;; Code:

(defvar pet-search-globally)

(defvar-local init/python/format-on-save 'auto
  "Whether saving the buffer formats it with ruff.
`auto' formats when `init/python/project-formats-with-ruff-p' holds, t
always formats and nil never does.")
(put 'init/python/format-on-save 'safe-local-variable
     (lambda (value) (memq value '(auto t nil))))

(defconst init/python/pylsp-configuration
  '(:plugins (:pycodestyle (:enabled :json-false)
              :pyflakes (:enabled :json-false)
              :mccabe (:enabled :json-false)
              :autopep8 (:enabled :json-false)
              :yapf (:enabled :json-false)))
  "pylsp workspace settings, leaving diagnostics and formatting to ruff.")

(defun init/python/project-executable-p (name)
  "Return non-nil if the current project installs executable NAME.
Search the project's virtualenv and `pre-commit' hooks, not `exec-path'."
  (let ((pet-search-globally nil))
    (pet-executable-find name)))

(defun init/python/project-formats-with-ruff-p ()
  "Return non-nil if the current project installs ruff but not black."
  (and (init/python/project-executable-p "ruff")
       (not (init/python/project-executable-p "black"))))

(defun init/python/apply-format-on-save ()
  "Turn `ruff-format-on-save-mode' on or off per `init/python/format-on-save'."
  (ruff-format-on-save-mode
   (if (if (eq init/python/format-on-save 'auto)
           (init/python/project-formats-with-ruff-p)
         init/python/format-on-save)
       1
     -1)))

(defun init/python/config ()
  "Configure Python editing globally."
  (add-to-list 'init/buffer-format-handlers-alist
               '((python-mode python-ts-mode) . ignore))
  (with-eval-after-load 'eglot
    (setopt eglot-workspace-configuration
            (plist-put (copy-sequence eglot-workspace-configuration)
                       :pylsp init/python/pylsp-configuration))))

(defun init/python/enable ()
  "Customise `python-mode'."

  (init/common-nonweb-programming-mode)
  ;; Ruff's default, for code, comments and docstrings alike.
  (setq-local fill-column 88)
  ;; Mode hooks run before file and directory local variables apply, so decide
  ;; once they have; the hook runs only in buffers visiting a file.
  (add-hook 'hack-local-variables-hook #'init/python/apply-format-on-save nil t))

(use-package python
  :ensure nil
  :mode (("\\.py\\'" . python-ts-mode))
  :interpreter (("python[0-9.]*" . python-ts-mode))
  :config (init/python/config)
  :hook ((python-mode python-ts-mode) . init/python/enable))

(provide 'init-python)

;;; init-python.el ends here
