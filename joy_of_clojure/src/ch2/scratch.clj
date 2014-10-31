(ns ch2.scratch)

; CH2: Drinking from the Clojure Firehose

; recursive function
;
(defn fact [x]
  (if (= x 1) x
   (* x (fact (- x 1))) )
)

; aliasing
;
(def p println)

; using recur for tail recursion
;
(defn print-down-from [x]
  (if (= x 0) x
    (do (p x) (recur (- x 1)))
  )
)

; using when
;
(defn print-down-from1 [x]
  (when (pos? x)
    (p x)
    (recur (- x 1))
  )
)

; using recur from within if statement
;
(defn sum-down-from [x]
  (loop [sum 0 i x]
   (if (pos? i)
     (recur (+ sum i) (- i 1))
     sum
    )
  )
)

(fact 20)

; implicit function declaration
;
(def l #(list %1 %2 %3 %4))

; blocks
;
(do (+ 1 2) (* 3 4) (- 6 5))

; locals
;
(let [a 1 b 2 c 3] (* a b c))
