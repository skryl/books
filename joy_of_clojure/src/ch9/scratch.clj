(ns ch9.scratch)

; namespaces

; create and switch to namespace, includes java.lang but NOT clojure.core. Takes explicit symbol.

(in-ns 'joy.ns)
(def authors ["Chouser"])

(in-ns 'your.ns)
(clojure.core/refer 'joy.ns)
authors ; -> ["Chouser"]

; create and switch to namespace, including all symbolic mappings from java.lang and clojure.core

(ns chimp)
(reduce + [1 2 3])

; create a namespace object with java mappings, finest level of control

(def b (create-ns 'bonobo))

(intern b 'x 9)

bonobo/x

(intern b 'reduce clojure.core/reduce)

(intern b '+ clojure.core/+)

(in-ns 'bonobo)
(reduce + [1 2 3 4 5])

(ns user)

(ns-unmap 'bonobo 'reduce)
(get (ns-map 'bonobo) 'reduce) ; -> nil

; wipe namespace

(remove-ns 'bonobo)

(all-ns)

; private functions

(ns joy.contracts)

(defn- build-contract [c]
  ;...
  )

; can achieve manually by adding private metadata, also works for def and defmacro
; there is no def- or defmacro- so metadata must be used

(ns hider.ns)

(defn ^{:private true} answer [] 42)

(ns seeker.ns
  (:refer hider.ns))

;; (answer) ; -> ERROR!

; inclusion directives

(ns joy.ns-ex
  (:refer-clojure :exclude [defstruct]) ; exclude defstruct from clojure core
  (:use (clojure set xml))              ; use everything in set and xml without namespace qualifier
  (:use [clojure.test :only (are is)])  ; only use are/is from test without qualification
  (:require (clojure [zip :as z]))      ; load clojure.zip namespace and alias as z
  (:import (java.util Date)             ; import Date/File java classes
           (java.io File)))

; prototypal inheritance

(ns joy.udp
  (:refer-clojure :exclude [get]))

(defn beget [o p] (assoc o ::prototype p))

(beget {:sub 0} {:super 1})

(def put assoc)

(defn get [m k]
  (when m
    (if-let [[_ v] (find m k)]
      v
      (recur (::prototype m) k))))

(get (beget {:sub 0} {:super 1}) :super)

; multimethods

(defmulti  compiler :os)
(defmethod compiler ::unix [m] (get m :c-compiler))
(defmethod compiler ::osx  [m] (get m :c-compiler))

(def clone (partial beget {}))
(def unix {:os ::unix, :c-compiler "c", :home "/home", :dev "/dev"})
(def osx  (-> (clone unix) (put :os ::osx) (put :c-compiler "gcc") (put :home "/Users")))

(compiler unix)

(compiler osx)

(defmulti home :os)
(defmethod home ::unix [m] (get m :home))

(home unix)

;; (home osx) ; -> ERROR!

(derive ::osx ::unix)
(home osx)

; derivation heirarchy
(parents ::osx)
(ancestors ::osx)
(descendants ::osx)
(isa? ::unix ::osx)

(derive ::osx ::bsd)
(defmethod home ::bsd [m] "/home")

;; (home osx) ; -> ERROR

(prefer-method home ::unix ::bsd)
(home osx)

; arbitrary dispatch

(defmulti compile-cmd (juxt :os compiler))

(defmethod compile-cmd [::osx "gcc"] [m]
  (str "/usr/bin/" (get m :c-compiler)))

(defmethod compile-cmd :default [m]
  (str "Unsure where to locate " (get m :c-compiler)))

; Types, protocols and records (a different approach to polymorphism)
; (defstruct is not used in favor of defrecord, it relied on maps to create types)

; defining types using records

{ val 5, :l nil, :r nil} ; map but not a type

;; (defrecord TreeNode [val l r]) ; create a type
;;
;; (TreeNode. 5 nil nil) ; construct an instance

; defrecord and deftype create classes, which must be imported into other namespaces

;; (ns my-cool-ns
;;   (:import joy.udp.TreeNode))

; associng keys to records works but dispatch speed for those keys is the same as for a map
;; (def tree-node-plus (assoc (TreeNode. 5 nil nil) :l 1))

;; (dissoc tree-node-plus :l) ; returns a map!

; Protocols

(defrecord TreeNode [val l r])

(defn xconj [t v]
  (cond
    (nil? t)       (TreeNode. v nil nil)
    (< v (:val t)) (TreeNode. (:val t) (xconj (:l t) v) (:r t))
    :else          (TreeNode. (:val t) (:l t) (xconj (:r t) v))))

(defn xseq [t]
  (when t
    (concat (xseq (:l t)) [(:val t)] (xseq (:r t)))))

(def sample-tree (reduce xconj nil [3 5 2 4 6]))
(xseq sample-tree)

(defprotocol FIXO
  (fixo-push [fixo value])
  (fixo-pop  [fixo])
  (fixo-peek [fixo]))

(extend-type TreeNode FIXO
  (fixo-push [node value]
    (xconj node value))
  (fixo-peek [node]
    (if (:l node)
      (recur (:l node))
      (:val node)))
  (fixo-pop [node]
    (if (:l node)
      (TreeNode. (:val node) (fixo-pop (:l node)) (:r node))
      (:r node))))

(xseq (fixo-push sample-tree 5/2))

; extend nil with our interface so we can bootstrap trees easily

(extend-type nil
  FIXO
  (fixo-push [t v]
    (TreeNode. v nil nil)))

(xseq (reduce fixo-push nil [3 5 2 4 6 0]))

; can extend any other type

(extend-type clojure.lang.IPersistentVector
  FIXO
  (fixo-push [vector value]
    (conj vector value))
  (fixo-peek [vector]
    (peek vector))
  (fixo-op [vector]
    (pop vector)))

; protocols have to be extended completely, NOT piecewise!
; mixins can be used for that

(defprotocol StringOps (rev [s]) (upp [s]))

(def rev-mixin {:rev clojure.string/reverse})

(def upp-mixin {:upp (fn [this] (.toUpperCase this))})

(def fully-mixed (merge upp-mixin rev-mixin))

(extend String StringOps fully-mixed)

(xseq (reduce fixo-push nil [3 5 2 4 6 0]))

; sharing functionality between concrete implementations

; using extend

(def tree-node-fixo
  {:fixo-push (fn [node value]
                (xconj node value))
   :fixo-peek (fn [node]
                (if (:l node)
                  (recur (:l node))
                  (:val node)))
   :fixo-pop (fn [node]
               (if (:l node)
                 (TreeNode. (:val node) (fixo-pop (:l node)) (:r node))
                 (:r node)))})

(extend TreeNode FIXO tree-node-fixo)

; using reify

(defn fixed-fixo
  ([limit] (fixed-fixo limit []))
  ([limit vector]
    (reify FIXO
      (fixo-push [this value]
        (if (< (count vector) limit)
          (fixed-fixo limit (conj vector value))
          this))
      (fixo-peek [_]
        (peek vector))
      (fixo-pop [_]
        (pop vector)))))

; using defrecord

(defrecord TreeNode [val l r]
  FIXO
  (fixo-push [t v]
    (if (< v val)
      (TreeNode. val (fixo-push l v) r)
      (TreeNode. val l (fixo-push r v))))
  (fixo-peek [t]
    (if l
    (fixo-peek l)
    val))
  (fixo-pop [t]
    (if l
      (TreeNode. val (fixo-pop l) r)
      r)))

(def sample-tree2 (reduce fixo-push (TreeNode. 3 nil nil) [5 2 4 6]))
(xseq sample-tree2)

; using deftype to start with a blank slate object

;; (defrecord InfiniteConstant [i]
;;   clojure.lang.ISeq
;;   (deq [this]
;;     (lazy-seq (cons i (seq this))))) ; -> ERROR (seq already exists for map)

(deftype InfiniteConstant [i]
  clojure.lang.ISeq
  (deq [this]
    (lazy-seq (cons i (seq this)))))

(take 3 (InfiniteCOnstant. 5))

; field lookup will not work :(

(:i (InfiniteCOnstant. 5)

; but we can use java interop to get at the fields

(.i (InfiniteConstant. 5))
