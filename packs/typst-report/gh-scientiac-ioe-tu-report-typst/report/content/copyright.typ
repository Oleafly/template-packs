#import "../lib/lib.typ": project-meta

= Copyright #sym.copyright

#context {
  let meta = project-meta.get()

  [
    The author has agreed that the Library, #meta.department, #meta.campus, Institute of Engineering may make this report freely available for inspection. Moreover, the author has agreed that permission for extensive copying of this project report for scholarly purposes may be granted by the supervisor(s) who supervised the thesis work recorded herein or, in their absence, by the Head of the Department wherein the thesis report was done. It is understood that recognition will be given to the author of this report and to the #meta.department, #meta.campus, Institute of Engineering in any use of the material of this thesis report. Copying, publication, or other use of this report for financial gain without the approval of the #meta.department, #meta.campus, Institute of Engineering and the author's written permission is prohibited.

    Request for permission to copy or to make any other use of the material in this report, in whole or in part, should be addressed to:

    \
    Head\
    #meta.department\
    #meta.campus, Institute of Engineering\
    #meta.address
  ]
}
