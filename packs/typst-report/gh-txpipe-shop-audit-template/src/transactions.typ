#import "templates/report.typ": *

#let example_transaction = vanilla_transaction(
  "Example Tx",
  mint: (
    "Example1 NFT": 1,
    "Example2 NFT": -1,
    "Example3 FT": "N",
    "Example4 FT": [_N_],
  ),
  withdrawals: (
    "withdrawal_addr1",
    "withdrawal_addr2",
  ),
  inputs: (
    (
      name: "Input 1",
      address: "example_addr1",
      value: (
        "ADA": "N",
      ),
      datum: (
        field0: "",  // no value or type
        field1: "Type",
        field2: [*value*],
        field3: 42,  // integer value
        field4: [],  // also no value or type
        field5: (
          subfield1: "SubType",
          subfield2: [*subvalue*],
        ),
        "...": [],  // ellipsis if needed
      ),
    ),
    (
      reference: true,
      name: "Ref. Input 1",
      address: "example_addr2",
      value: (
        "Ref. Input NFT": 1,
      ),
      datum: (
        field1: "Type",
        field2: [*value*],
      ),
    ),
  ),
  outputs: (
    (
      name: "Output 1",
      address: "example_addr",
      value: (
        "ADA": "N",
      ),
      datum: (
        field0: "",  // no value or type
        field1: "Type",
        field2: [*value*],
      ),
    ),
  ),
  notes: [
    - note 1
    - note 2
  ],
)