(defcommand help-com ())

(defmethod use ((command help-com))
  (format *query-io* "\"?\" или \"помощь\" - вывести справку
\"инфо\" - получения информации о персонаже
\"идти\" - продолжения пути
\"лечиться\" - лечить персонажа
\"ударить\" - нанести удар противнику (во время боя)
\"убежать\" - сбежать из боя
\"противник\" - посмотреть информацию о противнике
\"сохранить\" - сохранить игру (предыдущее сохранение будет удалено!)
\"выход\" - выход из игры
любая другая команда - получение сообщения об ошибке
Автор: Galastor~%"))

(defcommand info-com ())

(defmethod use ((command info-com))
  (let ((player (player *game*)))
    (format *query-io* "~a~%Уровень(опыт): ~a(~a)~%Здоровье: ~a~%Сила: ~a~%Выносливость: ~a~%" 
	    (name player) (level player) (expa player) (health player) (strength player) (vitality player))))

(defcommand walk-com ())

(defmethod use ((command walk-com))
  (if (= (mode *game*) 2)
    (format *query-io* "Вы слишком заняты боем, чтобы идти дальше~%")
    (progn
      (setf (mode *game*) 2)
      (let ((enemy-list (remove-if-not 
			  #'(lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) *monsters*)))
	(let ((enemy (elt enemy-list (random (length enemy-list)))))
	  (setf (enemy *game*)
		(make-instance `creature :name (getf enemy :name) 
			       		 :strength (+ (getf enemy :str) 
						      (* (getf enemy :str-lvl) (level (player *game*))))
					 :vitality (+ (getf enemy :vit) 
						      (* (getf enemy :vit-lvl) (level (player *game*))))))))
      (setf (health (enemy *game*)) (* 10 (vitality (enemy *game*))))
      (format *query-io* "Навстречу выходит ~a, имеющий ~a очков здоровья~%" 
	      (name (enemy *game*)) (health (enemy *game*))))))

(defcommand heal-com ())

(defmethod use ((command heal-com))
  (if (= (mode *game*) 1)
    (progn
      (setf (health (player *game*)) (* 10 (vitality (player *game*))))
      (format *query-io* "Вы полностью излечились~%"))
    (format *query-io* "Вы слишком заняты боем, чтобы лечиться~%")))

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
	  (format *query-io* "~a погиб~%" (name (enemy *game*)))
	  (setf (mode *game*) 1))))
    (format *query-io* "Вы ни с кем не сражаетесь~%")))

(defcommand run-com ())

(defmethod use ((command run-com))
  (if (= (mode *game*) 2)
    (if (= (random 2) 1)
      (let ((loseexp (* (level (player *game*)) 5)))
	(format *query-io* "Вы сбегаете и теряет ~a очков опыта~%" loseexp)
	(decf (expa (player *game*)) loseexp)
	(setf (mode *game*) 1))
      (progn
	(format *query-io* "Убежать не удалось~%")
	(kick (enemy *game*) (player *game*))))
    (format *query-io* "Вы ни с кем не сражаетесь.~%")))

(defcommand enemy-info-com ())

(defmethod use ((command enemy-info-com))
  (if (= (mode *game*) 2)
    (format *query-io*"~a~%Здоровье: ~a~%Сила: ~a~%Выносливость: ~a~%" (name (enemy *game*)) (health (enemy *game*)) 
	    							       (strength (enemy *game*)) (vitality (enemy *game*)))
    (format *query-io* "Вы ни с кем не сражаетесь.~%")))

(defcommand exit-com ())

(defmethod use ((command exit-com))
  (setf *exit* t))

(defcommand save-com ())

(defmethod use ((command save-com))
  (if (= (mode *game*) 1)
    (progn (with-open-file (out (ensure-directories-exist "mlsaves/meninlab.save")
				:direction :output :if-exists :supersede)
	     (with-standard-io-syntax 
	       (print (list 
			:name (name (player *game*))
			:health (health (player *game*))
			:strength (strength (player *game*))
			:vitality (vitality (player *game*))
			:level (level (player *game*))
			:expa (expa (player *game*))) out)))
	   (format *query-io* "Игра успешно сохранена~%"))
    (Format *query-io* "Вы слишком заняты боем~%")))

(defcommand exception-com ((ecode :initarg :ecode :reader ecode)))

(defmethod use ((command exception-com)) 
  (cond
    ((= (ecode command) 1) (format *query-io* "Неизвестная команда~%"))))
