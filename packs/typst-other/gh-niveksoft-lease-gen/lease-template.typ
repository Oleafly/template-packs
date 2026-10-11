#let property_address = "PROPERTY_ADDRESS"

#let landlord_names = "LANDLORD_NAMES"
#let landlord_address = "LANDLORD_ADDRESS"
#let landlord_phone = "LANDLORD_PHONE"
#let landlord_email = "LANDLORD_EMAIL"

#let tenant_names = "TENANT_NAMES"
#let tenant_phone = "TENANT_PHONE"
#let tenant_email = "TENANT_EMAIL"

#let emergency_contact_name = "EMERGENCY_CONTACT_NAME"
#let emergency_phone = "EMERGENCY_PHONE"

#let rent_amount = 2000
#let annual_interest = 0
#let lease_year = 2026
#let utilities_percentage = 100

#set page(
  paper: "us-letter",
  margin: (x: 1in, y: 1in),
)
#set text(
  font: "New Computer Modern",
  size: 11pt,
)
#set par(justify: false, leading: 0.65em)

#align(center)[
  #text(size: 16pt, weight: "bold")[
    RESIDENTIAL TENANCY AGREEMENT
  ]
]

#v(1em)

#text(size: 10pt)[
  This lease is governed by Alberta's Residential Tenancies Act. If this agreement conflicts with that Act, the Act takes priority.
]

#v(0.5em)

*Property Address:* #property_address

#v(1em)

= PARTIES

*Landlord(s):* #landlord_names

Address: #landlord_address \
Phone: #landlord_phone \
Email: #landlord_email

#v(0.5em)

*Tenant(s):* #tenant_names

Phone: #tenant_phone \
Email: #tenant_email

#v(1em)

= 1. LEASE TERM

- *Start Date:* #box()[#line(length: 50%, stroke: 0.5pt)]
- *End Date:* #box()[#line(length: 50%, stroke: 0.5pt)]
- *Type:* Fixed term

#v(0.5em)

= 2. PROPERTY DESCRIPTION

*Tenant has exclusive use of:* Main floor including all bedrooms, bathrooms, kitchen, living areas, and dining areas.

*Tenant has shared access to:* Garage, mechanical room (for furnace maintenance and meter readings), front yard, backyard, and driveway.

*Tenant cannot use:* Basement or basement suite areas.

#v(0.5em)

= 3. RENT

- *Amount:* \$#rent_amount\/month
- *Due Date:* 1st day of each month
- *Payment Method:* Electronic transfer or other agreed upon payment method
- *First Payment:* Due on move-in date
- *Prorated Rent:* If move-in is not on the 1st, rent is prorated accordingly

#v(0.5em)

= 4. SECURITY DEPOSIT

- *Amount:* \$#rent_amount
- *Due Date:* Upon signing
- *Interest:* Landlord pays #annual_interest% annual interest per Alberta regulations for #lease_year
- *Return:* Returned within 10 days of move-out, minus any lawful deductions
- *Held in:* Interest-bearing trust account

#v(0.5em)

= 5. RENT LATE FEES & NSF CHARGES

*If rent is late:*

- \$10.00 charge for day rent is due
- \$2.00 for each additional day unpaid (maximum \$50.00/month)

*If payment bounces (NSF):*

- Tenant pays the NSF fee charged by the bank
- After NSF, Landlord can require certified cheque, money order, or cash only
- Three (3) or more NSF payments is grounds for eviction

#v(0.5em)

= 6. INSPECTIONS

- *Move-in:* Within 1 week before/after occupancy (both parties required)
- *Move-out:* Within 1 week before/after move-out (both parties required)
- *Right to Attend:* Tenant can attend all inspections
- If Tenant misses 2 inspection times, Landlord can inspect without them

#v(0.5em)

= 7. TENANT RESPONSIBILITIES

*Tenant must:*

- Pay rent on time
- Keep property clean and in good repair
- Pay for damage they cause (normal wear and tear excluded)
- Not disturb neighbors or other tenants
- Follow all laws and city bylaws
- Get renters insurance and provide proof yearly
- Report any problems to Landlord immediately

*Tenant must NOT:*

- Engage in illegal activities
- Cause major disturbances to other tenants
- Damage the property beyond normal use
- Sublet or let others live there without written permission

#v(0.5em)

= 8. MODIFICATIONS & ALTERATIONS

*Tenant cannot make any changes without Landlord's written permission:*

- Wall changes, painting, wallpaper
- Flooring or carpet changes
- Installing shelves, cabinets, or fixtures
- Any electrical, plumbing, or heating/cooling changes
- Door, window, or lock changes
- Landscaping changes
- Adding security cameras or other permanent installations

*To request changes:*

