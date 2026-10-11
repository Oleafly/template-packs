// The agency

#import "@preview/touying:0.6.1": *
#import "arango-theme.typ": *

// Initialize the theme
#show: arango-theme.with(aspect-ratio: "16-9")

#title-slide(
  title: [The Agency],
  subtitle: [Our central, fault-tolerant metadata store],
  author: [Max Neunhöffer – Chief Architect of the Core DB],
  date: [4 March 2026],
)

// What is ArangoDB?

#section-slide(
  title: [What is the Agency?],
)

#light-slide(title: [What is the Agency?])[
  The *Agency*
   - holds #blue[all metadata] of a cluster (databases, collections, indexes),
   - holds #blue[all of the cluster configuration],
   - organizes #red[synchronization and cooperation] in the cluster.
   - consists of three `arangod` instances with a persistent volume,
   - implements the *Raft consensus protocol* to provide a #blue[replicated log],
   - thereby replicates #blue[all its data] #red[to all three nodes],
   - is on its own *fault tolerant*,
   - manages a #red[single, enormous JSON document],
   - has an API with #blue[read and write transactions],
   - runs the *"Supervision"*, which handles *all failovers in the cluster*.

   #align(center)[*#red[If the agency is unwell, the whole ArangoDB cluster is unwell!]*]
]

#section-slide(
  title: [Running your own agency]
)

#light-slide(title: [Running your own agency])[

In a normal build, you can do:

```bash
scripts/startStandAloneAgency.sh -a 3
```

You can then query the configuration and *find the leader*:

```bash
curl http://localhost:5000/_api/agency/config | jq .
curl http://localhost:5001/_api/agency/config | jq .
curl http://localhost:5002/_api/agency/config | jq .
```

One of the machines is *the elected leader* at any given time.

We can *only* talk with the leader, the others just replicate data.
]

#section-slide(
  title: [Reading and writing in the agency],
)

== Our first write

#light-slide(title: [Our first write])[
Assuming the one on port 5001 is the leader, this will write something:
#v(-5mm)

```bash
curl http://localhost:5001/_api/agency/write -d '[[{"/a": {"op":"set","new":12}}]]'
```
#v(-5mm)

So this uses this JSON document as body:

#v(-5mm)
```json
[ [
    {
      "/a": {
        "op": "set",
        "new": 12
      }
    }
] ]
```

#v(-5mm)
We get:
#v(-5mm)

```
{"results":[2]}
```

]

== Our first read

#light-slide(title: [Our first read])[
This reads the whole current state of the agency:

```bash
curl http://localhost:5001/_api/agency/read -d '[["/"]]'
```

So this uses this JSON document as body:

```json
[ [
  "/"
] ]
```

We get:

```json
[{"a":12}]
```

]

== Why so many brackets?

#light-slide(title: [Why so many brackets?])[

  #grid(columns:(1fr, 1fr),
    column-gutter: 16pt,
arango-card(title: [Read requests])[
A *read* operation for `/_api/agency/read` gets

 - a *list* of read transactions

and a *read transaction* is simply

 - a *list* of strings

 So this body:

 ```json
 [ [ "/a", "/b", "/c/d"],
   [ "/x" ] ]
 ```
],
arango-card(title: [Result bodies])[
The result body is
 - a *list* of results,
each is a *projection* of
 - the state of the whole agency.

 #v(1.7cm)
Could produce:

```json
[ {"a":12, "b":13, "c": {"d": "abc"}},
  {"x":true} ]
```
])
]

== Why so many brackets in writes?

#light-slide(title: [Why so many brackets in writes?])[

  #grid(columns:(1fr, 1fr),
    column-gutter: 16pt,
arango-card(title: [Write requests])[
A *write* operation for `/_api/agency/write` gets

 - a *list* of write transactions

and a *write transaction* is simply

 - a list of *objects* of *operations*

 #v(5mm)
 So this body:

 ```json
 [ [ {"/a": {"op":"set","new":12}} ],
   [ {"/x": {"op":"set","new":true}} ] ]
 ```
],
arango-card(title: [Result bodies])[
The result body is
 - an object with a `results` field,
 - which contains *list* of Raft indexes,
 - or *0* if the write did not happen.
There is one entry for each transaction.

Could produce:

```json
{ "results":[12, 13] }
```
])
]

