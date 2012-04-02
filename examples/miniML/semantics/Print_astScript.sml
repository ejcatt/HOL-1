(* generated by Lem from print_ast.lem *)
open bossLib Theory Parse res_quanTheory
open finite_mapTheory listTheory pairTheory pred_setTheory integerTheory
open set_relationTheory sortingTheory stringTheory wordsTheory

val _ = new_theory "Print_ast"

open MiniMLTheory

(*open MiniML*)

(*val Num : Int.int -> num*)

(*val CHR : num -> string*)

(*val string_first : string -> string*)

(*val string_last : string -> string*)

(*val (%) : num -> num -> num*)

val _ = Hol_datatype `
 token =
    NewlineT
  | WhitespaceT of num
  | IntlitT of int
  | IdentT of string
  | TvT of string

  | AndT | AndalsoT | CaseT | DatatypeT | ElseT | EndT | FnT | FunT | IfT 
  | InT | LetT | OfT | OpT | OrelseT | RecT | ThenT | ValT | Open_parenT
  | Close_parenT | CommaT | SemiT | BarT | EqT | EqarrowT | MinusarrowT | StarT

(* OCaml additions *)
  | MatchT | TypeT | WithT | AmpampT | BarbarT | SemisemiT`;


 val num_to_string_defn = Hol_defn "num_to_string" `
 (num_to_string n =
  if n > 0 then STRCAT 
    (num_to_string (n DIV 10))  (STRING (CHR  (n MOD 10 + 48)) "")
  else
    "")`;

val _ = Defn.save_defn num_to_string_defn;

(*val int_to_string : bool -> Int.int -> string*)
val _ = Define `
 (int_to_string sml n =
  if n = & 0 then
    "0"
  else if int_gt n (& 0) then
    num_to_string (Num n)
  else STRCAT 
    (if sml then "~" else "-")  (num_to_string (Num ((int_sub) (& 0) n))))`;


(*val spaces : num -> string*)
 val spaces_defn = Hol_defn "spaces" `
 
(spaces n =
  if (n:num) = 0 then
    ""
  else STRCAT 
    " "  (spaces (n - 1)))`;

val _ = Defn.save_defn spaces_defn;

val _ = Define `
 (space_append s1 s2 =
  if s2 = "" then
    s1
  else 
    let f = STRING (SUB ( s2,0)) "" in
      if (f = ")")  \/ (f = " ") \/ (f = ",") then STRCAT 
    s1  s2
  else STRCAT 
    s1 (STRCAT   " "  s2))`;


 val tok_to_string_defn = Hol_defn "tok_to_string" `

(tok_to_string sml NewlineT s = STRCAT  "\n"  s)
/\
(tok_to_string sml (WhitespaceT n) s = STRCAT  (spaces n)  s)
/\
(tok_to_string sml (IntlitT i) s = space_append (int_to_string sml i) s)
/\
(tok_to_string sml (IdentT id) s = space_append id s)
/\
(tok_to_string sml (TvT tv) s = space_append ( STRCAT "'"  tv) s)
/\
(tok_to_string sml AndT s = STRCAT  "and "  s)
/\
(tok_to_string sml AndalsoT s = STRCAT  "andalso "  s)
/\
(tok_to_string sml CaseT s = STRCAT  "case "  s)
/\
(tok_to_string sml DatatypeT s = STRCAT  "datatype "  s)
/\
(tok_to_string sml ElseT s = STRCAT  "else "  s)
/\
(tok_to_string sml EndT s = STRCAT  "end "  s)
/\
(tok_to_string sml FnT s = STRCAT  "fn "  s)
/\
(tok_to_string sml FunT s = STRCAT  "fun "  s)
/\
(tok_to_string sml IfT s = STRCAT  "if "  s)
/\
(tok_to_string sml InT s = STRCAT  "in "  s)
/\
(tok_to_string sml LetT s = STRCAT  "let "  s)
/\
(tok_to_string sml OfT s = STRCAT  "of "  s)
/\
(tok_to_string sml OpT s = STRCAT  "op "  s)
/\
(tok_to_string sml OrelseT s = STRCAT  "orelse "  s)
/\
(tok_to_string sml RecT s = STRCAT  "rec "  s)
/\
(tok_to_string sml ThenT s = STRCAT  "then "  s)
/\
(tok_to_string sml ValT s = STRCAT  "val "  s)
/\
(tok_to_string sml Open_parenT s = 
  if s = "" then
    "("
  else if STRING (SUB ( s,0)) "" = "*" then STRCAT 
    "( "  s
  else STRCAT 
    "("  s)
/\
(tok_to_string sml Close_parenT s = STRCAT  ")"  s)
/\
(tok_to_string sml CommaT s = STRCAT  ", "  s)
/\
(tok_to_string sml SemiT s = STRCAT  ";"  s)
/\
(tok_to_string sml BarT s = STRCAT  "| "  s)
/\
(tok_to_string sml EqT s = STRCAT  "= "  s)
/\
(tok_to_string sml EqarrowT s = STRCAT  "=> "  s)
/\
(tok_to_string sml MinusarrowT s = STRCAT  "-> "  s)
/\
(tok_to_string sml StarT s = STRCAT  "* "  s)
/\
(tok_to_string sml MatchT s = STRCAT  "match "  s)
/\
(tok_to_string sml TypeT s = STRCAT  "type "  s)
/\
(tok_to_string sml WithT s = STRCAT  "with "  s)
/\
(tok_to_string sml AmpampT s = STRCAT  "&& "  s)
/\
(tok_to_string sml BarbarT s = STRCAT  "|| "  s)
/\
(tok_to_string sml SemisemiT s = STRCAT  ";;"  s)`;

