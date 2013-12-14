(load (pathname "zones/zone00/zone00.lisp"))

(setf *current-room* (getf *zone00* :1))
