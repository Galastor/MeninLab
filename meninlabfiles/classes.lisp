(defclass creature ()
  ((name
     :initarg :name
     :reader name)
   (health
     :initarg :health
     :accessor health)))

(defclass player (creature)
  ((level
     :initform 1
     :accessor level)
   (expirience
     :initform 0
     :accessor expa)))

(defclass game ()
  ((player
     :initarg :player
     :accessor player)
   (enemy
     :accessor enemy)
   (mode 
     :initform 1
     :accessor mode)))

(defclass command () ())

