type name = string [@@deriving show { with_path = false }]

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
  | Pointer of expressions
  | Address of expressions
  | Add of expressions * expressions
  | Sub of expressions * expressions
  | Inc of expressions
  | Dec of expressions
  | UnaryMin of expressions
  | UnaryPlus of expressions
  | Mul of expressions * expressions
  | Div of expressions * expressions
  | Mod of expressions * expressions
  | And of expressions * expressions
  | Or of expressions * expressions
  | Equal of expressions * expressions
  | NotEqual of expressions * expressions
  | Less of expressions * expressions
  | LessOrEq of expressions * expressions
  | More of expressions * expressions
  | MoreOrEq of expressions * expressions
  | Assign of expressions * expressions
  | Define of types * expressions * expressions option
  | DefineSeq of expressions list
  | FuncCall of name * expressions list
  | Cast of types * expressions
  | Variable of name
  | Value of values
  | Array of types * name * expressions option * expressions list option
  | ArrayElem of name * expressions
[@@deriving show { with_path = false }]

and statements =
  | Expression of expressions
  | StatementsList of statements list
  | If of expressions * statements
  | IfSeq of statements list * statements option
  | While of expressions * statements
  | For of
      expressions option * expressions option * expressions option * statements
  | Break
  | Continue
  | Return of expressions
  | FunctionDef of types * name * (types * name) list * statements option
  | FuncSeq of statements list
[@@deriving show { with_path = false }]
