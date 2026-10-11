= Technické detaily
== Křížové odkazy
Odborné texty, mezi které lze počítat i bakalářské, diplomové a disertační práce, obvykle obsahují množství křížových odkazů odkazující na nejrůznější části textu:

/ kapitoly: -- například odkaz na @Uherske[kapitolu]. Pokud odkazujeme na kapitolu, která je značně vzdálená od současné stránky, bývá dobrým zvykem k odkazu na číslo kapitoly přidat ještě i odpovídající číslo stránky, jako například pokud odkazujeme na @Introduction[kapitolu] na straně #ref(<Introduction>, form: "page").
	
/ obrázky: -- například odkaz na @WritingThesis[obrázky], @CoffeAndComputerInAppendix[] a @TSquareFractal[]. Menší, vzájemně související obrázky můžeme sdružit do jednoho obrázku a odkazuvat se buď na menší obrázky, například @Subfig1 a @Subfig2, nebo na celkový obrázek, spíše řekněme, ilustraci @TopLevelFigureLabel[].
	
/ tabulky: -- například odkaz na tabulky @ExpResults[] a @Sidewaystable[]. Podobně jako u obrázků můžeme menší tabulky @Subtable1[] a @Subtable2[] sdružit do jedné společné a odkazovat se na obě menší tabulky jednotně, jako například na tabulku @TopLevelTableLabel[].
	
/ rovnice: -- odkazy na rovnice se obvykle uzavírají do kulatách závorek, jako například v odkazech na rovnice @eq:G[], @eq:H[] nebo @eq:I[].
	
/ výpisy zdrojového kódu: -- například odkaz na @CppListing[výpis]. @PythonListing[Výpis] je ukázkou výpisu v jiném programovacím jazyce, v tomto případě v jazyce Python, než je výchozí jazyk C++. Samozřejmě se lze odkazovat i na velmi dlouhé výpisy, jako například @CppExternal[výpis] na straně #ref(<CppExternal>, form: "page") v~@Appendix1[příloze], který je načítán z externího souboru.



== Odkaz v textu
Pro odkazy v textu používáme číselné označení citací dokumentů ohraničené hranatými závorkami. Takže například můžeme citovat časopisecké _články_ @herrmann @bertram @moore @yoon @sigfridsson #cite(label("baez/article")), _knihy_ @wilde #cite(<nietzsche:ksa1>) #cite(label("averroes/bland")) @hammond @cotton @knuth:ct:a @gerhardt @gonzalez @companion, _periodika_ @jcg, _bakalářské, diplomové či diserteční práce_ @geer, _patenty_ @kowalik @almendro @sorace @laufenberg, _online zdroje_ @ctan @wassenberg @itzhaki @markey, #cite(label("baez/online")) či _manuály_ @cms.
