;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Copyright (c) 2015 Clifford Thompson
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This file contains the general setup that I use for
;; setting up IDE-like capabilities for Emacs
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-emacs-ide ()
  (message "Setting up Emacs IDE plugins for %s" major-mode)
  (clifford:setup-gnu-global)
  (clifford:setup-auto-complete)
  (clifford:setup-iedit)
  (clifford:setup-yasnippet)
  ;;(clifford:setup-ff-find-other-files)
  (clifford:setup-flycheck)
  (clifford:setup-projectile)
  ;;(clifford:setup-ycmd)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GNU Global
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-gnu-global ()
  (setq load-path (cons "~/.emacs.d/plugins" load-path))
  (load-library "gtags")
  (autoload 'gtags-mode "gtags" "" t)

  (global-set-key [(control x) (meta 46)] 'gtags-find-tag-from-here) ;; C-x M-. finds tag
  (global-set-key [(control x) (meta 47)] 'gtags-find-rtag)          ;; C-x M-/ find all references
  (global-set-key [(control x) (meta 39)] 'gtags-pop-stack)          ;; C-x M-' pop the gtags
  (global-set-key [(control x) (meta 44)] 'gtags-find-file)          ;; C-x M-, finds file
  (global-set-key [(control x) (meta 59)] 'gtags-find-tag))          ;; C-x M-; finds symbol usages

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Autocomplete mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-auto-complete ()
  (if (version<= emacs-version "24.3")
    (progn
      (message "Emacs version is earlier than or equal to 24.3. Not loading auto-complete mode."))
    (progn
      (message "Emacs version is later than 24.3. Loading auto-complete mode.")
      (add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
      (require 'auto-complete-config)
      (ac-config-default)
      (clifford:setup-auto-complete-c-headers))))

;; My hook for starting auto-complete-c-headers mode while editing
;; C++ and C files
(defun clifford:setup-auto-complete-c-headers ()
  (add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-c-headers")
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-headers)
  (add-to-list 'achead:include-directories "<path to c++ headers>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-yasnippet ()
  (add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
  (require 'yasnippet)
  (yas-global-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; iedit mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-iedit ()
  (add-to-list 'load-path "~/.emacs.d/plugins/iedit")
  (require 'iedit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flycheck mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-flycheck ()
  (message "Starting Flycheck mode")
  (add-to-list 'load-path "~/.emacs.d/plugins/dash")
  (add-to-list 'load-path "~/.emacs.d/plugins/flycheck")
  (add-to-list 'load-path "~/.emacs.d/plugins/flycheck-tip")
  (require 'flycheck)
;;  (clifford:setup-flycheck-include-paths)

  ;; Flycheck popup tips
  (require 'flycheck-tip)
  (flycheck-tip-use-timer 'verbose))

(defun clifford:setup-flycheck-include-paths ()
(setq flycheck-highlighting-mode (quote lines)))

;; Enable C++11 support for gcc
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
;;  (setq flycheck-clang-include-path
;;        (list
;;         (file-truename (concat clifford:workspace-path "<dirA>"))
;;         (file-truename (concat clifford:workspace-path "<dirB>")))))

;; Testing function for trying out flycheck
(defun clifford:setup-test-flycheck-workspace ()
  (interactive)
  (clifford:setup-flycheck))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; porjectile mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-projectile ()
  (require 'projectile)
  (projectile-global-mode)
  (message "Starting projectile-mode with root at %s" projectile-project-root))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ycmd mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-ycmd ()
  (message "Setting up YouCompleteMe mode")
  (add-to-list 'load-path "~/.emacs.d/plugins/ycmd")
  (add-to-list 'load-path "~/.emacs.d/plugins/dash")
  (add-to-list 'load-path "~/.emacs.d/plugins/deferred")
  (add-to-list 'load-path "~/.emacs.d/plugins/f")
  (add-to-list 'load-path "~/.emacs.d/plugins/popup")
  (add-to-list 'load-path "~/.emacs.d/plugins/s")
  (set-variable 'ycmd-server-command '("python2.6" "<path to ycmd>"))
  (require 'ycmd)
  (ycmd-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Find other files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-ff-find-other-files ()
  (message "Setting up the search directories for ff-find-other-files")
  (set-variable 'ff-search-directories
                (list
                 (file-truename (concat clifford:workspace-path "<dirA>"))
                 (file-truename (concat clifford:workspace-path "<dirB")))))
