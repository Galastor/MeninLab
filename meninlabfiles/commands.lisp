(defcommand help-com ())

(defmethod use ((command help-com) room)
  (format *query-io* "\"?\" ��� \"������\" - ������� �������
\"����\" - ��������� ���������� � ���������
�����/��/������/����� - ����������� �� ����
\"��������\" - ���������� �������� ���������, � ������� ��������� ��������
\"�������\" - ������� ���� ���������� (�� ����� ���)
\"�������\" - ������� �� ���
\"���������\" - ���������� ���������� � ����������
\"�����\" - ����� �� ����
����� �������� ������, �� ����� ����� � ������ �������.
�����: Galastor~%"))

(defcommand info-com ())

(defmethod use ((command info-com) room)
  (let ((player (player *game*)))
    (format *query-io* "~a~%�������(����): ~a(~a)~%������: ~a~%��������: ~a~%����: ~a~%������������: ~a~%������: ~a (~a)~%"
	    (name player) (level player) (expirience player) (gold player) 
	    (health player) (strength player) (vitality player)
	    (name (weapon player)) (description (weapon player)))))

(defcommand walk-com ((direction :initarg :direction :reader direction)))

(defmethod use ((command walk-com) room)
  (if (= (mode *game*) 2)
    (format *query-io* "�� ������� ������ ����, ����� ����~%")
    (let ((exit (getf (exits *current-room*) (direction command))))
      (if exit
	(progn
	  (setf *current-room* exit)
	  (format *query-io* "�� ����� �� ~a.~%~%" (getf (list :north "�����" :south "��" :east "������" :west "�����") (direction command)))
	  (format *query-io* "~a~%~a~%������:~:[~; �����~]~:[~; ��~]~:[~; ������~]~:[~; �����~].~%" (name *current-room*) (description *current-room*) 
		  (getf (exits *current-room*) :north) (getf (exits *current-room*) :south) (getf (exits *current-room*) :east) (getf (exits *current-room*) :west)))
	(format *query-io* "�� �� ������ ����� � ���� �����������~%")))))

(defcommand heal-com ())

(defmethod use ((command heal-com) room)
  (format *query-io* "�� �� ������ ������ ��� �����.~%~%"))

(defcommand kick-com ())

(defmethod use ((command kick-com) room)
  (if (= (mode *game*) 2)
    (progn
      (kick (player *game*) (enemy *game*))
      (when (> (health (enemy *game*)) 0)
	(kick (enemy *game*) (player *game*))))
    (format *query-io* "�� �� � ��� �� ����������~%")))

(defcommand run-com ())

(defmethod use ((command run-com) room)
  (if (= (mode *game*) 2)
    (if (= (random 2) 1)
      (let ((loseexp (* (level (player *game*)) 5)))
	(format *query-io* "�� �������� � ������ ~a ����� �����~%" loseexp)
	(decf (expirience (player *game*)) loseexp)
	(setf (mode *game*) 1))
      (progn
	(format *query-io* "������� �� �������~%")
	(kick (enemy *game*) (player *game*))))
    (format *query-io* "�� �� � ��� �� ����������.~%")))

(defcommand enemy-info-com ())

(defmethod use ((command enemy-info-com) room)
  (if (= (mode *game*) 2)
    (format *query-io*"~a~%��������: ~a~%����: ~a~%������������: ~a~%" (name (enemy *game*)) (health (enemy *game*)) 
	    							       (strength (enemy *game*)) (vitality (enemy *game*)))
    (format *query-io* "�� �� � ��� �� ����������.~%")))

(defcommand exit-com ())

(defmethod use ((command exit-com) room)
  (setf *exit* t)
  (format *query-io* "�� �������!~%"))

(defcommand save-com ())

(defmethod use ((command save-com) room)
  (format *query-io* "���, ��� ������� �������� �� ��������~%"))

;(defmethod use ((command save-com) room)
;  (if (= (mode *game*) 1)
;    (progn (with-open-file (out (ensure-directories-exist "mlsaves/meninlab.save")
;				:direction :output :if-exists :supersede)
;	     (with-standard-io-syntax 
;	       (print (list 
;			:name (name (player *game*))
;			:health (health (player *game*))
;			:strength (strength (player *game*))
;			:vitality (vitality (player *game*))
;			:level (level (player *game*))
;			:expirience (expirience (player *game*))) out)))
;	   (format *query-io* "���� ������� ���������~%"))
;    (Format *query-io* "�� ������� ������ ����~%")))

(defcommand trade-list-com ())

(defmethod use ((command trade-list-com) room)
  (format *query-io* "����� �� � ��� ���������.~%"))

(defcommand stir-up-com ())

(defmethod use ((command stir-up-com) room)
  (format *query-io* "����� ������ ��������.~%"))

(defcommand dig-com ())

(defmethod use ((command dig-com) room)
  (format *query-io* "�� �������� ��������� ��� � ������������� � �����.~%"))

(defcommand read-com ())

(defmethod use ((command read-com) room)
  (format *query-io* "����� ������ ������.~%"))

(defcommand look-com ())

(defmethod use ((command look-com) room)
  (format *query-io* "~a~%~a~%������:~:[~; �����~]~:[~; ��~]~:[~; ������~]~:[~; �����~].~%" (name *current-room*) (description *current-room*) 
		  (getf (exits *current-room*) :north) (getf (exits *current-room*) :south) (getf (exits *current-room*) :east) (getf (exits *current-room*) :west)))

(defcommand buy-com ())

(defmethod use ((command buy-com) room)
  (format *query-io* "����� ��� ��������.~%"))

(defcommand exception-com ((ecode :initarg :ecode :reader ecode)))

(defmethod use ((command exception-com) room) 
  (cond
    ((= (ecode command) 1) (format *query-io* "����������� �������~%"))))

(defcommand admin-mode-com ())

(defmethod use ((command admin-mode-com) room)
  (setf (level (player *game*)) 
	(or (parse-integer (promt-read "�������") :junk-allowed t) 1))
  (setf (vitality (player *game*)) 
	(or (parse-integer (promt-read "������������") :junk-allowed t) 1))
  (setf (strength (player *game*)) 
	(or (parse-integer (promt-read "����") :junk-allowed t) 1)))
