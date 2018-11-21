(* riscvLib - generated by L3 - Wed Nov 21 20:26:09 2018 *)
structure riscvLib :> riscvLib =
struct
open HolKernel boolLib bossLib
open utilsLib riscvTheory
val () = (numLib.prefer_num (); wordsLib.prefer_word ())
fun riscv_compset thms =
   utilsLib.theory_compset (thms, riscvTheory.inventory)
end