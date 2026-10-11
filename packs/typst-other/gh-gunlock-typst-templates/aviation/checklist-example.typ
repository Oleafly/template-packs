#import "checklist-template.typ": *

// Use the checklist template with custom headers/footers
#show: checklist.with(
  head-left: [Cessna 172],
  head-center: [Check List],
  head-right: [N12345],
  foot: context [For Example Only],
  font: "Inter"
)
// Example checklist content

#section-black[BEFORE STARTING ENGINE][
  #item[Preflight Inspection][COMPLETE]
  #item[Passenger Briefing][COMPLETE]
  #item[Seats, Belts, Harnesses][ON]
  #item[Fuel shutoff valve][BOTH]
  #item[Fuel Quantity][CHECK]
  #item[Electrical][OFF]
  #item[Circuit Breakers][IN]
  #item[Brakes][TEST/SET]
]

#section-blue[ENGINE START][
  #item[Mixture][RICH]
  #item[Carburetor Heat][COLD]
  #item[Master][ON]
  #item[Beacon][ON]
  #item[Prime][AS REQUIRED]
  #item[Throttle][OPEN 1/8 INCH]
  #item[Propeller Area][CLEAR]
  #item[Ignition Switch][START]
  #item[Oil Pressure][CHECK]
  #item[Avionics][ON]
  #item[Radio][ON/SET]
  #item[Transponder][ON/ALT]
  #item[Wing Flaps][UP]
  #item[Mixture][LEAN]
]


#section-red[ENGINE FIRE IN FLIGHT][
  #item[Mixture][IDLE CUT-OFF]
  #item[Fuel Shutoff Valve][OFF]
  #item[Master Switch][OFF]
  #item[Cabin heat/air][OFF]
  #item[Airspeed][100 KIAS]
  #note(size: .6em)[or higher speed as required]
  #item[Fire Extinguisher][ACTIVATE]
  #item[Forced Landing][EXECUTE]
  #emptyline(count: 36)
]

#section-yellow[BEFORE TAKEOFF][
  #item[Doors][CLOSED/LATCHED]
  #item[Brakes][ON]
  #item[Flight Controls][FREE & CORRECT]
  #item[Fuel Valve][BOTH]
  #item[Mixture][RICH]
  #item[Trim][SET FOR TAKEOFF]
  #item[Throttle][1700 RPM]
  #item(indent: 12pt)[Mags][125 DROP/50 DIFF]
  #item(indent: 12pt)[Carb heat][CHK]
  #item(indent: 12pt)[Ammeter][CHK]
  #item(indent: 12pt)[Suction][CHK]
  #item(indent: 12pt)[Idle][CHK]
  #item[Throttle][BELOW 1000 RPM]
  #item[Radio][SET]
  #item[Transponder][ON ALT]
  #item[Lights][ON]
  #item[Throttle Fiction Lock][ADJ]
]

#section-black[NORMAL TAKEOFF][
  #item[Wing Flaps][0-10°]
  #item[Carburetor Heat][COLD]
  #item[Mixture][RICH]
  #item[Throttle][FULL OPEN]
  #item[Elevator Control][ROTATE AT 55 KIAS]
  #item[Climb Speed][70-80 KIAS]
]
