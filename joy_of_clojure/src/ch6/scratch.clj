(ns ch6.scratch)

; immutability (structural sharing)
;

(def baselist (list :barnabas :adam))
(def lst1 (cons :willie baselist))
(def lst2 (cons :phenix baselist))
(identical? (next lst1) (next lst2)) ; -> true

; structural sharing
;

(defn xconj [t v]
  (cond
    (nil? t)       { :val v, :L nil, :R nil }
    (< v (:val t)) { :val (:val t), :L (xconj (:L t) v), :R (:R t) }
    (:else         { :val (:val t), :L (:L t), :R (xconj (:R t) v) } ))

(def t (xconj (xconj (xconj (xconj nil 5) 3) 7) 9))

(defn xseq [t]
  (when t
    (concat (xseq (:L t)) [(:val t)] (xseq (:R t))) ))

(xseq t)

(def tree1 (xconj t 8))
(def tree2 (xconj t 9))

(identical? (:L tree1) (:L tree2)) ; -> true

; lazyness

(defn rec-step [[x & xs]]
  (if x
    [x (rec-step xs)]
    [] ))

(rec-step (range 10))
(rec-step (range 10000)) ; -> StackOverflow

; rest vs next

(def very-lazy (-> (iterate #(do (print \.) (inc %)) 1)
      rest rest rest))

(def less-lazy (-> (iterate #(do (print \.) (inc %)) 1)
      next next next))

(first very-lazy)
(first less-lazy)

; lazy seq macro

(defn lz-rec-step [s]
  (lazy-seq
    (if (seq s)
      [(first s) (lz-rec-step (rest s))]
      [] )))

(lz-rec-step [1 2 3 4])

(defn simple-range [i limit]
  #(
    (when (< i limit)
      (cons i (simple-range (inc i) limit)))))

; creating infinite sequences

(take 5 (iterate (fn [n] (/ n 2)) 1))

; delay and force

(defn defer-expensive [cheap expensive]
  (if-let [good-enough (force cheap)]
    good-enough
    (force expensive) ))

(defer-expensive (delay false)
                 (delay (do (Thread/sleep 5000) :expensive)))

; lazy, tail-recursive quicksort

(defn nom [n] (take n (repeatedly #(rand-int n))))

(defn sort-parts [work]
  (lazy-seq
    (loop [[part & parts] work]
      (if-let [[pivot & xs] (seq part)]
        (let [smaller? #(< % pivot)]
          (recur (list*
                   (filter smaller? xs)
                   pivot
                   (remove smaller? xs)
                   parts)))
        (when-let [[x & parts] parts]
          (do
            (println (str x " [" parts "]\n"))
            (cons x (sort-parts parts))))))))

(defn qsort [xs]
  (sort-parts (list xs)))

(take 3 (qsort (nom 10)))
