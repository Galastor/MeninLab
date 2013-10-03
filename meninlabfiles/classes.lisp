(defclass creature ()
  ((name
     :initarg :name
     :reader name)
   (health
     :initarg :health
     :accessor health)
   (strength
     :initarg :strength
     :accessor strength)
   (vitality
     :initarg :vitality
     :accessor vitality)))

(defclass player (creature)
  ((level
     :initform 1
     :accessor level
     :initarg :level)
   (expirience
     :initform 0
     :accessor expa
     :initarg :expa)))

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

