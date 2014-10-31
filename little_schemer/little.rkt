#lang racket

(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

; atoms

(atom? 'turkey)

(atom? '1492)

(atom? '*abc$)

; lists (not atoms)

(list? '(atom))

(list? '(atom turkey or))

(list? '())

; LAW OF CAR: car is defined only for non empty lists

(car '()) ; ERROR!

(car 'abc) ; ERROR!

; LAW OF CDR: cdr is defined only for non empty lists. cdr of any non empty list is always another list.

(cdr '(hamburger)) ; -> '()

(cdr '()) ; ERROR!

(cdr 'abc) ; ERROR!

; LAW OF CONS: cons takes two arguments. The second argument must be a list. The result is a list.

(cons 'a 'b) ; pair not list

(cons 'a '()) ; -> (a)

; LAW OF NULL: null is defined only for lists

(null? '())

(null? (quote ()))

(null? 'a) ; false for everything except empty lists in practice

; LAW OF EQ: eq? takes two arguments. Each must be a non numeric atom.

(eq? 'Harry 'Harry)

(eq? 1 1)

(eq? '() '())

(eq? '(a) '(a)) ; FALSE! not the same list!

(eq? '(a) 'a) ; FALSE!

; list of atoms?

(define lat?
  (lambda (xs)
    (cond
      ((null? xs) #t)
      ((atom? (car xs)) (lat? (cdr xs)))
      (else #f))))


(lat? (list 'a 1 'ab))  ; -> #t
(lat? (list 2 '() 3))   ; -> #f


; member of list?

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                (member? a (cdr lat)) )))))

(member? 1 '(3 2 1))
(member? 1 '(4 3 2))


; remove member

(define rember
  (lambda (item xs)
    (cond
      ((null? xs) xs)
      ((eq? item (car xs)) (cdr xs))
      (else (cons (car xs)
                  (rember item (cdr xs)))) )))

(rember 1 '(0 1 2 3))
(rember 1 '(0 1 1 2 3))
(rember 3 '(0 1 2 3))


; get the first element of each list

(define firsts
  (lambda (xs)
    (if (null? xs) '()
        (cons (car (car xs)) (firsts (cdr xs))) )))

(firsts '((a b) (1 2) (c 3)))


; insert an element to the right of given element

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old)
       (cons (car lat) (cons new (cdr lat))) )
      (else (cons (car lat) (insertR new old (cdr lat)))) )))

(insertR 'e 'd '(a b c d f g d h))


(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old)  (cons new lat))
      (else (cons (car lat) (insertL new old (cdr lat)))) )))

(insertL 'e 'd '(a b c d f g d h))


(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old)  (cons new (cdr lat)))
      (else (cons (car lat) (subst new old (cdr lat)))) )))

(subst 'e 'd '(a b c d f g d h))


(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) lat)
      ((or (eq? (car lat) o1)
           (eq? (car lat) o2))
             (cons new (cdr lat)))
      (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))) )))

(subst2 'e 'd 'b '(a b c d f g d h))

(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) a) (multirember a (cdr lat)))
      (else (cons (car lat) (multirember a (cdr lat)))) )))


(multirember 1 '(0 1 2 3))
(multirember 1 '(0 1 1 2 3))
(multirember 1 '(0 1 1 2 3 1))


(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old)
       (cons old
         (cons new
           (insertR new old (cdr lat)))))
      (else (cons (car lat) (multiinsertR new old (cdr lat)))) )))

(multiinsertR 'e 'd '(a b c d f g d h))


(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old)  (cons new (multiinsertL new old (cdr lat))))
      (else (cons (car lat) (insertL new old (cdr lat)))) )))

(insertL 'e 'd '(a b c d f g d h))


(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) lat)
      ((eq? (car lat) old)  (cons new (multisubst new old (cdr lat))))
      (else (cons (car lat) (multisubst new old (cdr lat)))) )))

(multisubst 'e 'd '(a b c d f g d h))

(define add1
  (lambda (n)
    (+ n 1) ))

(define sub1
  (lambda (n)
    (- n 1) ))

(zero? 1)

(define +
  (lambda (n m)
    (if (zero? m) n
      (plus (add1 n) (sub1 m)))))

(define -
  (lambda (n m)
    (if (zero? m) n
      (minus (sub1 n) (sub1 m)))))

(define addtup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (+ (car tup)
               (addtup (cdr tup)) )))))

(define x
  (lambda (n m)
    (if (zero? m) 0
        (plus n (mult n (sub1 m)) ))))

