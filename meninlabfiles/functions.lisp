(defun promt-read (promt) 
  (format *query-io* "~a: " promt) 
  (force-output *query-io*) 
  (read-line *query-io*))

(defun defmonster (name min-lvl max-lvl health)
  (list :name name :min-lvl min-lvl :max-lvl max-lvl :health health))

(defun add-monster (monster)
  (push monster *monsters*))

(defun save-monstesr-db ()
  (with-open-file (out (concatenate 'string *folder* "meninlabfiles/monsters.db")
		   :direction :output
		   :if-exists :supersede)
    (with-standard-io-syntax
      (print *monsters* out))))

(defun load-monsters-db ()
  (with-open-file (in (concatenate 'string *folder* "meninlabfiles/monsters.db"))
    (with-standard-io-syntax
      (setf *monsters* (read in)))))

(defun create-player ()
  (make-instance `player :health 10 :name (promt-read "������� ��� ���������")))

(defun read-command ()
  (let ((input (read-line *query-io*)))
    (cond 
      ((or (string-equal input "?") (string-equal input "������")) (make-instance `help-com))
      ((string-equal input "����") (make-instance `info-com))
      ((string-equal input "����") (make-instance `walk-com))
      ((string-equal input "��������") (make-instance `heal-com))
      ((string-equal input "�������") (make-instance `kick-com))
      ((string-equal input "�������") (make-instance `run-com))
      ((string-equal input "���������") (make-instance `enemy-info-com))
      ((string-equal input "�����") (make-instance `exit-com))
      (t (make-instance `exception-com :ecode 1)))))

(defun play ()
  (setf *exit* ())
  (load-monsters-db)
  (setf *game* (make-instance `game :player (create-player)))
  (format *query-io* "����� ���������� � ���� \"����\"~%��� ������� �������� \"������\" ��� \"?\"~%")
    (loop
      (use (read-command))
      (if *exit* (return))))
