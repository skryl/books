(* nested lets *)

let area_of_ring inner_radius outer_radius =
  let pi = acos (-1.) in
  let area_of_circle r = pi *. r *. r in
  area_of_circle outer_radius -. area_of_circle inner_radius
;;

area_of_ring 1. 3.;;

(* pattern matching lets *)

let (ints, strings) = List.unzip [(1,"one"), (2,"two")];;

(* non exhaustive match because of list *)

let upcase_first_entry line =
  let (first :: rest) = String.split ~on:',' line in
  String.concat ~sep:","  (String.uppercase first :: rest)
;;

let upcase_first_entry line =
  match String.split ~on:',' line with
  | [] -> assert false
  | first :: rest -> String.concat ~sep:","  (String.uppercase first :: rest)
;;

(* anonymous functions *)

(fun x -> x + 1) ;;
(fun x -> x + 1) 7;;

List.map ~f:(fun x -> x + 1) [1;2;3];;

let plusone = (fun x -> x + 1);;
plusone 6;;

let abs_diff = (fun x -> (fun y -> abs (x - y)));;
((abs_diff 1) 2);;

let abs_diff2 x y = abs (x - y);;
((abs_diff2 1) 2);;

let abs_diff3 (x, y) = abs (x - y);;
abs_diff3 (3,4);;

(* recursive functions *)

let rec find_first_stutter list = 
  match list with
  | [] | [_] -> None
  | x :: y :: t1 ->
      if x = y then Some x else find_first_stutter (y::t1)
;;

(* mutual recursion *)

(* silly example *)
let rec is_even x =
  if x = 0 then true else is_odd (x - 1)
and is_odd x =
  if x = 0 then false else is_even (x - 1)
;;

List.map ~f: is_even [0;1;2;3;4;5;6] ;;

(* infix operators *)

3 + 4;;
(+) 3 4;;
List.map ~f:((+) 3) [4;5;6];;

(* redefining operators *)

let (+!) (x1,y1) (x2,y2) = (x1 + x2, y1 + y2);;
(3,2) +! (-2,4) ;;

(* sequencing operator *)

let (|>) x f = f x ;;

let path = "/user/bin:/user/local/bin:/bin:/sbin";;
String.split ~on:':' path
  |> List.dedup ~compare:String.compare
  |> List.iter ~f:print_endline
;;

(* function keyword, automatic pattern matching *)

let some_or_zero num_opt =
  match num_opt with
  | Some x -> x
  | None -> 0
;;

let some_or_zero = function
  | Some x -> x
  | None   -> 0
;;

(* pattern match second argument *)

let some_or_default default = function
  | Some x -> x
  | None   -> default
;;

List.map ~f:(some_or_default 100) [Some 3; None; Some 4];;

(* labelled arguments *)

let ratio ~num ~denom = float num /. float denom;;
ratio ~num:3 ~denom:10;;

let num = 3 in 
let denom = 4 in
ratio ~num ~denom ;;

let apply_to_tuple f (first,second) = f ~first ~second;;
let apply_to_tuple2 f (first,second) = f ~second ~first;;

let divide ~first ~second = first / second;;
apply_to_tuple divide (6,3);;

(* error! named arguments must be in order when function is passed *)
apply_to_tuple2 divide (6,3);;

(* optional arguments *)
(* None is passed when user doesn't specify an argument *)

let concat ?sep x y =
  let sep = match sep with None -> "" | Some x -> x in
  x ^ sep ^ y
;;

let concat ?(sep="") x y = x ^ sep ^ y;;

(* can be explicit about wrapping optional args *)

concat ~sep:":" "foo" "bar" ;;
concat ?sep:(Some ":") "foo" "bar" ;;
concat "foo" "bar" ;;
concat ?sep:None "foo" "bar" ;;

let upcase_concat ?(sep="") a b = concat ~sep (String.uppercase a) b ;;

(* just pass through the optional args *)
let upcase_concat ?sep a b = concat ?sep (String.uppercase a) b ;;

(* partial application of optional arguments *)

let concat ?(sep="") x y = x ^ sep ^ y;;

let colon_concat = concat ~sep:":" ;;
colon_concat "a" "b" ;;

let prepend_pound = concat "# ";;
prepend_pound "a BASH comment" ;;
prepend_pound ~sep:"." "a BASH comment" ;; (* optional arg is erased! *)

(* move the optional argument to prevent erasure *)
let concat x ?(sep="") y = x ^ sep ^ y;;

let prepend_pound = concat "# ";;
prepend_pound "a BASH comment" ;;
prepend_pound ~sep:"." "a BASH comment" ;; (* optional arg is still there! *)

(* optional arg cannot be erased *)
let concat x y ?(sep="") = x ^ sep ^ y;;






