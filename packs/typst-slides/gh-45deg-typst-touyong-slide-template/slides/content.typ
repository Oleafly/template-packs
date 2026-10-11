#import "components.typ": *

#title-slide()

#message-slide(
  title: [背景],
  message: [FAQ一次回答をSlackに集約し、問い合わせの初動を短くします。],
)

#bullets-slide(
  title: [90日でやること],
  lead: [最初は範囲を絞って、運用を固めます。],
  bullets: (
    [対象窓口を1つに決める],
    [FAQを30件に絞る],
    [回答ログを毎週見直す],
  ),
)

#process-slide(
  title: [進め方],
  steps: (
    [1-2週目: 対象FAQを選ぶ],
    [3-6週目: Slack回答を試す],
    [7-12週目: ログからFAQを直す],
  ),
)

#takeaway-slide(
  message: [まず1窓口で試し、回答時間と未解決率を見ます。],
  next: [
    - 対象窓口を決める
    - 初回FAQを集める
    - 週次レビュー担当を置く
  ],
)
