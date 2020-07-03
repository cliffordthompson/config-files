;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Copyright (c) 2018-2020 Clifford Thompson
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
  (clifford:setup-perltidy)
  (clifford:setup-perlcritic)
  ;;(clifford:setup-ycmd)
  (clifford:setup-par-packer-mode)
  ;;(clifford:setup-perly-sense)
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
  (message "Starting yasnippet")
  (require 'yasnippet)
  (yas-global-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; iedit mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-iedit ()
  (require 'iedit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flycheck mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-flycheck ()
  (message "Starting Flycheck mode")
  (add-to-list 'load-path "~/.emacs.d/plugins/dash")
  (add-to-list 'load-path "~/.emacs.d/plugins/flycheck")
  (add-to-list 'load-path "~/.emacs.d/plugins/flycheck-tip")
  (require 'pkg-info) ;; Required by flycheck
  (require 'flycheck)
;;  (clifford:setup-flycheck-include-paths)

  ;; Flycheck popup tips
  (require 'flycheck-tip)
  (flycheck-tip-use-timer 'verbose)
  ;; Enable flycheck for code files
  (add-hook 'c++-mode-hook 'flycheck-mode)
  ;;(add-hook 'cperl-mode-hook 'flycheck-mode)
  ;;(add-hook 'perl-mode-hook 'flycheck-mode)
  (add-hook 'python-mode-hook 'flycheck-mode)
  (add-hook 'sh-mode-hook 'flycheck-mode)
  ;;(add-hook 'js-mode-hook 'flycheck-mode)

  ;;(setq flycheck-perlcritic-severity 1) ;; Severity: Brutal
  ;;  (setq flycheck-perlcritic "perlcritic.conf")
  )

(defun clifford:setup-flycheck-include-paths ()
  (setq flycheck-highlighting-mode (quote lines)))
;;  (setq flycheck-gcc-include-path
;;        (list
;;         (file-truename (concat clifford:workspace-path "<dirA>"))
;;         (file-truename (concat clifford:workspace-path "<dirB>")))))

;; Testing function for trying out flycheck
(defun clifford:setup-test-flycheck-workspace ()
  (interactive)
  (clifford:setup-flycheck))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; projectile mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq projectile-project-root "")

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; perltidy mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-perltidy ()
  (message "Setting up PerlTidy mode")
  (require 'perltidy)
  (add-hook 'cperl-mode 'perltidy)
  (add-hook 'perl-mode 'perltidy)
  (global-set-key [(control x) (p) (t) (b)] 'perltidy-buffer)
  (global-set-key [(control x) (p) (t) (r)] 'perltidy-region)
  (global-set-key [(control x) (p) (t) (f)] 'perltidy-subroutine)
  (global-set-key [(control x) (p) (t) (d)] 'perltidy-dwim-safe))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; perlcritic mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-perlcritic ()
  (message "Setting up PerlCritic mode")
  (require 'perlcritic)
  (setq perlcritic-profile "perlcritic.conf")
  (setq perlcritic-severity 1)
  (add-hook 'cperl-mode 'perlcritic)
  (add-hook 'perl-mode 'perlcritic)
  (global-set-key [(control x) (p) (c) (b)] 'perlcritic)
  (global-set-key [(control x) (p) (c) (r)] 'perlcritic-region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; par-packer mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-par-packer-mode ()
  (message "Setting up PAR::Packer mode")
  (setq par-packer-keywords
        '(("--\\(addfile\\|exclude\\|lib\\|link\\|module\\|noscan\\|compile\\|unicode\\|output\\|verbose\\|clean\\|filter\\|modfilter\\|cachedeps\\|compress\\)" . font-lock-keyword-face))))

(define-derived-mode par-packer-mode fundamental-mode
  (setq font-lock-defaults '(par-packer-keywords))
  (setq mode-name "par-packer"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devel::PerlySense
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-perly-sense ()
  (message "Setting up Devel::PerlySense")
  ;; The PerlySense prefix key (unset only if needed, like for \C-o)
  (global-unset-key "\C-o")
  (setq ps/key-prefix "\C-o")

  ;; ** Flymake **
  ;; Load flymake if t
  ;; Flymake must be installed.
  ;; It is included in Emacs 22
  ;;     (or http://flymake.sourceforge.net/, put flymake.el in your load-path)
  (setq ps/load-flymake t)
  ;; Note: more flymake config below, after loading PerlySense


  ;; *** PerlySense load (don't touch) ***
  (setq ps/external-dir (shell-command-to-string "perly_sense external_dir"))
  (if (string-match "Devel.PerlySense.external" ps/external-dir)
      (progn
        (message
         "PerlySense elisp files  at (%s) according to perly_sense, loading..."
         ps/external-dir)
        (setq load-path (cons
                         (expand-file-name
                          (format "%s/%s" ps/external-dir "emacs")
                          ) load-path))
        (load "perly-sense")
        )
    (message "Could not identify PerlySense install dir.
Is Devel::PerlySense installed properly?
Does 'perly_sense external_dir' give you a proper directory? (%s)" ps/external-dir)
    )

  ;; ** Flymake Config **
  ;; If you only want syntax check whenever you save, not continously
  (setq flymake-no-changes-timeout 9999)
  (setq flymake-start-syntax-check-on-newline nil)

  ;; ** Code Coverage Visualization **
  ;; If you have a Devel::CoverX::Covered database handy and want to
  ;; display the sub coverage in the source, set this to t
  (setq ps/enable-test-coverage-visualization nil)

  ;; ** Color Config **
  ;; Emacs named colors: http://www.geocities.com/kensanata/colors.html
  ;; The following colors work fine with a white X11
  ;; background. They may not look that great on a console with the
  ;; default color scheme.
  (set-face-background 'flymake-errline "antique white")
  (set-face-background 'flymake-warnline "lavender")
  (set-face-background 'dropdown-list-face "lightgrey")
  (set-face-background 'dropdown-list-selection-face "grey")

  ;; ** Misc Config **

  ;; Run calls to perly_sense as a prepared shell command. Experimental
  ;; optimization, please try it out.
  (setq ps/use-prepare-shell-command t))
