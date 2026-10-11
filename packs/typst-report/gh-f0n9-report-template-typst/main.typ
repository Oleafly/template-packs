#import "src/template.typ": project
#import "metadata.typ": *

#show: project.with(
  title: project_title,
  subtitle: project_subtitle,
  university: university,
  faculty: faculty,
  department: department,
  course: course,
  class: class_name,
  author_name: author_name,
  author_id: author_id,
  author_email: author_email,
  instructor: instructor_name,
  date: submission_date,
  logo: "../assets/logo.png",
  border: "../assets/border.png",
)

// Nội dung báo cáo bắt đầu từ đây
#include "content/01_intro.typ"
#include "content/02_summary.typ"

// Các phần khác...
