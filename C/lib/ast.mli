type name = string

type types =
  | TVoid
  | TChar
  | TInt8
  | TInt16
  | TInt32
  | TInt
  | TFloat
  | TDouble
  | TPointer of types
[@@deriving show { with_path = false }]

type values =
  | VInt of Int32.t
  | VChar of char
  | VFloat of float
  | VDouble of float
  | VString of string
[@@deriving show { with_path = false }]

type expressions =
  | Pointer of expressions  (** var* *)
  | Address of expressions  (** &var *)
  | Add of expressions * expressions  (** a + b *)
  | Sub of expressions * expressions  (** a - b *)
  | Inc of expressions  (** var++ *)
  | Dec of expressions  (** var-- *)
  | UnaryMin of expressions  (** -(expr) or -var *)
  | UnaryPlus of expressions  (** +(expr) or +var *)
  | Mul of expressions * expressions  (** a * b *)
  | Div of expressions * expressions  (** a / b *)
  | Mod of expressions * expressions  (** a % b *)
  | And of expressions * expressions  (** a && b *)
  | Or of expressions * expressions  (** a || b *)
  | Equal of expressions * expressions  (** a == b *)
  | NotEqual of expressions * expressions  (** a != b *)
  | Less of expressions * expressions  (** a < b *)
  | LessOrEq of expressions * expressions  (** a <= b *)
  | More of expressions * expressions  (** a > b *)
  | MoreOrEq of expressions * expressions  (** a >= b *)
  | Assign of expressions * expressions  (** a = b *)
  | Define of types * expressions * expressions option  (** type var (= expr) *)
  | DefineSeq of expressions list  (** type a, b = expr, c; *)
  | FuncCall of name * expressions list  (** Function (a, b, c) *)
  | Cast of types * expressions  (** (type)(expr) *)
  | Variable of name  (** var *)
  | Value of values  (** value (const) *)
  | Array of types * name * expressions option * expressions list option
      (** type arr = {expr1, expr2, expr3} *)
  | ArrayElem of name * expressions  (** arr[index] *)
[@@deriving show { with_path = false }]

and statements =
  | Expression of expressions
  | StatementsList of statements list
      (** list of statements in {} splitted by ";" or by other statement *)
  | If of expressions * statements  (** if (condition) {statements list} *)
  | IfSeq of statements list * statements option
      (** if {...} else if {...} else {...} in list *)
  | While of expressions * statements  (** while (condition) {...} *)
  | For of
      expressions option * expressions option * expressions option * statements
      (** for (initial expr; condition; loop expr) {...} *)
  | Break  (** break; *)
  | Continue  (** continue; *)
  | Return of expressions  (** return expr; *)
  | FunctionDef of types * name * (types * name) list * statements option
      (** type funcname(type arg1, type arg2 ...) {...} *)
  | FuncSeq of statements list  (** list of function defs *)
[@@deriving show { with_path = false }]
