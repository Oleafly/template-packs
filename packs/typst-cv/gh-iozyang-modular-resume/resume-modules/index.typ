// 显式注册模块；入口只按 ID 选择与排序。
#import "education.typ": education
#import "experience-example.typ": experience-example
#import "project-activity.typ": activity
#import "project-library.typ": library
#import "project-ledger.typ": ledger
#import "campus-open-source.typ": open-source
#import "campus-library.typ": campus-library
#import "awards-core.typ": awards

#let all-modules = (
  education, experience-example, activity, library, ledger, open-source, campus-library, awards,
)
#let modules = (:)
#for item in all-modules {
  assert(not (item.id in modules), message: "重复模块 ID：" + item.id)
  assert(item.at("source-refs", default: ()).len() > 0,
    message: "模块缺少 source 引用：" + item.id)
  modules.insert(item.id, item)
}

#let select(ids) = {
  assert(ids.dedup().len() == ids.len(), message: "同一章节重复选择了模块 ID。")
  ids.map(id => {
    assert(id in modules, message: "未知模块 ID：" + id + "；请先注册模块。")
    modules.at(id)
  })
}
