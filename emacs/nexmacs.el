;; ██╗███╗   ███╗ █████╗  ██████╗███████╗
;; ██║████╗ ████║██╔══██╗██╔════╝██╔════╝
;; ██║██╔████╔██║███████║██║     ███████╗
;; ██║██║╚██╔╝██║██╔══██║██║     ╚════██║
;; ██║██║ ╚═╝ ██║██║  ██║╚██████╗███████║
;; ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
                                      

;; Package management with use-package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                      KEY-BINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; SETUP some prefix for some actions
(define-prefix-command 'eglot-lsp)
(define-prefix-command 'emacs-buffer)
(define-prefix-command 'list-themes)
(define-prefix-command 'windows)
(define-prefix-command 'neotree)
(define-prefix-command 'consult)

;; Advance keybindings
(global-set-key (kbd "C-c l") 'eglot-lsp)
(global-set-key (kbd "C-c e") 'emacs-buffer)
(global-set-key (kbd "C-c t") 'list-themes)
(global-set-key (kbd "C-c w") 'windows)
(global-set-key (kbd "C-c n") 'neotree)
(global-set-key (kbd "C-c c") 'consult)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "s-f") 'toggle-frame-fullscreen)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                     UI-UX
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save backup file in ~/.Trash
(setq backup-directory-alist '((".*" . "~/.Trash")))

;; Remove some noisy elements and add some new ones 😛
(scroll-bar-mode 0)
(display-battery-mode 1)
(display-time-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; Set Fonts
(set-face-attribute 'default nil :family "Fira Code Retina" :height 138)
(set-face-attribute 'variable-pitch nil :font "Fira Code Retina" :height 108)
(set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 108)

;; Line numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)
;; Disable line number for some mode
(dolist (mode '(org-mode-hook
		eshell-mode-hook
		shell-mode-hook
		dired-mode-hook
		term-mode-hook
		vterm-mode-hook
		vterm-toggle-mode-hook
		neotree-mode-hook
		eww-mode-hook
		treemacs-mode-hook
		))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Transparency
(add-to-list 'default-frame-alist '(alpha-background . 94))

;; Load theme
(use-package doom-themes)
(load-theme 'doom-Iosvkem t)

;; ;; Doom modeline
;; (use-package doom-modeline
;;   :init
;;   (doom-modeline-mode t)
;;   :custom (doom-modeline-height 10)
;;   )

;; Spacious Padding Mode
(use-package spacious-padding
  :init
  (spacious-padding-mode t)
  )

;; Complete the parenthesis
(use-package smartparens
  :hook (prog-mode . smartparens-mode))

;; Different color for different parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Custom theme path
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                         GENERAL-COMPONENTS                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Use-command-completion-and-description-package
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
        ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1)
  )


(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x b" . counsel-switch-buffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)
  )


(use-package ivy-rich
  :init
  (ivy-rich-mode t)
  )

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))


(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key))


(use-package consult)

;; Setup Leader key and Which keybinding
(use-package general)

(use-package which-key
  :init
  (which-key-mode t)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                         FILE-MANAGER                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package neotree
  :bind (
	 :map neotree
	      ("t" . neotree-toggle)
	      )
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 40
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action 
        neo-theme (if (display-graphic-p) 'icons )
	)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                         VERSION-CONTROL                                                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Git Based Settings
(use-package magit
  :custom  ;; display git diff in same window
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  )

(use-package forge)

(use-package git-gutter
  :hook ((text-mode . git-gutter-mode)
	 (prog-mode . git-gutter-mode))
  :config
  (setq git-gutter:update-interval 0.02))

(use-package git-gutter-fringe
  :config
  (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))(use-package git-gutter)

(use-package blamer
  :ensure t
  :config
  (global-blamer-mode 1)
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  (blamer-max-commit-message-length 100)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 140
                   :italic t)))
    )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                         ORG-MODE                                                                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Org-Mode
;; Turn on indentation and auto-fill mode for Org files
(defun bs/org-mode-setup ()				  
  (org-indent-mode)					  
  ;;(variable-pitch-mode 1)				  
  ;;(auto-fill-mode 0)				  
  (visual-line-mode 1))				  
  ;;(setq evil-auto-indent nil))

(use-package org
  :defer t
  :hook (org-mode . bs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers nil) ;;org-hide-emphasis-marker is used to hide the markers that are used for bold, italic, underline etc. 
  )


(use-package org-bullets					
  :after org							
  :hook (org-mode . org-bullets-mode)
  :custom							
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))	

(with-eval-after-load 'org-faces
(dolist (face '((org-level-1 . 1.3)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :font "Martianmono Nerd Font " :weight 'medium :height (cdr face))))

(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
	(python . t)
       ))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("bs" . "src bash"))
  )

;; Dashboard
(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-banner-logo-title "Editor of the century")
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-startup-banner "~/.config/emacs/images/gnu.jpg")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 3)
                        (agenda . 3)
                        (registers . 3)))
  (setq dashboard-icon-type 'all-the-icons) 
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                  LSP AND PROGRAMMING MODES                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; LSP MODE and PROGRAMMING MODES

(use-package eglot
  :diminish
  :bind (
	 :map eglot-lsp
	      ("a" . eglot-code-actions)
	      ("e" . eglot)
	 )
  )

(use-package company
  :init (global-company-mode 1)
  :hook (prog-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))


;; Packages for programming-modes
(use-package python-mode
  :hook (python-mode . eglot-ensure))

(use-package go-mode
  :hook (go-mode . eglot-ensure))

(use-package yaml-mode
  :mode "\\.y?ml\\'"
  :hook (yaml-mode . eglot-ensure)
  )

(use-package emacs
  :bind(
	:map emacs-buffer
	     ("v" . eval-buffer)
	     ("q" . revert-buffer-quick)
	     ("k" . kill-buffer)
	     ("b" . counsel-switch-buffer)
	:map list-themes
	     ("t" . counsel-load-theme)
	:map windows
	     ("h" . split-window-below)
	     ("d" . delete-window)
	     ("x" . delete-other-windows)
	     ("v" . split-window-right)
	     ("o" . other-window)
	)
  )

(use-package consult

  :bind(
	:map consult
	     ("f" . consult-flymake)
	)
  )


(use-package vterm)
;; (use-package yaml-mode
;;   :mode "\\.y?ml\\'"
;;   :hook (yaml-mode . lsp-deferred)
;;   :config
;;   (setq lsp-yaml-schemas '(:kubernetes "/*-k8s.yaml"))
;;   :custom
;;   (lsp-yaml-completion t)
;;   )

(use-package gptel)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(inputrc-mode yaml-mode which-key vterm spacious-padding smartparens rainbow-delimiters python-mode protobuf-mode org-bullets neotree lsp-ui lsp-treemacs lsp-pyright lsp-ivy helpful go-mode git-gutter-fringe general forge eglot doom-themes doom-modeline dashboard counsel consult company-box blamer all-the-icons-ivy-rich all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
