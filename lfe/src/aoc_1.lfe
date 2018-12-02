;; Documentation for the module.
(defmodule aoc_1
  (export (pt1 0) (pt2 0)))

(defun load () (aoc_util:load 1))

(defun consume-word (word n) (+ n (binary_to_integer word)))

(defun eval (lines n) (lists:foldl (fun consume-word 2) n lines))

(defun pt1 () (eval (load) 0))
(defun pt2 () (eval-check (load) 0 (sets:new)))

(defun eval-check
  (((cons word words) n seen)
        (let ([changed (consume-word word n)])
        (cond
          ((sets:is_element changed seen) changed)
          ('true (eval-check words changed (sets:add_element changed seen))))))
  ((() n seen) (eval-check (load) n seen)))
