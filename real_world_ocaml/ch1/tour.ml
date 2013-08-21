(* numbers *)
3 + 4;; 
8 / 3;;
3.5 +. 6.;; (* special ops for float math *)
sqrt 9.;;
4.0 + 3.0;; (* type error *)
4 + 3.0;;   (* type error *)
sqrt 9;;    (* type error *)

(* variables *)

let x = 3 + 4;;
let _x = 5 + 6;; (* return value not shown for _var *)

(* functions *)

let square x = x * x;;
square (square 2);;

let ratio x y = Float.of_int x /. Float.of_int y;;
ratio 4 7;;

(* higher order functions *)

let sum_if_true test first second =
  (if test first then first else 0) +
  (if test second then second else 0)
;;

let even x = x mod 2 = 0;;

sum_if_true even 3 4;; (* 4 *)
sum_if_true even 2 4;; (* 6 *)

(* type inference *)

let sum_if_true (test : int -> bool) (x : int) (y : int) : int = 
  (if test first then first else 0) +
  (if test second then second else 0)
;;


let first_if_true test x y =
  if test x then x else y
;; 

(* val first_if_true : ('a -> bool) -> 'a -> 'a -> 'a = <fun> *)

let long_string s = String.length s > 6;;
first_if_true long_string "abcdefgh" "short";;

let big_number x = x > 3;;
first_if_true big_number 2 10;;

(* tuples *)

let tuple = (3, "three");;
let another_tupe = (4, "four", 4.);;

let (x,y) = tuple;;
x + String.length y;;

let distance (x1,y1) (x2,y2) =
  sqrt ((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.)
;;

distance (1.,2.) (3.,4.);;

(* lists *)

let languages = ["OCaml"; "Perl"; "C"];;
let numbers = [3; "four"; 5];;              (* type error *)

List.length languages;;
List.map languages ~f:String.length;;

["a", "b", "c"] = [("a", "b", "c")];;       (* don't use commas in lists *)

"French" :: "Spanish" :: languages;;
[1; 2; 3;] = 1 :: (2 :: (3 :: []));;
[1;2;3] @ [4;5;6];;

(* pattern matching *)

let my_fav_lang (fav :: rest) = fav;;       (* non exhaustive *)
my_fav_lang [];;                            (* match failure  *)

let my_fav_lang languages =
  match languages with
  | first :: rest -> first
  | [] -> "OCaml"
;;

(* recursive functions *)

let rec sum l = 
  match l with
  | [] -> 0
  | first :: rest -> first + (sum rest)
;;

let rec destutter list =
  match list with
  | [] -> []
  | [x] -> [x]
  | x1 :: x2 :: xs -> 
      if x1 = x2 then destutter (x1 :: xs)
      else x1 :: destutter (x2 :: xs)
;;

(* options *)

let divide x y =
  if y = 0 then None else Some (x/y) ;;

let log maybe_time message =
  let time =
    match maybe_time with
    | Some x -> x
    | None -> Time.now ()
  in
  Time.to_sec_string time ^ " -- " ^ message
;;

log (Some Time.epoch) "A long long time ago";;
log None "In a galazy far far away";;

(* nesting lest *)

let x = 7 in 
let y = x * x in
x + y ;;

(* records *)

type point2d = { x : float; y : float };;
let p = { x = 3.; y = -4. };;

let magnitude { x = x_pos; y = y_pos } =
  sqrt (x_pos ** 2. +. y_pos ** 2.);;

let magnitude { x; y } = sqrt (x ** 2. +. y ** 2.);;  (* field punning, more terse *)

let distance v1 v2 =
  magnitude { x = v1.x -. v2.x; y = v1.y -. v2.y };;

type circle_desc  = { center: point2d; radius: float  }
type rect_desc    = { lower_left: point2d; width: float; height: float }
type segment_desc = { endpoint1: point2d; endpoint2: point2d  };;

type scene_element = 
  | Circle  of circle_desc
  | Rect    of rect_desc
  | Segment of segment_desc
;;

let inside_element point element =
  match element with
  | Circle { center; radius } ->
      distance center point < radius
  | Rect { lower_left; width; height } ->
      point.x > lower_left.x && point.x < lower_left.x +. width &&
      point.y > lower_left.y && point.y < lower_left.y +. height
  | Segment { endpoint1; endpoint2 } -> false
;;

inside_element {x=3.;y=7.} (Circle {center = {x=4.;y=4.}; radius = 1.});;

(* arrays *)

let numbers = [| 1; 2; 3; 4; 5 |] ;;

numbers.(2) ;;
numbers.(2) <- 4 ;;
numbers ;;

(* mutable records *)

type running_sum = { 
  mutable sum: float;
  mutable sum_sq: float;
  mutable samples: int;
};;

let mean rsum = rsum.sum /. float rsum.samples (* float is equivalent to Float.of_int *)
let stdev rsum =
  sqrt (rsum.sum_sq /. float rsum.samples
        -. (rsum.sum /. float rsum.samples) ** 2.) ;;

let create () = { sum = 0.; sum_sq = 0.; samples = 0 }
let update rsum x =
  rsum.samples <- rsum.samples + 1;
  rsum.sum     <- rsum.sum     +. x;
  rsum.sum_sq  <- rsum.sum_sq  +. x *. x
;;

let rsum = create ();;
List.iter [1.;3.;2.;-7.;4.;5.;] ~f:(fun x-> update rsum x);;
mean rsum;;
stdev rsum;;

(* mutable variables aka refs *)

let x = { contents = 0 };;
x.contents <- x.contents + 1;;
x ;;

let x = ref 0;;
!x ;;         (* get contents ie x.contents *)
x := !x + 1;; (* assignment ie x.contents <- ... *)
!x ;;

(* ref is just a type *)

type 'a ref  = { mutable contents : 'a }
let ref x = { contents = x }
let (!) r = r.contents
let (:=) r x = r.contents <- x

let sum list =
  let sum = ref 0 in
  List.iter list ~f:(fun x -> sum:= !sum + x);
  !sum
;;

(* for / while loops *)

let forloop = 
  for i = 0 to 100 do
    1 + 1
  done
;;

let whileloop =
  while 1 < 10 do
    1 + 1
  done
;;
