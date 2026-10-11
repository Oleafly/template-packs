#import "utils/global-imports.typ": * 


= Methodology

#blindtext(paragraphs: 13, length: "medium", lang: "en")


#import "utils/pseudocode.typ": * 

#pseudocode("Algorithm Selection via SSP Similarity", 
[
+ *procedure* #smallcaps[SolveTask]\(task(gridA, gridB, gridC))
  + *for each* k, grid *in* task.grids *do*
    + ssps.k $<-$ encode(grid) 
  + *end*
  + sspA, sspB, sspC $<-$ ssps

  + similarities_and_results $<-$ [ ]

  + *for each* solvingMethod *in* solvingAlgorithms *do*
    + ssp_resultAB, ssp_resultCD $<-$ process(solvingMethod, sspA, sspB, sspC)
    + similarity $<-$ ssp_resultAB $dot$ sspB
    + similarities_and_results.append((similarity, ssp_resultCD))
  + *end*

  + best_similarity, best_result $<-$ max(similarities_and_results, by: it[0])
  + *return* decode(best_result)
]
)