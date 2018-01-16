context("basic_bio")
library(discoveryengine)
source("helpers.R")

test_that("basic_bio meets specifications on standard input", {
  wealthy <- has_capacity(1)
  test <- basic_bio(wealthy)
  test %>% uses_table("d_entity_mv")
  test %>% id_of_type("entity_id")
  test %>% id_field_is("entity_id")
})