(mult 10 5)

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else (cons (plus (car tup1) (car tup2))
            (tup+ (cdr tup1) (cdr tup2)) )))))

(tup+ '(1 2 3 4) '(1 2 3))

(define >
  (lambda (n m)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else (more (sub1 n) (sub1 m)) ))))

(more 5 4)
(more 4 4)
(more 4 5)

(define <
  (lambda (n m)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else (less (sub1 n) (sub1 m)) ))))

(less 5 4)
(less 4 4)
(less 4 5)

(define =
  (lambda (n m)
    (cond
      ((or (> n m) (< n m)) #f)
      (else #t))))

(equal 5 4)
(equal 4 4)
(equal 4 5)

(define pow
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (mult n (pow n (sub1 m)))) )))

(pow 2 3)
(pow 5 3)

(define div
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (div (- n m) m))))))

(div 6 2)
(div 100 5)

(define length
  (lambda (lat)
    (if (null? lat) 0
      (add1 (length (cdr lat))) )))

(length '(0 1 2 3 4 5))

(define pick
  (lambda (n lat)
    (cond
      ((null? lat) #f)
      ((= 1 n) (car lat))
      (else (pick (sub1 n) (cdr lat))) )))

(pick 4 '(a b c d e f g))

(define rempick
  (lambda (n lat)
    (cond
      ((null? lat) null)
      ((= 1 n) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))) )))

(rempick 4 '(a b c d e f g))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) null)
      ((number? (car lat)) (no-nums (cdr lat)))
      (else (cons (car lat) (no-nums (cdr lat)))) )))

(no-nums '(1 a 2 b 3 c 4 d))


(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) null)
      ((number? (car lat)) (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))) )))

(all-nums '(1 a 2 b 3 c 4 d))

(define eqan?
  (lambda (a1 a2)
    (cond
      ((and (number? a1) (number? a2)) (= a1 a2))
      ((or (number? a1) (number? a2)) #f)
      (else (eq? a1 a2)) )))

(eqan? 1 1)
(eqan? 1 2)
(eqan? 1 'a)
(eqan? 'b 'a)
(eqan? 'a 'a)

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      ((eq? (car lat) a) (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))) )))

(occur 1 '(a b c 1 d e f 1 g h i))


(define one?
  (lambda (n) (= n 1)))

(one? 1)
(one? 10)


(define rempick
  (lambda (n lat)
    (cond
      ((null? lat) null)
      (one? (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))) )))

(rempick 4 '(a b c d e f g))


(define rember*
  (lambda (a l)
    (cond
      ((null? l) l)
      ((atom? (car l))
       (cond
        ((eq? a (car l)) (rember* a (cdr l)))
        (else (cons (car l) (rember* a (cdr l))))))
      (else (cons (rember* a (car l))
                  (rember* a (cdr l)))) )))

(rember* 1 '(1 2 (3 4 1) 1 ((5 1) 1) 6 7))


(define insertR*
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((atom? (car l))
       (cond
        ((eq? old (car l)) (cons old
                                 (cons new (insertR* new old (cdr l)))))
        (else (cons (car l) (insertR* new old (cdr l))))))
      (else (cons (insertR* new old (car l))
                  (insertR* new old (cdr l)))) )))

(insertR* 'z 1 '(1 2 (3 4 1) 1 ((5 1) 1) 6 7))


(define occur*
  (lambda (a l)
    (cond
      ((null? l) 0)
      ((atom? (car l))
       (cond
        ((eq? a (car l)) (add1 (occur* a (cdr l))))
        (else (occur* a (cdr l)))))
      (else (+ (occur* a (car l))
               (occur* a (cdr l)))) )))

(occur* 1 '(1 2 (3 4 1) 1 ((5 1) 1) 6 7))


(define subst*
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((atom? (car l))
       (cond
        ((eq? old (car l)) (cons new (subst* new old (cdr l))))
        (else (cons (car l) (subst* new old (cdr l))))))
      (else (cons (subst* new old (car l))
                  (subst* new old (cdr l)))) )))

(subst* 'z 1 '(1 2 (3 4 1) 1 ((5 1) 1) 6 7))


(define insertL*
  (lambda (new old l)
    (cond
      ((null? l) l)
      ((atom? (car l))
       (cond
        ((eq? old (car l)) (cons new
                                 (cons old (insertL* new old (cdr l)))))
        (else (cons (car l) (insertL* new old (cdr l))))))
      (else (cons (insertL* new old (car l))
                  (insertL* new old (cdr l)))) )))

