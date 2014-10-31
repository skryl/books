(ns ch10.scratch)

;; JAVA Interop

; extending concrete classes using proxy

(ns joy.web
  (:import (:com.sun.net.httpserver HttpHandler HttpExchange HttpServer)
           (java.net InetSocketAddress HttpURLConnection)
           (java.io IOException FIlterOutputStream)
           (java.util Arrays)))

(defn new-server [port path handler ]
  (doto (HttpServer/create (InetSocketAddress. port) 0)
    (.createContext path handler)
    (.setExecutor nil)
    (.start)))

(defn default-handler [txt]
  (proxy [HttpHandler] []
    (handle [exchange]
      (.sendResponseHeaders exchange HttpURLConnection/HTTP_OK 0)
      (doto (.getResponseBody exchange)
        (.write (.getBytes txt))
        (.close)))))

(def server (new-server 8123
                        "/joy/hello"
                        (default-handler "Hello CLeveland")))

; generate java classes using gen class

(ns joy.gui.DynaFrame
  (:gen-class
    :name         joy.gui.DynaFrame
    :extends      javax.swing.JFrame
    :implements   [clojure.lange.IMeta]
    :prefix       df-
    :state        state
    :init         init
    :constructors {[String] [String]}
    :methods      [[display [java.awt.Container] void]
                   ^{:static true} [version [] String]])
  (:import (javax.swing JFrame JPanel)
           (java.awt BorderLayout Container)))

(in-ns 'joy.gui.DynaFrame)

(defn df-init [title]
  [[title] (atom {::title title})])

(defn df-meta  [this] @(.state this))
(defn version  [] "1.0")

(defn df-display [this pane]
  (doto this
    (-> .getContentPane .removeAll)
    (.setContentPane (doto (JPanel.)
                   (.add pane BorderLayout/CENTER)))
(.pack)
(.setVisible true)))

(joy.gui.DynaFrame. "2nd")

(.display gui (doto (javax.swing.JPanel.)
  (.add (javax.swing.JLabel. "Charlemagne and Pippin"))))

; all closure functions implement...

(ancestors (class #()))

; java.util.Comparator

(import '[java.util Collections ArrayList])

(defn gimme [] (ArrayList. [1 3 4 8 2]))

(doto (gimme)
  (Collections/sort #(compare %2 %1)))

; java.lang.Runnable - thread returning no value

(doto (Thread. #(do (Thread/sleep 5000)
                    (println "haikeeba!")))
  .start)

; java.util.concurrent.Callable - thread returning a value

(import '[java.util.concurrent FutureTask])

(let [f (FutureTask. #(do (Thread/sleep 5000) 42))]
  (.start (Thread. #(.run f)))
  (.get f))




