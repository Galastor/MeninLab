(setf *zone00*
  (list
    :1 (make-instance 'game-room :index 1 :name "Заброшенный дом" :description "Этот дом выглядит, как будто в нем уже много лет никто не живет. Вся мебель успела развалиться, кроме хирургического стола, на котором можно ЛЕЧИТЬСЯ (ну или покончить с собой, занимаясь самолечением).")
    :2 (make-instance 'game-room :index 2 :name "Тупик" :description "Тропинка упирается в заброшенный дом на севере. На востоке виднеется заколоченная кузница.")
    :3 (make-instance 'game-room :index 3 :name "Перекресток" :description "Дорога на север уходит к заброшенному дому и старой кузнице. На юге виднеется старое кладбище. С запада доносится отвратительный запах: похоже бывшие жители устроили там свалку.")
    :4 (make-instance 'game-room :index 4 :name "Дорога у кладбища" :description "Кованные ворота на востоке ведут на кладбище. С той стороны доносятся звуки, намекающие что не все мертвецы обрели покой. На юге виднеется садик с памятником.")
    :5 (make-instance 'game-room :index 5 :name "Кузница" :description "По стенам развешано оружие. На прилавке лежит СПИСОК товаров, которые можно приобрести.")
    :6 (make-instance 'game-room :index 6 :name "Кузница" :description "Вдоль стен расставлены доспехи. На прилавке лежит СПИСОК товаров, которые можно здесь приобрести.")
    :7 (make-instance 'game-room :index 7 :name "Вход на свалку" :description "В воздухе витает неприятный запах. Повсюду лежат кучи мусора. Кто знает, что вылезет из такой кучи, если ее разВОРОШИТЬ? На востоке виден выход со свалки.")
    :8 (make-instance 'game-room :index 8 :name "На свалке" :description "Огромные кучи мусора могут скрывать в себе что угодно. Или кого угодно. Не стоит их ВОРОШИТЬ.")
    :9 (make-instance 'game-room :index 9 :name "Кладбище" :description "Старые надгробия, засохшие цветы... Обычное кладбище, вот только земля на могилах выглядит свежей. Кажется, кто-то пытался их расКОПАТЬ.")
    :10 (make-instance 'game-room :index 10 :name "Кладбище" :description "Старые надгробия, засохшие цветы... Обычное кладбище, вот только земля на могилах выглядит свежей. Кажется, кто-то пытался их расКОПАТЬ.")
    :11 (make-instance 'game-room :index 11 :name "Сад" :description "В этом саду давно никто не прибирался. Памятник, стоящий в центре, частично рассыпался. На пьедестале с большим трудом еще можно проЧИТАТЬ надпись.")))

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
  '((:name "Крыса" :min-lvl 1 :max-lvl 5 :level 1 :vit 1 :str 2 :gold 3
	   :weapon (:name "когти" :description "2d2" :damage (:d2 2)))
    (:name "Бешеная собака" :min-lvl 1 :max-lvl 7 :level 2 :vit 3 :str 5 :gold 10
	   :weapon (:name "клыки" :description "1d4" :damage (:d4 1)))
    (:name "Зомби" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "Бешеный кролик" :min-lvl 1 :max-lvl 30 :level 2 :vit 1 :str 10 :gold 1)))

(defvar *monsters0008*
  '((:name "Бешеная собака" :min-lvl 1 :max-lvl 7 :level 2 :vit 3 :str 5 :gold 10
	   :weapon (:name "клыки" :description "1d4" :damage (:d4 1)))
    (:name "Зомби" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "Бешеный кролик" :min-lvl 1 :max-lvl 30 :level 3 :vit 1 :str 10 :gold 1)
    (:name "Грязевой голем" :min-lvl 3 :max-lvl 12 :level 5 :vit 4 :str 14 :gold 30)
    (:name "Радскорпион" :min-lvl 10 :max-lvl 25 :level 13 :vit 15 :str 25)))

(defvar *monsters0009*
  '((:name "Скелет" :min-lvl 1 :max-lvl 3 :level 1 :vit 2 :str 4 :gold 10)
    (:name "Зомби" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "Сторож кладбища" :min-lvl 3 :max-lvl 7 :level 5 :vit 9 :str 9  :gold 100
	   :weapon (:name "ружье" :description "3d8" :damage (:d8 3)))))

(defvar *monsters0010*
  '((:name "Скелет" :min-lvl 1 :max-lvl 3 :level 1 :vit 2 :str 4 :gold 10)
    (:name "Зомби" :min-lvl 2 :max-lvl 5 :level 3 :vit 7 :str 4 :gold 30)
    (:name "Скелет с ножом" :min-lvl 2 :max-lvl 4 :level 2 :vit 2 :str 5 :gold 20
	   :weapon (:name "нож" :description "1d4" :damage (:d4 1)))
    (:name "Вампир" :min-lvl 5 :max-lvl 9 :level 7 :vit 15 :str 15 :gold 500
	   :weapon (:name "меч" :description "2d4" :damage (:d4 2)))
    (:name "Костяной дракон" :min-lvl 10 :max-lvl 30 :level 20 :vit 40 :str 40 :gold 10000
	   :weapon (:name "Дыхание смерти" :description "5d8" :damage (:d8 5)))))

(defmethod use ((command heal-com) (room (eql (getf *zone00* :1))))
  (if (= (mode *game*) 1)
    (progn
      (setf (health (player *game*)) (* 10 (vitality (player *game*))))
      (format *query-io* "Вы полностью излечились~%"))
    (format *query-io* "Вы слишком заняты боем, чтобы лечиться~%")))

(defmethod use ((command dig-com) (room (eql (getf *zone00* :1))))
  (format *query-io* "Вскопав земляной пол дома, Вы нашли несколько золотых монет~%")
  (incf (gold (player *game*)) (+ 1 (random 5))))

(defmethod use ((command trade-list-com) (room (eql (getf *zone00* :5))))
  (format *query-io* "Вы читаете список продаваемого здесь оружия:
1) Нож (1d4)   50з
2) Дубина (1d6)   75з 
3) Меч (1d8)   100з
4) Копье (2d4)   120з
5) Двуручный меч (2d6)   200з
6) Утренняя звезда (3d4)   250з
7) Булава справедливости (2d8)   350з
8) Кинжал ассасина (5d4)   500з
9) Резиновый слоник (1d2)   13з
10) Меч тысячи истин (1000d2)   10000з
Не забудьте что-нибудь КУПИТЬ~%"))

