#import "../../config/constants.typ" : glossary
#import "terms.typ": glossary-terms
#import "../../config/thesis-config.typ": print-glossary

#pagebreak(to:"odd")
#heading(numbering: none, glossary) <glossary>
/* I termini sono ordinati in ordine alfabetico su `key`.
 * Tutti i termini che iniziano con la lettera maiuscola saranno mostrati per primi (B > a), per questo consiglio di mettere tutte le key in minuscolo.
 * Se vuoi modificare il modo in cui vengono ordinati i termini vedi https://github.com/typst-community/glossarium/issues/107#issuecomment-2692722556
*/
#print-glossary(glossary-terms, deduplicate-back-references: true)
