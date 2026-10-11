#import "../template/template.typ": *

= Einleitung
#lorem(600)

== Sub-Einleitung
#lorem(20)
#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  kind: "tab",
  supplement: "Tabelle",
  caption: [Timing results],
) <tab1>
in @tab1 kann man sehen, dass
#lorem(20)


=== Sub-Sub-Einleitung
#lorem(20)
@Wellens2010 @Yoshida1999 @Walke2001 #lorem(2) @Walke2000 @Burns2003
#lorem(20)
#ac("API")
#lorem(20)
#ac("API")
#lorem(20)
#ac("IOCCC")
#lorem(20)
#ac("IOCCC")

==== asdf
#lorem(20)
#figure(
  image("../img/hbrs_logo.png"),
  caption: [HBRS logo],
  kind: "fig",
  supplement: "Abbildung",
) <abb1>

===== asdf
#lorem(20)
#figure(
  ```rust
   fn handle_connection(mut stream: TcpStream) {
       // --snip--

       let (status_line, filename) = if request_line == "GET / HTTP/1.1" {
           ("HTTP/1.1 200 OK", "hello.html")
       } else {
           ("HTTP/1.1 404 NOT FOUND", "404.html")
       };

       let contents = fs::read_to_string(filename).unwrap();
       let length = contents.len();

       let response =
           format!("{status_line}\r\nContent-Length: {length}\r\n\r\n{contents}");

       stream.write_all(response.as_bytes()).unwrap();
   }
  ```,
  caption: [Code Ausschnitt],
  kind: "lst",
  supplement: "Listing",
  outlined: true,
) <lst1>
#lorem(20)
in @lst1 kann man sehen, dass