+ Submit written request with details (materials, contractors, timeline)
+ Landlord responds in writing within 14 days
+ If approved, Tenant gets required permits and uses licensed professionals
+ Tenant provides copies of permits and inspection certificates when done

*Unauthorized changes:*

- Are a lease violation
- Must be removed and restored at Tenant's expense within 14 days
- Can result in eviction
- Tenant pays all removal and restoration costs plus any property value loss

#v(0.5em)

= 9. UTILITIES

*Tenant's share:* #utilities_percentage% of total utilities

*Payment:*

- Landlord pays all bills and sends Tenant monthly statement
- Tenant pays within 10 days by e-transfer

*Late payment (after 10 days):*

- \$10.00 charge first day late
- \$2.00 per day after (maximum \$50.00/month)
- May be grounds for eviction after 30+ days

*If utilities unpaid for 30+ days:*

- Amount becomes debt owed to Landlord
- Can be deducted from security deposit
- Landlord can pursue collection for any amount over the deposit

*If utilities are not paid 3 or more times:* Grounds for eviction

*Other utilities:*

- Landlord does NOT provide any other utilities (internet, cable TV, phone, etc.)
- Tenant is responsible for requesting and putting any other utilities under their own name with the provider
- Tenant is responsible for all costs associated with these services

#v(0.5em)

= 10. LANDLORD RESPONSIBILITIES

