(ns ch7.scratch)

; function composition

(def fifth (comp first rest rest rest rest))

(fifth [1 2 3 4 5]) ; -> 5

(defn fnth [n]
  (apply comp
    (cons first
      (take (dec n) (repeat rest)))))

((fnth 5) '[a b c d e])

(map (comp keyword #(.toLowerCase %) name) '(a B C))

; partial application

((partial + 5) 100 200)

; equivalent to...

(#(apply + 5 %&) 100 200)

; reversing truthiness

(defn truthiness [v] v)
((complement truthiness) 3)
((complement truthiness) false)

; named args

(defn slope
  [& {:keys [p1 p2] :or {p1 [0 0] p2 [1 1]}}]
  (float (/ (- (p2 1) (p1 1))
            (- (p2 0) (p1 0)))))

(slope :p1 [4 15] :p2 [3 21])

(slope :p2 [2 1])

(slope)

; pre and post constraints

(defn slope [p1 p2]
  {:pre [(not= p1 p2) (vector? p1) (vector? p2)]
   :post [(float? %)]
   }
  (float (/ (- (p2 1) (p1 1))
            (- (p2 0) (p1 0)))))

(slope [10 10] [10 10]) ; -> ERROR!

; decoupling constraints
;

(defn put-things [m]
  (into m {:meat "beef" :veggie "brocoli"}))

(defn vegan-constraings [f m]
  {:pre [(:veggie m)]
   :post [(:veggie %) (nil? (:meat %))]}
  (f m))

(defn balanced-diet [f m]
  {:post [(:meat %) (:veggie %)]}
  (f m))

(vegan-constraings put-things {:veggie "carrot"}) ; -> ERROR
(balanced-diet put-things {})

; closures

(def bearings [{:x  0,  :y  1}
               {:x  0,  :y -1}
               {:x -1,  :y  0}])

(defn bot [x y bearing-num]
  {:coords  [x y]
   :bearing ([:north :east :south :west] bearing-num)
   :forward (fn [] (bot (+ x (:x (bearings bearing-num)))
                        (+ y (:y (bearings bearing-num)))
                                  bearing-num))
  :turn-right (fn [] (bot x y (mod (+ 1 bearing-num) 4)))
  :turn-left  (fn [] (bot x y (mod (- 1 bearing-num) 4))) })

(:bearing ((:forward ((:forward ((:turn-right (bot 5 5 0))))))))

; reify helps avoid this kind of closure based programming

; mutual recursion, WTF?!

(defn elevator [commands]
  (letfn
    [(ff-open [[cmd & r]]
       #(case cmd
          :close (ff-closed r)
          :done  true
          false))
     (ff-closed [[cmd & r]]
       #(case cmd
          :open (ff-open r)
          :up   (sf-closed r)
          false))
     (sf-open [[cmd & r]]
       #(case cmd
          :close (sf-closed r)
          :done  true
          false))
     (sf-closed [[cmd & r]]
       #(case cmd
          :down (ff-closed r)
          :open (sf-open r)
          false))]
    (trampoline ff-open commands)))

(elevator [:close :up :open :close :down :open :done])

; cps

; regular recursion
;
(defn fac [n]
  (if (zero? n)
    1
    (* n (fac (dec n)))))

; cps'd tail recursion
;
(defn fac-cps [n k]
  (if (zero? n)
    (k 1)
    (recur (dec n) (fn [v] (k (* v n)))) ))

(defn fac [n]
  (fac-cps n identity))

(fac 10)

;; (cont [v]
;;   ((cont [v]
;;     ((cont [v] (identity (* v 4)))
;;   (* v 3))))
;; (* v 2))

; Still overflows in a language with no general tail call elimination like Clojure :(

; regular fib
;
(defn fib [n]
  (if (< n 2)
    1
    (+ (fib (- n 1)) (fib (- n 2))) ))

; cps'd fib
;
(defn fib-cps [n k]
  (if (< n 2)
    (k 1)
    (recur (dec n) (fn [fib-n1] (fib-cps (fn [fib-n2] (k (+ fib-n1 fib-n2))) (- n 2)))) ))

(defn fib [n]
  (fib-cps n identity))









































