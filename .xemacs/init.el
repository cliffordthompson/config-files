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

;;
;; My Keystroke definitions
;;

(global-set-key 'return 'newline-and-indent)
(global-set-key 'delete 'delete-char)
;;(global-set-key 'kp-7 'undo)
(global-set-key 'kp-8 'query-replace-regexp)

;;
;; TAG completion 
;;

;;(global-set-key '(meta 92) 'tag-complete-symbol)

;;
;; Find TAG
;;

(global-set-key '(meta 46) 'find-tag-other-window)

;;
;; Align
;;
(global-set-key '(meta 91) 'align)
(global-set-key '(meta 93) 'align-regexp)

;; Cut 

;;(global-set-key 'kp-4 'x-kill-primary-selection)
;;(global-set-key '(meta control button1) 'x-kill-primary-selection)

;; Copy

;;(global-set-key 'kp-5 'x-copy-primary-selection)
;;(global-set-key '(meta control button2) 'x-copy-primary-selection)

;; Paste 

;;(global-set-key 'kp-6 'x-yank-clipboard-selection)
;;(global-set-key '(meta control button3) 'x-yank-clipboard-selection)


;; Foward deletion 

(setq delete-key-deletes-forward t)

;; Tab
(global-set-key '(tab) 'indent-according-to-mode)

;; Closing XEmacs. Prevent save-buffers-kill-emacs from
;; being called
(global-set-key (kbd "C-x C-c") nil)

;;
;; file and warning definitions 
;;

(setq display-warning-minimum-level 'error)
(setq font-lock-maximum-decoration t)


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

(setq minibuffer-max-depth nil)

;;
;; background definitions 
;;


(set-face-background-pixmap 'default "~/.xemacs/img/xemacs.xpm")

;;
;; My Style for C Programming
;;

(defconst my-c-style
  '(;;(c-basic-offset  . 0)
    (c-offsets-alist . ((statement             . 0)
                        (statement-cont        . 4)
                        (substatement          . 0)
                        (substatement-open     . 0)
                        (statement-block-intro . 4)
                        (comment-intro         . 0)
                        (access-label          . 0)
                        (block-open            . 0)
                        (block-close           . 0)
                        (case-label            . 2)
                        (defun-open            . 0)
                        (defun-block-intro     . 4)
                        (defun-close           . 0)
                        (topmost-intro         . 0)
                        (topmost-intro-cont    . 0)
                        (else-clause           . 0)
                        (brace-list-intro      . 4)
                        (brace-list-open       . 0)
                        (brace-list-entry      . 0)
                        (inextern-lang         . 0)
                        (cpp-macro-cont        . 12)
                        (arglist-intro         . 4))))
  "My C Programming Style")

(defun my-c-mode-common-hook ()
        (c-add-style "my-c-style" my-c-style t)
        (setq tab-width 8 indent-tabs-mode nil) ;; Indent
)

;;
;; My Style for C++ Programming
;;

(defconst my-cpp-style
  '((c-offsets-alist . (;; C or C++
                        (statement             . 0)
                        (statement-cont        . 4)
                        (substatement          . 0)
                        (substatement-open     . 0)
                        (statement-block-intro . 4)
                        (block-open            . 0)
                        (block-close           . 0)
                        (case-label            . 0)
                        (defun-open            . 0)
                        (defun-block-intro     . 4)
                        (defun-close           . 0)
                        (topmost-intro         . 0)
                        (topmost-intro-cont    . 0)
                        (else-clause           . 0)
                        (brace-list-intro      . 4)
                        (brace-list-open       . 0)
                        (brace-list-entry      . 0)
                        (brace-list-close      . 0)
                        (inextern-lang         . 0)
                        (arglist-intro         . 4)
                        (comment-intro         . 0)
			(label                 . 0)
                        ;; C++ specific
                        (class-open            . 0)
                        (class-close           . 0)
                        (member-init-intro     . 4)
                        (member-init-cont      . 0)
                        (friend                . 0)
                        (cpp-macro-cont        . 12)
                        (inclass               . 4)
                        (innamespace           . 0)
                        (inher-intro           . 4)
                        (access-label          . -4)
                        (inline-open           . 0)
                        (inline-close          . 0)
                        (template-args-cont c-lineup-template-args +))))
  "My C++ Programming Style")

(defun my-cpp-mode-common-hook ()
        (c-add-style "my-cpp-style" my-cpp-style t)
        (setq tab-width 8 indent-tabs-mode nil) ;; Indent
)

;;
;; My Style for Makefiles
;;

(defun My-makefile-common-hook ()
        (setq tab-width 8)
)

;;
;; My Styles for XML files
;;

(defun My-xml-common-hook ()
        (setq sgml-indent-step 4
              sgml-indent-data 4
              sgml-set-face nil
              tab-width 4
              indent-tabs-mode nil) ;; Indent
)

;;
;; Mode Hooks
;;

(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-hook 'turn-on-font-lock)
(add-hook 'c++-mode-hook 'my-cpp-mode-common-hook)
(add-hook 'makefile-mode-hook 'my-makefile-common-hook)
(add-hook 'xml-mode-hook 'my-xml-common-hook)

;; Do DOS style end-of-line characters
;;(modify-coding-system-alist 'file "\\.*\\'" 'raw-text-dos) 

;;;
;;; Function for clearing trailing whitespace
;;;
(defun clean-whitespace-region (start end)
  "Removes trailing whitespace, and re-indents the region"
  (interactive "r")
  (save-excursion
    (replace-regexp "[  ]+$" "")))

;;;(defun test-ws ()
;;;  "Ensures no trailing whitespace when adding newlines"
;;;  (interactive "*")
;;;  (delete-horizontal-space)
;;;  (newline-and-indent))
