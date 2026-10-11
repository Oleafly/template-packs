#let _icon(path) = box(
    baseline: 0.125em,
    height: 1.0em,
    width: 1.25em,
    image(path, width: 1em),
)

#let icon_path = "../assets/icons/";

#let icon_email = _icon(icon_path + "envelope-solid-full.svg");
#let icon_phone = _icon(icon_path + "phone-volume-solid-full.svg");
#let icon_location = _icon(icon_path + "location-dot-solid-full.svg");
#let icon_wechat = _icon(icon_path + "weixin-brands-solid-full.svg");
#let icon_education = _icon(icon_path + "graduation-cap-solid-full.svg");
#let icon_intern = _icon(icon_path + "briefcase-solid-full.svg");
#let icon_project = _icon(icon_path + "diagram-project-solid-full.svg");
#let icon_campus = _icon(icon_path + "building-columns-solid-full.svg");
#let icon_skill = _icon(icon_path + "wrench-solid-full.svg");
