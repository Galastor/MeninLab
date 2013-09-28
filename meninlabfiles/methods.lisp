(defgeneric use (command))

(defgeneric kick (atacker defender))

(defmethod kick ((atacker player) (defender creature))
  (let ((damage (random 4)))
    (decf (health defender) damage)
    (incf (expa atacker) damage)
    (format *query-io* "¬ы нанесли противнику ~a урона (~a)~%" damage (health defender))))

(defmethod kick ((atacker creature) (defender player))
  (let ((damage (random 4)))
    (decf (health defender) damage)
    (format *query-io* "~a нанес ~a урона (~a)~%" (name atacker) damage (health defender))
    (when (< (health defender) 1)
      (format *query-io* "—мерть пришла за тобой, ~a, когда ты достиг ~a уровн€.~%" 
	      (name (player *game*)) (level (player *game*)))
      (setf *exit* t))))

(defgeneric lvl-up (player))

(defmethod lvl-up ((player player))
  (decf (expa player) (* 100 (level player)))
  (incf (level player))
  (setf (health player) (* 10 (level player)))
  (format *query-io* "¬ы достигли нового уровн€!~%"))
