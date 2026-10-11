/// Typst-шаблон для оформления выпускных квалификационных работ МФТИ.
///
/// == Публичное API
///
/// - `mipt-diploma` — главная функция-шаблон, применяется как `show`-правило
/// - `annotation` — страница реферата (русский + английский)
/// - `unnumbered` — ненумерованный заголовок раздела (Введение, Заключение…)
/// - `appendix` — блок приложений с буквенной нумерацией

#import "lib/template.typ": mipt-diploma
#import "lib/utils.typ": annotation, unnumbered, appendix
