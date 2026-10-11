#import "/template.typ": *

#show: rule-document.with(
  document-title: [규정 문서 서식 레퍼런스],
  debug: true,
)

// ===== 표지 페이지 =====

#show: cover-page

#cover(
  [규정 문서 서식 \ 레퍼런스],
  "1970. 01. 01",
  rgb("#239dad"),
  image("sub_logo.png", height: 10mm),
  image("main_logo.png", height: 15mm),
)

#simple-cover(
  [규정 문서 서식 \ 레퍼런스],
  top-text: [문법을 간단히 확인하기 위함임.],
  bottom-text: [이 표지는 상단과 하단에 텍스트 삽입이 가능함.],
)

#toc-page()

// ===== 본문 페이지 =====

#show: body-page

= 규정 // 규정, 지침, 세칙, 정관, 혹은 기타 괜찮은 제목을 작성해주세요. 혹은 이 줄을 아예 삭제해도 됩니다.

#revision-history((
  ("2020. 01. 01.", "제정"), // 날짜 부분은 자유롭게 작성해도 됩니다.
  ("2021. 01. 01.", "1차 개정"),
  ("2022. 01. 01.", "2차 개정"),
  ("2023. 01. 01.", "3차 개정"),
  ("2024. 01. 01.", "4차 개정"),
  ("2025. 01. 01.", "5차 개정"),
  ("2026. 01. 01.", "6차 개정"),
))

#chapter[장의 제목]

#section-title[절의 제목]

#article[조의 제목][
  이 조항을 제1조로 한다.
  #clause[이 조항을 제1조제1항으로 한다.]
  #clause[이 조항을 제1조제2항으로 한다.]
  #clause[이 조항을 제1조제3항으로 한다.]
  #clause[
    이 조항을 제1조제4항으로 한다.
    #numitem[이 조항을 제1조제4항제1호로 한다.]
    #numitem[
      이 조항을 제1조제4항제2호로 한다.
      #subitem[이 조항을 제1조제4항제2호제1목으로 한다.]
      #subitem[이 조항을 제1조제4항제2호제2목으로 한다.]
      #subitem(m: "목이하미구현")[목 단위 이하 부분은 구현하지 아니 하였다.]
    ]
  ]
]

#b-article[가지번호 조의 제목][
  이 조항을 제1조의2로 한다.
  #clause[이 조항을 제1조의2제1항으로 한다.]
  #clause[
    이 조항을 제1조의2제2항으로 한다.
    #numitem[이 조항을 제1조의2제2항제1호로 한다.]
  ]
]

#article[조의 제목][
  이 조항을 제2조로 한다.
  #numitem[이 조항을 제2조제1호로 한다.]
  #numitem[
    이 조항을 제2조제2호로 한다. 이걸 누르면 #at[제1조제2항]으로 넘어가야 한다.
    #subitem[이 조항을 제2조제2호제1목으로 한다. 이걸 누르면 #at[제1호]로 넘어가야 한다.]
    #subitem[이 조항을 제2조제2호제2목으로 한다. 이걸 누르면 #at[제1조의2제2항제1호]으로 넘어가야 한다.]
    #subitem[이 조항을 제2조제2호제2목으로 한다. 이걸 누르면 #at-m("목이하미구현")으로 넘어가야 한다.]
  ]
]

#show: body-page.with(compact-margin: true)
// #show: body-page // 일반 문서에서도 규정문과 같은 넓은 여백을 사용하고 싶다면 이 구문을 사용해도 됩니다.

= 일반 문서 예시

이 페이지부터 더 좁은 여백을 사용하도록 설정되어 있음.

== 2단계 제목

=== 3단계 제목

==== 4단계 제목

===== 5단계 제목

====== 6단계 제목

== 신·구조문대비표

#side-by-side-table((
  compare-row(
    [#manual-article(1)[조 제목][조 내용]],
    [#manual-article(1)[조 제목][수정된 조 내용]],
    remark: [수정 사실 추가],
  ),
  compare-row(
    [
      #manual-article(1)[조 제목][조 내용]
      #manual-clause("1~2")[(생략)]
      #manual-clause(3)[(신설)]
      #manual-clause(4)[(신설)]
    ],
    [
      #manual-article(1)[조 제목][조 내용]
      #manual-clause("1~2")[(현행과 같음)]
      #manual-clause(3)[이 조항은 새로운 3항의 내용으로 한다.]
      #manual-clause(4)[이 조항은 새로운 4항의 내용으로 한다.]
    ],
  ),
))

혹은 아래와 같이 더 복잡한 형태도 가능합니다. 오히려 이 형태가 실제 신구조문대비표의 형식에 더 맞습니다.
핵심은 조⋅항⋅호⋅목 단계와 상관없이, 조항 당 하나의 compare-row를 사용하는 것입니다.
이 경우, show-inner-stroke: false, no-inset: true 옵션을 넘기는 것을 추천합니다.

#side-by-side-table(hide-inner-stroke: true, no-inset: true, (
  compare-row(
    [#manual-article(1)[조 제목][조 내용]],
    [#manual-article(1)[조 제목][수정된 조 내용]],
    remark: [수정 사실 추가],
  ),
  compare-row([], []), // 이걸 일종의 여백으로 사용할 수도 있습니다.
  compare-row(
    [
      #manual-article(1)[조 제목][조 내용]
      #manual-clause("1~2")[(생략)]
    ],
    [
      #manual-article(1)[조 제목][조 내용]
      #manual-clause("1~2")[(현행과 같음)]
    ],
  ),
  compare-row(
    [#manual-clause(3)[헌법재판소 재판관은 탄핵 또는 금고 이상의 형의 선고에 의하지 아니하고는 파면되지 아니한다.]],
    [#manual-clause(3)[(삭제)]],
  ),
  compare-row(
    [#manual-clause(4)[(신설)]],
    [#manual-clause(4)[제안된 헌법개정안은 대통령이 20일 이상의 기간 이를 공고하여야 한다.]],
  ),
))
