
(defvar *db* ())

(defun make-cd (title artist rating ripped)
  (list :title title 
        :artist artist
        :rating rating
        :ripped ripped))

(defun add-record (record)
  (push record *db*))

;; format commands:
;;   a - "asthetic".  
;;        Don't use quotes around strings, don't use ' or :
;;        for symbols
;;   t - "tabulate".  ~10t: leave enough for 10 spaces.
;;   ~{...~} - iterate over elemnts of list
;;   ~% - emit a newline.  equivalent to \n (or is it \r\n?)
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))
  
(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  ; make sure no buffering of prompt goes on:
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (parse-relaxed-interger (prompt-read "Rating"))
   (y-or-n-p (prompt-read "Ripped [y/n]"))))

(defun parse-relaxed-interger (result)
  (or (parse-integer result :junk-allowed t)
      0))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
     (if (not (y-or-n-p "Another? [y/n]: "))
         (return))))
