(defcommand help-com ())

(defmethod use ((command help-com))
  (format *query-io* "\"?\" или \"помощь\" - вывести справку
\"инфо\" - получения информации о персонаже
\"идти\" - продолжения пути
\"лечиться\" - лечить персонажа
\"ударить\" - нанести удар противнику (во время боя)
\"убежать\" - сбежать из боя
\"противник\" - посмотреть информацию о противнике
\"выход\" - выход из игры
любая другая команда - получение сообщения об ошибке
Автор: Galastor~%"))

(defcommand info-com ())

(defmethod use ((command info-com))
  (let ((player (player *game*)))
    (format *query-io* "~a~%Уровень(опыт): ~a(~a)~%Здоровье: ~a~%" (name player) (level player) (expa player) (health player))))

(defcommand walk-com ())

(defmethod use ((command walk-com))
  (setf (enemy *game*) (make-instance `creature :name "Скелет" :health (+ (* 8 (level (player *game*))) 
									  (random (* 4 (level (player *game*)))))))
  (setf (mode *game*) 2)
  (format *query-io* "Навстречу выходит ~a, имеющий ~a очков здоровья~%" (name (enemy *game*)) (health (enemy *game*))))

(defcommand heal-com ())

(defmethod use ((command heal-com))
  (let ((heal (random 4)))
    (setf (health (player *game*)) (min (* 10 (level (player *game*))) (+ (health (player *game*)) heal)))
    (format *query-io* "Вы излечились на ~a. Текущее здоровье: ~a~%" heal (health (player *game*)))))

(defcommand kick-com ())

(defmethod use ((command kick-com))
  (if (= (mode *game*) 2)
    (let ((damage (random 4)))
      (decf (health (enemy *game*)) damage)
      (incf (expa (player *game*)) damage)
      (format *query-io* "Вы нанесли противнику ~a урона (~a)~%" damage (health (enemy *game*)))
      (when (>= (expa (player *game*)) (* 100 (level (player *game*))))
	(decf (expa (player *game*)) (* 100 (level (player *game*))))
	(incf (level (player *game*)))
	(setf (health (player *game*)) (* 10 (level (player *game*))))	
	(format *query-io* "Вы достигли нового уровня!~%"))
      (if (> (health (enemy *game*)) 0)
	(let ((damage (random 4)))
	  (decf (health (player *game*)) damage)
	  (format *query-io* "Противник нанес ~a урона (~a)~%" damage (health (player *game*)))
	  (when (< (health (player *game*)) 1)
	    (format *query-io* "Смерть пришла за тобой, ~a, когда ты достиг ~a уровня.~%" 
		    (name (player *game*)) (level (player *game*)))
	    (setf *exit* t)))
	(progn
	  (format *query-io* "Противник погиб~%")
	  (setf (mode *game*) 1))))
    (format *query-io* "Вы ни с кем не сражаетесь~%")))

(defcommand run-com ())

(defmethod use ((command run-com))
  (if (= (mode *game*) 2)
    (if (= (random 2) 1)
      (let ((loseexp (* (level (player *game*)) 5)))
	(format *query-io* "Вы сбегаете и теряет ~a очков опыта~%" loseexp)
	(decf (expa (player *game*)) loseexp))
      (progn 
	(format *query-io* "Убежать не удалось~%")
	(let ((damage (random 4)))
	  (decf (health (player *game*)) damage)
	  (format *query-io* "Противник нанес ~a урона (~a)~%" damage (health (player *game*)))
	  (when (< (health (player *game*)) 1)
	    (format *query-io* "Смерть пришла за тобой, ~a, когда ты достиг ~a уровня.~%" 
		    (name (player *game*)) (level (player *game*)))
	    (setf *exit* t)))))
    (format *query-io* "Вы ни с кем не сражаетесь.~%")))

(defcommand enemy-info-com ())

(defmethod use ((command enemy-info-com))
  (if (= (mode *game*) 2)
    (format *query-io* "~a~%Здоровье: ~a~%" (name (enemy *game*)) (health (enemy *game*)))
    (format *query-io* "Вы ни с кем не сражаетесь.~%")))

(defcommand exit-com ())

(defmethod use ((command exit-com))
  (setf *exit* t))

(defcommand exception-com ((ecode :initarg :ecode :reader ecode)))

(defmethod use ((command exception-com)) 
  (cond
    ((= (ecode command) 1) (format *query-io* "Неизвестная команда~%"))))
