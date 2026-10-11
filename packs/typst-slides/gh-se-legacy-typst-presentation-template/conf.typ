#let get_author_sex(sex) = {
	if sex == "male" {
		"студента"
	} else if sex == "female" {
		"студентки"
	} else if sex == "plural" {
		"студентов"
	}
	else {
		"6.21 КоАП РФ \nНЕИЗВЕСТНАЯ СПЕЦИАЛЬНОСТЬ"
	}
}

#let title-ssu(
	title: "Title",
	university: "Саратовский государственный университет им. Н.Г. Чернышевского",
	department: "",
	degree: "Бакалавриат",
	course: 251,
	author: "Author",
	sex: "male",
	satitle: "",
	saname: "",
	date: 2025,
) = align(center)[
		#text(2.5em)[*#title*]

		#let course_text;

		#if degree == "Специалитет" {
			course_text += "Хуйня"
			text(1.5em)[Хуйня]
		}else if int(course/100) == 4 {
			course_text += "Бакалаврская"
		} else if int(course/100) == 6 {
			course_text += "Магистерская"
		} else {
			course_text += "Курсовая"
		}

		#text(1.5em)[#course_text работа #get_author_sex(sex) #course группы #author]

		#text(1.5em)[#university]

		#text(1.5em)[#department]

		#text(1.5em)[Научный руководитель: #satitle #saname]

		#text(1.3em)[#date г.]
]
