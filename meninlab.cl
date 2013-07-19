(defun roll (x)
  (+ 1 (mod (get-internal-real-time) x)))

(defclass creature ()
  ((name :initarg :name
	 :reader name)
   (health :initarg :health
	   :accessor health)))

(defgeneric attack (attacker defenfer)
	    (:documentation "One creature atack another. Oh, this cruel world!"))

(defmethod attack ((attacker creature) (defender creature))
  (let ((atk (roll 20)))
    (format t "~a ����������� ~a. " (name attacker) atk)
    (if (> atk 10)
      (let ((damage (roll 4)))
	(format t "~a �������� ~a ����� �����.~%" (name defender) damage)
	(decf (health defender) damage))
      (format t "~a �����������.~%" (name attacker)))))

(defvar *player*)
(defparameter *player-max-health* 20)

(defmethod fight ((monster creature))
  (loop
    (attack *player* monster)
    (if (< (health monster) 0)
      (progn
	(format t "~a ������������ ������� ������. ~a ������� �������� �����!~%" (name monster) (name *player*))
	(return t)))
    (attack monster *player*)
    (if (< (health monster) 0)
      (progn
	(format t "~a ������������ � ������������. ~a ������ �������!~%" (name *player*) (name monster))
	(return nil)))
    (sleep 1)))

(defun play (x)
  (setf *player-max-health* 20)
  (format t "������� ��� ���������: ")
  (setf *player* (make-instance 'creature
				:name (read)
				:health *player-max-health*))
  (loop
    (let ((monster (make-instance 'creature
				  :name "������� ������"
				  :health (roll *player-max-health* ))))
      (format t "����� ������������ ~a.~%" (name monster))
      (if (fight monster)
	(format t "���� ������������ �������� ������������� �� 1. �� ��������� ��������.~%~%")
	(progn
	  (format t "�� ���������!")
	  (return)))
      (incf *player-max-health*)
      (if (> *player-max-health* x)
	(progn
	  (format t "����������, �� ��������!")
	  (return)))
      (setf (health *player*) *player-max-health*)
      (sleep 3))))
    
