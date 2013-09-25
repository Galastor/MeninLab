(defun promt-read (promt) 
  (format *query-io* "~a: " promt) 
  (force-output *query-io*) 
  (read-line *query-io*))

(defun roll (x)
  (+ (mod (+ (get-internal-real-time) (random x)) x) 1)) ;;�������� �� ���������� ������


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
  (setf *game* (make-instance `game :player (create-player)))
  (format *query-io* "����� ���������� � ���� \"����\"~%��� ������� �������� \"������\" ��� \"?\"~%")
    (loop
      (use (read-command))
      (if *exit* (return))))

