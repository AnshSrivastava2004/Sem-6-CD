# Sem-6-CD

## Grammar for subset of Go:  
Program   → "package" "main" FuncDecl  
FuncDecl  → "func" "main" "(" ")" Block  
Block     → "{" StmtList "}"  
StmtList  → Stmt StmtList | ε  
Stmt      → VarDecl ";" | Assign ";" | PrintStmt ";" | IfStmt | ForStmt  
VarDecl   → "var" id Type "=" Expr  
Type      → "int" | "float64" | "string"  
Assign    → id "=" Expr  
PrintStmt → "print" "(" Expr ")"  
IfStmt    → "if" Expr Block ElsePart  
ElsePart  → "else" Block | ε  
ForStmt   → "for" Expr Block  
Expr      → Expr AddOp Term | Term  
Term      → Term MulOp Factor | Factor  
Factor    → "(" Expr ")" | NUMBER | FLOAT | STRING | id  
AddOp     → "+" | "-"  
MulOp     → "*" | "/"
