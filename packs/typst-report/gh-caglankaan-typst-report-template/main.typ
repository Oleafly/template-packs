
//#set heading(numbering: "1.")
#import "about_us_pages.typ": about-us-pages
#import "executive_summary.typ": executive-summary
// Delete if its the final report.
//#set page(background: rotate(-50deg,
//text(100pt, fill: rgb("#cdcdcc"))[
//    *DRAFT*
//]
//))

#let sev-color(sev) = if sev == "Critical" {
  rgb("#51087E")
} else if sev == "High" {
  rgb("#D32F2F")
} else if sev == "Medium" {
  rgb("#F57C00")
} else if sev == "Low" {
  rgb("#1976D2")
} else {
  rgb("#616161")
}

#let status-color(status) = if status == "Fixed" {
  rgb("#68c16f")
} else if status == "Accepted" {
  rgb("#7c9384")
} else if status == "Mitigated" {
  rgb("#e8bf56")
} else if status == "New" {
  rgb("#759bf8")
} else {
  rgb("#bbb8cb")
}

#let status-badge(sev) = box(
  fill: status-color(sev).lighten(35%),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  text(size: 0.8em, weight: "bold", fill: white)[#sev],
)
#let sev-badge(sev) = box(
  fill: sev-color(sev).lighten(35%),
  inset: (x: 4pt, y: 0pt),
  outset: (y: 3pt),
  radius: 3pt,
  text(size: 0.8em, weight: "bold")[#sev],
)

#let AUDITOR = "Kaan Caglan"
#let CLIENT_NAME = "Union Labs"
#let DATE = "14/11/2025"
#let ASSESMENT_NAME = "Cosmwasm Smart Contract Security Assessment"
#let ISSUE_COUNT = "5"
#let CLIENT_WEBSITE = "https://union.build/"
#let PROJECT_REPOSITORY = "https://github.com/unionlabs/union/"
#let INITIAL_AUDIT_COMMIT = "a14705f7530a05256e04c5612723c550d0855dae"
#let AUDIT_TIMELINE = "Nov 11 2025 to Nov 14 2025"
#let REMEDIATION_COMMIT = ""
#let CRITICAL_FOUND = 0
#let CRITICAL_FIXED = 0
#let CRITICAL_ACKED = 0
#let HIGH_FOUND = 1
#let HIGH_FIXED = 1
#let HIGH_ACKED = 0
#let MED_FOUND = 0
#let MED_FIXED = 0
#let MED_ACKED = 0
#let LOW_FOUND = 2
#let LOW_FIXED = 2
#let LOW_ACKED = 0
#let INFO_FOUND = 2
#let INFO_FIXED = 2
#let INFO_ACKED = 0

#let CLIENT_DESCRIPTION = "Union is a hyper-efficient, zero-knowledge (ZK) interoperability layer that enables trust-minimized general message passing, asset transfers, NFT bridging, and DeFi composability across blockchains and rollups – including EVM, Cosmos, and beyond."
#about-us-pages(CLIENT_NAME, DATE, ASSESMENT_NAME, CLIENT_DESCRIPTION)

    #set page(
    margin: 2.5cm,
    numbering: "1",
    number-align: center,
    fill: rgb("#ebebeb"),
    header: [
        #image("images/caglansec_logo_5.png", height: 0.6cm, fit: "contain")
        #line(length: 100%, stroke: rgb("#cfcfcf"))
        ],
    footer: context[
        #line(length: 100%, stroke: rgb("#cfcfcf"))
            #text(style: "italic")[#ASSESMENT_NAME]
            #h(1fr)
            #counter(page).display("1/1", both: true)
        ]
        )
    
    #show raw.where(block: true): set text(
    font: "DejaVu Sans Mono",
    size: 0.8em,
    )


