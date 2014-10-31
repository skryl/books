(ns ch4.scratch)

; CH4: On Scalars

; using keys as functions
;
(def population {:zombies 7000 :humans 3000})
(:zombies population)

; cond
;
(defn pour [lb ub]
  (cond
    (= ub :toujours) (iterate inc lb)
    :else (range lb ub)))

(pour 1 10)
(pour 1 :toujours)

; case and ns qualified symbols
;
(defn do-blowfish [directive]
  (case directive
    :aquarium/blowfish (println "feed the fish")
    :crypto/blowfish (println "encode the message")
    :blowfish (println "not sure")))

(ns crypto)
(user/do-blowfish :blowfish)
(user/do-blowfish ::blowfish)

(= `do-blowfish 'do-blowfish) ;false
(= `do-blowfish 'crypto/do-blowfish) ;true

; regexen
;
(re-seq #"\w+" "one-two/three")