== Other write Operations: delete

#light-slide(title: [Other write Operations: delete])[
Deletes the node at the given path. Takes *no additional arguments*.

```json
[[{"/a": {"op": "delete"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"a": 12, "b": "hello"}
```
  ],
  arango-card(title: [After])[
```json
{"b": "hello"}
```
  ])
]

== Other write Operations: increment

#light-slide(title: [Other write Operations: increment])[
Increments an *integer* value. Argument `"step"` is optional (default *1*).
If the node does not yet exist, it starts at *0*.

```json
[[{"/a": {"op": "increment", "step": 5}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"a": 12}
```
  ],
  arango-card(title: [After])[
```json
{"a": 17}
```
  ])
]

== Other write Operations: decrement

#light-slide(title: [Other write Operations: decrement])[
Decrements an *integer* value. Argument `"step"` is optional (default *1*).
If the node does not yet exist, it starts at *0*.

```json
[[{"/a": {"op": "decrement", "step": 3}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"a": 12}
```
  ],
  arango-card(title: [After])[
```json
{"a": 9}
```
  ])
]

== Other write Operations: push

#light-slide(title: [Other write Operations: push])[
Appends an element to the *end* of an array. Requires `"new"`.
If the node is not an array, a new empty array is used.

```json
[[{"/b": {"op": "push", "new": 4}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"b": [1, 2, 3]}
```
  ],
  arango-card(title: [After])[
```json
{"b": [1, 2, 3, 4]}
```
  ])
]

== Other write Operations: pop

#light-slide(title: [Other write Operations: pop])[
Removes the *last* element from an array. Takes *no additional arguments*.
If the array is empty, it stays empty.

```json
[[{"/b": {"op": "pop"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"b": [1, 2, 3]}
```
  ],
  arango-card(title: [After])[
```json
{"b": [1, 2]}
```
  ])
]

== Other write Operations: prepend

#light-slide(title: [Other write Operations: prepend])[
Inserts an element at the *beginning* of an array. Requires `"new"`.
If the node is not an array, a new empty array is used.

```json
[[{"/b": {"op": "prepend", "new": 0}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"b": [1, 2, 3]}
```
  ],
  arango-card(title: [After])[
```json
{"b": [0, 1, 2, 3]}
```
  ])
]

== Other write Operations: shift

#light-slide(title: [Other write Operations: shift])[
Removes the *first* element from an array. Takes *no additional arguments*.
If the array is empty, it stays empty.

```json
[[{"/b": {"op": "shift"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"b": [1, 2, 3]}
```
  ],
  arango-card(title: [After])[
```json
{"b": [2, 3]}
```
  ])
]

== Other write Operations: erase

#light-slide(title: [Other write Operations: erase])[
Removes elements from an array. Takes *either* `"val"` *or* `"pos"` (not both).
- `"val"`: removes *all* elements equal to the value
- `"pos"`: removes the element at the given position (0-based)

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Erase by value])[
```json
[[{"/b": {"op":"erase","val":2}}]]
```
#v(-5mm)
Before:
#v(-5mm)
```json
[1, 2, 3, 2]
```

#v(-5mm)
After:
#v(-5mm)
```json
[1, 3]
```
  ],
  arango-card(title: [Erase by position])[
```json
[[{"/b": {"op":"erase","pos":1}}]]
```
#v(-5mm)
Before:
#v(-5mm)
```json
[1, 2, 3]
```
#v(-5mm)
After:
#v(-5mm)
```json
[1, 3]
```
  ])
]

== Other write Operations: replace

#light-slide(title: [Other write Operations: replace])[
Replaces *all occurrences* of a value in an array with a new value.
Requires `"val"` (value to find) and `"new"` (replacement).

