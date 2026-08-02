#let default-path = "../../assets/ot/card/ot.json"

#let load(path: default-path) = json(path)

#let find(id, cards) = {
    let card = cards.find(card => card.id == id)
    assert(card != none, message: "OT card not found: " + str(id))
    card
}
