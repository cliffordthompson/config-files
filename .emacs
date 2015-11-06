;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;; My Keystroke definitions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Key remappings due to rxvt terminal
;;(define-key function-key-map "\e\eOA" [(meta up)])
;;(define-key function-key-map "\e\eOB" [(meta down)])
;;(define-key function-key-map "\e\e2C" [(control meta up)])
;;(define-key function-key-map "\e\e2D" [(control meta down)])
(define-key global-map (kbd "RET") 'newline-and-indent-and-no-whitespace)

(global-set-key [(meta g)] 'goto-line)
(global-set-key (kbd "ESC <up>") 'backward-paragraph)         ;; Mac OS X doesn't seem pick up the meta key for this
(global-set-key (kbd "ESC <down>") 'forward-paragraph)        ;; Mac OS X doesn't seem pick up the meta key for this
(global-set-key [(meta up)] 'backward-paragraph)
(global-set-key [(meta down)] 'forward-paragraph)
(global-set-key [(control meta  up)] 'transpose-line-up)      ;; C-M-up move current line up
(global-set-key [(control meta down)] 'transpose-line-down)   ;; C-M-down move current line down
(global-set-key [(control c) (d)] 'duplicate-line)            ;; C-c-d duplicate current line with integer increment
(global-set-key [(control x) left] 'windmove-left)            ;; move to left window
(global-set-key [(control x) right] 'windmove-right)          ;; move to right window
(global-set-key [(control x) up] 'windmove-up)                ;; move to upper window
(global-set-key [(control x) down] 'windmove-down)            ;; move to lower window
(global-set-key [(control x) (control down)] 'enlarge-window) ;; C-x C-down adjust window size down
(global-set-key [(control x) (control up)] 'shrink-window)    ;; C-x C-up adjust window size up
(global-set-key [(control x) (w)] 'whitespace-cleanup)        ;; C-x-w Remove trailing whitespace
(global-set-key [(meta 91)] 'align)                           ;; M-[
(global-set-key [(meta 93)] 'align-regexp)                    ;; M-]
(global-set-key [(control x) (meta l)] 'linum-mode)           ;; C-x M-l toggle line number mode
(global-set-key [(control x) (meta o)] 'ff-find-other-file)   ;; C-x M-o C-x M-o open opposite source file
(global-set-key [(meta 8)] 'extend-selection)                 ;; M-8 mark the word under cursor
(global-set-key [(control x) (meta 46)] 'gtags-find-tag-from-here) ;; C-x M-. finds tag
(global-set-key [(control x) (meta 47)] 'gtags-find-rtag)          ;; C-x M-/ find all references
(global-set-key [(control x) (meta 39)] 'gtags-pop-stack)          ;; C-x M-' pop the gtags
(global-set-key [(control x) (meta 44)] 'gtags-find-file)          ;; C-x M-, finds file
(global-set-key [(control x) (meta 59)] 'gtags-find-tag)           ;; C-x M-; finds symbol usages

(setq delete-key-deletes-forward t)                           ;; Foward deletion
(setq transient-mark-mode t)                                  ;; Highlight region when marking
(setq make-backup-files nil)                                  ;; Disable ~ files
(setq auto-save-default nil)                                  ;; Disable #auto-ssave# files

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Line number mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq linum-format "%4d|")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Line motion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun transpose-line-up ()
  "Move the current line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun transpose-line-down ()
  "Move the current line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun duplicate-line (num-lines)
  "Duplicates line and increments any numbers within that line."
  (interactive "p")
  (if (not num-lines) (setq num-lines 0) (setq num-lines (1- num-lines)))
  (let* ((col (current-column))
         (bol (save-excursion (forward-line (- num-lines)) (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (goto-char bol)
    (while (re-search-forward "[0-9]+" eol 1)
      (let ((num (string-to-int (buffer-substring
                                 (match-beginning 0) (match-end 0)))))
        (replace-match (int-to-string (1+ num))))
        (setq eol (save-excursion (goto-char eol) (end-of-line) (point))))
    (goto-char bol)
    (insert line "\n")
    (move-to-column col)
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Remove trailing whitspace on newlines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun newline-and-indent-and-no-whitespace ()
  "Ensure there is no trailing whitespace when adding newlines"
  (interactive)
  (delete-horizontal-space)
  (newline-and-indent)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; erc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq erc-prompt (lambda () (concat (buffer-name) ">"))) ;; Set the prompt to the IRC channel name
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/.emacs.d/org/gtd/in-basket.org"
                             "~/.emacs.d/org/gtd/next-actions.org"
                             "~/.emacs.d/org/gtd/references.org"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Marking a word under a cursor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)
      )
    )
  (up-list arg)
  )

;; by Nikolaj Schumacher, 2008-10-20. Released under GPL.
(defun extend-selection (arg &optional incremental)
  "Select the current word. Subsequent calls expands the selection to larger semantic unit."
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (or (and transient-mark-mode mark-active)
                         (eq last-command this-command))))
  (if incremental
      (progn
        (semnav-up (- arg))
        (forward-sexp)
        (mark-sexp -1))
    (if (> arg 1)
        (extend-selection (1- arg) t)
      (if (looking-at "\\=\\(\\s_\\|\\sw\\)*\\_>")
          (goto-char (match-end 0 ))
        (unless (memq (char-before) '(?\) ?\"))
          (forward-sexp)))
      (mark-sexp -1)
      )
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GNU Global
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load Gtags support
;;(setq load-path (cons "<path to gtags.el>" load-path))
;;(load-library "gtags")
;;(autoload 'gtags-mode "gtags" "" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Autocomplete mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Earlier version of emacs are missing libraries for auto-complete
;; mode. So don' load them in that case

(if (version<= emacs-version "24.5")
    (progn
      (message "Emacs version is earlier than 24.5. Not loading auto-complete mode.")
      )
  (progn
    (message "Emacs version is 24.5 or later. Loading auto-complete mode.")
    (add-to-list 'load-path "~/.emacs.d/auto-complete")
    (require 'auto-complete-config)
    (ac-config-default)
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Version control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq vc-handled-backends nil) ;; turn it all off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File to mode bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq auto-mode-alist (append '(("\\.cpp$"  .  c++-mode)
                                ("\\.cc$"   .  c++-mode)
                                ("\\.c$"    .  c-mode)
                                ("\\.gp$"   .  shell-script-mode) ;; GNU Plot
                                ("\\.h$"    .  c++-mode)
                                ("\\.ut$"   .  c++-mode)
                                ("\\.xml$"  .  nxml-mode)
                                ("\\.xsd$"  .  nxml-mode)
                                ("\\.xsl$"  .  nxml-mode)
                                ("\\.xslt$" .  nxml-mode)
                                ("\\.wsdl$" .  nxml-mode)
                                ("\\.org$"  .  org-mode)) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GDB Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add the assembler window to the display
;;(defadvice gdb-setup-windows (around setup-more-gdb-windows activate)
;;  ad-do-it
;;  (switch-to-buffer-other-window (gdb-inferior-io-name))
;;  (split-window-vertically)
;;  (switch-to-buffer (gdb-assembler-buffer-name))
;;  (switch-to-buffer-other-window (buffer-name gud-comint-buffer))
;;)

;; Add colour to the current GUD line
(defvar gud-overlay
(let* ((ov (make-overlay (point-min) (point-min))))
(overlay-put ov 'face 'region)
ov)
"Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight act)
"Highlight current line."
(let* ((ov gud-overlay)
(bf (gud-find-file true-file)))
(save-excursion
  (set-buffer bf)
  (move-overlay ov (line-beginning-position) (line-end-position)
  (current-buffer)))))

(defun gud-kill-buffer ()
(if (eq major-mode 'gud-mode)
(delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Abbreviations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(abbrev-mode 1)
;;
;;(load-file "~/.emacs.d/company-skeletons-cpp.el")
;;(define-abbrev-table 'c++-mode-abbrev-table ())
;;(define-abbrev c++-mode-abbrev-table "clst"   'company-c++-class-skeleton)
;;(define-abbrev c++-mode-abbrev-table "tsclst" 'company-c++-test-suite-class-skeleton)
;;(define-abbrev c++-mode-abbrev-table "pbf"    'company-c++-func-public-comment-skeleton)
;;(define-abbrev c++-mode-abbrev-table "pvf"    'company-c++-func-private-comment-skeleton)
;;(define-abbrev c++-mode-abbrev-table "forl"   'company-c++-for-skeleton)
;;(define-abbrev c++-mode-abbrev-table "ifst"   'company-c++-if-skeleton)
;;(define-abbrev c++-mode-abbrev-table "ifest"  'company-c++-if-else-skeleton)
;;(define-abbrev c++-mode-abbrev-table "est"    'company-c++-enum-skeleton)
;;(define-abbrev c++-mode-abbrev-table "sst"    'company-c++-switch-skeleton)
;;(define-abbrev c++-mode-abbrev-table "cst"    'company-c++-case-skeleton)
;;
;;(load-file "~/.emacs.d/company-skeletons-html.el")
;;(define-abbrev-table 'html-mode-abbrev-table ())
;;(define-abbrev html-mode-abbrev-table "<head" 'company-html-head-skeleton)
;;(define-abbrev html-mode-abbrev-table "<body" 'company-html-body-skeleton)
;;(define-abbrev html-mode-abbrev-table "<php"  'company--html-php-skeleton)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Misc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable the splash screen. To enable it again, replace the t with nil
(setq inhibit-splash-screen nil)

;; Display the enclosing scope in the modeline
(which-function-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Custom Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-label-minimum-indentation 0)
 '(c-offsets-alist
   (quote
    ((statement . 0)
     (statement-cont . 4)
     (substatement . 0)
     (substatement-open . 0)
     (statement-block-intro . 4)
     (block-open . 0)
     (block-close . 0)
     (case-label . 0)
     (defun-open . 0)
     (defun-block-intro . 4)
     (defun-close . 0)
     (topmost-intro . 0)
     (topmost-intro-cont . 0)
     (else-clause . 0)
     (brace-list-intro . 4)
     (brace-list-open . 0)
     (brace-list-entry . 0)
     (brace-list-close . 0)
     (inextern-lang . 0)
     (arglist-intro . 4)
     (comment-intro . 0)
     (label . 0)
     (class-open . 0)
     (class-close . 0)
     (member-init-intro . 4)
     (member-init-cont . 0)
     (friend . 0)
     (cpp-macro-cont . 12)
     (inclass . 4)
     (innamespace . 4)
     (inher-intro . 4)
     (access-label . -4)
     (inline-open . 0)
     (inline-close . 0)
     (template-args-cont c-lineup-template-args +))))
 '(column-number-mode t)
 '(erc-autoaway-message
   "I'm gone (auto after %i seconds od idletime). You might need to send me an email if I'm not paying attention.")
 '(erc-autoaway-mode t)
 '(erc-current-nick-highlight-type (quote nick-or-keyword))
 '(erc-enable-logging t)
 '(erc-generate-log-file-name-function (quote erc-generate-log-file-name-with-date))
 '(erc-log-channels-directory "~/.emacs.d/erc/log")
 '(erc-log-insert-log-on-open nil)
 '(erc-log-mode t)
 '(erc-log-write-after-insert)
 '(erc-log-write-after-send t)
 '(erc-save-buffer-on-part)
 '(ff-always-try-to-create nil)
 '(ff-ignore-include t)
 '(gdb-many-windows t)
 '(gdb-use-separate-io-buffer t)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(indent-tabs-mode nil)
 '(large-file-warning-threshold nil)
 '(org-agenda-skip-deadline-if-done t)
 '(org-log-done (quote time) t)
 '(org-log-note-clock-out nil)
 '(safe-local-variables-values
   (quote
    ((tabs-width . 4)
     (topmost-intro . 8)
     (c-offsets-alist
      (statement-block-intro . +))
     (statement-block-intro . 8))))
 '(show-paren-delay 2)
 '(show-paren-style (quote parenthesis))
 '(show-trailing-whitespace t))


(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(comint-highlight-prompt ((t (:foreground "green"))))
 '(ediff-current-diff-A ((((class color) (min-colors 16)) (:background "color-80"))))
 '(ediff-current-diff-Ancestor ((((class color) (min-colors 16)) (:background "color-80"))))
 '(ediff-current-diff-B ((((class color) (min-colors 16)) (:background "color-80"))))
 '(ediff-current-diff-C ((((class color) (min-colors 16)) (:background "color-80"))))
 '(ediff-even-diff-A ((((class color) (min-colors 16)) nil)))
 '(ediff-even-diff-Ancestor ((((class color) (min-colors 16)) nil)))
 '(ediff-even-diff-B ((((class color) (min-colors 16)) nil)))
 '(ediff-even-diff-C ((((class color) (min-colors 16)) nil)))
 '(ediff-fine-diff-A ((((class color) (min-colors 16)) (:background "red" :foreground "white"))))
 '(ediff-fine-diff-Ancestor ((((class color) (min-colors 16)) (:background "red" :foreground "white"))))
 '(ediff-fine-diff-B ((((class color) (min-colors 16)) (:background "red" :foreground "white"))))
 '(ediff-fine-diff-C ((((class color) (min-colors 16)) (:background "red" :foreground "white"))))
 '(ediff-odd-diff-A ((t nil)))
 '(ediff-odd-diff-Ancestor ((((class color) (min-colors 16)) nil)))
 '(ediff-odd-diff-B ((((class color) (min-colors 16)) nil)))
 '(ediff-odd-diff-C ((((class color) (min-colors 16)) nil)))
 '(erc-action-face ((t (:foreground "green4" :weight normal))))
 '(erc-button ((t (:foreground "cyan4" :weight normal))))
 '(erc-command-indicator-face ((t (:foreground "color-60" :weight normal))))
 '(erc-current-nick-face ((t (:foreground "DarkTurquoise" :weight normal))))
 '(erc-input-face ((t (:foreground "steelblue" :weight normal))))
 '(erc-keyword-face ((t (:foreground "pale green" :weight normal))))
 '(erc-my-nick-face ((t (:foreground "DarkTurquoise" :weight normal))))
 '(erc-nick-default-face ((t (:foreground "#aa1100" :weight normal))))
 '(erc-nick-message-face ((t (:foreground "IndianRed" :weight normal))))
 '(erc-notice-face ((t (:foreground "grey50" :weight normal))))
 '(erc-prompt-face ((t (:foreground "orange" :weight normal))))
 '(erc-timestamp-face ((t (:foreground "green4" :weight normal))))
 '(font-lock-comment-face ((t (:foreground "red"))))
 '(font-lock-constant-face ((t (:foreground "cyan4"))))
 '(font-lock-function-name-face ((t (:foreground "steelblue"))))
 '(font-lock-keyword-face ((t (:foreground "orange3"))))
 '(font-lock-preprocessor-face ((t (:foreground "#cd00cd"))))
 '(font-lock-string-face ((t (:foreground "green4"))))
 '(font-lock-type-face ((((class color) (min-colors 8)) (:foreground "yellow3"))))
 '(font-lock-variable-name-face ((t (:foreground "cyan4"))))
 '(highlight ((((class color) (min-colors 88) (background light)) (:background "grey" :foreground "black"))))
 '(link ((((class color) (background light)) (:foreground "steelblue" :underline t))))
 '(minibuffer-prompt ((t (:foreground "red"))))
 '(mode-line ((t (:background "color-22" :foreground "black" :box (:line-width -1 :style released-button)))))
 '(mode-line-buffer-id ((t (:foreground "color-17" :weight light))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#7f7f7f" :foreground "black" :box (:line-width -1 :color "grey75") :weight light))))
 '(region ((((class color) (min-colors 88) (background light)) (:background "grey10"))))
 '(show-paren-match ((((class color) (background light)) (:foreground "brightwhite"))))
 '(show-paren-mismatch ((((class color)) (:foreground "red"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red")))))
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
