#import "/layout.typ": resume
#let common = yaml("/common.yaml")
#let specific = yaml("config.yaml")
#let data = common + specific
#resume(data)
