context("giving chunk")
library(discoveryengine)

test_that("giving is householded in giving chunk", {
  wealthy = has_capacity(1)

  # not the best way to do this
  qry <- append(wealthy, giving)$template$query[[1]]
  expect_true(grepl("sf_hh_corp_summary_mv", qry))
  expect_false(grepl("sf_entity_summary_mv", qry))
})

