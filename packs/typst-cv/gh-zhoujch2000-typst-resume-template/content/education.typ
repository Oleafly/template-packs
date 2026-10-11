// 教育经历
#import "../template/layout.typ": *

#let education_section = {
    resume_section("教育经历", icon_education)
    resume_item(
        "哈基理工大学",
        ("哈基学院", "哈基工程系"),
        "哈基工程·硕士",
        "2022.09",
        "2025.06",
        background: false,
    )
    resume_item(
        "哈基米大学",
        "哈基科学学院",
        "哈基学·本科",
        "2018.09",
        "2022.06",
        background: false,
    )
}
