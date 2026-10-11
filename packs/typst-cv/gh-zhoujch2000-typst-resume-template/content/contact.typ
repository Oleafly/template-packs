// 联系信息
#import "../template/layout.typ": *

#let contact_section = {
    contact_info(
        color: rgb(0, 0, 0),
        (
            icon: icon_email,
            link: "mailto:hajiminanbeilvdou@cat.com",
            content: "hajiminanbeilvdou@cat.com",
        ),
        (
            icon: icon_phone,
            link: "tel:+86 114514",
            content: "114514",
        ),
        (
            icon: icon_wechat,
            content: "hajimi",
        ),
    )
}
