(setf *zone00*
  (list
    :1 (make-instance 'game-room :index 1 :name "����������� ���" :description "���� ��� ��������, ��� ����� � ��� ��� ����� ��� ����� �� �����. ��� ������ ������ �����������, ����� �������������� �����, �� ������� ����� �������� (�� ��� ��������� � �����, ��������� ������������).")
    :2 (make-instance 'game-room :index 2 :name "�����" :description "�������� ��������� � ����������� ��� �� ������. �� ������� ��������� ������������ �������.")
    :3 (make-instance 'game-room :index 3 :name "�����������" :description "������ �� ����� ������ � ������������ ���� � ������ �������. �� ��� ��������� ������ ��������. � ������ ��������� �������������� �����: ������ ������ ������ �������� ��� ������.")
    :4 (make-instance 'game-room :index 4 :name "������ � ��������" :description "�������� ������ �� ������� ����� �� ��������. � ��� ������� ��������� �����, ���������� ��� �� ��� �������� ������ �����. �� ��� ��������� ����� � ����������.")
    :5 (make-instance 'game-room :index 5 :name "�������" :description "�� ������ ��������� ������. �� �������� ����� ������ �������, ������� ����� ����������.")
    :6 (make-instance 'game-room :index 6 :name "�������" :description "����� ���� ����������� �������. �� �������� ����� ������ �������, ������� ����� ����� ����������.")
    :7 (make-instance 'game-room :index 7 :name "���� �� ������" :description "� ������� ������ ���������� �����. ������� ����� ���� ������. ��� �����, ��� ������� �� ����� ����, ���� �� �����������? �� ������� ����� ����� �� ������.")
    :8 (make-instance 'game-room :index 8 :name "�� ������" :description "�������� ���� ������ ����� �������� � ���� ��� ������. ��� ���� ������. �� ����� �� ��������.")
    :9 (make-instance 'game-room :index 9 :name "��������" :description "������ ���������, �������� �����... ������� ��������, ��� ������ ����� �� ������� �������� ������. �������, ���-�� ������� �� ���������.")
    :10 (make-instance 'game-room :index 10 :name "��������" :description "������ ���������, �������� �����... ������� ��������, ��� ������ ����� �� ������� �������� ������. �������, ���-�� ������� �� ���������.")
    :11 (make-instance 'game-room :index 11 :name "���" :description "� ���� ���� ����� ����� �� ����������. ��������, ������� � ������, �������� ����������. �� ���������� � ������� ������ ��� ����� ��������� �������.")))

(setf (exits (getf *zone00* :1)) (list :south (getf *zone00* :2)))

(setf (exits (getf *zone00* :2)) (list :north (getf *zone00* :1) :south (getf *zone00* :3) :east (getf *zone00* :5)))

(setf (exits (getf *zone00* :3)) (list :north (getf *zone00* :2) :south (getf *zone00* :4) :west (getf *zone00* :7)))

(setf (exits (getf *zone00* :4)) (list :north (getf *zone00* :3) :south (getf *zone00* :11) :east (getf *zone00* :9)))

(setf (exits (getf *zone00* :5)) (list :east (getf *zone00* :6) :west (getf *zone00* :2)))

(setf (exits (getf *zone00* :6)) (list :west (getf *zone00* :5)))

(setf (exits (getf *zone00* :7)) (list :east (getf *zone00* :3) :west (getf *zone00* :8)))

(setf (exits (getf *zone00* :8)) (list :east (getf *zone00* :7)))

(setf (exits (getf *zone00* :9)) (list :east (getf *zone00* :10) :west (getf *zone00* :4)))

(setf (exits (getf *zone00* :10)) (list :west (getf *zone00* :9)))

(setf (exits (getf *zone00* :11)) (list :north (getf *zone00* :4)))

(defvar *monsters0007*
  '((:name "�����" :min-lvl 1 :max-lvl 5 :level 1 :vit 1 :str 2 :gold 3
	   :weapon (:name "�����" :description "2d2" :damage (:d2 2)))
    (:name "������� ������" :min-lvl 1 :max-lvl 7 :level 2 :vit 3 :str 5 :gold 10
	   :weapon (:name "�����" :description "1d4" :damage (:d4 1)))
    (:name "�����" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "������� ������" :min-lvl 1 :max-lvl 30 :level 2 :vit 1 :str 10 :gold 1)))

(defvar *monsters0008*
  '((:name "������� ������" :min-lvl 1 :max-lvl 7 :level 2 :vit 3 :str 5 :gold 10
	   :weapon (:name "�����" :description "1d4" :damage (:d4 1)))
    (:name "�����" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "������� ������" :min-lvl 1 :max-lvl 30 :level 3 :vit 1 :str 10 :gold 1)
    (:name "�������� �����" :min-lvl 3 :max-lvl 12 :level 5 :vit 4 :str 14 :gold 30)
    (:name "�����������" :min-lvl 10 :max-lvl 25 :level 13 :vit 15 :str 25)))

(defvar *monsters0009*
  '((:name "������" :min-lvl 1 :max-lvl 3 :level 1 :vit 2 :str 4 :gold 10)
    (:name "�����" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "������ ��������" :min-lvl 3 :max-lvl 7 :level 5 :vit 9 :str 9  :gold 100
	   :weapon (:name "�����" :description "3d8" :damage (:d8 3)))))

(defvar *monsters0010*
  '((:name "������" :min-lvl 1 :max-lvl 3 :level 1 :vit 2 :str 4 :gold 10)
    (:name "�����" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "������ � �����" :min-lvl 2 :max-lvl 4 :level 2 :vit 2 :str 5 :gold 20
	   :weapon (:name "���" :description "1d4" :damage (:d4 1)))
    (:name "������" :min-lvl 5 :max-lvl 9 :level 7 :vit 15 :str 15 :gold 500
	   :weapon (:name "���" :description "2d4" :damage (:d4 2)))
    (:name "�������� ������" :min-lvl 10 :max-lvl 30 :level 20 :vit 40 :str 40 :gold 10000
	   :weapon (:name "������� ������" :description "5d8" :damage (:d8 5)))))

(defmethod use ((command heal-com) (room (eql (getf *zone00* :1))))
  (if (= (mode *game*) 1)
    (progn
      (setf (health (player *game*)) (* 10 (vitality (player *game*))))
      (format *query-io* "�� ��������� ����������~%"))
    (format *query-io* "�� ������� ������ ����, ����� ��������~%")))

(defmethod use ((command dig-com) (room (eql (getf *zone00* :1))))
  (format *query-io* "������� �������� ��� ����, �� ����� ��������� ������� �����~%")
  (incf (gold (player *game*)) (+ 1 (random 5))))

(defmethod use ((command trade-list-com) (room (eql (getf *zone00* :5))))
  (format *query-io* "�� ������� ������ ������������ ����� ������:
1) ��� (1d4)   50�
2) ������ (1d6)   75� 
3) ��� (1d8)   100�
4) ����� (2d4)   120�
5) ��������� ��� (2d6)   200�
6) �������� ������ (3d4)   250�
7) ������ �������������� (2d8)   350�
8) ������ �������� (5d4)   500�
9) ��������� ������ (1d2)   13�
10) ��� ������ ����� (1000d2)   10000�
�� �������� ���-������ ������~%"))