val _ = Defn.save_defn tok_to_string_defn;

 val tok_list_to_string_defn = Hol_defn "tok_list_to_string" `
 
(tok_list_to_string sml [] = "")
/\
(tok_list_to_string sml (t::l) = 
  tok_to_string sml t (tok_list_to_string sml l))`;

val _ = Defn.save_defn tok_list_to_string_defn;

(*type 'a tree = L of 'a | N of 'a tree * 'a tree*)
val _ = Hol_datatype `
 tok_tree = L of token | N of tok_tree => tok_tree`;


(*val (^^) : forall 'a. 'a tree -> 'a tree -> 'a tree*)
(*val (^^) : tok_tree -> tok_tree -> tok_tree*)

(*val tree_to_list : forall 'a. 'a tree -> 'a list -> 'a list*)
(*val tree_to_list : tok_tree -> token list -> token list*)
 val tree_to_list_defn = Hol_defn "tree_to_list" `

(tree_to_list (L x) acc = x::acc)
/\
(tree_to_list (N x1 x2) acc = tree_to_list x1 (tree_to_list x2 acc))`;

val _ = Defn.save_defn tree_to_list_defn;

(* Should include "^", but I don't know how to get that into HOL, since
 * antiquote seem stronger than strings. *)
val _ = Define `
 sml_infixes = 
  ["mod"; "<>"; ">="; "<="; ":="; "::"; "before"; "div"; "o"; "@"; ">";
   "="; "<"; "/"; "-"; "+"; "*"]`;


val _ = Define `
 ocaml_infixes = ["="; "+"; "-"; "*"; "/"; "mod"; "<"; ">"; "<="; ">="]`;


(*val join_trees : forall 'a. 'a tree -> 'a tree list -> 'a tree*)
(*val join_trees : tok_tree -> tok_tree list -> tok_tree*)
 val join_trees_defn = Hol_defn "join_trees" `

(join_trees sep [x] = x)
/\
(join_trees sep (x::y::l) = N 
  x (N   sep  (join_trees sep (y::l))))`;

val _ = Defn.save_defn join_trees_defn;

 val lit_to_tok_tree_defn = Hol_defn "lit_to_tok_tree" `

(lit_to_tok_tree sml (Bool T) = L (IdentT "true"))
/\
(lit_to_tok_tree sml (Bool F) = L (IdentT "false"))
/\
(lit_to_tok_tree sml (IntLit n) = L (IntlitT n))`;

