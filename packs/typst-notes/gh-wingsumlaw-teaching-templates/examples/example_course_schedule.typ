#import "../templates/t_course_doc.typ": course_doc, make_title
#import "this_course.typ": this_course
#import "../templates/t_course_sched.typ": make_course_sched
#import "assignment_list.typ": assignment_list

#let classes = (
    (
        "date": datetime(year: 2026, month: 10, day: 1),
        "topic": "Introduction to the course"),
    (
        "date": datetime(year: 2026, month: 10, day: 8),
        "topic": "Topic 1: Basics"),
    (
        "date": datetime(year: 2026, month: 10, day: 15),
        "topic": "Topic 2: Advanced Concepts"),
    (
        "date": datetime(year: 2026, month: 10, day: 22),
        "topic": "Midterm Exam"),
    (
        "date": datetime(year: 2026, month: 10, day: 29),
        "topic": "Topic 3: Applications"),
    (
        "date": datetime(year: 2026, month: 11, day: 5),
        "topic": "Topic 4: Case Studies"),
    (
        "date": datetime(year: 2026, month: 11, day: 12),
        "topic": "Final Project Presentations"),
    (
        "date": datetime(year: 2026, month: 11, day: 19),
        "topic": "Final Exam")
)

#show: course_doc.with(this_course, "Schedule for " + this_course.info.code)
#show: make_title.with("Schedule for " + this_course.info.code, this_course.info.semester)

#show: make_course_sched.with(classes, assignment_list)
