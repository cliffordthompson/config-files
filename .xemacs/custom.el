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

(custom-set-variables
 '(column-number-mode t)
 '(ediff-coding-system-for-write (quote raw-text))
 '(fast-lock-mode t nil (fast-lock))
 '(font-lock-maximum-decoration t)
 '(font-lock-maximum-size 10000000)
 '(font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(lazy-shot-mode t nil (lazy-shot))
 '(line-number-mode t)
 '(paren-blink-interval 0.75)
 '(paren-max-blinks 1)
 '(paren-mode (quote paren) nil (paren))
 '(paren-sexp-mode (quote mismatch))
 '(sgml-markup-faces (quote ((start-tag . bold) (end-tag . bold) (comment . bold) (pi . bold) (sgml . bold) (doctype . bold) (entity . bold) (shortref . bold) (ignored . default) (ms-start . default) (ms-end . default))))
 '(tab-width 8)
 '(toolbar-visible-p nil))
(custom-set-faces
 '(default ((t (:foreground "grey70" :background "black" :size "12pt" :family "Clean" :bold nil))) t)
 '(blue ((t (:foreground "Dodgerblue"))) t)
 '(bold ((t (:size "12" :dim nil :bold nil :italic nil))) t)
 '(bold-italic ((t nil)) t)
 '(border-glyph ((t nil)) t)
 '(buffers-tab ((t (:foreground "black" :background "grey80"))) t)
 '(cperl-array-face ((((class color) (background light)) (:foreground "cyan4"))))
 '(cperl-hash-face ((((class color) (background light)) (:foreground "cyan4"))))
 '(custom-documentation-face ((t (:foreground "red"))) t)
 '(custom-face-tag-face ((t nil)))
 '(custom-group-tag-face ((((class color) (background light)) (:foreground "blue"))))
 '(custom-group-tag-face-1 ((((class color) (background light)) (:foreground "red"))))
 '(custom-saved-face ((t nil)))
 '(custom-state-face ((nil (:foreground "green"))))
 '(custom-variable-button-face ((t nil)))
 '(dired-face-marked ((((type x pm mswindows) (class color)) (:foreground "black" :background "green4"))))
 '(dired-face-permissions ((((type x pm mswindows) (class color)) nil)))
 '(font-lock-comment-face ((nil (:foreground "red"))))
 '(font-lock-constant-face ((nil (:foreground "cyan4"))))
 '(font-lock-function-name-face ((nil (:foreground "steelblue"))))
 '(font-lock-keyword-face ((nil (:foreground "orange3"))))
 '(font-lock-preprocessor-face ((nil (:foreground "darkorchid"))))
 '(font-lock-reference-face ((((class color) (background light)) (:foreground "grey30"))))
 '(font-lock-string-face ((nil (:foreground "green3"))))
 '(font-lock-type-face ((nil (:foreground "yellow4"))))
 '(font-lock-variable-name-face ((nil (:foreground "cyan4"))))
 '(font-lock-warning-face ((((class color) (background light)) (:foreground "Red"))))
 '(gui-button-face ((t (:foreground "white" :background "grey45"))) t)
 '(gui-element ((t (:foreground "black" :background "grey80" :family "clean"))) t)
 '(highlight ((t (:foreground "black" :background "gray50"))) t)
 '(highlight-80+ ((((background light)) (:foreground "pink" :background "dark gray"))))
 '(html-helper-bold-face ((t (:bold nil))))
 '(html-helper-italic-face ((t nil)))
 '(hyper-apropos-heading ((t nil)))
 '(hyper-apropos-major-heading ((t nil)))
 '(hyper-apropos-section-heading ((t nil)))
 '(hyper-apropos-warning ((t (:foreground "red"))))
 '(info-node ((t (:foreground "cyan2"))))
 '(info-xref ((t (:foreground "green2"))))
 '(isearch-secondary ((t (:foreground "black" :background "forestgreen"))) t)
 '(italic ((t nil)) t)
 '(list-mode-item-selected ((t (:foreground "black" :background "gray68"))) t)
 '(modeline ((t (:foreground "" :background "grey80"))) t)
 '(modeline-buffer-id ((t (:foreground "blue4"))) t)
 '(modeline-mousable ((t (:foreground "firebrick"))) t)
 '(modeline-mousable-minor-mode ((t (:foreground "green4"))) t)
 '(paren-match ((t (:foreground "black" :background "green3"))) t)
 '(paren-mismatch ((t (:foreground "black" :background "DeepPink"))) t)
 '(pointer ((t (:foreground "black" :background "orange3"))) t)
 '(primary-selection ((t (:background "grey50"))) t)
 '(secondary-selection ((t (:foreground "black" :background "paleturquoise"))) t)
 '(text-cursor ((t (:foreground "black" :background "orange3"))) t)
 '(toolbar ((t (:foreground "black" :background "Gray80"))) t)
 '(tpum-plain-face1 ((((class color)) nil)))
 '(tpum-pseudo-face1 ((((class color)) (:bold t))))
 '(tpum-toggled-face ((t nil)))
 '(underline ((t nil)) t)
 '(widget-button-face ((t nil)))
 '(widget-field-face ((((class grayscale color) (background light)) (:background "black"))))
 '(xrdb-option-value-face ((t (:foreground "red"))) t)
 '(zmacs-region ((t (:background "gray30"))) t))
