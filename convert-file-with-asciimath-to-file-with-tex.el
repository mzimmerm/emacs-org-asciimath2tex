;;; convert-file-with-asciimath-to-file-with-tex.el --- Convert am to tex.  -*- lexical-binding: t; -*-
;;; Commentary:
;;     This package converts AsciiMath inside org to Tex

;;; Code:

(defun my/convert-file-with-asciimath-to-file-with-tex (input-file output-file)
  "Convert from INPUT-FILE and OUTPUT-FILE."
  (progn
   ;;          (find-file "$input_file")
   (find-file input-file)
   ;; defun was here
   (my/org-asciimath-to-latex)
   ;;         (write-file "$output_file")
   (write-file output-file)
   (kill-buffer)
   ;;  (message "Conversion complete. Output saved to %s" "$output_file"))
   (message "Conversion complete. Output saved to %s" output-file)))
    

(defun my/org-asciimath-to-latex ()
  "Replace asciimath string with tex string."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "`\\([^`]+\\)`" nil t)
      ;; (let ((asciimath (match-string 1)))
      (let ((asciimath (replace-regexp-in-string "\\s-+" " " (match-string 1))))
        (message "asciimath=%s" asciimath)
        (delete-region (match-beginning 0) (match-end 0))
        (insert
         "$"
         (shell-command-to-string (concat "asciimath2tex-node.sh \"" asciimath "\""))
         "$"
         )
        ))))
  
(provide 'convert-file-with-asciimath-to-file-with-tex)
;;; convert-file-with-asciimath-to-file-with-tex.el ends here
