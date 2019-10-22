signature termSyntax =
sig

  include Abbrev

  val oterm_ty : hol_type

  val VAR_t : term
  val mk_VAR : term -> term
  val dest_VAR : term -> term
  val is_VAR : term -> bool

  val APP_t : term
  val mk_APP : term * term -> term
  val dest_APP : term -> term * term
  val is_APP : term -> bool

  val LAM_t : term
  val mk_LAM : term * term -> term
  val dest_LAM : term -> term * term
  val is_LAM : term -> bool

  val ORC_t : term

  val SUB_t : term
  val mk_SUB : term * term * term -> term
  val dest_SUB : term -> term * term * term
  val is_SUB : term -> bool

end
