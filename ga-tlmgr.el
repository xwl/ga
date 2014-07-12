;;; ga-tlmgr.el --- tlmgr backend (TexLive)

;; Copyright (C) 2014 William Xu

;; Author: William Xu <william.xwl@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
;; MA 02110-1301, USA.

;;; Code:

(require 'ga)

;; Variables
(defvar ga-tlmgr-font-lock-keywords
  '(("^package:[\t ]*\\(.*\\)"
     (1 ga-package-face nil t))
    ("^shortdesc:[\t ]*\\(.*\\)"
     (1 ga-description-face nil t))
    ("^[^ ]+:"
     (0 font-lock-keyword-face t t))))

(defvar ga-tlmgr-sources-file nil)

;; Interfaces
(defun ga-tlmgr-update ()
  )

;; (defun ga-tlmgr-search-by-name (pkg)
;;   (ga-run-command (list "search" "--keyword" pkg)))

(defun ga-tlmgr-search (pkg)
  (ga-run-command (list "search" "--keyword" pkg)))

(defun ga-tlmgr-show (pkg)
  (ga-run-command (list "info" "--list" pkg)))

(defun ga-tlmgr-install (pkg)
  (ga-run-command (list "install" pkg)))

(defalias 'ga-tlmgr-listfiles 'ga-tlmgr-show)

(defun ga-tlmgr-upgrade (pkg)
  (ga-run-command (list "update" pkg)))

(defun ga-tlmgr-remove (pkg)
  (ga-run-command (list "remove" pkg)))

;; Misc

(defun ga-tlmgr-update-available-pkgs ()
  (let ((arg "info | sed -e 's/\\..*//' -e 's/:.*//' -e 's/^i //' -e 's/ //g' | uniq"))
    (setq ga-available-pkgs
          (cons
           (list 'tlmgr
                 (cdr
                  (split-string
                   (ga-run-command-to-string arg))))
           (remove-if (lambda (i) (eq (car i) 'tlmgr))
                      ga-available-pkgs)))))

(provide 'ga-tlmgr)

;;; ga-tlmgr.el ends here
