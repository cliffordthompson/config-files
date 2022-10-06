;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Copyright (c) 2015-2022 Clifford Thompson
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
  (message "[clifford] Setting up Emacs IDE plugins")
  ;;(clifford:setup-gnu-global)
  ;;(clifford:setup-auto-complete)
  (clifford:setup-iedit)
  (clifford:setup-yasnippet)
  ;;(clifford:setup-ff-find-other-files)
  (clifford:setup-flycheck-mode)
  (clifford:setup-magit)
  (clifford:setup-projectile)
  (clifford::setup-projectile-rails)
  ;;(clifford:setup-perltidy)
  ;;(clifford:setup-perlcritic)
  ;;(clifford:setup-ycmd)
  ;;(clifford:setup-par-packer-mode)
  ;;(clifford:setup-perly-sense)
  (clifford::setup-editorconfig)
  (clifford::setup-lsp)
  (clifford::setup-helm)
  (clifford::setup-crux)
  (clifford::setup-company-mode)
  (clifford::setup-rspec-mode)
  (clifford::setup-ruby-mode)
  (clifford::setup-js2-mode)
  (clifford::setup-json-mode)
  (clifford::setup-web-mode)
  (clifford::setup-prettier)
  (clifford::setup-tide-mode)
  (clifford::setup-string-inflection)
  (clifford::setup-treemacs)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GNU Global
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-gnu-global ()
  (message "[clifford] Setting up GNU Global")
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
      (message "[clifford] Emacs version is earlier than or equal to 24.3. Not loading auto-complete mode."))
    (progn
      (message "[clifford] Emacs version is later than 24.3. Loading auto-complete mode.")
      (require 'auto-complete-config)
      (ac-config-default)
      (clifford:setup-auto-complete-c-headers))))

