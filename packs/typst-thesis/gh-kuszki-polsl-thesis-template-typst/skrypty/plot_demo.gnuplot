# Używaj terminala 'svg' o zadanych parametrach
set terminal svg size 575,350 font "Latin Modern Roman,15"
set output '../obrazki/gnuplot_demo.svg'

# Ustaw parametry wykresu
set xlabel 'Wartości parametru {/:Italic x}'
set ylabel 'Wartości funkcji {/:Italic f}({/:Italic x})'
set xrange [0:20]
set yrange [-1:1]
set key off
set grid

# Przykładowa funkcja do narysowania
f(x) = exp(-0.1*x) * sin(x)

# Rysowanie wskazanej funkcji
plot f(x) title 'Funkcja {/:Italic f}({/:Italic x})' lc 'blue'
