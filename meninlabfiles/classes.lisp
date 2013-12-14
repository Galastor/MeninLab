(defclass item ()
  ((name
     :initarg :name
     :reader name)))

(defclass weapon (item)
  ((name 
     :initform "руки")
   (description
     :initarg :description
     :initform "1d2"
     :reader description)
   (damage
     :initarg :damage
     :initform (list :d2 1)
     :reader damage)))

(defclass creature ()
  ((name
     :initarg :name
     :reader name)
   (level
     :initform 1
     :accessor level
     :initarg :level)
   (health
     :initarg :health
     :accessor health)
   (strength
     :initarg :strength
     :accessor strength)
   (vitality
     :initarg :vitality
     :accessor vitality)
   (weapon
     :initarg :weapon
     :initform (make-instance `weapon)
     :accessor weapon)
   (gold
     :initform 0
     :initarg :gold
     :accessor gold)))

(defclass player (creature)
  ((expirience
     :initform 0
     :accessor expirience
     :initarg :expirience)))

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

(defclass game-room ()
  ((index
     :initarg :index
     :reader :index)
   (name
     :initarg :name
     :reader name)
   (description
     :initarg :description
     :accessor description)
   (exits
     :initarg :exits
     :accessor exits)))

