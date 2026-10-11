#import "/constants.typ": client, company, template
#import template: heading_style

///!
///! title = "Bad stuff"
///! likelihood = "medium"
///! impact = "high"
///!

==== This is a header

*This is some text*

This is a root cause that is talking about bad stuff. The bad stuff was present in #client's software and #company recommends X fix

```c
int main() {
    return 0;
}
```

#table(
    columns: (auto, auto),
    align: horizon + left,
    inset: 10pt,
    table.header([IP Address], [Hostname]),
    par("10.1.1.1"), [https://example.com/iuosdhgoiusdfhgoiusdhgoiusdfhgoiusdhgoiusdfhgoiusdfhgoiudfshogiusdfhgoiusdhfgoiusdfhoguihsdiou],
    par("10.1.1.2"), [EXAMPLE-PROD-02],
)

https://example.com/iuosdhgoiusdfhgoiusdhgoiusdfhgoiusdhgoiusdfhgoiusdfhgoiudfshogiusdfhgoiusdhfgoiusdfhoguihsdiou