(insertL* 'z 1 '(1 2 (3 4 1) 1 ((5 1) 1) 6 7))


(define member*
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
         (or (eq? a (car l)) (member* a (cdr l))))
      (else (or (member* a (car l))
                (member* a (cdr l)))) )))

(member* 5 '(1 2 (3 4 1) 1 ((5 1) 1) 6 7))


(define leftmost
  (lambda (l)
    (cond
      ((atom? (car l)) (car l))
      (else (leftmost (car l))) )))

(leftmost '(((6 7) 4 1) 1 ((5 1) 1) 6 7))

(define eqlist?
  (lambda (l1 l2)
      (or (and (null? l1) (null? l2))
          (and (atom? (car l1)) (atom? (car l2))
               (eqan? (car l1) (car l2))
               (eqlist? (cdr l1) (cdr l2)))
          (and (pair? (car l1)) (pair? (car l2))
               (eqlist? (car l1) (car l2))
               (eqlist? (cdr l1) (cdr l2))) )))

(eqlist? '(1 2 3) '(1 2 3))

(define equal?
  (lambda (s1 s2)
      (or (and (atom? s1) (atom? s2)
               (eqan? s1 s2))
          (and (pair? s1) (pair? s2)
               (eqlist? s1 s2) ))))

; eqlist in terms of equal

(define eqlist?
  (lambda (l1 l2)
      (or (and (null? l1) (null? l2))
          (and (equal? (car l1) (car l2))
               (equal? (cdr l1) (cdr l2))) )))


(equal? 1 1)
(equal? 1 2)
(equal? '(1 2 3) '(1 2 3))
(equal? '(1 3) '(1 2 3))

; rember in terms of equal?

(define rember
  (lambda (s l)
    (cond
      ((null? l) '())
      ((equal? (car l) s) (cdr l))
      (else (cons (car l) (rember s (cdr l)))))))


; s expression with all numbers and ops

(define numbered?
  (lambda (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else
        (and (numbered? (car aexp))
             (numbered? (caddr aexp))) ))))

(numbered? '(1 + (4 ^ 5)))
(numbered? '(a + (4 ^ 5)))

(define ^
  (lambda (a b)
    (expt a b)))

(define value
  (lambda (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (cadr nexp) '+)
               (+ (value (car nexp)) (value (caddr nexp))))
      ((eq? (cadr nexp) '*)
               (* (value (car nexp)) (value (caddr nexp))))
      (else (expt (value (car nexp)) (value (caddr nexp)))))))

(numbered? '(1 + (4 ^ 5)))
(value '(1 ^ (4 * 5)))


; member in terms of equal instead of eq

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (equal? (car lat) a)
                (member? a (cdr lat)) )))))

(define set?
  (lambda (l)
    (cond
      ((null? l) #t)
      (else (and (not (member? (car l) (cdr l)))
                 (set? (cdr l)))))))

(set? '(1 2 3 4))
(set? '(1 2 3 1 4))


(define makeset
  (lambda (l)
    (cond
      ((null? l) l)
      ((not (member? (car l) (cdr l)))
         (cons (car l) (makeset (cdr l))))
      (else (makeset (cdr l))) )))

(makeset '(1 2 3 4))
(makeset '(1 2 3 1 4))

; makeset in terms of multirember

(define makeset
  (lambda (l)
    (cond
      ((null? l) l)
      (else (cons (car l)
                  (makeset (multirember (car l) (cdr l))))))))

(makeset '(1 2 3 4))
(makeset '(1 2 3 1 4))

(define subset?
  (lambda (s1 s2)
    (cond
      ((null? s1) #t)
      (else (and (member? (car s1) s2)
                 (subset (cdr s1) s2))))))

(subset '(1 2) '(1 2 3 1 4))
(subset '(1 5) '(1 2 3 1 4))

(define eqset?
  (lambda (s1 s2)
    (cond
      ((and (null? s1) (null? s2)) #t)
      ((or (null? s1) (null? s2)) #f)
      (else (and (member? (car s1) s2)
                 (eqset?  (cdr s1) (rember (car s1) s2)))))))

(define eqset?
  (lambda (s1 s2)
    (and (subset? s1 s2) (subset? s2 s1)) ))

(eqset? '(4 3 2 1) '(1 2 3 4))

; Boooring, skipping to ch9...

(define looking
  (lambda (a lat)
    (keep-looking a (pick 1 lat) lat)))

; partial (not total) function because it might not terminate

(define keep-looking
  (lambda (a b lat)
    (cond
      ((number? b) (keep-looking a (pick b lat) lat))
      (else (eq? a b)) )))

; never stops

(define eternity
  (lambda (x)
    (eternity x)))


; pairs

(define a-pair?
  (lambda (s)
    (cond
      ((or (null? s) (atom? s) (null? (cdr s))) #f)
      ((null? (cddr s)) #t)
      (else #f))))

(define first
  (lambda (p)
    (car p)))

(define second
  (lambda (p)
    (cadr p)))

(define build
  (lambda (s1 s2)
    (cons s1 (cons s2 '())) ))

(define shift
  (lambda (pair)
    (build (first (first pair))
           (build (second (first pair))
                  (second pair)))))

(define align
  (lambda (pora)
    (cond
      ((atom? pora) pora)
      ((a-pair? (first pora))
       (align (shift pora)))
      (else (build (first pora)
                   (align (second pora)))))))

(align (build (build 1 2) 3))
(align (build (build 1 2) (build 3 4)))

(define length*
  (lambda (pora)
    (cond
      ((atom? pora) 1)
      (else
        (+ (length* (first pora))
           (length* (second pora)) )))))

; is this function total? Nope. Thanks Collatz.

(define C
  (lambda (n)
    (cond
      ((one? n) 1)
      (else
        (cond
          ((even? n) (C (/ n 2)))
          (else (C (add1 (* 3 n)))) )))))

; how about Ackermann?

(define A
  (lambda (n m)
    (cond
      ((zero? n) (add1 m))
      ((zero? m (A (sub1 n) 1)))
      (else (A (sub1 n)
               (A n (sub1 m)))))))

; can we write the function will-stop?

(define will-stop?
  (lambda (f)
    ...
    ))

; what should it return for f = length -> t
; what about for f = eternity -> f
; what about f =

(define last-try
  (lambda (x)
    (and (will-stop? last-try) (eternity x)) ))

; FAIL, will-stop cannot be defined, thanks Turing and Godel

; can we define recursive functions without using 'define'?

(define length
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))) )))

; what does this do? only determines the length of an empty list

(lambda (l)
  (cond
    ((null? l) 0)
    (else (add1 (eternity (cdr l)))) ))

; lets call this length0, can we get the length of a list with 1 item?
; we can use length0, but without define we must substitute its definition

(lambda (l)
  (cond
    ((null? l) 0)
    (else (add1 (
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (eternity (cdr l)))))) (cdr l)))))))


; can we abstract his out?

((lambda (length)
  (lambda (l)
    (cond
      ((null? l) 0)
      (else (add1 (length (cdr l)))))))
 eternity)

; lets call the above mk-length

((lambda (mk-length)
   (mk-length eternity))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l))))))))

(((lambda (mk-length)
   (mk-length
     (mk-length
       (mk-length
         (mk-length eternity)))))
  (lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))) '(1 2 3))

; do we need an infinite number of applications? NO!

(((lambda (mk-length)
   (mk-length mk-length))
  (lambda (mk-length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 ((mk-length mk-length) (cdr l)))))))) '(1 2 3))

; can we preserve the length function?

(((lambda (mk-length)
   (mk-length mk-length))
  (lambda (mk-length)
    ((lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l)))))))
    (lambda (x)
      ((mk-length mk-length) x))))) '(1 2 3 4))

; lets extract the length function

((lambda (le)
  ((lambda (mk-length)
     (mk-length mk-length))
    (lambda (mk-length)
      (le (lambda (x)
          ((mk-length mk-length) x))))))
   (lambda (length)
        (lambda (l)
          (cond
            ((null? l) 0)
            (else (add1 (length (cdr l))))))))

; lets seperate the two

(lambda (length)
  ((lambda (mk-length)
     (mk-length mk-length))
    (lambda (mk-length)
      (length (lambda (x)
          ((mk-length mk-length) x))))))


(lambda (length)
    (lambda (l)
      (cond
        ((null? l) 0)
        (else (add1 (length (cdr l)))))))

; generalize

(define Y
  (lambda (le)
    ((lambda (f) (f f))
      (lambda (f)
        (le (lambda (x) ((f f) x)))))))

(define mk-length
  (lambda (length)
      (lambda (l)
        (cond
          ((null? l) 0)
          (else (add1 (length (cdr l))))))))

; this is the Applicative order Y-combinator

((Y mk-length) '(1 2 3))

; Ch 10


