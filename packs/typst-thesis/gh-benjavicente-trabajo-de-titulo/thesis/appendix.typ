
= Terminología inmobiliaria

/ Programa: Normalmente, se refiere a la combinación de dormitorios y baños que posee una vivienda. Por ejemplo, un programa de 3D+2B se refiere a una vivienda con tres dormitorios y dos baños. Hay casos especiales que no siguen esta regla, por ejemplo, el programa STUDIO, que se consideran distinto a 1D+1B dado que no tiene un espacio dedicado a dormitorio.

/ Modelo: Una variante de un programa, es decir, una agrupación de unidades que se venden bajo el mismo plano de planta. Por ejemplo, un modelo de 3D+2B puede tener modelo A y B, donde el A tiene los 3 dormitorios juntos, mientras que le B tiene dormitorio de visita separado. Se suele llamar también como tipología.

/ Bienes primarios y secundarios: Separación realizada en proyectos inmobiliarios donde se busca que los bienes secundarios se vendan asociados a los primarios. Estacionamiento y bodegas suelen ser bienes secundarios, mientras que viviendas y oficinas son bienes primarios.


= Proceso de desarrollo <appendix.DevelopmentProcess>

/ Entender el problema: Identificar los requerimientos y sus prioridades, entendiendo el dolor a resolver y cual es el estado del arte, desde lo tecnológico a lo existente en el mercado.
/ Diseñar la solución: Definir como se modelará la solución, determinar que tecnologías son las más adecuadas, y cuales son los componentes claves de la solución.
/ Llevar el desarrollo: Planificar como sera llevado a cabo el desarrollo de la solución en un tiempo establecido, entendiendo un desarrollo progresivo y ágil.
/ Implementar la solución: Programar la solución, armando un producto funcional.


#page(
  flipped: true,
  margin: (top: 2cm, bottom: 2cm, left: 1.5cm, right: 1.5cm),
  [
  #let ok = (content: sym.checkmark) => table.cell(content, fill: green.lighten(80%))
  #let bad = (content: [x]) => table.cell(content, fill: red.lighten(80%))
  #let partial = (content: sym.tilde) => table.cell(content, fill: yellow.lighten(80%))

  = Comparativa de Backend as a Service <appendix.BaaS>
  #figure(
    table(
      columns: 6,
      table.cell([Funcionalidad], colspan: 2), table.cell([Backend as a Service (BaaS)], colspan: 4),
      [Categoría], [Nombre], [Supabase], [Firebase], [Cloudflare DO #footnote[DO es un primitivo para contruir un backend, y no entrega todas las heramientas comunes de un BaaS]], [Convex],

      table.cell([Descipción], rowspan: 3),
      [Creación servicio], [Firestore (2017)], [Supabase (2020)], [Durable Objects (2021)], [Convex (2021)],
      [Lenguaje], partial(content: [SQL]), ok(content: [JS]), ok(content: [JS/TS, estándares web]), ok(content: [JS/TS, estándares web]),
      [BDD], ok(content: [PostgreSQL]), partial(content: [Firestore, no ralacional]), ok(content: [SQLite]), ok(content: [Documentos, relacional]),

      table.cell([Funcionalidades], rowspan: 5),
      [Real Time], ok(), ok(), ok(content: [WebSockets diracto]), ok(),
      [Tareas], partial(content: [Basado en SQL]), ok(content: [Google Tasks]), partial(content: [Impl. propia]), ok(),
      [Subir imágenes], ok(), ok(), ok(content: [R2]), ok(),
      [Integración Autentificación], ok(), ok(), bad(), ok(),
      [Permisos #footnote[Que sistema de permisos se asume en las funcionalidades que otorga el Backend as a Service]], partial(content: [RLP (polizas en la SQL)]), partial(content: [Security Rules]), ok(content: [Impl. Propia]), ok(content: [Impl. Propia]),

      table.cell([Agilizantes de desarrollo], rowspan: 5),
      [Servidor local], partial(content: [Complejo]), partial(content: "Distinto produción"), partial(content: "Levemente diferente"), ok(),
      [Dashboard], ok(), partial(content: [Complejo de usar]), bad(), ok(),
      [Buena documentación], ok(), partial(), partial(), ok(),
      [Integración cliente], ok(), partial(content: [Deprecada]), bad(content: [Implementación propia]), ok(),
      [Testing], partial(content: [Basado en SQL]), partial(content: [Deprecada]), partial(content: [Complejo]), ok(content: [Bien integrado]),

      table.cell([Nice to have], rowspan: 4),
      [Sin cold start], ok(), partial(content: [x]), ok(), ok(),
      [Deploy automatico], ok(), ok(), ok(), ok(),
      [Previews], ok(), ok(), ok(), ok(),
      [Self hosteable ], ok(), partial(content: [x]), ok(), ok(),

      table.cell([Escalabilidad], rowspan: 2),
      [Fuerza buenas prácticas], partial(content: [Accesso directo a BDD]), partial(content: [Accesso directo a BDD]), partial(content: [Libre]), ok(),
      [Conexiones Cloud], partial(content: [Por SQL]), ok(content: [Google Cloud]), ok(content: [Servicios de Cloudflare]), partial(content: [Cloud aparte]),

      table.cell([Costos], rowspan: 2),
      [Plan gratis], [Sí], [Sí, por uso], [No], [Sí (2 personas)],
      [Siguiente plan], [\$25/mes], ok(content: [Solo basado en uso]), [\$5/mes], partial(content: [\$25/mes/persona]),
    ),
    caption: "Compartiva de Backend as a Service.",
  )
  ]
)