(defmethod use ((command buy-com) (room (eql (getf *zone00* :5))))
  (format *query-io* "Выберите номер товара (0 для отмены):~%")
  (let ((input (or (parse-integer (read-line *query-io*) :junk-allowed t) 0)))
    (cond
      ((= input 1) (when (>= (gold (player *game*)) 50)
		     (decf (gold (player *game*)) 50) (setf (weapon (player *game*)) (make-instance 'weapon :name "нож" :description "1d4" :damage '(:d4 1))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 2) (when (>= (gold (player *game*)) 75)
		     (decf (gold (player *game*)) 75) (setf (weapon (player *game*)) (make-instance 'weapon :name "дубина" :description "1d6" :damage '(:d6 1))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 3) (when (>= (gold (player *game*)) 100)
		     (decf (gold (player *game*)) 100) (setf (weapon (player *game*)) (make-instance 'weapon :name "Меч" :description "1d8" :damage '(:d8 1))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 4) (when (>= (gold (player *game*)) 120)
		     (decf (gold (player *game*)) 120) (setf (weapon (player *game*)) (make-instance 'weapon :name "копье" :description "2d4" :damage '(:d4 2))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 5) (when (>= (gold (player *game*)) 200)
		     (decf (gold (player *game*)) 200) (setf (weapon (player *game*)) (make-instance 'weapon :name "двуручный меч" :description "2d6" :damage '(:d6 2))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 6) (when (>= (gold (player *game*)) 250)
		     (decf (gold (player *game*)) 250) (setf (weapon (player *game*)) (make-instance 'weapon :name "утренняя звезда" :description "3d4" :damage '(:d4 3))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 7) (when (>= (gold (player *game*)) 350)
		     (decf (gold (player *game*)) 350) (setf (weapon (player *game*)) (make-instance 'weapon :name "булава справедливости" :description "2d8" :damage '(:d8 2))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 8) (when (>= (gold (player *game*)) 500)
		     (decf (gold (player *game*)) 500) (setf (weapon (player *game*)) (make-instance 'weapon :name "кинжал ассасина" :description "5d4" :damage '(:d4 5))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 9) (when (>= (gold (player *game*)) 13)
		     (decf (gold (player *game*)) 13) (setf (weapon (player *game*)) (make-instance 'weapon :name "резиновый слоник" :description "1d2" :damage '(:d2 1))) (format *query-io* "Спасибо за покупку! ")))
      ((= input 10) (when (>= (gold (player *game*)) 10000)
		     (decf (gold (player *game*)) 10000) (setf (weapon (player *game*)) (make-instance 'weapon :name "меч тысячи истин" :description "1000d2" :damage '(:d2 1000))) (format *query-io* "Спасибо за покупку! ")))
      (t ())))
  (format *query-io* "Приходите еще!~%"))

(defmethod use ((command walk-com) (room (eql (getf *zone00* :5))))
  (if (eql (direction command) :east)
    (format *query-io* "Похоже, отдел доспехов временно не работает. Приходите позже.~%")
    (call-next-method)))

(defmethod use ((command stir-up-com) (room (eql (getf *zone00* :7))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0007*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "Как только Вы приближаетесь к ближайшей мусорной куче, из нее вылезает ~a. Без драки не обойтись.~%" 
		(name (enemy *game*))))
      (format *query-io* "Похоже, ничего живого здесь уже не осталось. Может, хватит уже рыться в мусоре?~%"))))

(defmethod use ((command stir-up-com) (room (eql (getf *zone00* :8))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0008*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "Как только Вы приближаетесь к ближайшей мусорной куче, из нее вылезает ~a. Без драки не обойтись.~%"
		(name (enemy *game*))))
      (format *query-io* "Похоже, ничего живого здесь уже не осталось. Может, хватит уже рыться в мусоре?~%~%"))))

(defmethod use ((command dig-com) (room (eql (getf *zone00* :9))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0009*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "Вы начинаете вскапывать могилу.~%Неожиданно, из земли вылезает ~a и нападает.~%" 
		(name (enemy *game*))))
      (format *query-io* "Вы вскапываете могилу, но ничего не находите. Похоже, Вы перебили всю местную нежить.~%"))))

(defmethod use ((command dig-com) (room (eql (getf *zone00* :10))))
  (let ((monster-list 
	  (remove-if-not (lambda (x) (<= (getf x :min-lvl) (level (player *game*)) (getf x :max-lvl))) 
			 *monsters0010*)))
    (if monster-list
      (progn
	(setf (mode *game*) 2)
	(setf (enemy *game*) (make-random-monster monster-list))
	(format *query-io* "Вы начинаете вскапывать могилу.~%Неожиданно, из земли вылезает ~a и нападает.~%" 
		(name (enemy *game*))))
      (format *query-io* "Вы вскапываете могилу, но ничего не находите. Похоже, Вы перебили всю местную нежить.~%"))))

(defmethod use ((command read-com) (room (eql (getf *zone00* :11))))
  (format *query-io* "Большая часть слов стерлась со временем. Вам удается разобрать только это: \"...НОГО.ЗОЛО...ЗАР.ТО.В......КУЗНЕЦА\"~%"))
