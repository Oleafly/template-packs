// Functional
#let getFR(getLen: bool) = {
  let FR = ()
  let m = "FMR"
  let d = "FDR"
  let o = "FOR"
  let mandatory = 0
  let desirable = 0
  let optional = 0
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)), [L'utente non autenticato deve poter effettuare il login inserendo mail e password.],[@us:login]
  ))
  
  mandatory+=1
  FR.push((
    (m + str(mandatory)), [L'utente non autenticato deve poter inserire una mail e una password per potersi registrare.],[@us:registrazione]
  ))
  
  if getLen == true {
    return (mandatory, desirable, optional)
  }
  return FR
}

// Qualitative
#let getQR(getLen: bool) = {
  let QR = ()  
  let m = "QMR"
  let d = "QDR"
  let o = "QOR"
  let mandatory = 0
  let desirable = 0
  let optional = 0
  
  mandatory+=1
  QR.push((
    (m + str(mandatory)), [L'applicazione web deve garantire la compatibilità cross-browser.],[Piano di lavoro.]
  ))
  
  desirable+=1
  QR.push((
    (d+str(desirable)), [L'applicazione web deve poter essere fruibile anche su dispositivi mobile.],[Piano di lavoro.]
  ))
  
  optional+=1
  QR.push((
    (o+str(optional)), [Il sistema nelle nuove analisi aggiorna solo le parti modificate del codice sorgente.], [Piano di lavoro.]
  ))
  
  if getLen == true {
    return (mandatory, desirable, optional)
  }
  return QR
}

// Constraint
#let getCR(getLen: bool) = {
  let CR = ()  
  let m = "CMR"
  let d = "CDR"
  let o = "COR"
  let mandatory = 0
  let desirable = 0
  let optional = 0
  
  mandatory+=1
  CR.push((
    (m + str(mandatory)), [Il front-end dell'applicazione deve essere scritto usando la libreria React con linguaggio Typescript.],[Riunione col tutor.]
  ))
  
  if getLen == true {
    return (mandatory, desirable, optional)
  }
  return CR
}
