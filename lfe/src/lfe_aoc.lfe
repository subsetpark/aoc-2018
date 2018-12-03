;; Documentation for the module.
(defmodule aoc_util
  (export (load 1))
  (export-macro loadm)
)

(defun load (day-num)
  (let* ([file-name (++ (integer_to_list day-num) ".md")]
         [file-path (filename:join (list "priv" file-name))]
         [(tuple 'ok contents) (file:read_file file-path)])
  (binary:split contents '(#"\n") '(global trim_all))))

(defmacro loadm ()
  '(let* ([mod-string (atom_to_list (MODULE))]
          [mod-num (list_to_integer (lists:nth 2 (string:split mod-string "_")))])
        (: aoc_util load mod-num)))