val _ = Defn.save_defn lit_to_tok_tree_defn;

val _ = Define `
 (pad_start v =
  if STRING (SUB ( v,0)) "" = "*" then STRCAT 
    " "  v
  else
    v)`;


val _ = Define `
 (pad_end v =
  if STRING (SUB ( v,STRLEN  v - 1)) "" = "*" then STRCAT 
    v  " "
  else
    v)`;


val _ = Define `
 (var_to_tok_tree sml v =
  if sml /\ MEM v sml_infixes then N 
    (L OpT)  (L (IdentT v))
  else if ~ sml /\ MEM v ocaml_infixes then N 
    (L Open_parenT) (N   (L (IdentT v))  (L Close_parenT))
  else
    L (IdentT v))`;


 val pat_to_tok_tree_defn = Hol_defn "pat_to_tok_tree" `

(pat_to_tok_tree sml (Pvar v) = var_to_tok_tree sml v)
/\
(pat_to_tok_tree sml (Plit l) = lit_to_tok_tree sml l)
/\
(pat_to_tok_tree sml (Pcon c []) = var_to_tok_tree sml c)
/\
(pat_to_tok_tree sml (Pcon c ps) = N 
  (L Open_parenT) (N   (var_to_tok_tree sml c) (N   
    (L Open_parenT) (N   (join_trees (L CommaT) (MAP (pat_to_tok_tree sml) ps)) (N  
    (L Close_parenT)  (L Close_parenT))))))`;

val _ = Defn.save_defn pat_to_tok_tree_defn;

val _ = Define `
 (inc_indent i = 
  if (i:num) < 30 then
    i + 2
  else
    i)`;


