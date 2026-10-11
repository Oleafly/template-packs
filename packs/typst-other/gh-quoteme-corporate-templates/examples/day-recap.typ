#import "../day-recap.template.typ": day-recap, todo-item

#show: day-recap.with(
  date: datetime(year: 2026, month: 6, day: 1),
  todos: (
    ("Review protocol v3", true),
    ("Send study summary to team", true),
    ("Schedule follow-up meeting with investigators"),
    ("Update study documentation"),
  ),
  notes: [Today was focused on protocol review and team alignment. Key decisions were made regarding the Phase II study timeline and data collection procedures.],
)

= Highlights

Key accomplishments and observations from the day.

== Morning

Reviewed the updated protocol v3 with the clinical team. All major concerns from the previous version have been addressed and sign-off is expected by end of week.

== Afternoon

Sent the study summary to the broader team and received positive feedback. Next steps are being coordinated with the principal investigator.

= Action Items for Tomorrow

Follow up on outstanding regulatory queries and prepare agenda for the Friday sync.