(defmethod use ((command buy-com) (room (eql (getf *zone00* :5))))
  (format *query-io* "�������� ����� ������ (0 ��� ������):~%")
  (let ((input (or (parse-integer (read-line *query-io*) :junk-allowed t) 0)))
    (cond
      ((= input 1) (when (>= (gold (player *game*)) 50)
		     (decf (gold (player *game*)) 50) (setf (weapon (player *game*)) (make-instance 'weapon :name "���" :description "1d4" :damage '(:d4 1))) (format *query-io* "������� �� �������! ")))
      ((= input 2) (when (>= (gold (player *game*)) 75)
		     (decf (gold (player *game*)) 75) (setf (weapon (player *game*)) (make-instance 'weapon :name "������" :description "1d6" :damage '(:d6 1))) (format *query-io* "������� �� �������! ")))
      ((= input 3) (when (>= (gold (player *game*)) 100)
		     (decf (gold (player *game*)) 100) (setf (weapon (player *game*)) (make-instance 'weapon :name "���" :description "1d8" :damage '(:d8 1))) (format *query-io* "������� �� �������! ")))
      ((= input 4) (when (>= (gold (player *game*)) 120)
		     (decf (gold (player *game*)) 120) (setf (weapon (player *game*)) (make-instance 'weapon :name "�����" :description "2d4" :damage '(:d4 2))) (format *query-io* "������� �� �������! ")))
      ((= input 5) (when (>= (gold (player *game*)) 200)
		     (decf (gold (player *game*)) 200) (setf (weapon (player *game*)) (make-instance 'weapon :name "��������� ���" :description "2d6" :damage '(:d6 2))) (format *query-io* "������� �� �������! ")))
      ((= input 6) (when (>= (gold (player *game*)) 250)
		     (decf (gold (player *game*)) 250) (setf (weapon (player *game*)) (make-instance 'weapon :name "�������� ������" :description "3d4" :damage '(:d4 3))) (format *query-io* "������� �� �������! ")))
      ((= input 7) (when (>= (gold (player *game*)) 350)
		     (decf (gold (player *game*)) 350) (setf (weapon (player *game*)) (make-instance 'weapon :name "������ ��������������" :description "2d8" :damage '(:d8 2))) (format *query-io* "������� �� �������! ")))
      ((= input 8) (when (>= (gold (player *game*)) 500)
		     (decf (gold (player *game*)) 500) (setf (weapon (player *game*)) (make-instance 'weapon :name "������ ��������" :description "5d4" :damage '(:d4 5))) (format *query-io* "������� �� �������! ")))
      ((= input 9) (when (>= (gold (player *game*)) 13)
		     (decf (gold (player *game*)) 13) (setf (weapon (player *game*)) (make-instance 'weapon :name "��������� ������" :description "1d2" :damage '(:d2 1))) (format *query-io* "������� �� �������! ")))
      ((= input 10) (when (>= (gold (player *game*)) 10000)
		     (decf (gold (player *game*)) 10000) (setf (weapon (player *game*)) (make-instance 'weapon :name "��� ������ �����" :description "1000d2" :damage '(:d2 1000))) (format *query-io* "������� �� �������! ")))
      (t ())))
  (format *query-io* "��������� ���!~%"))

