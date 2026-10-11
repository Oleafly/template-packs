// Personal Security Policy
// Update at every annual review. All [BRACKETED] fields are placeholders.
// Copyright Adam M. Furman - https://adamfurman.me
// GPLv3 License


// ─── DOCUMENT VARIABLES ─────────────────────────────────────────────────────────────────

// Update this:
#let owner = "[Your Name]"
#let created = "[YYYY-MM-DD]"
#let updated = "[YYYY-MM-DD]"
#let version = "1.0"

// Color palette 
#let c-navy    = rgb("#1B2A4A")
#let c-blue    = rgb("#2563EB")
#let c-teal    = rgb("#0D9488")
#let c-amber   = rgb("#D97706")
#let c-red     = rgb("#DC2626")
#let c-purple  = rgb("#7C3AED")
#let accent = c-blue
#let subtle = luma(130)
#let rule-color = luma(180)

// ─── DOCUMENT METADATA ─────────────────────────────────────────────────────────────────

#set document(author: owner, title: "Personal Security Policy")
#set page(
  paper: "us-letter",
  margin: (top: 0.85in, bottom: 0.75in, left: 0.9in, right: 0.9in),
  header: context {
    if counter(page).get().first() > 1 {
      grid(
        columns: (1fr, 1fr),
        align(left)[#text(size: 7.5pt, fill: luma(160))[Personal Security Policy — Confidential]],
        align(right)[#text(size: 7.5pt, fill: luma(160))[Last reviewed: #updated]]
      )
      v(2pt)
      line(length: 100%, stroke: 0.4pt + luma(200))
    }
  },
  footer: context {
    line(length: 100%, stroke: 0.4pt + luma(200))
    v(3pt)
    align(center)[#text(size: 7pt, fill: luma(170))[#counter(page).display()]]
  }
)

// Typography
#show title: it => align(center)[
  #text(weight: "bold", size: 22pt, fill: accent)[#it]
]
#set text(font: "Liberation Sans", size: 10pt, fill: luma(20))
#set par(leading: 0.65em, spacing: 0.9em, justify: false)

// Section heading
#set heading(numbering: "1.")
#show heading.where(level: 1): it => {
  v(14pt)
  text(size: 10.5pt, weight: "bold", fill: accent)[#upper(it)]
  v(-8pt)
  line(length: 100%, stroke: 0.6pt + rule-color)
  v(6pt)
}

// Subsection label
#let sub(title, color: accent) = {
  v(8pt)
  text(size: 9.5pt, weight: "bold", fill: color)[#title]
  v(3pt)
}

// Field: label + fill line
#let field(label, hint: "") = {
  grid(
    columns: (1.6in, 1fr),
    column-gutter: 8pt,
    align(top)[#text(size: 9pt)[#label]],
    align(bottom)[
      #box(width: 100%, stroke: (bottom: 0.5pt + luma(180)))[
        #text(size: 8.5pt, fill: luma(170), style: "italic")[#hint]
        #h(1fr)
      ]
    ]
  )
  v(5pt)
}

// Table style
#let tbl-head-fill = accent
#let tbl-row-fill = luma(240)

#let styled-table(cols, header, ..rows) = {
  show table.cell: set text(size: 8.5pt)
  table(
    columns: cols,
    fill: (_, row) => if row == 0 { tbl-head-fill } else if calc.odd(row) { white } else { tbl-row-fill },
    stroke: (_, y) => (
      bottom: if y == 0 { 0.8pt + luma(160) } else { 0.4pt + luma(210) }
    ),
    inset: (x: 8pt, y: 5.5pt),
    ..header,
    ..rows.pos().flatten()
  )
}

// Risk badge
#let badge(level) = {
  let (color, label) = if level == "high" or level == "secret" {
    (c-red, upper(level))
  } else if level == "medium" or level == "confidential" {
    (c-amber, upper(level))
  } else if level == "low" or level == "public" {
    (c-teal, upper(level))
  } else {
    (black, upper(level))
  }
  box(
    fill: color,
    radius: 2pt,
    inset: (x: 5pt, y: 2pt),
  )[#text(size: 8pt, weight: "bold", fill: white)[#label]]
}

