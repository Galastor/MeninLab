(defgeneric use (command))

(defgeneric kick (atacker defender))

(defmethod kick ((atacker player) (defender creature))
  (let ((damage (+ (random (/ (+ (strength atacker) (mod (strength atacker) 2) 2) 2)) 
		   (/ (- (strength atacker) (mod (strength atacker) 2)) 2))))
    (if (< (random 100) (+ 5 (strength atacker)))
      (incf damage (strength atacker)))
    (decf (health defender) damage)
    (incf (expa atacker) damage)
    (format *query-io* "�� ������� ���������� ~a ����� (~a)~%" damage (health defender))))

(defmethod kick ((atacker creature) (defender player))
  (let ((damage (+ (random (/ (+ (strength atacker) (mod (strength atacker) 2) 2) 2)) 
		   (/ (- (strength atacker) (mod (strength atacker) 2)) 2))))
    (if (< (random 100) (+ 5 (strength atacker)))
      (incf damage (strength atacker)))
    (decf (health defender) damage)
    (format *query-io* "~a ����� ~a ����� (~a)~%" (name atacker) damage (health defender))
    (when (< (health defender) 1)
      (format *query-io* "������ ������ �� �����, ~a, ����� �� ������ ~a ������.~%" 
	      (name (player *game*)) (level (player *game*)))
      (setf *exit* t))))

(defgeneric lvl-up (player))

(defmethod lvl-up ((player player))
  (format *query-io* "�� �������� ������ ������!~%")
  (let ((tp 3))
    (loop
      (format *query-io* "� ��� ~a ����� ����������. " tp)
      (let ((tren (promt-read "�������� �������������� ��� ���������� (�-����, �-������������)")))
	(cond 
	  ((string-equal tren "�") (incf (strength player)) (decf tp))
	  ((string-equal tren "�") (incf (vitality player)) (decf tp))
	  (t (format *query-io* "����������� ������� ��������������~%"))))
      (if (= 0 tp) (return))))
  (decf (expa player) (* 100 (level player)))
  (incf (level player))
  (setf (health player) (* 10 (vitality player))))
