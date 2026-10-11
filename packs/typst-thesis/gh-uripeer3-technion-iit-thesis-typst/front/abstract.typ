#let abstract-english = [
  At this point you write the abstract of your work, in the main language in
  which it is written (in this template - English). Graduate school regulations
  require the abstract to constitute an independent whole and be understood to a
  reader with general knowledge of the field. Use complete sentences and make
  few or no citations. Do not refer to the main body of the work and do not use
  uncommon shorthand, symbols and terms unless you have room for explaining
  them. The English abstract should be between 200 and 500 words long.

  So this should contain a few more paragraphs... we'll fill them using some
  placeholder text (in Latin):

  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Ut purus elit,
  vestibulum ut, placerat ac, adipiscing vitae, felis. Curabitur dictum gravida
  mauris. Nam arcu libero, nonummy eget, consectetuer id, vulputate a, magna.
  Donec vehicula augue eu neque. Pellentesque habitant morbi tristique senectus
  et netus et malesuada fames ac turpis egestas. Mauris ut leo. Cras viverra
  metus rhoncus sem. Nulla et lectus vestibulum urna fringilla ultrices.
  Phasellus eu tellus sit amet tortor gravida placerat. Integer sapien est,
  iaculis in, pretium quis, viverra ac, nunc. Praesent eget sem vel leo ultrices
  bibendum. Aenean faucibus. Morbi dolor nulla, malesuada eu, pulvinar at,
  mollis ac, nulla. Curabitur auctor semper nulla. Donec varius orci eget risus.
  Duis nibh mi, congue eu, accumsan eleifend, sagittis quis, diam. Duis eget
  orci sit amet orci dignissim rutrum.

  Nam dui ligula, fringilla a, euismod sodales, sollicitudin vel, wisi. Morbi
  auctor lorem non justo. Nam lacus libero, pretium at, lobortis vitae,
  ultricies et, tellus. Donec aliquet, tortor sed accumsan bibendum, erat ligula
  aliquet magna, vitae ornare odio metus a mi. Morbi ac orci et nisl hendrerit
  mollis. Suspendisse ut massa. Cras nec ante. Pellentesque a nulla. Cum sociis
  natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
  Aliquam tincidunt urna. Nulla ullamcorper vestibulum turpis. Pellentesque
  cursus luctus mauris.

  #hide[@CLR @hoeffding1963 @Knuth1973 @Yao1977]
]

#let abstract-hebrew = [#text(lang: "he")[
  כאן יבוא תקציר מורחב בעברית (כאשר שפת החיבור העיקרית היא אנגלית). היקף
  התקציר יהיה 1000-2000 מילים. התקציר יהווה שלמות בפני עצמו ויהיה מובן לקורא
  בעל ידיעות כלליות בנושא.

  בית הספר ללימודי מוסמכים מנחה מספר הנחיות לגבי התקציר בעברית:

  - על התקציר להיכתב במשפטים מקושרים שלמים.
  - בדרך-כלל אין לציין בתקציר מקורות ספרותיים וציטוטים.
  - אין להתייחס למספר של פרק, סעיף, נוסחה, ציור או טבלה שבגוף החיבור, ואין
    להשתמש בקיצורים, סמלים ומונחים לא מקובלים, אלא אם יש בתקציר די מקום
    לזיהויים.

  לעתים יש בכל-זאת צורך לכלול קישור פנימי, קישור חיצוני, מונח באנגלית או
  ציטוט בתוך התקציר העברי. בתבנית Typst זו מומלץ להשתמש במקטעי
  `text(lang: "en", dir: ltr)` עבור טקסט אנגלי קצר, ולבדוק את התוצאה בקובץ
  ה-PDF לאחר ההידור. לדוגמה: אם יש צורך לצטט מקור ביבליוגרפי, אפשר לכתוב
  הפניה רגילה כגון `@hoeffding1963` בתוך משפט עברי, או לעטוף ביטוי אנגלי קצר
  בכיוון שמאל-לימין כדי למנוע ערבוב כיוונים בלתי רצוי.

  #heading(level: 2, numbering: none, outlined: false)[תת-חלק בתקציר המורחב]

  תוכן מקוצר לגבי נושא מסוים. התייחסות ל#emph[מושג] מסוים שהחיבור בוחן. וכולי
  וכולי.

  #heading(level: 2, numbering: none, outlined: false)[נקודה מעניינת לגבי העמודים בעברית]

  שימו לב כי העמודים בעברית אמורים להיות מיוצרים בסדר ה"הפוך", הווה אומר
  העמוד האחרון בקובץ ה-PDF הוא הכריכה העברית, לפניו השער העברי, ודפי התקציר
  צריכים להופיע בסדר הפוך (וכן במספור רומי, לפי נהלי הטכניון). כך אם נתבונן
  במספר שבתחתית עמוד זה -- אשר צריך להיות העמוד הראשון בתקציר-המורחב מבחינת
  רצף התוכן, והינו העמוד האחרון מבין עמודי התקציר-המורחב בקובץ ה-PDF -- נמצא
  את המספר i ...

  #pagebreak()

  ... ואילו עמוד זה של התקציר-המורחב בעברית -- שהינו העמוד השני
  בתקציר-המורחב מבחינת רצף התוכן, ונמצא ראשון בקובץ ה-PDF -- ממוספר ב-ii.
  המטרה במספור בסדר ה"הפוך" היא, שבעת ההדפסה לא יהיה צורך להפוך דפים, לשנות
  את סדרם וכולי -- רק להדפיס ולכרוך.
]]
