#import "../style.typ": zihao
#import "../utils.typ": *

#let introduction-page(
  doctype: "master",
  ziti: (:),
) = {
  if doctype == "midterm" {
    align(
      center,
      text(
        "填报说明",
        font: ziti.heiti,
        size: zihao.xiaosan,
      )
        + h(1em)
        + text(
          "Instruction",
          size: zihao.xiaosan,
          weight: "bold",
        ),
    )
  } else {
    align(
      center,
      text(
        "填    报    说    明",
        font: ziti.heiti,
        size: zihao.xiaosan,
        weight: "bold",
      ),
    )

    v(1em)

    align(
      center,
      text(
        "Instruction",
        size: zihao.xiaosan,
        weight: "bold",
      ),
    )
  }

  v(1em)

  if doctype == "proposal" {
    [
      1. 校本部研究生的开题报告应通过#mysjtu-link[数字交大]在线提交申请，填写本表并上传系统。特殊情况下经研究生院事先同意，可不上传系统，并使用《上海交通大学研究生论文开题评审表》完成评审。
        #v(0.2em)
        The application for thesis/dissertation proposal should be submitted online through #mysjtu-link[My SJTU]. The student shall fill this form and upload it in the system. Under special circumstance, this form does not need to be uploaded and the review can be proceeded with the review form with prior consent from the graduate school.
        #v(0.1em)

      2. 开题报告为A4大小，于左侧装订成册。各栏空格不够时，请自行加页。考核前提前一周送交导师、评审专家审阅。
        #v(0.2em)
        This form should be printed with A4 papers and bound together on the left. If the space left is not enough, please feel free to add extra pages.The print version shall be sent to the supervisor, and the review committee members for review at least one week before the oral presentation.
        #v(0.1em)

      3. 博士生导师可以根据博士生学位论文选题情况自行确定是否进行开题查新，博士学位论文开题查新报告应由查新工作站提供。
        #v(0.2em)
        The supervisor should decide, based on the proposed topics, whether a novelty assessment report is needed or not, which should be conducted by an authorized novelty assessment department.
        #v(0.1em)

      4. 开题报告通过后，定稿版开题报告由研究生、导师各存档一份，无需上传系统。
        #v(0.2em)
        Upon passing the proposal, the final version of this report shall be archived by the graduate student and his/her supervisors for future reference.
        #v(0.1em)

      5. 医学院研究生如果以函评形式开题，开题地点请填写“函评”，专家组组长签名由导师签名。
        #v(0.2em)
        For students in the School of Medicine, if the dissertation proposal is conducted via peer review, the “Proposal venue” shall be filled with “peer review” and the “Signature of Committee Chair” shall be signed by the supervisor.
        #v(0.1em)
    ]
  } else if doctype == "midterm" {
    [
      1. 硕士研究生学位论文中期检查应通过#mysjtu-link[数字交大]在线提交申请，填写本表并上传系统。特殊情况下经研究生院事先同意，可不上传系统，并使用《上海交通大学硕士论文中期检查评审表》完成评审。
        #v(0.2em)
        The application for thesis mid-term examination should be submitted online through #mysjtu-link[My SJTU]. The student shall filled this form and upload it in the system. Under special circumstance, this form does not need to be uploaded and the review can be proceeded with the review form with prior consent from the graduate school.
        #v(0.1em)

      2. 本报告请用A4纸双面打印，于左侧订在一起。各栏空格不够时，请自行加页。考核前提前一周送交导师、评审专家审阅。
        #v(0.2em)
        This report should be printed with A4 papers and bound together on the left. If the space left is not enough, please feel free to add extra pages. The print version shall be sent to the supervisor, and the review committee members for review at least one week before the oral presentation.
        #v(0.1em)

      3. 中期检查报告通过后，定稿版报告由研究生、导师各存档一份，无需上传系统。
        #v(0.2em)
        Upon passing the review, the final version of this report shall be archived by the graduate student and his/her supervisors for future reference.
        #v(0.1em)
    ]
  } else if doctype == "annual-progress" {
    [
      1. 博士研究生年度进展报告应通过#mysjtu-link[数字交大]在线提交申请，填写本表并上传系统。特殊情况下经研究生院事先同意，可不上传系统，并使用《上海交通大学博士研究生年度进展报告评审表》完成评审。
        #v(0.2em)
        The application for thesis/dissertation work annual progress review should be submitted online through #mysjtu-link[My SJTU]. The student shall filled this form and upload it in the system. Under special circumstance, this form does not need to be uploaded and the review can be proceeded with the review form with prior consent from the graduate school.
        #v(0.1em)

      2. 本报告应A4纸双面打印，于左侧钉在一起。各栏空格不够时，请自行加页。考核前提前一周送交导师、评审专家审阅。
        #v(0.2em)
        This report should be printed with A4 papers and bound together on the left. If the space left is not enough, please feel free to add extra pages. The print version shall be sent to the supervisor, and the review committee members for review at least one week before the oral presentation.
        #v(0.1em)

      3. 年度进展报告通过后，定稿版报告由研究生、导师各存档一份，无需上传系统。
        #v(0.2em)
        Upon passing the review, the final version of this report shall be archived by the graduate student and his/her supervisors for future reference.
        #v(0.1em)
    ]
  }

  pagebreak(weak: true)
}
