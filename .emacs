;;
;; My Keystroke definitions
;;

;; Key remappings due to rxvt terminal
;;(define-key input-decode-map "\e\eOA" [(meta up)])
;;(define-key input-decode-map "\e\eOB" [(meta down)])
;;(define-key input-decode-map "\e\e[A" [(control meta up)])
;;(define-key input-decode-map "\e\e[B" [(control meta down)])

(global-set-key [(meta g)] 'goto-line)
(global-set-key [(meta up)] 'backward-paragraph)
(global-set-key [(meta down)] 'forward-paragraph)
(global-set-key (kbd "ESC <up>") 'backward-paragraph)  ;; Mac OS X doesn't seem pick up the meta key for this
(global-set-key (kbd "ESC <down>") 'forward-paragraph) ;; Mac OS X doesn't seem pick up the meta key for this
(global-set-key [(control meta up)] 'beginning-of-defun)
(global-set-key [(control meta down)] 'c-end-of-defun)
(global-set-key [(control x) left] 'windmove-left)   ;; move to left window
(global-set-key [(control x) right] 'windmove-right) ;; move to right window
(global-set-key [(control x) up] 'windmove-up)       ;; move to upper window
(global-set-key [(control x) down] 'windmove-down)   ;; move to lower window

(global-set-key [(control x) (control down)] 'enlarge-window)
(global-set-key [(control x) (control up)] 'shrink-window)

(global-set-key [(control x) (control up)] 'shrink-window)
;;(global-set-key [(meta 91)] 'align)
(global-set-key [(meta 93)] 'align-regexp)

(setq delete-key-deletes-forward t) ;; Foward deletion
(setq transient-mark-mode t)        ;; Highlight region when marking

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Version control
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq vc-handled-backends nil) ;; turn it all off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Function for clearing trailing whitespace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun clean-whitespace ()
  "Removes trailing whitespace."
  (interactive)
  (save-excursion
    (goto-char 1)
    (replace-regexp "[ ]+$" "")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; File to mode bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq auto-mode-alist (append '(("\\.cpp$" .  c++-mode)
                                ("\\.cc$"  .  c++-mode)
                                ("\\.c$"   .  c-mode)
                                ("\\.h$"   .  c++-mode)
                                ("\\.ut$"  .  c++-mode)
                                ("\\.xml$" .  xml-mode)
                                ("\\.xsd$" .  xml-mode)
                                ("\\.xsl$" .  xml-mode)
                                ("\\.xslt$".  xml-mode)
                                ("\\.wsdl$" . xml-mode)) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GDB Bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Add the assembler window to the display
(defadvice gdb-setup-windows (around setup-more-gdb-windows activate)
  ad-do-it
  (switch-to-buffer-other-window (gdb-inferior-io-name))
  (split-window-vertically)
  (switch-to-buffer (gdb-assembler-buffer-name))
  (switch-to-buffer-other-window (buffer-name gud-comint-buffer))
)

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

;; Allow up/down arrows to work like in terminal GDB
(add-hook 'gdb-mode-hook
          (lambda()
            (local-set-key [up] 'comint-previous-input)
            (local-set-key [down] 'comint-next-input)
            ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Custom Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-label-minimum-indentation 0)
 '(c-offsets-alist (quote ((statement . 0) (statement-cont . 4) (substatement . 0) (substatement-open . 0) (statement-block-intro . 4) (block-open . 0) (block-close . 0) (case-label . 0) (defun-open . 0) (defun-block-intro . 4) (defun-close . 0) (topmost-intro . 0) (topmost-intro-cont . 0) (else-clause . 0) (brace-list-intro . 4) (brace-list-open . 0) (brace-list-entry . 0) (brace-list-close . 0) (inextern-lang . 0) (arglist-intro . 4) (comment-intro . 0) (label . 0) (class-open . 0) (class-close . 0) (member-init-intro . 4) (member-init-cont . 0) (friend . 0) (cpp-macro-cont . 12) (inclass . 4) (innamespace . 0) (inher-intro . 4) (access-label . -4) (inline-open . 0) (inline-close . 0) (template-args-cont c-lineup-template-args +))))
 '(gdb-many-windows t)
 '(gdb-use-separate-io-buffer t)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(indent-tabs-mode nil)
 '(large-file-warning-threshold nil)
 '(show-paren-delay 2)
 '(show-paren-style (quote parenthesis))
 '(show-trailing-whitespace t))
 

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(comint-highlight-prompt ((t (:foreground "blue1"))))
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
