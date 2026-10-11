#import "template.typ": init, warn, note, tip, signature
#show: init.with("My Title", "My Subtitle", logo: "bird.svg")



= My Technical Document

It is amazing how easy it is to document `python` setups now. 

To start a server, I just run:

```bash
python3 -m http.server 8080
```

Then I can visit http://localhost:8080/ to see the result.

I can also reference variables like `foo` or `bar` inline without breaking my
flow.

#note[hi]

#note(title: "Hello")[How are you?]

#warn[Uh oh..]

#tip[It's all good.]

#signature(name: "Jane Doe", title: "Director of Operations")