#executive-summary(ISSUE_COUNT, AUDITOR, CLIENT_NAME, CLIENT_WEBSITE, PROJECT_REPOSITORY, INITIAL_AUDIT_COMMIT, AUDIT_TIMELINE,
  CRITICAL_FOUND, CRITICAL_FIXED, CRITICAL_ACKED,
    HIGH_FOUND, HIGH_FIXED, HIGH_ACKED,
    MED_FOUND, MED_FIXED, MED_ACKED,
    LOW_FOUND, LOW_FIXED, LOW_ACKED,
    INFO_FOUND, INFO_FIXED, INFO_ACKED,
)

#let code-inline(param) = box(
  fill: rgb("#f6f8fa"),   
  stroke: rgb("#d0d7de"),
  radius: 1.5pt,
  inset: (x: 2pt, y: 0pt),
  outset: (y: 3pt),
  text(
    font: "DejaVu Sans Mono",
    size: 0.82em,
    weight: "regular",
    fill: rgb("#24292f"),
  )[#param],
)



#text(20pt, font: "DejaVu Sans Mono")[= Potential Risks]

- Because upgrade authority is delegated to the `AccessManager`, any misconfiguration of its policy (for example, granting Upgradable permissions to a broad admin role, or setting an insufficient execution delay) could allow an unintended party to migrate the contract to arbitrary code, resulting in full control over token minting and balances.

#pagebreak()

#let code-snippet(body) = block(
  stroke: gray.lighten(30%),
  radius: 6pt,
  inset: 5pt,
  width: 100%,
  [
   #body
  ],
)

// id, title, severity, impact, likelihood, status, assets, description, recommendation, poc
#let finding(
  id, title, severity, status, assets,
  description, recommendation, poc, remediation
) = block(
  stroke: (paint: sev-color(severity)),
  radius: 6pt,
  inset: 10pt,
  [
    #grid(
      columns: (1fr, auto),
      column-gutter: 8pt,
      [
        #text(weight: "bold", size: 1.05em, font: "Noto Sans")[#underline(stroke: 1pt)[#id #title]]
      ],
    )

    #text(weight: "bold", size: 1em, font: "Noto Sans")[Severity: #sev-badge(severity)]

    #text(weight: "bold", size: 1em, font: "Noto Sans")[Context]: #text(style: "italic", size: 0.95em)[#assets]
    
    #text(weight: "bold", size: 1em, font: "Noto Sans")[Status: #status-badge(status)]

    #line(length: 100%, stroke: (paint: rgb("#cccccc")))
    #text(weight: "bold", size: 1em, font: "Noto Sans")[Description:]
    #text(font: "Noto Sans")[#description]


    #if recommendation != [] [
        #line(length: 100%, stroke: (paint: rgb("#cccccc")))
        #text(weight: "bold", size: 1em, font: "Noto Sans")[Recommendation]  
        #text(font: "Noto Sans")[#recommendation]
    ]

    #if poc != [] [
        #line(length: 100%, stroke: (paint: rgb("#cccccc")))
        #text(weight: "bold", size: 1em, font: "Noto Sans")[Proof of Concept]  
        #text(font: "Noto Sans")[#poc]
    ]

    #if remediation != [] [
      #text(weight: "bold", size: 1em, font: "Noto Sans")[Remediation]  
      #text(font: "Noto Sans")[#remediation]
    ]
  ],
)
#text(20pt, font: "DejaVu Sans Mono")[= Findings]

