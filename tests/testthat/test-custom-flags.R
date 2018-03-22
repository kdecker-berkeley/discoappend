context("custom flags")
library(discoveryengine)

test_that("custom_flags work for any disco engine definition", {
  # atomic, compound, flist, custom
  wealthy = has_capacity(1)
  flag1 = has_interest(MUS)
  flag2 = flag1 %and% majored_in(540)
  flag3 = parent_of(flag1)
  flag4 = gave_to_area(HSB)
  flag5 = flag4 %and% flag2
  flag6 = parent_of(flag5)


  test1 = wealthy %>%
    custom(flag1 = flag1)

  test2 = wealthy %>% custom(flag1 = flag1, flag2 = flag2)
  test3 = wealthy %>% custom(flag3 = flag3)
  test4 = wealthy %>% custom(flag1 = flag1, flag4 = flag4)
  test5 = wealthy %>% custom(flag5 = flag5)
  test6 = wealthy %>% custom(flag6 = flag6)
  test7 = wealthy %>% custom(
    flag1 = flag1,
    flag2 = flag2,
    flag3 = flag3,
    flag4 = flag4,
    flag5 = flag5,
    flag6 = flag6
  )

  # ideally, we also test the generated SQL from these
  expect_is(test1, "report")
  expect_is(test2, "report")
  expect_is(test3, "report")
  expect_is(test4, "report")
  expect_is(test5, "report")
  expect_is(test6, "report")
  expect_is(test7, "report")
})

