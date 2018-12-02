;; Documentation for the module.
(defmodule aoc_util
  (export (load 1)))

(defun load (day-num)
  (let* ([file-name (++ (integer_to_list day-num) ".md")]
         [file-path (filename:join (list "priv" file-name))]
         [(tuple 'ok contents) (file:read_file file-path)])
  (binary:split contents '(#"\n") '(global trim_all))))
