// A List of Symbols. Worth the effort as soon as your thesis merges work that
// was written for different audiences and reuses the same letters.

#import "../lib/utils.typ": symbol-group, symbol-table

= List of Symbols <app:symbols>

The symbols below are used consistently throughout this thesis. Acronyms are
listed separately in the List of Abbreviations.

#symbol-group[General quantities]

#symbol-table(
  [$r$], [radial position, measured from the axis of rotation], [cm],
  [$t$], [time], [s],
  [$T$], [absolute temperature], [K],
  [$omega$], [angular velocity of the rotor], [rad s#super[-1]],
  [$c(r,t)$], [solute concentration], [mol L#super[-1]],
)

#symbol-group[Hydrodynamic quantities]

#symbol-table(
  [$s$], [sedimentation coefficient], [S ($10^(-13)$ s)],
  [$D$], [diffusion coefficient], [cm#super[2] s#super[-1]],
  [$M$], [molar mass of the solute], [Da],
  [$overline(v)$], [partial specific volume of the solute], [mL g#super[-1]],
  [$rho$], [solvent density], [g mL#super[-1]],
  [$eta$], [dynamic viscosity of the solvent], [cP],
  [$f\/f_0$], [frictional ratio], [dimensionless],
)
