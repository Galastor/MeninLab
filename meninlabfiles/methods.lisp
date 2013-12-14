(defgeneric use (command room))

(defgeneric lvl-up (player))

(defmethod lvl-up ((player player))
  (format *query-io* "¬ы достигли нового уровн€!~%")
  (let ((tp 3))
    (loop
      (format *query-io* "” вас ~a очков тренировки. " tp)
      (let ((tren (promt-read "¬ыберите характеристику дл€ тренировки (с-сила, в-выносливость)")))
	(cond 
	  ((string-equal tren "с") (incf (strength player)) (decf tp))
	  ((string-equal tren "в") (incf (vitality player)) (decf tp))
	  (t (format *query-io* "Ќеправильно выбрана характеристика~%"))))
      (if (= 0 tp) (return))))
  (decf (expirience player) (* 100 (level player)))
  (incf (level player))
  (setf (health player) (* 10 (vitality player))))

(defgeneric get-damage (weapon))

(defmethod get-damage ((weapon weapon))
  (let ((damage (damage weapon)) (result 0))
    (dotimes (i (if (getf damage :d2) (getf damage :d2) 0))
      (incf result (+ 1 (random 2))))
    (dotimes (i (if (getf damage :d4) (getf damage :d4) 0))
      (incf result (+ 1 (random 4))))
    (dotimes (i (if (getf damage :d6) (getf damage :d6) 0))
      (incf result (+ 1 (random 6))))
    (dotimes (i (if (getf damage :d8) (getf damage :d8) 0))
      (incf result (+ 1 (random 8))))
    result))

(defgeneric die (creature))

(defmethod die ((creature creature))
  (format *query-io* "~a погибает~%" (name creature))
  (setf (mode *game*) 1)
  (incf (expirience (player *game*)) (* 10 (level creature)))
  (incf (gold (player *game*)) (gold creature))
  (if (>= (expirience (player *game*)) (* 100 (level (player *game*))))
    (lvl-up (player *game*))))

(defmethod die ((player player))
  (format *query-io* "—мерть пришла за тобой, ~a, на ~a уровне" (name player) (level player))
  (setf *exit* t))

(defgeneric kick (atacker defender))

(defmethod kick ((atacker creature) (defender creature))
  (let ((damage (+ (get-damage (weapon atacker)) (strength atacker))))
    (when (< (random 100) (+ 5 (strength atacker)))
      (incf damage damage))
    (decf (health defender) damage)
    (format *query-io* "~a наносит ~a урона (~a)~%" (name atacker) damage (health defender))
    (if (< (health defender) 1)
      (die defender))))

(defgeneric enter (room))

(defmethod enter ((room game-room))
  (format *query-io* "~a~%~a~%" (name room) (description room)))
