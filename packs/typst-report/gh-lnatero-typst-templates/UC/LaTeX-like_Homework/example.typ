#import "latex-hm-template.typ": *

#show: project.with(
  title: "Informe Tarea XX",
  authors: (
    (name: "Juanito Perez", email: "juanito@perez.cl"),
  ),
  faculty: "Escuela de Ingeniería",
  department: "Departamento de Ingeniería Eléctrica",
  course: (name: "Aprendizaje Reforzado Para Control de Sistemas Dinámicos", code: "IEE3615"),
  semester: "2026-1",
  date: "14 de Abril del 2026",
)


= Idea principal de la pregunta
Como $cal(S) " "cal(A)$ es demostrado en @ddpg
#figure(
  image("assets/imagenes/img1.jpeg", width: 50%),
  caption: [Imagen de Ejemplo 1],
)
#pagebreak()
= Idea principal de la pregunta

#figure(
  image("assets/imagenes/img2.jpg", width: 50%),
  caption: [Imagen de Ejemplo 2],
)


#figure(
  ```python
  from BEAR.Env.env_building  import BuildingEnvReal
  from BEAR.Utils.utils_building import ParameterGenerator,get_user_input

  beta = 0.999
  setpoint = 22

  Parameter=ParameterGenerator('OfficeSmall','Hot_Dry','Tucson')
  env = BuildingEnvReal(Parameter)
  env.target = np.array([setpoint]*env.roomnum)
  env.q_rate = (1 - beta)
  env.error_rate = beta
  print(env.roomnum) # Numero de habitaciones en el edificio
  numofhours=24*5 # Duracion de la simulacion en horas
  env.reset()
  out_temp = []
  for i in range(numofhours):
      a = env.action_space.sample() #Reemplazar por su controlador
      obs, r, terminated, truncated, _ = env.step(a)
  ```,
  caption: [Ejemplo de Código],
  supplement: "Código",
)

#pagebreak()



#algorithm(title: "Ejemplo Pseudocódigo")[
  + Initialize replay memory $D$ to capacity $N$
  + Initialize action-value function $Q$ with random weights
  + Initialize target action-value function $hat(Q)$ with weights $theta^(-) = theta$
  + #strong[For episode] = 1, M #strong[do]
    + Initialize sequence $s_1 = { x_1 }$.
    + #strong[For] $t = 1\,T$ #strong[do]
      + With probability $epsilon$ select a random action $a_t$ otherwise select $a_t = arg max + Q\(s\,a\;theta\)$
      + Execute action $a_t$ in environment and observe reward $r_t$ and state $s_(t + 1)$
      + Store transition $\(s_t\,a_t\,r_t\,s_(t + 1)\)$ in $D$
      + Sample random minibatch of transitions $\(s_j\,a_j\,r_j\,s_(j + 1)\)$ from $D$
      + #strong[If] episode terminates at step $j + 1$
        + $y_j = r_j$
      + #strong[else]
        + $y_j = r_j + gamma max_a Q\(s_(j + 1)\,a\;theta^(-)\)$
      + #strong[End If]
      + Perform a gradient descent step on $#scale(x: 120%, y: 120%)[\(] y_j - Q\(s_j\,a_j\;theta\)#scale(x: 120%, y: 120%)[\)]^2$
      + Every $C$ steps reset $hat(Q) = Q$
    + #strong[End For]
  + #strong[End For]
]

#figure(
  table(
    columns: 3,
    table.header([Encabezado 1], [Encabezado 2], [Encabezado 3]),
    [0], [0], [0],
    [0], [0], [0],
    [0], [0], [0],
    [0], [0], [0],
  ),
  caption: [Ejemplo Tabla],
)


#bibliography("assets/referencias.bib", style: "ieee")
