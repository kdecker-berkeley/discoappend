context("findability of chunks")
library(discoveryengine)

test_that("all chunks are accounted for in the registry", {
  all_r_files <- list.files(system.file("R", package = "discoappend"))
  existing_chunks <- grep("^chunk", all_r_files, value = TRUE)
  existing_chunks <- gsub("^chunk-", "", existing_chunks)
  existing_chunks <- gsub("\\.R$", "", existing_chunks)
  existing_chunks <- gsub("-", "_", existing_chunks)

  registered_chunks <- chunk_df()$chunk_name

  not_registered <- setdiff(existing_chunks, registered_chunks)
  nr_msg <- paste("some chunks have not been registered: ",
                  paste(not_registered, collapse = ", "), sep = "")
  expect(length(not_registered) == 0L, nr_msg)

  not_existing <- setdiff(registered_chunks, existing_chunks)
  ne_msg <- paste("some chunks in the registry don't exist: ",
                  paste(not_existing, collapse = ", "), sep = "")
  expect(length(not_existing) == 0L, ne_msg)

  dupes <- registered_chunks[duplicated(registered_chunks)]
  dupe_msg <- paste("these chunks appeared twice in the registry: ",
                    paste(dupes, collapse = ", "), sep = "")
  expect(length(dupes) == 0L, dupe_msg)
})