#page(
  flipped: true,
  [
    #show raw: set text(size: 8pt)
    = Refractor de código con jscodeshift <appendix.jscodeshift>

    ```ts
    export default function (fileInfo, api) {
      const j = api.jscodeshift, root = j(fileInfo.source);
      // Step 1: Identify all helper functions
      const helperFunctions = {};
      root.find(j.FunctionDeclaration).forEach((path) => {
        const functionName = path.node.id.name;
        const returnStatement = j(path).find(j.ReturnStatement);
        if (returnStatement.size() !== 1) return;
        const argument = returnStatement.get(0)?.value?.argument;
        if (argument && argument.type === "CallExpression" && argument.callee.name === "convexQuery") {
          helperFunctions[functionName] = returnStatement.value.argument;
        }
      });
      // Step 2: Replace all usages of the helper functions
      Object.keys(helperFunctions).forEach((helperName) => {
        const inlineEquivalent = helperFunctions[helperName];
        root
          .find(j.CallExpression, { callee: { name: helperName } })
          .replaceWith((path) => {
            const args = path.value.arguments;
            const newCall = structuredClone(inlineEquivalent);
            newCall.arguments[1] = args[0]; // Replace "args" in convexQuery with actual arguments
            return newCall;
          });
      });
      // Step 3: Remove unused helper functions
      Object.keys(helperFunctions).forEach((helperName) => {
        const isHelperUsed = root.find(j.Identifier, { name: helperName }).size() > 1;
        if (!isHelperUsed) root.find(j.FunctionDeclaration, { id: { name: helperName } }).remove();
      });
      return root.toSource();
    }
    ```
    
    Código de entrada:
    ```ts
    export function getMessagesQuery(args: FunctionArgs<typeof api.messages.list>) {
      return convexQuery(api.messages.list, args);
    }
    
    export const Route = createFileRoute("...")({
      loader: async ({ params: { inboxId } }) => {
        await client.ensureQueryData(getMessagesQuery({ inboxId }));
      },
      component: RouteComponent,
    });

    function RouteComponent() {
      const { inboxId } = Route.useParams();
      const { data } = useSuspenseQuery(getMessagesQuery({ inboxId }));
      // ...
    }
    ```

    Código de salida:

    ```ts
    export const Route = createFileRoute("...")({
      loader: async ({ params: { inboxId } }) => {
        await client.ensureQueryData(convexQuery(api.messages.list, { inboxId }));
      },
      component: RouteComponent,
    });
    function RouteComponent() {
      const { inboxId } = Route.useParams();
      const { data } = useSuspenseQuery(convexQuery(api.messages.list, { inboxId }));
      // ...
    }
    ```
  ]
)