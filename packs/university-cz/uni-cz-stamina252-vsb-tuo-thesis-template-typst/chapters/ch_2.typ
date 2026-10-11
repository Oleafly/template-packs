= Obecné

- *Tučný text* \
 Michal Tučný.

- *Kurzivní text* \
  Michal _Kurzivní_.
  
- *Podrtžený text* \
  Michal #underline[Podtržený].

- *Odkaz* \
  #link("https//typst.app")
  
- *Pevná mezera* \
  271~tisíc

- *Přešktnutý text* \
  #strike[6~milionů]
 
- *Pomlčka* \
  -- ffff -?fjsdflsdj
 
- *Výpustka* \
  ...

- *Symbol* \
  #sym.arrow.l
  Všechny symboly i emoji najdete #link("https://typst.app/docs/reference/symbols/")[zde]
  
- *Spodní index* \
  H#sub[2]SO#sub[4]
  
- *Horní index* \
  m#super[2]

- *Poznámka pod čarou* \
  Ukázkový text je standardní výplňový text, nejčastěji ve formě Lorem ipsum#footnote[Pseudolatinský text, který na první pohled vypadá jako skutečný text, ale nemá smysl.].

- *Automatické uvozovky* \
  Vyslechli jsme Beethovenovu "Devátou".
  
- Odrážkový list
  - #lorem(8)
  - #lorem(12)
    - #lorem(3)
      - #lorem(3)
        - #lorem(3)
    - #lorem(3)
  - #lorem(3)


- Číslovaný list:
  + #lorem(8)
  + #lorem(12)
    + #lorem(3)
    + #lorem(3)
      + #lorem(3)
        + #lorem(3)
      + #lorem(3)
    + #lorem(3)
  + #lorem(3)

- Číslovaný list s poloautomatickým číslováním 
  + #lorem(3)
  + #lorem(3)
  145. #lorem(3)
  + #lorem(3)
  12. #lorem(3)
  + #lorem(3)
  3. #lorem(3)
  + #lorem(3)

  
- Obrázky, tabulky, raw
- Figures







  
- *Citování a křížové odkazy* \

  - Citace se neoddělují čárkou – systém je odděluje sám. Při více po sobě jdoucích citacích zobrazí automaticky jen první a poslední, oddělené pomlčkou.
    - #strike[@ctan, @wassenberg, @itzhaki, @markey]
    - @ctan @wilde @itzhaki @markey
    - @ctan @wassenberg @itzhaki @markey
    
  - Pokud název citace obsahuje znaky jako lomítko (které Typst parser považuje za oddělovač a způsobí chybu), nelze použít přímý zápis:
    ```@averroes/bland```. Řešení je zabalit název do ```typst #label()``` takto
    ```typst #cite(label("averroes/bland"))```. 

    Nejlepší řešení je upravit název citace přímo v citačním souboru tak, aby neobsahoval lomítka, mezery ani jiné problematické znaky.

    





    
/*

    
    

- Ukázat matiku, obrázky, a citace, nadpisy, i čísla stránek


 Přidat sem odakzy na utils




 




 Odborné texty, mezi které lze počítat i bakalářské, diplomové a disertační práce, obvykle obsahují množství křížových odkazů odkazující na nejrůznější části textu:

/ kapitoly: -- například odkaz na @Uherske[kapitolu]. Pokud odkazujeme na kapitolu, která je značně vzdálená od současné stránky, bývá dobrým zvykem k odkazu na číslo kapitoly přidat ještě i odpovídající číslo stránky, jako například pokud odkazujeme na @Introduction[kapitolu] na straně #ref(<Introduction>, form: "page").
	
/ obrázky: -- například odkaz na @WritingThesis[obrázky], @CoffeAndComputerInAppendix[] a @TSquareFractal[]. Menší, vzájemně související obrázky můžeme sdružit do jednoho obrázku a odkazuvat se buď na menší obrázky, například @Subfig1 a @Subfig2, nebo na celkový obrázek, spíše řekněme, ilustraci @TopLevelFigureLabel[]
	
/ tabulky: -- například odkaz na tabulky @ExpResults[] a @Sidewaystable[]. Podobně jako u obrázků můžeme menší tabulky @Subtable1[] a @Subtable2[] sdružit do jedné společné a odkazovat se na obě menší tabulky jednotně, jako například na tabulku @TopLevelTableLabel[].
	
/ rovnice: -- odkazy na rovnice se obvykle uzavírají do kulatách závorek, jako například v odkazech na rovnice @eq:G[], @eq:H[] nebo @eq:I[].
	
/ výpisy zdrojového kódu: -- například odkaz na @CppListing[výpis]. @PythonListing[Výpis] je ukázkou výpisu v jiném programovacím jazyce, v tomto případě v jazyce Python, než je výchozí jazyk C++. Samozřejmě se lze odkazovat i na velmi dlouhé výpisy, jako například @CppExternal[výpis] na straně #ref(<CppExternal>, form: "page") v~@Appendix1[příloze], který je načítán z externího souboru.



=== Odkaz v textu
Pro odkazy v textu používáme číselné označení citací dokumentů ohraničené hranatými závorkami. Takže například můžeme citovat časopisecké _články_ @herrmann @bertram @moore @yoon @sigfridsson #cite(label("baez/article")), _knihy_ @wilde @nietzsche:ksa1 #cite(label("averroes/bland")) @hammond @cotton @knuth:ct:a @gerhardt @gonzalez @companion, _periodika_ @jcg, _bakalářské, diplomové či diserteční práce_ @geer, _patenty_ @kowalik @almendro @sorace @laufenberg, _online zdroje_ @ctan @wassenberg @itzhaki @markey, #cite(label("baez/online")) či _manuály_ @cms.

*/





#let zvyraznit(body) = {
  strong(
    upper(
      text(fill: red, body)
    )
  )
}


- *Vlastní funkce* \
  Tato jednoduchá vlastní funkce s názvem zvyraznit má za úkol udělat #zvyraznit[text] velkým červeným tučným písmem:
  #figure(
    
  
  ```typst
  #let zvyraznit(body) = {
    strong(
      upper(
        text(fill: red, body)
      )
    )
  }
  ```,
  caption: [Vlastní ukázková funkce v Typst.app]
  )
  
  Symbol \` se používá k zápisu raw. Na klávesnici QWERTZ se píše pomocí pravý Alt~+~7.
