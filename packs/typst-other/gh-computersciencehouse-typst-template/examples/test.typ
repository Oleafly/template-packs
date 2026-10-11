/*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at https://mozilla.org/MPL/2.0/.
*/

#import "../template/lib.typ": csh

#show: csh.with(
        title: "porject", 
        subtitle: "subtitle", 
        author: "name"
    )

= test 
#lorem(30)

== Subheading
#lorem(10)

=== test
Crazy subheading!

= Components
#lorem(10)

- #lorem(10)
- #lorem(10)

#lorem(20)

= math
math math math math math math maht parabola:

$ f(x) = x^2 + 2x + 1 $

#lorem(30)


= code!!!!

swizzy python scropt does stuff python python content content

```python@
def lorem_process(data):
    output = []
    for item in data:
        output.append(item * 2)
    return output
```