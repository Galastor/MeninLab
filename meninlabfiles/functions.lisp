(defun promt-read (promt) 
  (format *query-io* "~a: " promt) 
  (force-output *query-io*) 
  (read-line *query-io*))

(defun roll (x)
  (+ (mod (+ (get-internal-real-time) (random x)) x) 1)) ;;заменить на нормальный рандом


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
  (setf *game* (make-instance `game :player (create-player)))
  (format *query-io* "Добро пожаловать в игру \"Игра\"~%Для справки наберите \"помощь\" или \"?\"~%")
    (loop
      (use (read-command))
      (if *exit* (return))))

