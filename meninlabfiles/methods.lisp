(defgeneric use (command))

(defgeneric kick (atacker defender))

(defmethod kick ((atacker player) (defender creature))
  (let ((damage (+ (random (/ (+ (strength atacker) (mod (strength atacker) 2) 2) 2)) 
		   (/ (- (strength atacker) (mod (strength atacker) 2)) 2))))
    (if (< (random 100) (+ 5 (strength atacker)))
      (incf damage (strength atacker)))
    (decf (health defender) damage)
    (incf (expa atacker) damage)
    (format *query-io* "¬ы нанесли противнику ~a урона (~a)~%" damage (health defender))))

(defmethod kick ((atacker creature) (defender player))
  (let ((damage (+ (random (/ (+ (strength atacker) (mod (strength atacker) 2) 2) 2)) 
		   (/ (- (strength atacker) (mod (strength atacker) 2)) 2))))
    (if (< (random 100) (+ 5 (strength atacker)))
      (incf damage (strength atacker)))
    (decf (health defender) damage)
    (format *query-io* "~a нанес ~a урона (~a)~%" (name atacker) damage (health defender))
    (when (< (health defender) 1)
      (format *query-io* "—мерть пришла за тобой, ~a, когда ты достиг ~a уровн€.~%" 
	      (name (player *game*)) (level (player *game*)))
      (setf *exit* t))))

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
  (decf (expa player) (* 100 (level player)))
  (incf (level player))
  (setf (health player) (* 10 (vitality player))))
