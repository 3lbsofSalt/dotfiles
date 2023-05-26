;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Max Ramsdell"
      user-mail-address "max.ramsdell@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq js-indent-level 2)

;; Keybindings so that vim works with colemak

(map! :nv "n" #'evil-next-line)
(map! :n "j" #'evil-ex-search-next)
(map! :n "N" #'evil-join)
(map! :n "J" #'evil-ex-search-previous)

(map! :nve "e" #'evil-previous-line)
(map! :nve "E" #'+lookup/documentation)
(map! :nve "k" #'evil-forward-word-end)
(map! :nve "K" #'evil-forward-WORD-end)

(map! :n "l" #'evil-insert)
(map! :n "L" #'evil-insert-line)
(map! :nve "i" #'evil-forward-char)
(map! :nve "I" #'evil-window-bottom)

(map! :leader :map doom-leader-map :nve "w K" #'evil-window-new)
(map! :leader :map doom-leader-map :nve "w i" #'evil-window-right)
(map! :leader :map doom-leader-map :nve "w e" #'evil-window-up)
(map! :leader :map doom-leader-map :nve "w n" #'evil-window-down)

(map! :leader :map doom-leader-map :nve "w H" #'evil-window-move-far-left)
(map! :leader :map doom-leader-map :nve "w E" #'evil-window-move-very-top)
(map! :leader :map doom-leader-map :nve "w I" #'evil-window-move-far-right)
(map! :leader :map doom-leader-map :nve "w N" #'evil-window-move-very-bottom)


;; Various Emacs Utilities
(map! :leader :map doom-leader-map :n "s g" #'consult-ripgrep)

(defun openEshellInNewWindow ()
  "Opens Eshell in a new window."
  (evil-window-vsplit)
  (eshell))

(map! :leader :map doom-leader-map :n "o e" #'openEshellInNewWindow)
(map! :leader :map doom-leader-map :n "o E" #'eshell)

(setq tab-width 2)
(setq evil-shift-width 2)

(defun my-web-mode-hook ()
  "Hook for web-mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-attr-indent-offset 2))

(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

(add-hook 'web-mode-hook 'my-web-mode-hook)

(set-frame-font "scientifica" nil t)
(set-face-attribute 'default nil :height 140)

(setq so-long-threshold 1000000)

;; Company Mode Config
(add-hook 'after-init-hook 'global-company-mode)
; No delay
(setq company-idle-delay 0)
; Suggestions after 1 character
(setq company-minimum-prefix-length 1)
; Wrap around list of suggestions
(setq company-selection-wrap-around t)
; Use tab key to cycle suggestions
(company-tng-configure-default)
(setq company-backends
      '((company-files          ; files & directory
         company-keywords       ; keywords
         company-capf
         company-yasnippet
         )
        (company-abbrev company-dabbrev)
        ))
