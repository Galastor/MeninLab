(defmacro defcommand (name params) 
  `(defclass ,name (command) ,params))

(defun promt-read (promt) 
  (format *query-io* "~a: " promt) 
  (force-output *query-io*) 
  (read-line *query-io*))