// ─── TITLE ─────────────────────────────────────────────────────────────────

#v(6pt)
#title()
#text(size: 18pt, weight: "bold", fill: accent)[]
#v(2pt)
#align(center)[#text(size: 10pt, fill: subtle)[A governance document that serves as a north star for guiding information security management.]]
#v(8pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 0pt,
  [#text(size: 8.5pt, fill: subtle)[Owner] \ #text(size: 9.5pt)[#context document.author.first()]],
  [#text(size: 8.5pt, fill: subtle)[Created] \ #text(size: 9.5pt)[#created]],
  [#text(size: 8.5pt, fill: subtle)[Version] \ #text(size: 9.5pt)[#version]],
)

#v(4pt)
#line(length: 100%, stroke: 0.8pt + luma(40))

// ─── 1. DEVICE SCOPE ───────────────────────────────────────────────────────

= Device Scope

#text(size: 9pt, fill: subtle)[All devices considered in scope for this policy. Update whenever devices are added or retired.]
#v(6pt)

#styled-table(
  (0.9in, 1.5in, 1.5in, 1.5in, 0.7in, .75in),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Type],
    text(size: 8.5pt, weight: "bold", fill: white)[Name / Model],
    text(size: 8.5pt, weight: "bold", fill: white)[OS & Version],
    text(size: 8.5pt, weight: "bold", fill: white)[Serial Number],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[FDE]],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[Supported]],
  ),
  [Laptop], [[MacBook Pro M1]], [[macOS 15.x]], [[123-XYZ]], align(center)[✓], align(center)[✓],
  [Phone],  [[iPhone 15]],      [[iOS 18.x]],   [[123-XYZ]], align(center)[✓], align(center)[✓],
  [Router], [[Model]],          [[Firmware x]], [[123-XYZ]], align(center)[—], align(center)[✓],
  [],       [],                  [],            [], align(center)[], align(center)[],
  [],       [],                  [],            [], align(center)[], align(center)[],
)

// ─── 2. DATA CLASSIFICATION ────────────────────────────────────────────────

= Data Classification

#text(size: 9pt, fill: subtle)[Every category of data you hold, its classification tier, where it is stored, and the controls required to protect it. ]
#v(6pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 18pt,
  [
    #sub("🔴 Secret", color: c-red)
    #text(size: 8.5pt, fill: subtle)[Loss or exposure causes serious harm (e.g., password vault master password, private keys, cryptocurrency seed phrases, TOTP codes).]
    #v(5pt)
    #set text(size: 9pt)
    
    Controls & Safeguards: 

    - Encryption at rest
    - 3-2-1 backup
      - 3 copies
      - 2 media types
      - 1 off-site storage
    - Fully air-gapped
    - Succession plan
  ],
  [
    #sub("🟡 Confidential", color: c-amber)
    #text(size: 8.5pt, fill: subtle)[Exposure is damaging; loss is painful but survivable (e.g., Financial documents, ID scans, medical records, passwords).]
    #v(5pt)
    #set text(size: 9pt)
    
    Controls & Safeguards:

    - Encryption at rest
    - Multi-Factor Authentication
    - 2 copies
    - E2E encryption for cloud storage
    - Succesion Plan
  ],
  [
    #sub("🟢 Public", color: c-teal)
    #text(size: 8.5pt, fill: subtle)[Non-sensitive information where exposure and loss do not cause harm (e.g., photos, notes, regular computer files). ]
    #v(5pt)
    #set text(size: 9pt)
    
    Controls & Safeguards:

    - Device/user account passcode
    - 2 copies
    - E2E encrypted cloud storage
  ],
)

#v(10pt)