#finding(
  "H-01",
  "Schedule Consumed Even When Call Is Immediate",
  "High",
  "Fixed",
  [`./cosmwasm/access-manager/contract.rs`],
  [
    Inside `execute(...)`, the code **consumes the scheduled operation** (removes it from storage) even when the call is configured as *immediate* (i.e., has zero delay).
This behavior differs from expected semantics, where only delayed or explicitly scheduled operations should be consumed on execution.

```rust
pub(crate) fn execute(
    ctx: &mut ExecCtx,
    target: &Addr,
    data: &str,
) -> Result<(SubMsg, Option<Nonce>), ContractError> {
    let caller = ctx.msg_sender();

    // Fetch restrictions that apply to the caller on the targeted function
    let can_call = _can_call_extended(ctx, caller, target, data)?;

    // If call is not authorized, revert
    let immediate = match can_call {
        CanCall::Immediate {} => true,
        CanCall::WithDelay { delay: _ } => false,
        CanCall::Unauthorized {} => {
            return Err(AccessManagerError::AccessManagerUnauthorizedCall {
                caller: caller.clone(),
                target: target.clone(),
                selector: _check_selector(data)?.to_owned(),
            }
            .into());
        }
    };

    let operation_id = hash_operation(caller, target, data);
    let mut nonce = None;

    // If caller is authorized, check operation was scheduled early enough
    // Consume an available schedule even if there is no currently enforced delay
    if immediate || get_schedule(ctx.query_ctx(), operation_id)?.is_some() {
        nonce = Some(_consume_scheduled_op(ctx, operation_id)?);
    }
```
  ],
  [
    Condition the `consume_schedule` call on whether the operation actually came from a scheduled entry:

```rust
if delay.is_some() {
    consume_schedule(...);
}
```
  ],
  [
    #code-snippet(
      [
```rust
#[test]
fn execute_with_delay_without_schedule_must_fail() {
    let (mut deps, env) = setup();

    // This is the same data used in `schedule_works`
    let data = r#"{"a":{}}"#;

    // This constant is also used in `schedule_works` and corresponds to:
    // operationId = keccak256(abi.encode(ACCOUNT_1, TARGET_1, data))
    let operation_id = H256::new(hex!(
        "7c99107b1d6b31f7b0c08fece541ea567a76154de0d91f62d2f2022d09004b0e"
    ));

    execute(
        deps.as_mut(),
        env.clone(),
        message_info(&ADMIN, &[]),
        ExecuteMsg::SetTargetFunctionRole {
            target: TARGET_1.clone(),
            selectors: vec![Selector::new("a").to_owned()],
            role_id: RoleId::new(1),
        },
    )
    .unwrap();

    execute(
        deps.as_mut(),
        env.clone(),
        message_info(&ADMIN, &[]),
        ExecuteMsg::GrantRole {
            role_id: RoleId::new(1),
            account: ACCOUNT_1.clone(),
            execution_delay: 10,
        },
    )
    .unwrap();

    assert_query_result(
        deps.as_ref(),
        &env,
        QueryMsg::CanCall {
            target: TARGET_1.clone(),
            selector: Selector::new("a").to_owned(),
            caller: ACCOUNT_1.clone(),
        },
        &CanCall::WithDelay {
            delay: NonZero::new(10).unwrap(),
        },
    );

    // Sanity check: there is currently NO schedule for this operation
    assert_query_result(
        deps.as_ref(),
        &env,
        QueryMsg::GetSchedule { id: operation_id },
        &None::<()>,
    );

    // Try to execute directly WITHOUT calling `Schedule` first.
    //
    // OpenZeppelin behaviour:
    //   _canCallExtended(..) -> (immediate = false, setback = 10)
    //   if (setback != 0 || getSchedule(operationId) != 0) {
    //       _consumeScheduledOp(operationId); // timepoint == 0 -> AccessManagerNotScheduled
    //   }
    //
    // So OZ AccessManager MUST revert with AccessManagerNotScheduled(operationId).
    //
    // This test encodes that behaviour. If our port allows this call to succeed
    // without a prior schedule, the test will panic (and that’s the PoC).
    assert_eq!(
        execute(
            deps.as_mut(),
            env.clone(),
            message_info(&ACCOUNT_1, &[]),
            ExecuteMsg::Execute {
                target: TARGET_1.clone(),
                data: data.to_owned(),
            },
        )
        .unwrap_err(),
        ContractError::AccessManager(
            AccessManagerError::AccessManagerNotScheduled(operation_id),
        ),
    );
}
```],
)
  ],
  [Fixed the issue in commit hash: `8edb6747898ec7a5d427d572fc6b48ba4b79c5ed`
]
)

