#import "../template/lib.typ": LaTeX

= Sklicevanje na besedilne konstrukte <ch:sklicevanje>

Matematična ali popolna indukcija je eno prvih orodij, ki jih spoznamo za dokazovanje trditev pri matematičnih predmetih.

#block(inset: (y: 0.5em))[
  *Izrek 2.1.* _Za vsako naravno število $n$ velja_
  $ n < 2^n. $ <eq:1>
]

#block(inset: (y: 0.5em))[
   _Dokaz._ Dokazovanje z indukcijo zahteva, da neenakost~@eq:1 najprej preverimo za najmanjše naravno število --- $0$. Res, ker je $0 < 1 = 2^0$, je neenačba~@eq:1 za $n = 0$ izpolnjena.

   Sledi indukcijski korak. S predpostavko, da je neenakost~@eq:1 veljavna pri nekem naravnem številu $n$, je potrebno pokazati, da je ista neenakost v veljavi tudi pri njegovem nasledniku --- naravnem številu $n + 1$. Izračun zapišemo s tremi vrsticami, ki jih končamo s piko, saj so del tega stavka:
      $ n + 1 &< 2^n + 1, $ <eq:2a>

      $ &<= 2^n + 2^n, $ <eq:2b>

      $ &= 2^(n+1). $ <eq:2c>
    Neenakost~@eq:2a v prvi vrstici je posledica indukcijske predpostavke, neenakost v drugi vrstici pa enostavno dejstvo, da je za vsako naravno število $n$ izraz $2^n$ vsaj tako velik kot 1. S tem je dokaz Izreka 2.1 zaključen. #h(1fr) $square$
]

Opazimo, da je #LaTeX številko izreka podredil številki poglavja.
