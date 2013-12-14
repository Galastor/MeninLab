(defcommand help-com ())

(defmethod use ((command help-com) room)
  (format *query-io* "\"?\" или \"помощь\" - вывести справку
\"инфо\" - получения информации о персонаже
север/юг/восток/запад - перемещение по игре
\"смотреть\" - посмотреть описание помещения, в котором находится персонаж
\"ударить\" - нанести удар противнику (во время боя)
\"убежать\" - сбежать из боя
\"противник\" - посмотреть информацию о противнике
\"выход\" - выход из игры
Читая описания комнат, вы можте найти и другие команды.
Автор: Galastor~%"))

(defcommand info-com ())

(defmethod use ((command info-com) room)
  (let ((player (player *game*)))
    (format *query-io* "~a~%Уровень(опыт): ~a(~a)~%Золота: ~a~%Здоровье: ~a~%Сила: ~a~%Выносливость: ~a~%Оружие: ~a (~a)~%"
	    (name player) (level player) (expirience player) (gold player) 
	    (health player) (strength player) (vitality player)
	    (name (weapon player)) (description (weapon player)))))

(defcommand walk-com ((direction :initarg :direction :reader direction)))

(defmethod use ((command walk-com) room)
  (if (= (mode *game*) 2)
    (format *query-io* "Вы слишком заняты боем, чтобы идти~%")
    (let ((exit (getf (exits *current-room*) (direction command))))
      (if exit
	(progn
	  (setf *current-room* exit)
	  (format *query-io* "Вы идете на ~a.~%~%" (getf (list :north "север" :south "юг" :east "восток" :west "запад") (direction command)))
	  (format *query-io* "~a~%~a~%Выходы:~:[~; север~]~:[~; юг~]~:[~; восток~]~:[~; запад~].~%" (name *current-room*) (description *current-room*) 
		  (getf (exits *current-room*) :north) (getf (exits *current-room*) :south) (getf (exits *current-room*) :east) (getf (exits *current-room*) :west)))
	(format *query-io* "Вы не можете пойти в этом направлении~%")))))

(defcommand heal-com ())

(defmethod use ((command heal-com) room)
  (format *query-io* "Вы не можете делать это здесь.~%~%"))

(defcommand kick-com ())

(defmethod use ((command kick-com) room)
  (if (= (mode *game*) 2)
    (progn
      (kick (player *game*) (enemy *game*))
      (when (> (health (enemy *game*)) 0)
	(kick (enemy *game*) (player *game*))))
    (format *query-io* "Вы ни с кем не сражаетесь~%")))

(defcommand run-com ())

(defmethod use ((command run-com) room)
  (if (= (mode *game*) 2)
    (if (= (random 2) 1)
      (let ((loseexp (* (level (player *game*)) 5)))
	(format *query-io* "Вы сбегаете и теряет ~a очков опыта~%" loseexp)
	(decf (expirience (player *game*)) loseexp)
	(setf (mode *game*) 1))
      (progn
	(format *query-io* "Убежать не удалось~%")
	(kick (enemy *game*) (player *game*))))
    (format *query-io* "Вы ни с кем не сражаетесь.~%")))

(defcommand enemy-info-com ())

(defmethod use ((command enemy-info-com) room)
  (if (= (mode *game*) 2)
    (format *query-io*"~a~%Здоровье: ~a~%Сила: ~a~%Выносливость: ~a~%" (name (enemy *game*)) (health (enemy *game*)) 
	    							       (strength (enemy *game*)) (vitality (enemy *game*)))
    (format *query-io* "Вы ни с кем не сражаетесь.~%")))

(defcommand exit-com ())

(defmethod use ((command exit-com) room)
  (setf *exit* t)
  (format *query-io* "До встречи!~%"))

(defcommand save-com ())

(defmethod use ((command save-com) room)
  (format *query-io* "Увы, эта функция временно не работает~%"))

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
;	   (format *query-io* "Игра успешно сохранена~%"))
;    (Format *query-io* "Вы слишком заняты боем~%")))

(defcommand trade-list-com ())

(defmethod use ((command trade-list-com) room)
  (format *query-io* "Здесь не с кем торговать.~%"))

(defcommand stir-up-com ())

(defmethod use ((command stir-up-com) room)
  (format *query-io* "Здесь нечего ворошить.~%"))

(defcommand dig-com ())

(defmethod use ((command dig-com) room)
  (format *query-io* "Вы выкопали небольшую яму и перепачкались в земле.~%"))

(defcommand read-com ())

(defmethod use ((command read-com) room)
  (format *query-io* "Здесь нечего читать.~%"))

(defcommand look-com ())

(defmethod use ((command look-com) room)
  (format *query-io* "~a~%~a~%Выходы:~:[~; север~]~:[~; юг~]~:[~; восток~]~:[~; запад~].~%" (name *current-room*) (description *current-room*) 
		  (getf (exits *current-room*) :north) (getf (exits *current-room*) :south) (getf (exits *current-room*) :east) (getf (exits *current-room*) :west)))

(defcommand buy-com ())

(defmethod use ((command buy-com) room)
  (format *query-io* "Здесь нет продавца.~%"))

(defcommand exception-com ((ecode :initarg :ecode :reader ecode)))

(defmethod use ((command exception-com) room) 
  (cond
    ((= (ecode command) 1) (format *query-io* "Неизвестная команда~%"))))

(defcommand admin-mode-com ())

(defmethod use ((command admin-mode-com) room)
  (setf (level (player *game*)) 
	(or (parse-integer (promt-read "Уровень") :junk-allowed t) 1))
  (setf (vitality (player *game*)) 
	(or (parse-integer (promt-read "Выносливость") :junk-allowed t) 1))
  (setf (strength (player *game*)) 
	(or (parse-integer (promt-read "Сила") :junk-allowed t) 1)))
