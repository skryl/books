(ns ch5.scratch)

; CH5: Composite Data Types

; equality partitions (sequences, maps, sets)
;
(= [1 2 3] '(1 2 3 )) ; true
(= [1 2 3] #{1 2 3})  ; false

; vectors
;
(vec (range 10))

(def v (vec (range 100)))
(identical? v (vec v)) ; false

; concat vectors
;
(let [my-vector [:a :b :c]]
  (into my-vector (range 10)))

; primitive vectors
;
(into (vector-of :int) [1.1 2.2 3.3])

(into (vector-of :char) [100 101 102])

; ops
;
(count [1 2 3 4 5])
(nth v 20)
(assoc v 20 "hey!")

(def matrix [[1 2 3] [4 5 6] [7 8 9]])
(get-in matrix [2 1])
(assoc-in matrix [2 1] "yo")
(update-in matrix [2 1] * 100)

; neighbors in matrix
;
(defn neighbors
  ([size yx] (neighbors [[-1 0] [1 0] [0 -1] [0 1]] size yx))
  ([deltas size yx]
    (filter (fn [new-yx]
              (every? #(< -1 % size) new-yx))
            (map #(map + yx %) deltas))))

(neighbors 1 [0 0])
(neighbors 3 [0 0])

; mapping a function on multiple collections
;
(def deltas [[-1 0] [1 0] [0 -1] [0 1]])
(map #(map + [0 0] %) deltas)

; vectors as stacks
;
(def my-stack [1 2 3])
(pop my-stack)
(conj my-stack 4)
(peek my-stack)

;classic lisp ops
;
(cons 1 my-stack)
(first my-stack)
(rest my-stack)

; reimplement map using classic lisp seqs
;
(defn strict-map1 [f coll]
  (loop [coll coll, acc nil]
    (if (empty? coll)
      (reverse acc)
      (recur (next coll) (cons (f (first coll)) acc )))))

; reimplement map using vectors
;
(defn strict-map2 [f coll]
  (loop [coll coll, acc []]
    (if (empty? coll)
      acc
      (recur (next coll) (conj acc (f (first coll)) )))))

(strict-map1 #(+ % 1) [1 2 3 4 5])

(strict-map2 #(+ % 1) [1 2 3 4 5])

; subvectors
;
(subvec [ 1 2 3 4 ] 0 3)

; iterating maps
;
(first {:width 10 :height 20 :depth 30})

(doseq [[dimension amount] {:width 10 :height 20 :depth 30}]
  (println (str (name dimension) ":") amount "inches"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; skipping queues and sets;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

; maps
;

(def h (hash-map :a 1 :b 2 :c 3 :d 4 :e 5))

(get h :a)
(h :a)

; sequencing a map
;
(seq h)

; constructing maps
;
(into {} (seq h))
(zipmap [:a :b] [1 2])
(apply hash-map [:a 2 :b 4])

; sorted maps
;
(sorted-map :thx 1138 :r2d2 2)

; cast error
;
(sorted-map "abc" 1 :a 2)

; array-map (maintains insertion order)
;
(seq (hash-map :a 1 "a" 2 :c 3 "b" 4))
(seq (array-map :a 1 "a" 2 :c 3 "b" 4))

; an index function
;
(defn index [coll]
  (cond
    (map? coll) (seq coll)
    (set? coll) (map vector coll coll)
    :else (map vector (iterate inc 0) coll)))

(defn pos [e coll]
  (for [[i v] (index coll) :when (= e v)] i))



