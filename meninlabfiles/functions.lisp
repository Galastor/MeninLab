(defun save-monstesr-db ()
  (with-open-file (out (pathname "meninlabfiles/monsters.db")
		   :direction :output
		   :if-exists :supersede)
    (with-standard-io-syntax
      (print *monsters* out))))

(defun load-monsters-db ()
  (with-open-file (in (pathname "meninlabfiles/monsters.db"))
    (with-standard-io-syntax
      (setf *monsters* (read in)))))

(defun create-player ()
  (make-instance `player :health 30 :strength 3 :vitality 3 :name (promt-read "Введите имя персонажа")))

(defun read-command ()
  (let ((input (read-line *query-io*)))
    (cond 
      ((or (string-equal input "?") (string-equal input "помощь")) (make-instance `help-com))
      ((string-equal input "инфо") (make-instance `info-com))
      ((string-equal input "идти") (make-instance `walk-com))
      ((string-equal input "лечиться") (make-instance `heal-com))
      ((string-equal input "ударить") (make-instance `kick-com))
      ((string-equal input "убежать") (make-instance `run-com))
      ((string-equal input "противник") (make-instance `enemy-info-com))
      ((string-equal input "выход") (make-instance `exit-com))
      ((string-equal input "сохранить") (make-instance `save-com))
      (t (make-instance `exception-com :ecode 1)))))

(defun play ()
  (setf *exit* ())
  (setf *random-state* (make-random-state t))  
  (format *query-io* "Для справки наберите \"помощь\" или \"?\"~%")
  (loop
    (use (read-command))
    (if *exit* (return)))
  (force-output *query-io*)
  (read-line *query-io*))

(defun menu ()
  (format *query-io* "	Добро пожаловать!~%")
  (loop
    (format *query-io* "1) Начать новую игру
2) Загрузить игру
3) Выход~%")
    (let ((choice (or (parse-integer (read-line *query-io*) :junk-allowed t) 0)))
      (cond
	((= choice 1) (setf *game* (make-instance 'game :player (create-player)))
		      (play))
	((= choice 2) (let ((save (with-open-file (in "mlsaves/meninlab.save") (with-standard-io-syntax (read in)))))
			(setf *game* (make-instance 'game 
						    :player (make-instance 'player
									   :name (getf save :name)
									   :health (getf save :health)
									   :strength (getf save :strength)
									   :vitality (getf save :vitality)
									   :level (getf save :level)
									   :expa (getf save :expa)))))
		      (format *query-io* "Игра успешно загружена~%")
		      (play))
	((= choice 3) (return))
	(t (format *query-io* "Неизвестная команда. Попробуй еще раз.~%"))))))