(defmethod use ((command walk-com) (room (eql (getf *zone00* :5))))
  (if (eql (direction command) :east)
    (format *query-io* "������, ����� �������� �������� �� ��������. ��������� �����.~%")
    (call-next-method)))

(defmethod use ((command stir-up-com) (room (eql (getf *zone00* :7))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0007*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "��� ������ �� ������������� � ��������� �������� ����, �� ��� �������� ~a. ��� ����� �� ��������.~%" 
		(name (enemy *game*))))
      (format *query-io* "������, ������ ������ ����� ��� �� ��������. �����, ������ ��� ������ � ������?~%"))))

(defmethod use ((command stir-up-com) (room (eql (getf *zone00* :8))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0008*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "��� ������ �� ������������� � ��������� �������� ����, �� ��� �������� ~a. ��� ����� �� ��������.~%"
		(name (enemy *game*))))
      (format *query-io* "������, ������ ������ ����� ��� �� ��������. �����, ������ ��� ������ � ������?~%~%"))))

(defmethod use ((command dig-com) (room (eql (getf *zone00* :9))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0009*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "�� ��������� ���������� ������.~%����������, �� ����� �������� ~a � ��������.~%" 
		(name (enemy *game*))))
      (format *query-io* "�� ����������� ������, �� ������ �� ��������. ������, �� �������� ��� ������� ������.~%"))))

(defmethod use ((command dig-com) (room (eql (getf *zone00* :10))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0010*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "�� ��������� ���������� ������.~%����������, �� ����� �������� ~a � ��������.~%" 
		(name (enemy *game*))))
      (format *query-io* "�� ����������� ������, �� ������ �� ��������. ������, �� �������� ��� ������� ������.~%"))))

(defmethod use ((command read-com) (room (eql (getf *zone00* :11))))
  (format *query-io* "������� ����� ���� �������� �� ��������. ��� ������� ��������� ������ ���: \"...����.����...���.��.�......�������\"~%"))
