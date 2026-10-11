= Inserting tables and formulas
Here is how to insert a table that shows up in the table of tables:

#figure(
  table(
    columns: 2,
    [*Unit*], [*Value*],
    [$(k m) / h$], [#lorem(50)],
    [$m/s^2$], [9.81],
  ),
  caption: [This is a table]
)

Formulas are added like this:

#figure(
  $ y = m dot x + c $,
  kind: math.equation
)

Inline equations like $y = m dot x + c$ are not listed. They also don't update the numbering. If you want to add a supplement that is shown inside of the list of formulas, insert them like this:

#figure(
  math.equation($x+y$, supplement: [Add two variables], block: true),
  kind: math.equation
)

The formula is now named "Add two variables" inside of the list. If formulas are added like this, the parameter `block: true` is required. This is because the outline is configured to only show equations with this property (to avoid displaying inline formulas).