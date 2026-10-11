= Velké obrázky a tabulky <Appendix1>
#figure(
  image("../figures/fig_C.svg", width: 80%),
  caption: [Fraktál],
) <TSquareFractal>

#align(center)[
  #rotate(
    90deg,
    reflow: true,
    [
    #figure(
      table(
        columns: 6,
        align: (right, right, right, left, center, left),
        table.hline(),
        [Vpravo], [Vpravo], [Vpravo], [Vlevo], [Na střed], [Do bloku],
        table.hline(),
        [-7576], [-2092], [5418], [nulla pulvinar], [a], [Donec ipsum massa, ullamcorper in, auctor et, scelerisque sed.],
        [-397], [4340], [8617], [eleifend sem um sociis], [aa], [Fusce aliquam vestibulum ipsum, cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est.],
        [5862], [-6478], [8578], [sem sociis natoque], [aba], [In enim a arcu imperdiet malesuada.],
        [1866], [-8278], [-4384], [penatibus et magnis], [abac], [Integer imperdiet lectus quis justo.],
        [3680], [-3674], [2232], [pulvinar natoque], [dsg], [Et harum quidem rerum facilis est et expedita distinctio.],
        [586], [805], [-7404], [sem et magnis], [abc], [Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.],
        [1388], [8761], [-8929], [sem odio bibendum], [tsi], [Phasellus faucibus molestie nisl.],
        [7361], [-5446], [2361], [mauris vehicula lacinia], [mpi], [In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero.],
        [-7901], [-4274], [5595], [vulputate nec], [tdi], [Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.],
        [-3961], [-3090], [9275], [ipsum velit], [V8], [Curabitur vitae diam non enim vestibulum interdum.],
        table.hline(),
      ),
      caption: [Ukázka velké tabulky s různě zarovnanými sloupci],
    ) <Sidewaystable> ], 
  )
]

#rotate(-90deg, reflow: true)[  
  #figure(
    image("../figures/coffe_and_computer.jpg", width: 95%),
    caption: [Káva a počítač @AhDTEmY2CY7Qv65e],
  )<CoffeAndComputerInAppendix>
]