- Keep property in good repair and safe condition
- Maintain essential services (heat, water, electricity)
- Make repairs within reasonable time after Tenant reports problems
- Maintain pest-free environment (pre-existing or adjoining unit infestations are Landlord's cost)

#v(0.5em)

= 11. LANDLORD ENTRY

Landlord can enter only with *24 hours written notice*, except emergencies.

*Allowed entries:*

- Repairs and inspections
- Showing to prospective buyers or tenants
- Pest control treatments
- Emergencies

*Entry hours:* 8 AM to 8 PM on non-holidays (except Tenant's religious day if written notice given)

#v(0.5em)

= 12. KEYS & LOCKS

- Landlord provides keys for all exterior doors
- *Tenant must return all keys at move-out* (failure results in lock change cost charged to Tenant)
- Tenant cannot change locks without written permission (if they do, Landlord changes them back at Tenant's expense)

#v(0.5em)

= 13. PETS

- *No pets allowed* without Landlord's written permission
- Tenant pays for all pet-related damage beyond normal wear and tear

#v(0.5em)

= 14. RENT INCREASES

- *Not allowed during this fixed-term lease*
- Minimum 365 days must pass before any increase is allowed
- Any increase must follow Alberta Residential Tenancies Act rules

#v(0.5em)

= 15. ENDING THE LEASE EARLY

*Mutual Agreement:*

- Both parties must agree in writing to end early and specify new end date

*Tenant wants to leave early:*

- Must give 60 days written notice
- Remains liable for rent until move-out date or new tenant takes over (whichever is sooner)
- Landlord will try to find replacement tenant at fair market price

*Landlord terminates for breach:*

- Landlord gives 14 days written notice with details of the problem
- Tenant has 14 days to fix it
- If not fixed, Landlord can evict

*Special circumstances:*

- Domestic or family violence
- Senior moving to supported living

#v(0.5em)

= 16. NOTICES & COMMUNICATION

All notices must be in writing:

*Delivery methods:*

- Hand-delivered to person
- Registered mail to address in this agreement
- Email or electronic method that creates printed copy

*When considered received:*

- When hand-delivered
- 3 days after registered mail is sent
- When email confirmation is received

#v(0.5em)

= 17. SUBLETTING & ASSIGNMENT

- Tenant cannot sublet or assign the lease without Landlord's written permission
- Landlord will not unreasonably refuse permission

#v(0.5em)

= 18. SMOKING POLICY

*Smoking is completely prohibited:*

- Inside the Premises
- On balconies or patios attached to the property
- Within 5 meters of doors, windows, or air intakes

*Includes:* Tobacco, cannabis, e-cigarettes, vaping

*Violation:* Substantial lease breach; repeated violations is grounds for eviction after proper notice

#v(0.5em)

= 19. PEST CONTROL

- *Landlord ensures* property remains pest-free per housing standards

- *Tenant reports immediately* any bed bugs, cockroaches, rodents, or other pests in writing

- *Tenant allows* pest control access with 24-hour notice and follows all preparation instructions

- *Cost split:*
  - Landlord pays: Pre-existing infestations or infestations from adjoining units
  - Tenant pays: Infestations from Tenant's failure to keep property reasonably clean
  - Pest control professional decides cause

#v(0.5em)

= 20. OCCUPANCY & GUESTS

- *Only named Tenant* (and pre-approved occupants) can permanently live in the property
- *Guests can stay:* Maximum 14 consecutive days or 30 days total per year without permission
- *Unauthorized occupants:* Substantial breach is grounds for eviction
- *Tenant responsible* for guest conduct and any damage they cause

#v(0.5em)

= 21. OUTDOOR MAINTENANCE

*Tenant is responsible for:*

- *Snow/Ice Removal:* Remove from all sidewalks, driveways, walkways, entrances within 24-48 hours of snowfall (per city bylaws)
- *Lawn Care:* Regular mowing during growing season, edging, basic weed control
- *Leaves & Debris:* Remove fallen leaves and branches; keep yard tidy
- *Garden Maintenance:* Basic upkeep of flower beds, shrubs, watering, weed removal (major changes need Landlord approval)
- *Municipal Compliance:* Meet city standards; Tenant pays any fines for non-compliance

#v(0.5em)

= 22. DRAINAGE & PLUMBING

*Tenant must NOT pour down drains or toilets:*

- Cooking oil, grease, or petroleum products
- Paint, solvents, cleaning chemicals, or hazardous materials
- Feminine hygiene products, diapers, wipes, medications, or inappropriate items
- Caustic drain cleaners or industrial chemicals
- Automotive fluids, batteries, or electronic waste

*Proper disposal:*

- Use municipal waste collection for hazardous materials
- Take oil and automotive fluids to recycling centers
- Take paint and chemicals to municipal hazardous waste facilities
- Report spills or accidents immediately to Landlord
- *Tenant pays* for any plumbing damage or cleanup from improper disposal

#v(0.5em)

= 23. PARKING

*Available to Tenant:*

- Outdoor driveway and parking areas
- Garage space (shared with basement tenant)

*Garage:*

- Gravel floor surface (not finished concrete)
- Each tenant can park one (1) vehicle, space permitting
- Coordinate equitably with basement tenant
- Tenant parks at own risk; Landlord not responsible for gravel/dust damage

*Garage etiquette:*

- Don't block other tenant's access
- Keep garage area tidy and free of storage clutter
- Be courteous with shared space

#v(0.5em)

= 24. EMERGENCY CONTACT INFORMATION

- Name: #emergency_contact_name
- Phone: #emergency_phone

*Tenant must notify Landlord within 10 days of changes to:*

- Mailing address
- Phone number
- Email address
- Emergency contact
- Employment information (if requested)

#v(0.5em)

= 25. FIRE & SAFETY DETECTORS

- Tenant must NOT tamper with smoke detectors
- Tenant must NOT tamper with carbon monoxide detectors
- Tenant must report any malfunction immediately to Landlord

#v(0.5em)

= 26. NORMAL WEAR & TEAR

*Normal wear & tear (Landlord's responsibility):*

- Paint fading from sunlight
- Minor nail holes from pictures
- Carpet wear in normal traffic areas
- Minor wall scuffs
- Worn floor finish from normal use

*NOT normal wear & tear (Tenant pays):*

- Large holes in walls or ceilings
- Stains on carpet, walls, or fixtures
- Broken windows, fixtures, or appliances
- Excessive dirt or grime requiring deep cleaning
- Pet damage (odors, scratches, urine stains)
- Smoking damage (odors or discoloration)

#v(0.5em)

= 27. LEASE END & MOVE-OUT

*When lease ends:*

- Remove all personal belongings
- Return all keys and access devices
- Leave property clean and undamaged
- Complete final outdoor maintenance (snow removal, lawn care as needed)
- Attend move-out inspection

*Security deposit return:*

- Returned within 10 days after move-out
- Minus any lawful deductions
- With written account of deductions
- Plus accrued interest

#v(0.5em)

= 28. DISPUTE RESOLUTION

- First step: Use Alberta's Residential Tenancy Dispute Resolution Service (RTDRS) per the Act
- Mediation preferred before formal hearings
- Each party pays own costs unless ordered otherwise

#v(0.5em)

= 29. GENERAL TERMS

- *Entire Agreement:* This agreement is the complete lease between both parties
- *Severable:* If one part is unenforceable, the rest remains valid
- *Alberta Law:* Governed by Alberta law; Act takes priority on conflicts
- *Binding:* Applies to both parties and their heirs, successors, and assigns

#pagebreak()

= SIGNATURES

#v(2em)

*LANDLORD:*

#v(1em)

Signature: #box()[#line(length: 50%, stroke: 0.5pt)]

#v(0.5em)

Name: #landlord_names

#v(2em)

*TENANT:*

#v(1em)

Signature: #box()[#line(length: 50%, stroke: 0.5pt)]

#v(0.5em)

Name: #tenant_names

#v(2em)

Date: #box()[#line(length: 50%, stroke: 0.5pt)]