#finding(
  "L-01",
  "Non-Deterministic Operation Hashing May Cause Schedule Collisions or Failures",
  "Low",
  "Mitigated",
  [`./cosmwasm/access-manager/contract.rs`],
  [
    ```rust
pub(crate) fn hash_operation(caller: &Addr, target: &Addr, data: &str) -> H256 {
    Sha256::digest(format!("{caller}/{target}/{data}")).into()
}
```
The hash depends on the **stringified JSON representation** of `data`.
Different JSON key ordering produces different byte sequences, leading to inconsistent hashes for logically equivalent operations.

Example:

```json
{"mint":{"to":"alice","amount":"1000"}}
{"mint":{"amount":"1000","to":"alice"}}
```

Both represent the same intent, but produce different hashes ⇒ one is stored under a different key, and later execution fails with `NotScheduled`.],
  [
Normalize `data` before hashing, e.g., canonicalize JSON (sort keys) or hash the binary representation of the encoded message (`to_json_binary(msg)` output) instead of `format!()`.],
  [],
  [No code change was required – this hashing scheme and the “at most one scheduled operation per (caller, target, data)” behavior are intentional to match OpenZeppelin’s `AccessManager`. To prevent confusion and clearly inform integrators, the documentation was updated in commit `8edb6747898ec7a5d427d572fc6b48ba4b79c5ed` to explicitly state that callers who need multiple concurrent schedules for the same operation parameters should append insignificant whitespace (or another salt) to the JSON `data` field to derive distinct operation IDs.]
)

#finding(
  "L-02",
  "Missing Basic Sanity Checks on Upgrade Inputs",
  "Low",
  "Fixed",
  [`./cosmwasm/upgradable/src/contract.rs`],
  [`execute` accepts any `new_code_id` and forwards migration unconditionally. There are no guardrails against no-op or obviously invalid upgrades.],
  [Add minimal validation

```rust
if new_code_id == 0 {
    return Err(ContractError::InvalidCodeId);
}
if new_code_id == env.contract.code_id {
    return Err(ContractError::NoopUpgrade);
}
```],
  [],
  [Fixed the issue in commit hash: `8edb6747898ec7a5d427d572fc6b48ba4b79c5ed`]
)


#finding(
  "I-01",
  "Incorrect Error Variant in `require_not_paused()`",
  "Informational",
  "Fixed",
  [`./cosmwasm/pausable/contract.rs`],
  [The function currently returns `ContractError::ExpectedPause` when the contract *is paused*, while logically it should return `EnforcedPause`, matching OpenZeppelin’s `_requireNotPaused`.

```rust
pub fn require_not_paused(deps: Deps) -> Result<(), ContractError> {
    if is_paused(deps)? {
        Err(ContractError::ExpectedPause) // wrong variant
    } else {
        Ok(())
    }
}
```],
  [Swap the error variants:

```rust
Err(ContractError::EnforcedPause)
```

for `require_not_paused`, and the inverse for `require_paused`.],
  [],
  [Fixed the issue in commit hash: `8edb6747898ec7a5d427d572fc6b48ba4b79c5ed`]
)


#finding(
  "I-02",
  "Missing Revert When Label Role Equals Admin or Public Role",
  "Informational",
  "Fixed",
  [`./cosmwasm/access-manager/contract.rs`],
  [OpenZeppelin’s `AccessManager` reverts when attempting to set a role label that matches its `ADMIN_ROLE` or `PUBLIC_ROLE`, preventing accidental reassignment of system roles.
The CosmWasm implementation silently allows such assignments.],
  [Add a revert check before updating role labels:

```rust
if role == ADMIN_ROLE || role == PUBLIC_ROLE {
    return Err(ContractError::InvalidRoleAssignment);
}
```],
  [],
  [Fixed the issue in commit hash: `8edb6747898ec7a5d427d572fc6b48ba4b79c5ed`]
)
