(defcommand help-com ())

(defmethod use ((command help-com))
  (format *query-io* "\"?\" ��� \"������\" - ������� �������
\"����\" - ��������� ���������� � ���������
\"����\" - ����������� ����
\"��������\" - ������ ���������
\"�������\" - ������� ���� ���������� (�� ����� ���)
\"�������\" - ������� �� ���
\"���������\" - ���������� ���������� � ����������
\"�����\" - ����� �� ����
����� ������ ������� - ��������� ��������� �� ������
�����: Galastor~%"))

(defcommand info-com ())

(defmethod use ((command info-com))
  (let ((player (player *game*)))
    (format *query-io* "~a~%�������(����): ~a(~a)~%��������: ~a~%" (name player) (level player) (expa player) (health player))))

(defcommand walk-com ())

(defmethod use ((command walk-com))
  (setf (enemy *game*) (make-instance `creature :name "������" :health (+ (* 8 (level (player *game*))) 
									  (random (* 4 (level (player *game*)))))))
  (setf (mode *game*) 2)
  (format *query-io* "��������� ������� ~a, ������� ~a ����� ��������~%" (name (enemy *game*)) (health (enemy *game*))))

(defcommand heal-com ())

(defmethod use ((command heal-com))
  (let ((heal (random 4)))
    (setf (health (player *game*)) (min (* 10 (level (player *game*))) (+ (health (player *game*)) heal)))
    (format *query-io* "�� ���������� �� ~a. ������� ��������: ~a~%" heal (health (player *game*)))))

(defcommand kick-com ())

(defmethod use ((command kick-com))
  (if (= (mode *game*) 2)
    (let ((damage (random 4)))
      (decf (health (enemy *game*)) damage)
      (incf (expa (player *game*)) damage)
      (format *query-io* "�� ������� ���������� ~a ����� (~a)~%" damage (health (enemy *game*)))
      (when (>= (expa (player *game*)) (* 100 (level (player *game*))))
	(decf (expa (player *game*)) (* 100 (level (player *game*))))
	(incf (level (player *game*)))
	(setf (health (player *game*)) (* 10 (level (player *game*))))	
	(format *query-io* "�� �������� ������ ������!~%"))
      (if (> (health (enemy *game*)) 0)
	(let ((damage (random 4)))
	  (decf (health (player *game*)) damage)
	  (format *query-io* "��������� ����� ~a ����� (~a)~%" damage (health (player *game*)))
	  (when (< (health (player *game*)) 1)
	    (format *query-io* "������ ������ �� �����, ~a, ����� �� ������ ~a ������.~%" 
		    (name (player *game*)) (level (player *game*)))
	    (setf *exit* t)))
	(progn
	  (format *query-io* "��������� �����~%")
	  (setf (mode *game*) 1))))
    (format *query-io* "�� �� � ��� �� ����������~%")))

(defcommand run-com ())

(defmethod use ((command run-com))
  (if (= (mode *game*) 2)
    (if (= (random 2) 1)
      (let ((loseexp (* (level (player *game*)) 5)))
	(format *query-io* "�� �������� � ������ ~a ����� �����~%" loseexp)
	(decf (expa (player *game*)) loseexp))
      (progn 
	(format *query-io* "������� �� �������~%")
	(let ((damage (random 4)))
	  (decf (health (player *game*)) damage)
	  (format *query-io* "��������� ����� ~a ����� (~a)~%" damage (health (player *game*)))
	  (when (< (health (player *game*)) 1)
	    (format *query-io* "������ ������ �� �����, ~a, ����� �� ������ ~a ������.~%" 
		    (name (player *game*)) (level (player *game*)))
	    (setf *exit* t)))))
    (format *query-io* "�� �� � ��� �� ����������.~%")))

(defcommand enemy-info-com ())

(defmethod use ((command enemy-info-com))
  (if (= (mode *game*) 2)
    (format *query-io* "~a~%��������: ~a~%" (name (enemy *game*)) (health (enemy *game*)))
    (format *query-io* "�� �� � ��� �� ����������.~%")))

(defcommand exit-com ())

(defmethod use ((command exit-com))
  (setf *exit* t))

(defcommand exception-com ((ecode :initarg :ecode :reader ecode)))

(defmethod use ((command exception-com)) 
  (cond
    ((= (ecode command) 1) (format *query-io* "����������� �������~%"))))
