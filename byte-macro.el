;;; byte-macro.el -- Add byte shorthand to elisp
;;; Commentary:
;; Just thought this might be a neat thing to add

;;; Code:
(require 'subr-x)

(defmacro bytes (byte-units)
  "Convert BYTE-UNITS to number.
Byte units are in the form [0-9]+[BKMGTPZ].
Example: (bytes 12G)"
  (if-let* ((units '(B K M G T P Z))
            (symbol-name (symbol-name byte-units))
            (unit (replace-regexp-in-string "[0-9]+" "" symbol-name))
            (number (string-to-number (replace-regexp-in-string "[BKMGTPZ]" "" symbol-name)))
            (pow (cl-position unit units :test 'string=)))
      `(* ,number (expt 1024 ,pow))
    (error "Unrecognized unit %s" byte-units)))

(provide 'byte-macro)
;;; byte-macro.el ends here