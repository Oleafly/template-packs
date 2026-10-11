// TODO: write a more asymptotic algorithm

// pre-calculate based on the space needed for supervisors and advisors
#let spacer(supervisors_len, advisors_len) = {
  // we assume the existence of supervisors
  let spv_space = supervisors_len * 5mm;
  // a spacer is added in for advisors, since they may not always exist
  let adv_count = advisors_len;
  let adv_space = if adv_count == 0 {0cm} else {1cm + adv_count * 5mm};

  // 11.5cm is an experimentally obtained value for the amount of free space
  let space_for_space = 12cm - (spv_space + adv_space);

  // limits: minimum for pre is 2cm, min for post is 1cm
  assert(space_for_space > 4cm, message: "aaaaah")
  // with 1cm of extra buffer for space before bottom section
  let space_quarts = space_for_space / 4;

  // maintain a ratio between these two 2:1
  (space_quarts * 2, space_quarts)
};