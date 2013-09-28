(defun promt-read (promt) 
  (format *query-io* "~a: " promt) 
  (force-output *query-io*) 
  (read-line *query-io*))

(defun defmonster (name min-lvl max-lvl health)
  (list :name name :min-lvl min-lvl :max-lvl max-lvl :health health))

(defun add-monster (monster)
  (push monster *monsters*))

(defun save-monstesr-db ()
  (with-open-file (out (concatenate 'string *folder* "meninlabfiles/monsters.db")
		   :direction :output
		   :if-exists :supersede)
    (with-standard-io-syntax
      (print *monsters* out))))

(defun load-monsters-db ()
  (with-open-file (in (concatenate 'string *folder* "meninlabfiles/monsters.db"))
    (with-standard-io-syntax
      (setf *monsters* (read in)))))

(defun create-player ()
  (make-instance `player :health 10 :name (promt-read "Введите имя персонажа")))

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
      (t (make-instance `exception-com :ecode 1)))))

(defun play ()
  (setf *exit* ())
  (load-monsters-db)
  (setf *game* (make-instance `game :player (create-player)))
  (format *query-io* "Добро пожаловать в игру \"Игра\"~%Для справки наберите \"помощь\" или \"?\"~%")
    (loop
      (use (read-command))
      (if *exit* (return))))
