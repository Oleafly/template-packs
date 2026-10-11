% Utwórz nowy wykres (jesli uruchomiono z terminala -- ukryj go)
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

% Ustaw rozmiar rysunku i marginesy (dla przykładu 16x7.5 cm)
set(h, "paperunits", "centimeters")
set(h, "papersize", [16 7.5])
set(h, "paperposition", [0, 0, [16 7.5]])
set(h, "defaultaxesposition", [0.095, 0.185, 0.870, 0.790])

% Ustaw parametry czcionki, spójne ze stylem dokumentu
set(h, "defaulttextfontsize", 11)
set(h, "defaultaxesfontsize", 11)
set(h, "defaulttextfontname", "Latin Modern Roman")
set(h, "defaultaxesfontname", "Latin Modern Roman")
set(h, "defaulttextcolor", "black")

% Przygotuj przykładowe dane do narysowania wykresu
x = 0 : 0.1 : 1;                 % Wygeneruj wartośći X
y = 1.55 * x + 3.05;             % Wygeneruj wartości Y
y = y + 0.35*rand(1, length(y)); % Dodaj trochę szumu na pokaz
p = polyfit(x, y, 1);            % Wykonaj dopasowanie
f = x*p(1) + p(2);               % Wyznacz wartości

plot(x, y, "x;Dane;", x, f, "-;Dopasowanie;"); % Rysuj wykres
ylabel("Napięcie na wyjściu, mV");             % Opis osi Y
xlabel("Temperatura otoczenia, °C");           % Opis osi X
legend('location', 'southeast');               % Pozycja legendy
xlim([0 1]);                                   % Zakres osi X
ylim([3 5]);                                   % Zakres osi Y
grid on;                                       % Załącz siatkę
box on;                                        % Załącz obwódkę

set_format(gca, 'XY', true);                   % Ustaw format osi

print("../obrazki/plot_demo.svg");             % Zapisz wykres
