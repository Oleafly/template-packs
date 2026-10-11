#let template-names = ("default", "mai-university-lab", "mirea-university-report")

#let title-template-factory(template, arguments-function) = {
  (..arguments) => template(..arguments-function(..arguments))
}

#let custom-title-template(module) = {
  title-template-factory(module.template, module.arguments)
}

#import "../title-templates/default.typ" as default_module
#import "../title-templates/mai-university-lab.typ" as mai_university_lab_module
#import "../title-templates/mirea-university-report.typ" as mirea_university_report_module

#let templates = (
  default: title-template-factory(
    default_module.template,
    default_module.arguments,
  ),
  "mai-university-lab": title-template-factory(
    mai_university_lab_module.template,
    mai_university_lab_module.arguments,
  ),
  "mirea-university-report": title-template-factory(
    mirea_university_report_module.template,
    mirea_university_report_module.arguments,
  ),
)
