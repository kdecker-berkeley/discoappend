context("append")
library(discoveryengine)

test_that("only actual chunks can be called from append", {
  wealthy = has_capacity(1)
  expect_error(append(wealthy, rting), "unrecognized chunk")
  expect_error(append(wealthy, has_degree_from(chemistry)),
               "unrecognized chunk")
  expect_error(append(wealthy, 3), "unrecognized chunk")
  expect_error(append(wealthy, display), "unrecognized chunk")
  expect_error(append(wealthy, print), "unrecognized chunk")
  rating <- "1 ($100M+)"
  expect_is(append(wealthy, rating), "report")
})

