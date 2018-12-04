(defmodule aoc_3
  (export (pt1 0) (pt2 0)))

(defun load () (aoc_util:loadm))

(defun pt1 ()
 (let ([two-or-more (dict:filter (match-lambda ((_ v) (> v 1))) (all-claims))])
  (dict:size two-or-more)))

(defun all-claims ()
 (let ([all-coords (lists:map (fun line->coords 1) (all-lines))])
  (lists:foldl (fun claim 2) (dict:new) all-coords)))

(defun all-lines () (lists:map (fun parse-line 1) (load)))

(defun parse-line (line)
    (let* ([(list claim-no _ coords area) (string:split line " " 'all)]
           [claim-no (string:trim claim-no 'leading "#")]
           [(list x y) (string:split (string:trim coords 'trailing ":") ",")]
           [(list width height) (string:split area "x")]
           [after-integer (lists:map (fun string to_integer 1) (list claim-no x y width height))])
      (lists:map (lambda (x) (element 1 x)) after-integer)))

(defun line->coords
  [((list _ x y width height))
   (let* ([xs (lists:seq x (+ x (- width 1)))]
          [ys (lists:seq y (+ y (- height 1)))])
    (list-comp ((<- x2 xs) (<- y2 ys)) (tuple x2 y2)))])

(defun claim (coords acc) (lists:foldl (fun update-dict 2) acc coords))

(defun update-dict
  (((tuple x y) acc) (dict:update_counter (tuple x y) 1 acc)))

(defun pt2 ()
  (let ([all-claims (all-claims)])
   (lists:filtermap (lambda (line) (check-claim line all-claims)) (all-lines))))

(defun check-claim (line all-claims)
  (let ([claim-no (car line)]
        [coords (line->coords line)])
    (cond
      [(lists:all (lambda (coord-pair) (== 1 (dict:fetch coord-pair all-claims))) coords)
       (tuple 'true claim-no)]
      ['true 'false])))
