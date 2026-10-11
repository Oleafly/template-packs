// Точка входа отчёта. Обычно этот файл менять не требуется.
// Сначала подключаются шаблон, конфигурация и содержимое разделов.
#import "template/report.typ": lab-report
#import "config.typ": config
#import "sections/task.typ": task
#import "sections/work.typ": work
#import "sections/conclusion.typ": conclusion
#import "sections/sources.typ": sources

// Затем все части передаются главному компоненту, который формирует PDF.
#lab-report(
  config: config,
  task: task,
  work: work,
  conclusion: conclusion,
  sources: sources,
)
