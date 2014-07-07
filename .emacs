(set-default-font "Menlo-16")
(when (display-graphic-p) 
  (setq fonts 
        (cond ((eq system-type 'darwin)     '("Monaco"     "STHeiti")) 
              ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei")) 
              ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei")))) 

  (setq face-font-rescale-alist '(("STHeiti" . 1.2) ("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2))) 
  (set-face-attribute 'default nil :font 
                      (format "%s:pixelsize=%d" (car fonts) 16)) 
  (dolist (charset '(kana han symbol cjk-misc bopomofo)) 
    (set-fontset-font (frame-parameter nil 'font) charset 
                      (font-spec :family (car (cdr fonts)))))) 


(add-to-list 'load-path "~/.emacs.d/load")
(setq exec-path (cons "/usr/local/bin" exec-path))  

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'substatement-open 0)
(setq c-basic-offset 4)

(defun my-c-mode-common-hook()
  (c-toggle-auto-state 1)
  (c-toggle-auto-hungry-state 1)
)

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)


;; PHP mode
(load "php-mode")
(add-to-list 'auto-mode-alist
  '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))
(defun my-php-mode()
;;设置php程序的对齐风格
;(c-set-style "K&R")
;;自动模式，在此种模式下当你键入｛时，会自动根据你设置的对齐风格对齐
(c-toggle-auto-state)
;;此模式下，当按backspace时会删除最多的空格
(c-toggle-hungry-state)
;;在菜单中加入当前buffer的函数索引
(imenu-add-menubar-index)
;;在状态条上显示当前光标在哪个函数体内部
(which-function-mode)
)
(add-hook 'php-mode-hook 'my-php-mode)

(set-scroll-bar-mode nil)
(if window-system
      (setq default-frame-alist
                 (append
                     '( (top . 80)
                             (left . 100)                               
                                 (width . 110)
                                 (height . 35))
                                     default-frame-alist))
)
(mouse-avoidance-mode 'animate)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
;;(setq auto-save-default nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq display-time-day-and-date t)
(display-time)

(add-to-list 'load-path "~/.emacs.d/load/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))
(sublime-text-2)


(setq load-path (cons  "~/.emacs.d/load/erlang"
      load-path))
      (setq erlang-root-dir "/usr/local/lib/erlang")
      (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
      (require 'erlang-start)


;;yasnippet
(add-to-list 'load-path
              "~/.emacs.d/load/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;;Auto compelete
(add-to-list 'load-path
              "~/.emacs.d/load/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/load/auto-complete/dict")
(ac-config-default)

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

(setq-default ac-sources '(
			   ac-source-yasnippet 
			   ac-source-dictionary 
			   ac-source-words-in-same-mode-buffers
			   ac-source-words-in-buffer
			   ac-source-words-in-all-buffer
			   ac-source-files-in-current-dir
			   ac-source-filename))

;; (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)    
;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;; (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;; (global-auto-complete-mode t)
;; (add-to-list 'ac-modes 'objc-mode)


;; xcscope
(require 'xcscope)

;; ecb
(load-file "~/.emacs.d/load/cedet/common/cedet.el")
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(setq semanticdb-default-save-directory "~/.emacs.d/semantic.cache/")
(setq semanticdb-project-roots
      (list
       (expand-file-name "/home/wfei/IAM3.1")))


(add-to-list 'load-path "~/.emacs.d/load/ecb/")
(require 'ecb)

;; Highlight Current Line
;;(require 'crosshairs)
;;(crosshairs-mode t)
;;(set-face-background 'hl-line "light green")

;; Fast Open
(ido-mode t)

;; 
(global-set-key [f1] 'eshell)
(global-set-key [f2] 'compile)
(global-set-key [f12] 'ecb-activate)
(global-set-key [C-f12] 'ecb-deactivate)
(global-set-key [(meta return)] 'semantic-ia-complete-symbol-menu)
(global-set-key [C-.] 'cscope-find-global-definition)

(custom-set-variables
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(display-time-mode t)
 '(ecb-auto-activate nil)
 '(ecb-options-version "2.32")
 '(ecb-tip-of-the-day nil)
 '(ecb-windows-width 0.18)
 '(tool-bar-mode nil)
 '(global-linum-mode t))

;;Python Config
(require 'python)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-m" 'newline-and-indent)))

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;;Markdown
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;;haml
(require 'haml-mode)
(add-hook 'haml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (define-key haml-mode-map "\C-m" 'newline-and-indent)))
