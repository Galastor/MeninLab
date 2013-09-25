(defmacro defcommand (name params) 
  `(defclass ,name (command) ,params))
