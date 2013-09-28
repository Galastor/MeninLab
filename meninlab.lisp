(defparameter *folder* "d:/lispprojects/MeninLab/")

(load (concatenate 'string *folder* "meninlabfiles/macroses.lisp"))
(load (concatenate 'string *folder* "meninlabfiles/constants.lisp"))
(load (concatenate 'string *folder* "meninlabfiles/classes.lisp"))
(load (concatenate 'string *folder* "meninlabfiles/methods.lisp"))
(load (concatenate 'string *folder* "meninlabfiles/commands.lisp"))
(load (concatenate 'string *folder* "meninlabfiles/functions.lisp"))

(setf *random-state* (make-random-state t))

(play)