val _ = Define `
 (newline indent = N  
  (L NewlineT)  (L (WhitespaceT indent)))`;


 val exp_to_tok_tree_defn = Hol_defn "exp_to_tok_tree" `

(exp_to_tok_tree sml indent (Raise r) =
  if sml then N 
    (L Open_parenT) (N   (L (IdentT "raise")) (N   (L (IdentT "Bind"))  (L Close_parenT)))
  else N 
    (L Open_parenT) (N   (L (IdentT "raise")) (N   
      (L Open_parenT) (N   (L (IdentT "Match_failure")) (N   
        (L Open_parenT) (N   (L (IdentT "string_of_bool")) (N   (L (IdentT "true")) (N   
        (L CommaT) (N  
        (L (IntlitT (& 0))) (N   (L CommaT) (N   (L (IntlitT (& 0))) (N   (L Close_parenT) (N  
      (L Close_parenT) 
    (L Close_parenT))))))))))))))
/\
(exp_to_tok_tree sml indent (Val (Lit l)) =
  lit_to_tok_tree sml l)
/\
(exp_to_tok_tree sml indent (Con c []) =
  var_to_tok_tree sml c)
/\
(exp_to_tok_tree sml indent (Con c es) = N 
  (L Open_parenT) (N  
  (var_to_tok_tree sml c) (N   
  (L Open_parenT) (N  
  (join_trees (L CommaT) (MAP (exp_to_tok_tree sml indent) es)) (N   
  (L Close_parenT)  (L Close_parenT))))))
/\
(exp_to_tok_tree sml indent (Var v) =
  var_to_tok_tree sml v)
/\
(exp_to_tok_tree sml indent (Fun v e) = N 
  (newline indent) (N  
  (L Open_parenT) (N  
  (if sml then L FnT else L FunT) (N  
  (var_to_tok_tree sml v) (N   
  (if sml then L EqarrowT else L MinusarrowT) (N   
  (exp_to_tok_tree sml (inc_indent indent) e)  
  (L Close_parenT)))))))
/\
(exp_to_tok_tree sml indent (App Opapp e1 e2) = N 
  (L Open_parenT) (N  
  (exp_to_tok_tree sml indent e1) (N   
  (exp_to_tok_tree sml indent e2)  
  (L Close_parenT))))
/\
(exp_to_tok_tree sml indent (App Equality e1 e2) = N 
  (L Open_parenT) (N  
  (exp_to_tok_tree sml indent e1) (N   
  (L EqT) (N   
  (exp_to_tok_tree sml indent e2)  
  (L Close_parenT)))))
/\
(exp_to_tok_tree sml indent (App (Opn o0) e1 e2) =
  let s = (case o0 of
      Plus => "+"
    | Minus => "-"
    | Times => "*"
    | Divide => if sml then "div" else "/"
    | Modulo => "mod"
  )
  in N 
    (L Open_parenT) (N  
    (exp_to_tok_tree sml indent e1) (N   
    (L (IdentT s)) (N   
    (exp_to_tok_tree sml indent e2)  
    (L Close_parenT)))))
/\
(exp_to_tok_tree sml indent (App (Opb o') e1 e2) =
  let s = (case o' of
      Lt => "<"
    | Gt => ">"
    | Leq => "<="
    | Geq => ">"
  )
  in N 
    (L Open_parenT) (N  
    (exp_to_tok_tree sml indent e1) (N   
    (L (IdentT s)) (N   
    (exp_to_tok_tree sml indent e2)  
    (L Close_parenT)))))
/\
(exp_to_tok_tree sml indent (Log lop e1 e2) = N 
  (L Open_parenT) (N  
  (exp_to_tok_tree sml indent e1) (N   
  (if lop = And then 
     if sml then L AndalsoT else L AmpampT
   else 
     if sml then L OrelseT else L BarbarT) (N  
  (exp_to_tok_tree sml indent e2)  
  (L Close_parenT)))))
/\
(exp_to_tok_tree sml indent (If e1 e2 e3) = N 
  (newline indent) (N  
  (L Open_parenT) (N  
  (L IfT) (N  
  (exp_to_tok_tree sml indent e1) (N   
  (newline indent) (N  
  (L ThenT) (N  
  (exp_to_tok_tree sml (inc_indent indent) e2) (N  
  (newline indent) (N  
  (L ElseT) (N  
  (exp_to_tok_tree sml (inc_indent indent) e3)  
  (L Close_parenT)))))))))))
/\
(exp_to_tok_tree sml indent (Mat e pes) = N 
  (newline indent) (N  
  (L Open_parenT) (N  
  (if sml then L CaseT else L MatchT) (N   
  (exp_to_tok_tree sml indent e) (N   
  (if sml then L OfT else L WithT) (N  
  (newline (inc_indent (inc_indent indent))) (N  
  (join_trees ( N (newline (inc_indent indent))  (L BarT)) 
               (MAP (pat_exp_to_tok_tree sml (inc_indent indent)) pes))  
  (L Close_parenT))))))))
/\
(exp_to_tok_tree sml indent (Let v e1 e2) = N 
  (newline indent) (N  
  (if sml then N  (L LetT)  (L ValT) else N  (L Open_parenT)  (L LetT)) (N   
  (var_to_tok_tree sml v) (N   
  (L EqT) (N  
  (exp_to_tok_tree sml indent e1) (N   
  (newline indent) (N  
  (L InT) (N  
  (exp_to_tok_tree sml (inc_indent indent) e2)  
  (if sml then N  (newline indent)  (L EndT) else L Close_parenT)))))))))
/\
(exp_to_tok_tree sml indent (Letrec funs e) = N 
  (newline indent) (N  
  (if sml then N  (L LetT)  (L FunT) else N  (L Open_parenT)  (L RecT)) (N   
  (join_trees ( N (newline indent)  (L AndT)) 
               (MAP (fun_to_tok_tree sml indent) funs)) (N   
  (newline indent) (N  
  (L InT) (N  
  (exp_to_tok_tree sml indent e)  
  (if sml then N  (newline indent)  (L EndT) else L Close_parenT)))))))
/\
(pat_exp_to_tok_tree sml indent (p,e) = N 
  (pat_to_tok_tree sml p) (N   
  (if sml then L EqarrowT else L MinusarrowT) 
  (exp_to_tok_tree sml (inc_indent (inc_indent indent)) e)))
/\
(fun_to_tok_tree sml indent (v1,v2,e) = N 
  (var_to_tok_tree sml v1) (N  
  (var_to_tok_tree sml v2) (N   
  (L EqT) 
  (exp_to_tok_tree sml (inc_indent indent) e))))`;

