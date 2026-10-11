




// Afbildningsmatrice (transformation matrix) helper
// Returns math content that can be embedded in equations
#let amat(content, left, right) = math.attach(math.mat(content, delim:"["), bl: left, br: right)

#let scalar(x,y) = $lr(chevron.l #x, #y chevron.r)$

#let par = math.partial


#let jacobi(n, m, f: $f$, x: $x$) = {
  let rows = ()
  for i in range(1, n + 1) {
    let cols = ()
    for j in range(1, m + 1) {
      cols.push($(par #f _(#i))/(par #x _(#j))$)
    }
    rows.push(cols)
  }
  
  math.mat(..rows)
}
