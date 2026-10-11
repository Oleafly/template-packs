#import "../template/appendix-listing.typ": appendix-listing
#import "../template/gallery.typ": gallery
#import "../template/scripts/maybe-image.typ": maybe-image

#show heading: none

= 附件一、比赛/活动简介与实录

== 一

#gallery(
  title: "活动名称一",
  descr: "简单介绍"
)[
  #maybe-image("/media/gallery/dummy.jpg", height: 36%, width: auto)
  #maybe-image("/media/gallery/dummy.jpg", height: 36%, width: auto)
]

== 二

#gallery(
  title: "活动名称二",
  descr: "简单介绍"
)[
  #maybe-image("/media/gallery/dummy.jpg", height: 36%, width: auto)
  #grid(
    columns: (48%, 48%),
    align: (right, left),
    gutter: 4%,
    maybe-image("/media/gallery/dummy.jpg", height: 20%, width: auto),
    maybe-image("/media/gallery/dummy.jpg", height: 20%, width: auto)
  )
]

= 附件三、奖项及证书

#appendix-listing(yaml("../lists/certs.yaml"))