val _ = Defn.save_defn exp_to_tok_tree_defn;

 val type_to_tok_tree_defn = Hol_defn "type_to_tok_tree" `

(type_to_tok_tree (Tvar tn) =
  L (TvT tn))
/\
(type_to_tok_tree (Tapp ts tn) =
  if ts = [] then
    L (IdentT tn)
  else N 
    (L Open_parenT) (N  
    (join_trees (L CommaT) (MAP type_to_tok_tree ts)) (N   (L Close_parenT)  
    (L (IdentT tn)))))
/\
(type_to_tok_tree (Tfn t1 t2) = N 
  (L Open_parenT) (N   (type_to_tok_tree t1) (N   (L MinusarrowT) (N   (type_to_tok_tree t2)  
  (L Close_parenT)))))
/\
(type_to_tok_tree Tnum =
  L (IdentT "int"))
/\
(type_to_tok_tree Tbool =
  L (IdentT "bool"))`;

val _ = Defn.save_defn type_to_tok_tree_defn;

val _ = Define `
 (variant_to_tok_tree sml (c,ts) =
  if ts = [] then
    var_to_tok_tree sml c 
  else N 
    (var_to_tok_tree sml c) (N   (L OfT)  
    (join_trees (L StarT) (MAP type_to_tok_tree ts))))`;


(*val typedef_to_tok_tree : bool -> num -> tvarN list * typeN * (conN * t list) list -> token tree*)
(*val typedef_to_tok_tree : bool -> num -> tvarN list * typeN * (conN * t list) list -> tok_tree*)
val _ = Define `
 (typedef_to_tok_tree sml indent (tvs, name, variants) = N 
  (if tvs = [] then 
     L (IdentT name)
   else N  
     (L Open_parenT) (N   
     (join_trees (L CommaT) (MAP (\ tv . L (TvT tv)) tvs)) (N   
     (L Close_parenT) 
     (L (IdentT name))))) (N   
  (L EqT) (N  
  (newline (inc_indent (inc_indent indent))) 
  (join_trees ( N (newline (inc_indent indent))  (L BarT)) 
               (MAP (variant_to_tok_tree sml) variants)))))`;


 val dec_to_tok_tree_defn = Hol_defn "dec_to_tok_tree" `
 
(dec_to_tok_tree sml indent (Dlet p e) = N 
  (if sml then L ValT else L LetT) (N  
  (pat_to_tok_tree sml p) (N   
  (L EqT) (N  
  (exp_to_tok_tree sml (inc_indent indent) e) 
  (if sml then L SemiT else L SemisemiT)))))
/\
(dec_to_tok_tree sml indent (Dletrec funs) = N 
  (if sml then L FunT else N  (L LetT)  (L RecT)) (N   
  (join_trees ( N (newline indent)  (L AndT)) 
             (MAP (fun_to_tok_tree sml indent) funs)) 
  (if sml then L SemiT else L SemisemiT)))
/\
(dec_to_tok_tree sml indent (Dtype types) = N 
  (if sml then L DatatypeT else L TypeT) (N   
  (join_trees ( N (newline indent)  (L AndT)) 
             (MAP (typedef_to_tok_tree sml indent) types)) 
  (if sml then L SemiT else L SemisemiT)))`;

val _ = Defn.save_defn dec_to_tok_tree_defn;

val _ = Define `
 (dec_to_sml_string d = 
  tok_list_to_string T (tree_to_list (dec_to_tok_tree T 0 d) []))`;

val _ = Define `
 (dec_to_ocaml_string d = 
  tok_list_to_string F (tree_to_list (dec_to_tok_tree F 0 d) []))`;

val _ = export_theory()

