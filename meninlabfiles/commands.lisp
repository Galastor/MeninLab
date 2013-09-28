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
  (if (= (mode *game*) 2)
    (format *query-io* "�� ������� ������ ����, ����� ���� ������~%")
    (progn
      (setf (mode *game*) 2)
      (let ((enemy-list (remove-if-not 
			  #'(lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) *monsters*)))
	(let ((enemy (elt enemy-list (random (length enemy-list)))))
	  (setf (enemy *game*)
		(make-instance `creature :name (getf enemy :name) 
			       		 :health (* (getf enemy :health) (level (player *game*)))))))
      (format *query-io* "��������� ������� ~a, ������� ~a ����� ��������~%" 
	      (name (enemy *game*)) (health (enemy *game*))))))

(defcommand heal-com ())

(defmethod use ((command heal-com))
  (if (= (mode *game*) 1)
    (progn
      (setf (health (player *game*)) (* 10 (level (player *game*))))
      (format *query-io* "�� ��������� ����������~%"))
    (format *query-io* "�� ������� ������ ����, ����� ��������~%")))

(defcommand kick-com ())

(defmethod use ((command kick-com))
  (if (= (mode *game*) 2)
    (progn
      (kick (player *game*) (enemy *game*))
      (if (>= (expa (player *game*)) (* 100 (level (player *game*))))
	(lvl-up (player *game*)))
      (if (> (health (enemy *game*)) 0)
	(kick (enemy *game*) (player *game*))
	(progn
	  (format *query-io* "~a �����~%" (name (enemy *game*)))
	  (setf (mode *game*) 1))))
    (format *query-io* "�� �� � ��� �� ����������~%")))

(defcommand run-com ())

(defmethod use ((command run-com))
  (if (= (mode *game*) 2)
    (if (= (random 2) 1)
      (let ((loseexp (* (level (player *game*)) 5)))
	(format *query-io* "�� �������� � ������ ~a ����� �����~%" loseexp)
	(decf (expa (player *game*)) loseexp)
	(setf (mode *game*) 1))
      (progn
	(format *query-io* "������� �� �������~%")
	(kick (enemy *game*) (player *game*))))
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