```json
[[{"/b": {"op": "replace", "val": 2, "new": 99}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"b": [1, 2, 3, 2]}
```
  ],
  arango-card(title: [After])[
```json
{"b": [1, 99, 3, 99]}
```
  ])
]

== Other write Operations: push-queue

#light-slide(title: [Other write Operations: push-queue])[
Appends an element and *caps* the array at length `"len"`, dropping the oldest entries.
Requires `"new"` and `"len"` (unsigned integer).

```json
[[{"/b": {"op": "push-queue", "new": 4, "len": 3}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"b": [1, 2, 3]}
```
  ],
  arango-card(title: [After])[
```json
{"b": [2, 3, 4]}
```
  ])
]

== Other write Operations: read-lock

#light-slide(title: [Other write Operations: read-lock])[
Acquires a *read lock* for a user. Requires `"by"` (string identifier).
Multiple users can hold a read lock simultaneously.
Fails if a write lock is held. The node stores an *array* of lock holders.

```json
[[{"/lock": {"op": "read-lock", "by": "user1"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{}
```
  ],
  arango-card(title: [After])[
```json
{"lock": ["user1"]}
```
  ])
]

== Other write Operations: read-unlock

#light-slide(title: [Other write Operations: read-unlock])[
Releases a *read lock* for a user. Requires `"by"` (string identifier).
Removes the user from the array of lock holders.
If the array becomes empty, the node is *deleted*.

```json
[[{"/lock": {"op": "read-unlock", "by": "user1"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"lock": ["user1", "user2"]}
```
  ],
  arango-card(title: [After])[
```json
{"lock": ["user2"]}
```
  ])
]

== Other write Operations: write-lock

#light-slide(title: [Other write Operations: write-lock])[
Acquires an *exclusive write lock* for a user. Requires `"by"` (string identifier).
Fails if any lock (read or write) is currently held.
The node becomes a *string* with the lock holder's name.

```json
[[{"/lock": {"op": "write-lock", "by": "user1"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{}
```
  ],
  arango-card(title: [After])[
```json
{"lock": "user1"}
```
  ])
]

== Other write Operations: write-unlock

#light-slide(title: [Other write Operations: write-unlock])[
Releases a *write lock* for a user. Requires `"by"` (string identifier).
Only succeeds if the lock is currently held by the specified user.
On success, the node is *deleted*.

```json
[[{"/lock": {"op": "write-unlock", "by": "user1"}}]]
```

#grid(columns:(1fr, 1fr),
  column-gutter: 16pt,
  arango-card(title: [Before])[
```json
{"lock": "user1"}
```
  ],
  arango-card(title: [After])[
```json
{}
```
  ])
]

#section-slide(
  title: [The Raft Consensus Protocol],
  subtitle: [How the Agency achieves fault tolerance],
)

#light-slide(title: [The Raft Consensus Protocol])[

  #grid(columns: (1fr, 1fr), column-gutter: 16pt,
    arango-card(title: [What is Raft?])[
      #set text(size: 17pt)
      - Consensus algorithm by Ongaro & Ousterhout (2014)
      - Designed to be *more understandable* than Paxos
      - Servers agree on a *replicated log* of commands
      - Tolerates up to *(N−1)/2 failures* in an N-node cluster
      - The Agency uses *3 nodes* → tolerates *1 failure*

      #v(2mm)
      #link("https://raft.github.io/")[raft.github.io]
    ],
    arango-card(title: [Key Mechanisms])[
      #set text(size: 17pt)
      *Terms* — logical clock; each starts with an election

      *Leader Election* — randomized timeouts trigger
      candidates; first to gain a *majority of votes* wins;
      leader sends *heartbeats* to prevent new elections

      *Log Replication* — leader appends entries and
      replicates via `AppendEntries` RPC; entry is
      *committed* once acknowledged by a majority

      *Safety* — a committed entry is *never lost*:
      only candidates with an up-to-date log can win
    ],
  )
]

#closing-slide(
  title: [Thank You],
  subtitle: [And have fun with the ArangoDB Agency!]
)
