structure arm_decompLib :> arm_decompLib =
struct

open HolKernel Parse boolLib bossLib;
open helperLib set_sepTheory addressTheory progTheory;
open pred_setTheory combinTheory;
open arm_decompTheory decompilerLib;

val ERR = Feedback.mk_HOL_ERR "arm_decompLib"

(* automation *)

local
   fun w_var i = Term.mk_var ("w" ^ Int.toString i, ``:word32``)
   fun word32 w = wordsSyntax.mk_wordi (Arbnum.fromHexString w, 32)
   val ok_rule = PURE_ONCE_REWRITE_RULE [GSYM arm_OK_def]
   val sbst =
      [``vfp:bool`` |-> boolSyntax.T, ``arch:Architecture`` |-> ``ARMv7_A``]
   fun arm_OK_intro l = ok_rule o Thm.INST (l @ sbst)
   fun format_thm th =
      (th, 4,
       stateLib.get_pc_delta
          (Lib.equal "arm_prog$arm_PC" o fst o boolSyntax.dest_strip_comb) th)
in
   val set_opt = arm_progLib.arm_config "vfp"
   fun l3_arm_triples hex =
      case String.tokens (fn c => c = #" ") hex of
         h :: r =>
           let
              val ws = List.tabulate (List.length r, w_var)
              val l =
                List.map (fn (v, hx) => v |-> word32 hx) (ListPair.zip (ws, r))
           in
              List.map (arm_OK_intro l)
                 (stateLib.fix_precond (arm_progLib.arm_spec_hex h))
           end
       | _ => raise ERR "l3_arm_triples" "empty string"
   fun l3_arm_spec hex =
      case List.map format_thm (l3_arm_triples hex) of
         [x] => (x, NONE)
       | [x1, x2] => (x1, SOME x2)
       | _ => raise ERR "l3_arm_spec" ""
   fun l3_arm_spec_opt s hex = (set_opt s; l3_arm_spec hex)
end

val arm_pc = Term.prim_mk_const {Thy = "arm_prog", Name = "arm_PC"}

fun arm_tools f hide = (f, fn _ => fail(), hide, arm_pc): decompiler_tools
fun arm_tools_opt opt = arm_tools (l3_arm_spec_opt opt)

val l3_arm_tools = arm_tools l3_arm_spec arm_progTheory.aS_HIDE
val l3_arm_tools_no_status = arm_tools l3_arm_spec TRUTH

val l3_arm_tools_array = arm_tools_opt "array" arm_progTheory.aS_HIDE
val l3_arm_tools_array_no_status = arm_tools_opt "array" TRUTH
val l3_arm_tools_mapped = arm_tools_opt "mapped" arm_progTheory.aS_HIDE
val l3_arm_tools_mapped_no_status = arm_tools_opt "mapped" TRUTH
val l3_arm_tools_mapped32 = arm_tools_opt "mapped32" arm_progTheory.aS_HIDE
val l3_arm_tools_mapped32_no_status = arm_tools_opt "mapped32" TRUTH

fun arm_decompile opt f =
   fn name => fn qcode =>
      ( set_opt opt
      ; arm_progLib.set_newline ""
      ; (UNABBREV_CODE_RULE ## I) (decompile f name qcode)
      )

val l3_arm_decompile = arm_decompile "mapped" l3_arm_tools
val l3_arm_decompile_no_status = arm_decompile  "mapped" l3_arm_tools_no_status

val l3_arm_decompile32 = arm_decompile "mapped32" l3_arm_tools
val l3_arm_decompile32_no_status =
   arm_decompile  "mapped32" l3_arm_tools_no_status

(* testing

open rel_decompilerLib

val hex = "B0821003"
val hex = "07921003"

val l3_arm_spec = Count.apply l3_arm_spec

  l3_arm_spec "07921003";
  l3_arm_spec "17921003";
  l3_arm_spec "27921003";
  l3_arm_spec "37921003";
  l3_arm_spec "47921003";
  l3_arm_spec "57921003";
  l3_arm_spec "67921003";
  l3_arm_spec "77921003";
  l3_arm_spec "87921003";
  l3_arm_spec "97921003";
  l3_arm_spec "A7921003";
  l3_arm_spec "B7921003";
  l3_arm_spec "C7921003";
  l3_arm_spec "D7921003";
  l3_arm_spec "E7921003";

fast_decompile "test" `e59f322c  00012f94`

*)

end