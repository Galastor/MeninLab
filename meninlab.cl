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
    (format t "~a выбрасывает ~a. " (name attacker) atk)
    (if (> atk 10)
      (let ((damage (roll 4)))
	(format t "~a получает ~a очков урона.~%" (name defender) damage)
	(decf (health defender) damage))
      (format t "~a промахнулся.~%" (name attacker)))))

(defvar *player*)
(defparameter *player-max-health* 20)

(defmethod fight ((monster creature))
  (loop
    (attack *player* monster)
    (if (< (health monster) 0)
      (progn
	(format t "~a отправляется кормить червей. ~a танцует победный танец!~%" (name monster) (name *player*))
	(return t)))
    (attack monster *player*)
    (if (< (health monster) 0)
      (progn
	(format t "~a отправляется к прародителям. ~a злобно хохочет!~%" (name *player*) (name monster))
	(return nil)))
    (sleep 1)))

(defun play (x)
  (setf *player-max-health* 20)
  (format t "Введите имя персонажа: ")
  (setf *player* (make-instance 'creature
				:name (read)
				:health *player-max-health*))
  (loop
    (let ((monster (make-instance 'creature
				  :name "Обычный монстр"
				  :health (roll *player-max-health* ))))
      (format t "Герою повстречался ~a.~%" (name monster))
      (if (fight monster)
	(format t "Ваше максимальное здоровье увеличивается на 1. Вы полностью вылечены.~%~%")
	(progn
	  (format t "Вы проиграли!")
	  (return)))
      (incf *player-max-health*)
      (if (> *player-max-health* x)
	(progn
	  (format t "Поздравляю, Вы победили!")
	  (return)))
      (setf (health *player*) *player-max-health*)
      (sleep 3))))
    
