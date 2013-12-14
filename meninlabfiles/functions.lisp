(defun load-monsters-db ()
  (with-open-file (in (pathname "meninlabfiles/monsters.db"))
    (with-standard-io-syntax
      (setf *monsters* (read in)))))

(defun create-player ()
  (make-instance `player :health 30 :strength 3 :vitality 3 :name (promt-read "Введите имя персонажа")))

(defun make-random-monster (monster-list)
  (let ((monster-data (elt monster-list (random (length monster-list)))))
    (let ((monster (make-instance 'creature :name (getf monster-data :name) :strength (getf monster-data :str) 
				  :vitality (getf monster-data :vit) :level (getf monster-data :level) 
				  :gold (random (getf monster-data :gold)) :health (* 10 (getf monster-data :vit))))
	  (weapon (getf monster-data :weapon)))
      (if weapon
	(setf (weapon monster)
	      (make-instance 'weapon :name (getf weapon :name) :description (getf weapon :description) 
			     :damage (getf weapon :damage))))
      monster)))

(defun read-command ()
  (let ((input (read-line *query-io*)))
    (cond 
      ((or (string-equal input "?") (string-equal input "помощь")) (make-instance `help-com))
      ((string-equal input "инфо") (make-instance `info-com))
      ((string-equal input "север") (make-instance `walk-com :direction :north))
      ((string-equal input "юг") (make-instance `walk-com :direction :south))
      ((string-equal input "восток") (make-instance `walk-com :direction :east))
      ((string-equal input "запад") (make-instance `walk-com :direction :west))
      ((string-equal input "лечиться") (make-instance `heal-com))
      ((string-equal input "ударить") (make-instance `kick-com))
      ((string-equal input "убежать") (make-instance `run-com))
      ((string-equal input "противник") (make-instance `enemy-info-com))
      ((string-equal input "выход") (make-instance `exit-com))
      ((string-equal input "сохранить") (make-instance `save-com))
      ((string-equal input "список") (make-instance `trade-list-com))
      ((string-equal input "купить") (make-instance `buy-com))
      ((string-equal input "копать") (make-instance `dig-com))
      ((string-equal input "ворошить") (make-instance `stir-up-com))
      ((string-equal input "читать") (make-instance `read-com))
      ((string-equal input "смотреть") (make-instance `look-com))
      ((string-equal input "свежие пончики") (make-instance `admin-mode-com))
      (t (make-instance `exception-com :ecode 1)))))

(defun play ()
  (setf *exit* ())
  (setf *random-state* (make-random-state t))  
  (setf *current-room* (getf *zone00* :1))
  (format *query-io* "~a~%~a~%Для справки наберите \"помощь\" или \"?\"~%" (name *current-room*) (description *current-room*))
  (loop
    (use (read-command) *current-room*)
    (if *exit* (return)))
  (force-output *query-io*)
  (read-line *query-io*))

(defun menu ()
  (format *query-io* "	Добро пожаловать!~%")
  (loop
    (format *query-io* "1) Начать новую игру
2) Выход~%")
    (let ((choice (or (parse-integer (read-line *query-io*) :junk-allowed t) 0)))
      (cond
	((= choice 1) (setf *game* (make-instance 'game :player (create-player)))
		      (play))
;	((= choice 2) (let ((save (with-open-file (in "mlsaves/meninlab.save") (with-standard-io-syntax (read in)))))
;			(setf *game* (make-instance 'game 
;						    :player (make-instance 'player
;									   :name (getf save :name)
;									   :health (getf save :health)
;									   :strength (getf save :strength)
;									   :vitality (getf save :vitality)
;									   :level (getf save :level)
;									   :expirience (getf save :expirience)))))
;		      (format *query-io* "Игра успешно загружена~%")
;		      (play))
	((= choice 2) (return))
	(t (format *query-io* "Неизвестная команда. Попробуй еще раз.~%"))))))

()
