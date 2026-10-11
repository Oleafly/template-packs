#!/bin/bash

# Konwertuj pliki 'odg' z folderu 'obrazki' do formatu 'pdf'
libreoffice --convert-to pdf obrazki/*.odg --outdir obrazki

# Uruchom kompilacje dokumentu i zapisz wyniki do pliku 'main.pdf'
typst compile main.typ
