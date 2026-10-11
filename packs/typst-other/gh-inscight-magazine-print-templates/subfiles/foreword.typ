//////////////////////////////////////////////////////////////////////////////
// EXAMPLE ARTICLE FOR INSCIGHT
// I HAVE TRIED MY BEST TO INCLUDE AS MANY EXAMPLES OF TEMPLATING AS POSSIBLE
// TO MAKE THE EXAMPLE AS COMPREHENSIVE AS I CAN.
// IF YOU FIND ANYTHING UNCLEAR OR HAVE THOUGHTS ON MAKING THIS MORE
// COMPLETE, LET ME KNOW.
//////////////////////////////////////////////////////////////////////////////

#import "/template-files/inscight-template.typ": * // this simply imports the layouts and helpers; this never changes

#show: foreword.with(
  issueDetails: yaml("/dataFiles/issueData.yml"),
  title: "Tradition, Science, and the Search for Truth",
  // appropriate title that captures the spirit of the writeup.
  // passing some title is mandatory, otherwise the template
  // will interpret this as the "Editor's word" section instead.
  // keys: ("arora", "comic"),
  // A title is not needed for the editor's word section, 
  // it's automatically set internally. In fact, IT IS
  // NECESSARY FOR THE TEMPLATE THAT YOU NOT PASS ANY TITLE,
  // in order to disntinguish this from the foreword section,
  // that uses the same function.
  imgWidths: (100%, 100%),
  fraction: 1.6fr,
  // array of widths for the above images
  // if left empty, images will take up entirety of right column
  author: [Prof. Sayam Sen Gupta],
  affiliation: [Department Of Chemical Sciences, IISER Kolkata],
  // full name and affiliation of editor who wrote this
)

A science magazine is not a science journal. A science magazine has the requirement of being intelligible to an educated person who is not an expert in the field, and not even a scientist. The target reader is someone who follows logic but not the mathematics involved and not the associated jargon. The scientific logic should take the driver's seat. Yet, being a magazine, it should have a literary flair. The reader, on the other hand, should understand that he is not reading a novel. To understand the development of ideas and their connection to phenomena demands a thorough reading; one cannot skip pages or paragraphs! When this bonding between the author and the reader is established, a science magazine can claim a success.

Publishing a science magazine is thus a difficult proposition. As InScight enters into its tenth issue, it graduates to its adulthood in less than two years and I feel proud to present this issue to you. Like the earlier issues, this contains science, science news, and interviews of persons directly involved in the scientific discoveries. The interview with the
founder director should be an added attraction.

Today, like every aspect in life, the mission of science is like “do it now!” Saki's Prince Dimitri hated “this to-be-left-till-called-for business”. However, in science, one needs to have patience. One has to work with passion, sitting idle does not work; but people might have to wait for generations to achieve its goal. One stellar example is the discovery of gravity waves in 2015. Einstein published his general theory of relativity in 1915, which turned out to be the most successful theory of gravity and to many, is the most beautiful geometric theory in physics. If it were true, there should be a wave associated with the change in the gravitational field. Weber started with huge aluminium bars to detect gravity waves in 1960's, but the mankind had to wait for a century after Einstein's prediction before its actual detection.

Science and its stories are thus fascinating and a science magazine brings them to people.

The commendable zeal and the creativity of the students of IISER Kolkata opened this new gateway to knowledge. Trust that this will last till eternity. I once again invite you to this issue of InScight and so many more to come.
