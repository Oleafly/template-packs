#import "departure_board.typ": board

#show: board.with(
	datetime(hour: 19, minute: 46, second: 01),
	"Departures",
)

#table(
	table.header(
		[*Time*], [*Destination*], [*Platform*], [*Expected*],
	),
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [Delayed],
	[07:45], [London Marylebone], [2], [Cancelled],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
	[07:45], [London Marylebone], [2], [On time],
)
