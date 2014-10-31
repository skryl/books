(ns ch8.scratch)

; macros
;

(-> 25 Math/sqrt int list)

; expands to

(clojure.walk/macroexpand-all '(-> 25 Math/sqrt int list))

(list (int (Math/sqrt 25)))

; eval

(eval 42)

(eval '(+ 1 1))

;; (eval (list 1 2)) ; -> ERROR!

; eval with context

(defn context-eval [ctx expr]
  (eval
    `(let [~@(mapcat (fn [[k v]] [k `'~v]) ctx)]
       ~expr )))

(context-eval {'a 1, 'b 2} '(+ a b))

; do-until macro

(defmacro do-until [& clauses]
  (when clauses
    (list `when (first clauses)
                (second clauses)
                (cons 'do-until (nnext clauses))) ))

(do-until
  (even? 2) (println "Even")
  (odd?  3) (println "Odd")
  :lollipop (println "Truthy")
)

(defmacro unless [condition & body]
  `(if (not ~condition)
     (do ~@body)))

; macro resolution

(defmacro resolution [] `x)
(clojure.walk/macroexpand-all '(resolution)) ; -> user/x

(def x 9)

(let [x 109] (resolution))
