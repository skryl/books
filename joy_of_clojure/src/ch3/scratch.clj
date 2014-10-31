(ns ch3.scratch)

; CH3: Dipping Our Toes in the Pool

; nil punning
;
(defn print-seq [s]
  (when (seq s)
    (prn (first s))
    (recur (rest s))))

; seq returns nil for empty sequence
;
(nil? (seq ()))

; vector destructing
;
(def guys-whole-name ["Guy" "Lewis" "Steele"])

(let [[f-name m-name l-name] guys-whole-name]
  (str l-name ", " f-name " " m-name))

(let [[a b c & more] (range 10)]
  (println "a b c are:" a b c)
  (println "more is:" more))

(let [range-vec (vec (range 10))
      [a b c & more :as all] range-vec]
  (println "a b c are:" a b c)
  (println "more is:" more)
  (println "all is:" all))

; associative destructing
;
(let [{first-thing 0, last-thing 3} [1 2 3 4]]
  [first-thing last-thing])

; map destructing
;
(def guys-name-map
  {:f-name "Guy" :m-name "Lewis" :l-name "Steele"} )

(let [{:keys [f-name m-name l-name]} guys-name-map]
  (str l-name ", " f-name " " m-name))

(let [{:keys [title f-name m-name l-name], :or {title "Mr."}} guys-name-map]
  (println title f-name m-name l-name))

; drawing
;
(defn xors [max-x max-y]
  (for [x (range max-x) y (range max-y)] [x y (bit-xor x y)]))

(def frame (java.awt.Frame.))

(for [method (seq (.getMethods java.awt.Frame))
        :let [method-name (.getName method )]
        :when (re-find #"Vis" method-name)]
    method-name)

(.isVisible frame)

(.setVisible frame true)

(.setSize frame (java.awt.Dimension. 200 200))

(def gfx (.getGraphics frame))

(.fillRect gfx 100 100 50 75)

(.setColor gfx (java.awt.Color. 255 128 0))
(.fillRect gfx 100 150 75 50)

(doseq [[x y xor] (xors 200 200)]
  (.setColor gfx (java.awt.Color. xor xor xor))
  (.fillRect gfx x y 1 1))

(defn clear [g] (.clearRect g 0 0 200 200))

(clear gfx)

(defn f-values [f xs ys]
  (for [x (range xs) y (range ys)]
    [x y (rem (f x y) 256)]))

(defn draw-values [f xs ys]
  (clear gfx)
  (.setSize frame (java.awt.Dimension. xs ys))
  (doseq [[x y v] (f-values f xs ys)]
    (.setColor gfx (java.awt.Color. v v v))
    (.fillRect gfx x y 1 1)))

(draw-values bit-and 256 256)
(draw-values + 256 256)
(draw-values * 256 256)
