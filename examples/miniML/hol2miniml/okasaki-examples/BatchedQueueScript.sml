
open HolKernel Parse boolLib bossLib; val _ = new_theory "BatchedQueue";

open listTheory arithmeticTheory ml_translatorLib;

(* setting up the translator *)

val res = translate listTheory.REV_DEF;
val res = translate listTheory.REVERSE_REV;

(* implementation *)

val _ = Hol_datatype `queue = QUEUE of 'a list => 'a list`;

val empty_def = mlDefine `
  empty = QUEUE [] []`;

val is_empty_def = mlDefine `
  (is_empty (QUEUE [] xs) = T) /\
  (is_empty _ = F)`;

val checkf_def = mlDefine `
  (checkf (QUEUE [] xs) = QUEUE (REVERSE xs) []) /\
  (checkf q = q)`;

val snoc_def = mlDefine `
  snoc (QUEUE f r) x = checkf (QUEUE f (x::r))`;

val head_def = mlDefine `
  head (QUEUE (x::f) r) = x`;

val tail_def = mlDefine `
  tail (QUEUE (x::f) r) = checkf (QUEUE f r)`;

(* verification proof *)

val queue_inv_def = Define `
  queue_inv q (QUEUE xs ys) = (q = xs ++ REVERSE ys) /\ ((xs = []) ==> (ys = []))`;

val empty_thm = prove(
  ``!xs. queue_inv xs empty = (xs = [])``,
  EVAL_TAC THEN SIMP_TAC std_ss []);

val is_empty_thm = prove(
  ``!q xs. queue_inv xs q ==> (is_empty q = (xs = []))``,
  Cases THEN Cases_on `l` THEN EVAL_TAC THEN SRW_TAC [] []
  THEN FULL_SIMP_TAC std_ss [REVERSE_DEF]);

val snoc_thm = prove(
  ``!q xs x. queue_inv xs q ==> queue_inv (xs ++ [x]) (snoc q x)``,
  Cases THEN Cases_on `l` THEN EVAL_TAC THEN SRW_TAC [] []);

val head_thm = prove(
  ``!q x xs. queue_inv (x::xs) q ==> (head q = x)``,
  Cases THEN Cases_on `l` THEN EVAL_TAC THEN SRW_TAC [] []
  THEN FULL_SIMP_TAC (srw_ss()) [REVERSE_DEF]);

val tail_thm = prove(
  ``!q x xs. queue_inv (x::xs) q ==> queue_inv xs (tail q)``,
  Cases THEN Cases_on `l` THEN EVAL_TAC THEN SRW_TAC [] []
  THEN TRY (Cases_on `t`) THEN EVAL_TAC
  THEN FULL_SIMP_TAC (srw_ss()) [REVERSE_DEF]);

val _ = export_theory();