#styled-table(
  (1fr, 1fr, 2fr, 2fr),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Data Type],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[Tier]],
    text(size: 8.5pt, weight: "bold", fill: white)[Storage Location],
    text(size: 8.5pt, weight: "bold", fill: white)[Control Details],
  ),
  [Private keys],                   align(center)[#badge("secret")], [[1. Security key \ 2. Encrypted USB \ 3. Safety deposit box paper backup]], [[All copies > 256-bit encryption \ All copies air-gapped \ Encryption passwords stored in pasword vault]],
  [Cryptocurrency seed phrases],                         align(center)[#badge("secret")],    [],                                 [],
  [[Add your own]],                         align(center)[#badge("secret")],    [],                                 [],
  [Financial records (tax, banking)],       align(center)[#badge("confidential")],    [[Encrypted vault / local drive]], [FDE + offline backup + no cloud sync],
  [Legal documents (wills, contracts)],     align(center)[#badge("confidential")],    [[Fireproof safe + scanned copy]], [Physical original + encrypted digital copy],
  [Identity documents (passport, SSN)],     align(center)[#badge("confidential")],    [[Physical safe / vault]],         [Never stored unencrypted digitally],
  [Password vault],                         align(center)[#badge("confidential")],    [[Password manager]],              [MFA on vault + offline emergency export],
  [Irreplaceable personal files],           align(center)[#badge("confidential")],    [[NAS + cloud backup]],            [3-2-1 rule: 3 copies, 2 media, 1 offsite],
  [Personal photos and videos],             align(center)[#badge("confidential")],   [[Cloud photo library + NAS]],     [Encrypted at rest + 2 copies],
  [Email archive],                          align(center)[#badge("confidential")],   [[Provider + local export]],       [Account MFA + periodic local export],
  [Health and medical records],             align(center)[#badge("confidential")],   [[Patient portal + encrypted folder]], [Encrypted storage, access restricted],
  [Personal correspondence],                align(center)[#badge("confidential")],   [[Local device / encrypted folder]], [Device FDE sufficient],
  [[Add your own]],                         align(center)[#badge("confidential")],   [],                                 [],
  [Installed applications],                 align(center)[#badge("public")], [Local device],                     [None — reinstall from source],
  [Cached and temporary data],              align(center)[#badge("public")], [Local device],                     [None],
  [Downloaded media],                       align(center)[#badge("public")], [Local device / NAS],              [Single backup, best-effort],
  [OS configuration],                       align(center)[#badge("public")], [[Dotfiles repo / config export]], [Version-controlled config repo],
  [[Add your own]],                         align(center)[#badge("public")], [],                                 [],
)

// ─── 3. THREAT MODEL ───────────────────────────────────────────────────────

= Personal Threat Model

#text(size: 9pt, fill: subtle)[Document only threats that realistically apply and the primary mitigation against them.]
#v(6pt)

#styled-table(
  (1.7in, 0.9in, 0.9in, 1fr),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Threat],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[Likelihood]],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[Impact]],
    text(size: 8.5pt, weight: "bold", fill: white)[Primary Mitigation],
  ),
  [Credential stuffing],    align(center)[#badge("high")],   align(center)[#badge("medium")], [Unique passwords + HIBP monitoring],
  [Phishing],               align(center)[#badge("high")],   align(center)[#badge("high")],   [Hardware key MFA on high-value accounts],
  [Device theft / loss],    align(center)[#badge("medium")], align(center)[#badge("medium")], [FDE + remote wipe configured],
  [Opportunistic malware],  align(center)[#badge("medium")], align(center)[#badge("high")],   [AV, DNS filtering, limited installs],
  [Ransomware],             align(center)[#badge("low")],    align(center)[#badge("high")],   [Air-gapped offline backup],
  [Financial fraud],        align(center)[#badge("medium")], align(center)[#badge("medium")], [Transaction alerts + credit freeze],
  [[Custom threat]],        align(center)[],       align(center)[],       [],
)

// ─── 4. ACCEPTED RISKS ─────────────────────────────────────────────────────

= Accepted Risks

#text(size: 9pt, fill: subtle)[Every deliberate security tradeoff must be documented here. An undocumented risk is an oversight, not an acceptance.]
#v(8pt)

#let risk(num, title, justification, review) = {
  grid(
    columns: (1fr, auto),
    text(size: 9.5pt, weight: "bold")[Risk #num — #title],
    text(size: 8.5pt, fill: subtle)[Review by: #review]
  )
  v(2pt)
  text(size: 9pt)[_Justification:_ #justification]
  v(8pt)
  line(length: 100%, stroke: 0.4pt + luma(210))
  v(6pt)
}

#risk(
  "1",
  "[SMS MFA on bank account — TOTP not supported]",
  "[Bank does not offer hardware key or TOTP. Mitigated by transaction alerts and monthly account review.]",
  "[YYYY-MM-DD]"
)
#risk(
  "2",
  "[Device X is end-of-life — replacement planned]",
  "[Budget constraint. Device not used for sensitive tasks. Replacement scheduled for [Month Year].]",
  "[YYYY-MM-DD]"
)
#risk(
  "3",
  "[Add accepted risk]",
  "[Justification and mitigating controls.]",
  "[YYYY-MM-DD]"
)

// ─── PAGE BREAK ────────────────────────────────────────────────────────────

// #pagebreak()

// ─── 5. TOOLING REGISTER ───────────────────────────────────────────────────

= Security Tooling Register

#text(size: 9pt, fill: subtle)[Recovery keys and credentials should be secured elsewhere — record reference locations only here.]
#v(6pt)

#styled-table(
  (1fr, 1fr, 3fr, 1.05in),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Category],
    text(size: 8.5pt, weight: "bold", fill: white)[Tool],
    text(size: 8.5pt, weight: "bold", fill: white)[Notes / Recovery Location],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[Last Audited]],
  ),
  [Password manager],  [[Bitwarden / 1Password]],    [Emergency sheet at: [location]],             align(center)[[YYYY-MM-DD]],
  [MFA authenticator], [[Aegis / Raivo]],            [Encrypted backup at: [location]],            align(center)[[YYYY-MM-DD]],
  [Hardware key],      [[YubiKey 5 — 2×]],           [Backup key stored at: [location]],           align(center)[[YYYY-MM-DD]],
  [Local backup],      [[Time Machine / rsync]],     [External drive at: [location]],              align(center)[[YYYY-MM-DD]],
  [Cloud backup],      [[Backblaze / Restic+B2]],    [Encryption key: in vault],                   align(center)[[YYYY-MM-DD]],
  [DNS filtering],     [[NextDNS / Pi-hole]],        [Config ID: [ID] — in vault],                 align(center)[[YYYY-MM-DD]],
  [VPN],               [[Mullvad / ProtonVPN]],      [Account credentials: in vault],              align(center)[[YYYY-MM-DD]],
  [Breach monitoring], [HIBP],                       [All email addresses enrolled],               align(center)[[YYYY-MM-DD]],
  [Outbound firewall], [[Little Snitch / Lulu]],     [Rule backup at: [location]],                 align(center)[[YYYY-MM-DD]],
  [Credit monitoring], [[Service name]],             [All three bureaus enrolled],                 align(center)[[YYYY-MM-DD]],
  [[Add]],             [],                           [],                                           align(center)[[YYYY-MM-DD]],
)

// ─── 6. REVIEW & AUDIT LOG ─────────────────────────────────────────────────

= Review & Audit Log

#text(size: 9pt, fill: subtle)[Record every review and any findings, remediations, or changes.]
#v(6pt)

#styled-table(
  (1.05in, 0.25fr, 1fr, 1fr),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Date],
    text(size: 8.5pt, weight: "bold", fill: white)[Type],
    text(size: 8.5pt, weight: "bold", fill: white)[Findings],
    text(size: 8.5pt, weight: "bold", fill: white)[Actions Taken],
  ),
  [[YYYY-MM-DD]], [Annual],    [Initial policy created], [All sections completed],
  [],             [Ad-hoc],   [], [],
  [],             [Annual], [], [],
)

// ─── 7. BACKUP RESTORE TEST LOG ────────────────────────────────────────────

= Backup Restore Test Log

#text(size: 9pt, fill: subtle)[Test backup restore at least quarterly. Document the date, backup source, scope, result, and any relvant notes.]
#v(6pt)

#styled-table(
  (1.05in, 0.95in, 1fr, 0.65in, 1fr, 0.65in),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Date],
    text(size: 8.5pt, weight: "bold", fill: white)[Source],
    text(size: 8.5pt, weight: "bold", fill: white)[File / Scope Restored],
    align(center)[#text(size: 8.5pt, weight: "bold", fill: white)[Pass/Fail]],
    text(size: 8.5pt, weight: "bold", fill: white)[Notes],
    text(size: 8.5pt, weight: "bold", fill: white)[Integrity Check],
  ),
  [], [Local backup],   [], align(center)[✓], [], align(center)[✓],
  [], [Cloud backup],   [], align(center)[—], [], align(center)[—],
  [], [Local backup],   [], align(center)[], [], align(center)[],
  [], [Cloud backup],   [], align(center)[], [], align(center)[],
  [], [Local backup],   [], align(center)[], [], align(center)[],
  [], [Cloud backup],   [], align(center)[], [], align(center)[],
  [[YYYY-MM-DD]], [Full rehearsal], [Complete system restore], align(center)[✓], [Annual — bare metal], align(center)[✓],
)

// ─── 8. INCIDENT LOG ───────────────────────────────────────────────────────

= Incident Log

#text(size: 9pt, fill: subtle)[Every security event, however minor. Record what happened, how it was handled, and what changed as a result.]
#v(6pt)

#styled-table(
  (1.05in, 0.9in, 1fr, 1fr, 1fr),
  (
    text(size: 8.5pt, weight: "bold", fill: white)[Date],
    text(size: 8.5pt, weight: "bold", fill: white)[Type],
    text(size: 8.5pt, weight: "bold", fill: white)[What Happened],
    text(size: 8.5pt, weight: "bold", fill: white)[Response],
    text(size: 8.5pt, weight: "bold", fill: white)[Changes Made],
  ),
  [[YYYY-MM-DD]], [], [], [], [],
  [], [], [], [], [],
  [], [], [], [], [],
  [], [], [], [], [],
  [], [], [], [], [],
)

// ─── 9. EMERGENCY REFERENCE ────────────────────────────────────────────────

= Emergency Reference

#text(size: 9pt, fill: subtle)[Print this section and store with physical secure documents. Reference locations only — no credentials here.]
#v(10pt)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 24pt,
  [
    #sub("Password Manager")
    #field("Manager:", hint: "Bitwarden / 1Password / KeePass")
    #field("Master password at:", hint: "Physical location — not the password")
    #field("Emergency contact:", hint: "Name and how to reach them")
    #field("Backup codes at:", hint: "Physical location")

    #sub("Primary Email Recovery")
    #field("Provider:", hint: "Gmail / iCloud / other")
    #field("Recovery phone:", hint: "Last 4 digits only")
    #field("Backup email:", hint: "Address")
    #field("Backup codes at:", hint: "Physical location")
  ],
  [
    #sub("Financial Emergency")
    #field("Primary bank fraud line:", hint: "Number on card")
    #field("Credit card fraud line:", hint: "Number on card")
    #field("Credit freeze PINs at:", hint: "Location — not the PINs")

    #sub("Device Remote Lock / Wipe")
    #field("Apple Find My:", hint: "icloud.com/find")
    #field("Google Find My Device:", hint: "android.com/find")
    #field("Microsoft Find My Device:", hint: "account.microsoft.com/devices")

    #sub("Credit Bureau Freeze")
    #set text(size: 9pt)
    #v(3pt)
    □ #h(4pt) Equifax — 1-800-349-9960 \
    #v(3pt)
    □ #h(4pt) Experian — 1-888-397-3742 \
    #v(3pt)
    □ #h(4pt) TransUnion — 1-888-909-8872
  ]
)

#v(16pt)
#line(length: 100%, stroke: 0.4pt + luma(200))
#v(5pt)
#text(size: 8pt, fill: subtle)[Store the digital version encrypted in your password manager. Print Section 9 and keep it in a fireproof safe or with your legal documents. Rewrite Sections 1–4 at every annual review.]