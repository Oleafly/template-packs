// ============================================================
// AMIA Symposium Example Paper
// ============================================================
// Compile: typst compile --root . example/main.typ

#import "../template/amia-symposium.typ": amia-symposium

#show: amia-symposium.with(
  title: "The Impact of Natural Language Processing on Clinical Decision Support: A Systematic Review",

  authors: (
    ("John A. Smith, PhD", (1,)),
    ("Jane M. Doe, MD, MS", (1, 2)),
    ("Robert L. Johnson, MPH", (2,)),
  ),

  affiliations: (
    "Department of Biomedical Informatics, University of Health Sciences, Boston, MA",
    "Division of Clinical Informatics, Memorial Hospital, New York, NY",
  ),

  abstract: [
    Natural language processing (NLP) has emerged as a promising approach for enhancing clinical decision support (CDS) by extracting information from unstructured clinical narratives. This systematic review examines the current state of NLP-enabled CDS systems, evaluating their methods, performance, and clinical impact. We searched MEDLINE, Embase, and the ACM Digital Library for studies published between 2015 and 2025. Of 1,247 unique records, 42 studies met inclusion criteria. Transformer-based models were the most commonly used NLP approach (54.8%), with a median F1 score of 0.89 for named entity recognition. While 42.9% of studies reported significant improvements in clinical outcomes, only 21.4% were evaluated in real-time clinical settings. Our findings indicate that NLP-CDS systems have made substantial technical advances, but significant gaps remain in real-world deployment, algorithmic fairness, and workflow integration.
  ],

  keywords: (
    "Natural Language Processing",
    "Clinical Decision Support",
    "Electronic Health Records",
    "Systematic Review",
  ),

  bib: bibliography("refs.bib", style: "american-medical-association"),
)

// ---- Main body ----

= Introduction

Natural language processing (NLP) has emerged as a transformative technology in clinical informatics, enabling the extraction and analysis of unstructured data from electronic health records (EHRs) #cite(<nadkarni2011nlp>). The growing adoption of EHR systems has resulted in an unprecedented accumulation of clinical narratives, including physician notes, discharge summaries, and radiology reports, which contain valuable information for clinical decision support (CDS) #cite(<kreimeyer2017nlp>). However, the majority of this information remains locked in free-text format, inaccessible to traditional rule-based CDS systems that rely on structured data #cite(<chapman2011overcoming>).

Recent advances in deep learning and large language models have significantly improved the performance of clinical NLP systems, achieving state-of-the-art results on tasks such as named entity recognition, relation extraction, and text classification #cite(<wu2020deep>)#cite(<lee2020biobert>). These developments have renewed interest in integrating NLP capabilities into CDS workflows, promising to enhance the completeness and timeliness of clinical recommendations #cite(<bates2003effects>).

Despite these advances, the translation of NLP research into practical CDS applications faces several challenges. These include issues related to data privacy, model generalizability, clinical workflow integration, and the need for rigorous evaluation in real-world settings #cite(<rajan2024clinical>). Understanding the current landscape of NLP-enabled CDS systems is essential for identifying best practices and guiding future research directions.

= Methods

== Search Strategy

We conducted a systematic review following the Preferred Reporting Items for Systematic Reviews and Meta-Analyses (PRISMA) guidelines #cite(<liberati2009prisma>). We searched MEDLINE, Embase, and the ACM Digital Library for studies published between January 2015 and December 2025. The search strategy combined terms related to natural language processing, clinical decision support, and electronic health records.

== Inclusion Criteria

Studies were included if they: (1) described the development or evaluation of an NLP system integrated with a CDS intervention, (2) were conducted in a clinical or simulated clinical setting, (3) reported quantitative performance metrics, and (4) were published in English. We excluded review articles, editorials, and studies that only used structured data.

== Data Extraction and Quality Assessment

Two reviewers independently extracted data on study characteristics, NLP methods, CDS integration approach, and performance outcomes. Disagreements were resolved through consensus. Study quality was assessed using a modified version of the Newcastle-Ottawa Scale adapted for NLP-CDS studies.

== Statistical Analysis

We summarized model performance using the $F_1$ score, the harmonic mean of precision $P$ and recall $R$, defined in @eq-f1. Inline expressions such as $P = "TP" / ("TP" + "FP")$ are written between single dollar signs, while display equations are placed between spaced dollar signs and are numbered automatically:

