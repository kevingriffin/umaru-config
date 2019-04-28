;;; cfn-mode.el --- Cloudformation template editor mode

;; Package-Requires: ((flycheck) (yaml-mode) (json-mode))

;;; Commentary:

;; Adapted from https://awk.space/blog/cfn-lint/

;;; Code:

(require 'flycheck)
(require 'yaml-mode)
(require 'json-mode)

;;;###autoload
(defun cfn-mode-auto ()
  "Cloudformation template mode, automatically detecting JSON vs YAML."
  (let ((is-json (save-excursion
                   (widen)
                   (goto-char (point-min))
                   (looking-at "{"))))
    (if is-json (cfn-json-mode) (cfn-yaml-mode))))

;;;###autoload
(define-derived-mode cfn-yaml-mode yaml-mode
  "Cloudformation"
  "Cloudformation template mode.")

;;;###autoload
(define-derived-mode cfn-json-mode json-mode
  "Cloudformation"
  "Cloudformation template mode.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.template\\'" . cfn-mode-auto))

(flycheck-define-checker cfn-lint
  "A Cloudformation linter using cfn-python-lint.

See URL 'https://github.com/awslabs/cfn-python-lint'."
  :command ("cfn-lint" "-f" "parseable" source)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column
            ":" (one-or-more digit) ":" (one-or-more digit) ":"
            (id "W" (one-or-more digit)) ":" (message) line-end)
   (error line-start (file-name) ":" line ":" column
          ":" (one-or-more digit) ":" (one-or-more digit) ":"
          (id "E" (one-or-more digit)) ":" (message) line-end)
   )
  :modes (cfn-json-mode cfn-yaml-mode))

(add-to-list 'flycheck-checkers 'cfn-lint)

(provide 'cfn-mode)
;;; cfn-mode.el ends here