;; My hook for starting auto-complete-c-headers mode while editing
;; C++ and C files
(defun clifford:setup-auto-complete-c-headers ()
  (message "[clifford] Setting up auto-complete-c-headers")
  (add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-c-headers")
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-headers)
  (add-to-list 'achead:include-directories "<path to c++ headers>"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; yasnippet mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-yasnippet ()
  (message "[clifford] Setting up yasnippet")
  (require 'yasnippet)
  (require 'yasnippet-snippets)
  (require 'react-snippets)
  (require 'angular-snippets)
  (require 'js-react-redux-yasnippets)
  (require 'java-snippets)
  (require 'common-lisp-snippets)
  (require 'mocha-snippets)
  (yas-global-mode t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; iedit mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-iedit ()
  (message "[clifford] Setting up iedit")
  (require 'iedit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; flycheck mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-flycheck-mode ()
  (message "[clifford] Setting up Flycheck mode")
  (require 'flycheck)
  ;;  (clifford:setup-flycheck-include-paths)
  (clifford::setup-flycheck-exec-and-config-paths)

  ;; Flycheck popup tips
  (require 'flycheck-tip)
  (flycheck-tip-use-timer 'verbose)
  ;; Enable flycheck for code files
  (add-hook 'c++-mode-hook 'flycheck-mode)
  ;;(add-hook 'cperl-mode-hook 'flycheck-mode)
  ;;(add-hook 'perl-mode-hook 'flycheck-mode)
  (add-hook 'python-mode-hook 'flycheck-mode)
  (add-hook 'sh-mode-hook 'flycheck-mode)
  (add-hook 'html-mode-hook 'flycheck-mode)
  (add-hook 'mhtml-mode-hook 'flycheck-mode)
  (add-hook 'js-mode-hook 'flycheck-mode)
  (add-hook 'css-mode-hook 'flycheck-mode)
  (add-hook 'ng2-ts-mode-hook 'flycheck-mode)
  (add-hook 'ruby-mode-hook 'flycheck-mode)
  (add-hook 'haml-mode-hook 'flycheck-mode)
  (add-hook 'coffee-mode-hook 'flycheck-mode)

  ;; Make ng2-mode use tslint for Typescript files
  (flycheck-add-mode 'typescript-tslint 'ng2-ts-mode)

  ;; Make ng2-mode use tslint for Typescript files
  (flycheck-add-mode 'html-tidy 'mhtml-mode)

  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'javascript-mode)

  ;;(setq flycheck-perlcritic-severity 1) ;; Severity: Brutal
  ;;  (setq flycheck-perlcritic "perlcritic.conf")

  (add-hook 'flycheck-mode-hook #'clifford::use-eslint-from-node-modules)
  )

(defun clifford:setup-flycheck-include-paths ()
  (message "[clifford] Setting up Flycheck include paths")
  (setq flycheck-highlighting-mode (quote lines)))
;;  (setq flycheck-gcc-include-path
;;        (list
;;         (file-truename (concat clifford:workspace-path "<dirA>"))
;;         (file-truename (concat clifford:workspace-path "<dirB>")))))

;; Testing function for trying out flycheck
(defun clifford:setup-test-flycheck-workspace ()
  (interactive)
  (clifford:setup-flycheck))

(defun clifford::setup-flycheck-exec-and-config-paths ()
  (message "[clifford] Setting up Flycheck exec and config paths")

  ;; ESLint
  (setq flycheck-javascript-eslint-executable "/Users/clifford/Developer/thinkific/workspace/thinkific/node_modules/.bin/eslint")
  (setq flycheck-eslintrc "/Users/clifford/Developer/thinkific/workspace/thinkific/.eslintrc")

  ;; Stylelint (CSS)
  (setq flycheck-css-stylelint-executable "/Users/clifford/Developer/thinkific/workspace/thinkific/node_modules/.bin/stylelint")
  (setq flycheck-stylelintrc "/Users/clifford/Developer/thinkific/workspace/thinkific/.stylelintrc")
  (setq flycheck-stylelint-args "--formatter=unix")

  ;; SASS Lint (SASS/SCSS)
  (setq flycheck-sass/scss-sass-lint-executable "/Users/clifford/Developer/thinkific/workspace/thinkific/node_modules/.bin/sass-lint")
  (setq flycheck-scss-stylelint-executable "/Users/clifford/Developer/thinkific/workspace/thinkific/node_modules/.bin/stylelint")
  (setq flycheck-sass-lintrc ".sass-lint.yml")

  ;; Coffeescript
  (setq flycheck-coffee-executable "/Users/clifford/Developer/thinkific/workspace/thinkific/node_modules/.bin/coffee")

  ;; Perl Critic
  (setq flycheck-perlcriticrc "perlcritic.conf")

  ;; HTML Tidy
  (setq flycheck-tidyrc ".htmltidyrc"))

;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
(defun clifford::use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; projectile mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq projectile-project-root "~/Developer/thinkific/workspace/thinkific/")

(defun clifford:setup-projectile ()
  (message "[clifford] Setting up projectile-mode with root at %s" projectile-project-root)
  (require 'projectile)
  (require 'helm)
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )

(defun clifford::setup-projectile-rails ()
  (message "[clifford] Setting up projectile-rails-mode with root at %s" projectile-project-root)
  (require 'projectile-rails)
  (projectile-rails-global-mode)
  (setq projectile-rails-vanilla-command "bin/rails")
  (define-key projectile-rails-mode-map (kbd "C-c r") 'projectile-rails-command-map)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ycmd mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-ycmd ()
  (message "[clifford] Setting up YouCompleteMe mode")
  (set-variable 'ycmd-server-command '("python2.6" "<path to ycmd>"))
  (require 'ycmd)
  (ycmd-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Find other files
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-ff-find-other-files ()
  (message "[clifford] Setting up the search directories for ff-find-other-files")
  (set-variable 'ff-search-directories
                (list
                 (file-truename (concat clifford:workspace-path "<dirA>"))
                 (file-truename (concat clifford:workspace-path "<dirB")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; perltidy mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-perltidy ()
  (message "[clifford] Setting up PerlTidy mode")
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
  (message "[clifford] Setting up PerlCritic mode")
  (require 'perlcritic)
  (setq perlcritic-profile "C:\\Dev\\avnprod\\development\\tools\\conf\\perlcritic.conf")
  (setq perlcritic-severity 1)
  (setq perlcritic-verbose 3)
  (add-hook 'cperl-mode 'perlcritic)
  (add-hook 'perl-mode 'perlcritic)
  (global-set-key [(control x) (p) (c) (b)] 'perlcritic)
  (global-set-key [(control x) (p) (c) (r)] 'perlcritic-region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; par-packer mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-par-packer-mode ()
  (message "[clifford] Setting up PAR::Packer mode")
  (setq par-packer-keywords
        '(("--\\(addfile\\|exclude\\|lib\\|link\\|module\\|noscan\\|compile\\|unicode\\|output\\|verbose\\|clean\\|filter\\|modfilter\\|cachedeps\\|compress\\)" . font-lock-keyword-face))))

(define-derived-mode par-packer-mode fundamental-mode
  (setq font-lock-defaults '(par-packer-keywords))
  (setq mode-name "par-packer"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Devel::PerlySense
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-perly-sense ()
  (message "[clifford] Setting up Devel::PerlySense")
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
  (set-face-background 'flymake-errline "red4")
  (set-face-background 'flymake-warnline "cyan")
  (set-face-background 'dropdown-list-face "lightgrey")
  (set-face-background 'dropdown-list-selection-face "grey")

  ;; ** Misc Config **

  ;; Run calls to perly_sense as a prepared shell command. Experimental
  ;; optimization, please try it out.
  (setq ps/use-prepare-shell-command t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; magit mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford:setup-magit ()
  (message "[clifford] Setting up Magit mode")
  (require 'magit)
  (global-set-key [(control c) (g)] 'magit-file-dispatch)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EditorConfig
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-editorconfig ()
  (message "[clifford] Setting up EditorConfig")
  (editorconfig-mode 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-lsp ()
  (message "[clifford] Setting up LSP Mode")
  (require 'lsp-mode)
  (require 'lsp-ui)
  (require 'lsp-treemacs)
  (setq lsp-auto-configure t)
  (global-set-key [(control c) (59)] 'lsp-iedit-highlights)
  (add-hook 'ruby-mode-hook 'lsp)
  (add-hook 'js-mode-hook 'lsp)
  (add-hook 'typescript-mode-hook 'lsp)
  (add-hook 'web-mode-hook 'lsp)
  (lsp-treemacs-sync-mode 1)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-helm ()
  (message "[clifford] Setting up Helm")
  (require 'helm)
  (helm-mode 1)
  (global-set-key (kbd "M-x") 'helm-M-x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Crux
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-crux ()
  (message "[clifford] Setting up Crux")
  (require 'crux)
  (global-set-key [(control c) (d)] 'crux-duplicate-current-line-or-region))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Company Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-company-mode ()
  (message "[clifford] Setting up Company Mode")
  (require 'company)
  (require 'company-inf-ruby)
  (add-hook 'after-init-hook 'global-company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  (setq company-minimum-prefix-length 1)
  (setq company-require-match nil)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; RSpec Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-rspec-mode ()
  (message "[clifford] Setting up RSpec Mode")
  (require 'rspec-mode)
  (eval-after-load 'rspec-mode '(rspec-install-snippets))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-ruby-mode ()
  (message "[clifford] Setting up Ruby Mode")
  (setq ruby-insert-encoding-magic-comment nil) ;; Stop inserting encoding comments
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JS2 Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-js2-mode ()
  (message "[clifford] Setting up JS2 Mode")
  (require 'js2-mode)
  (add-hook 'js-mode-hook 'js2-minor-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JSON Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-json-mode ()
  (message "[clifford] Setting up JSON Mode")
  (require 'json-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Web Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-web-mode ()
  (message "[clifford] Setting up Web Mode")
  (require 'web-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prettier Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun clifford::setup-prettier ()
  (message "[clifford] Setting up Prettier")
  (require 'prettier)
  (add-hook 'after-init-hook #'global-prettier-mode)
  (add-hook 'js-mode-hook #'prettier-mode)
  (add-hook 'js-jsx-mode-hook #'prettier-mode)
  (add-hook 'typescript-mode-hook #'prettier-mode)
  (add-hook 'ruby-mode-hook #'prettier-mode)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TIDE Mode
;;   https://github.com/ananthakumaran/tide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford::_setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(defun clifford::setup-tide-mode ()
  (message "[clifford] Setting up TIDE Mode")
  (require 'tide)
  (setq tide-project-root "~/Developer/thinkific/workspace/thinkific/")
  (add-hook 'js-mode-hook #'clifford::_setup-tide-mode)
  (add-hook 'js-jsx-mode-hook #'clifford::_setup-tide-mode)
  (add-hook 'typescript-mode-hook #'clifford::_setup-tide-mode)
  (setq company-tooltip-align-annotations t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; String Inflection Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford::setup-string-inflection ()
  (message "[clifford] Setting up string-inflection")
  (require 'string-inflection)
  (setq string-inflection-skip-backward-when-done t)

  ;; default
  (global-set-key (kbd "C-c s i") 'string-inflection-all-cycle)

  ;; for ruby
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (local-set-key
                (kbd "C-c s i") 'string-inflection-ruby-style-cycle)))

  ;; for java
  (add-hook 'java-mode-hook
            '(lambda ()
               (local-set-key
                (kbd "C-c s i") 'string-inflection-java-style-cycle)))

  ;; for python
  (add-hook 'python-mode-hook
            '(lambda ()
               (local-set-key
                (kbd "C-c s i") 'string-inflection-python-style-cycle))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Treemacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clifford::setup-treemacs ()
  (message "[clifford] Setting up Treemacs")
  (require 'treemacs)
)