$ F_1 = 2 dot (P dot R) / (P + R) $ <eq-f1>

Inter-rater agreement was assessed with Cohen's $kappa$, and pooled estimates were computed under a random-effects model.

= Results

== Study Selection

Our search yielded 1,247 unique records, of which 42 studies met the inclusion criteria (@fig-flow). The inter-rater agreement for study selection was high (kappa = 0.84).

#figure(
  image("fig1.png", width: 100%),
  caption: [Study selection flow: (a) records identified, (b) title/abstract
    screening, (c) duplicates removed, (d) full-text assessment, (e) excluded
    studies, and (f) studies included in the final synthesis.],
) <fig-flow>

== Characteristics of Included Studies

Of the 42 included studies, 28 (66.7%) focused on medication-related CDS, 8 (19.0%) on diagnostic decision support, and 6 (14.3%) on preventive care recommendations. The majority of studies (n = 31, 73.8%) were conducted in academic medical centers.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    table.header(
      table.cell([Study Characteristic]),
      table.cell([Number]),
      table.cell([Percentage]),
    ),
    [Medication-related CDS], [28], [66.7%],
    [Diagnostic decision support], [8], [19.0%],
    [Preventive care], [6], [14.3%],
    [Academic medical center], [31], [73.8%],
  ),
  caption: [Characteristics of included studies by focus area and setting.],
)

== NLP Methods and Performance

The most commonly used NLP approaches were transformer-based models (n=23, 54.8%), followed by traditional machine learning methods (n=12, 28.6%) and rule-based systems (n=7, 16.7%). The median F1 score for named entity recognition tasks was 0.89 (IQR: 0.82--0.94), and the median accuracy for text classification tasks was 0.91 (IQR: 0.85--0.95).

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    table.header(
      table.cell([NLP Approach]),
      table.cell([Number]),
      table.cell([Percentage]),
    ),
    [Transformer-based], [23], [54.8%],
    [Traditional ML], [12], [28.6%],
    [Rule-based], [7], [16.7%],
  ),
  caption: [Distribution of NLP approaches used in included studies.],
)

== Clinical Impact

Of the 42 studies, 18 (42.9%) reported statistically significant improvements in clinical outcomes, including reduced medication errors, improved guideline adherence, and earlier detection of adverse events. However, only 9 studies (21.4%) were conducted in a real-time clinical environment, limiting the generalizability of these findings to routine practice.

= Discussion

This systematic review demonstrates that NLP-enabled CDS systems have made substantial progress in recent years, particularly with the adoption of transformer-based architectures. The high performance observed on NLP tasks suggests that the technical barriers to clinical NLP implementation are increasingly surmountable #cite(<velupillai2018recent>).

However, several important challenges remain. First, the gap between NLP system development and clinical deployment remains substantial. Only a minority of studies evaluated their systems in real-time clinical settings, and even fewer assessed the impact on patient outcomes beyond process measures #cite(<rajan2024clinical>). Second, issues of algorithmic fairness and bias in clinical NLP systems have received insufficient attention, despite growing evidence that NLP models can perpetuate or amplify existing health disparities #cite(<obermeyer2019dissecting>).

== Limitations

This review has several limitations. The heterogeneity of study designs and outcome measures precluded meta-analysis of clinical impact. Publication bias may have resulted in overestimation of NLP system performance. Additionally, the rapid pace of advancement in NLP technology means that findings from studies using older methods may not reflect current capabilities.

== Future Directions

Future research should prioritize prospective evaluations of NLP-CDS systems in diverse clinical settings, with particular attention to health equity, workflow integration, and sustainability. The development of standardized evaluation frameworks and reporting guidelines for NLP-CDS studies would facilitate meaningful comparisons across studies and accelerate the translation of research into practice.

= Conclusion

Natural language processing has the potential to significantly enhance clinical decision support by unlocking the wealth of information contained in clinical narratives. While recent technical advances, particularly in deep learning, have improved system performance, substantial work remains to bridge the gap between research and clinical implementation. Addressing challenges related to real-world evaluation, algorithmic fairness, and workflow integration will be critical to realizing the full potential of NLP-enabled clinical decision support.
