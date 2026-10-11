// Vector Autoregression (VAR) model
#let eq-var = $ Y_t = c + sum_(i=1)^p A_i Y_(t-i) + epsilon_t $
#let var-eq = eq-var
#let eq-var-expanded = $ Y_t = c + A_1 Y_(t-1) + dots.c + A_p Y_(t-p) + epsilon_t $
#let eq-var-bivariate = $ mat(Y_(1, t); Y_(2, t)) = mat(c_1; c_2) + mat(a_(11), a_(12); a_(21), a_(22)) mat(Y_(1, t-1); Y_(2, t-1)) + mat(epsilon_(1, t); epsilon_(2, t)) $

#eq-var
