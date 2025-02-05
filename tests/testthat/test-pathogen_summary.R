test_that("pathogen_summary works with valid input", {
  ebola_summary <- pathogen_summary(pathogen = "ebola")
  expect_s3_class(ebola_summary, "data.frame")
  expect_identical(dim(ebola_summary), c(3L, 7L))
  expect_named(
    ebola_summary,
    c("pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI")
  )
  expect_type(ebola_summary$pathogen, "character")
  expect_type(ebola_summary$delay_dist, "character")
  expect_type(ebola_summary$distribution, "character")
  expect_type(ebola_summary$mean, "double")
  expect_type(ebola_summary$sd, "double")
  expect_type(ebola_summary$study, "character")
  expect_type(ebola_summary$DOI, "character")
  expect_snapshot(pathogen_summary(pathogen = "ebola"))
})

test_that("pathogen_summary works with pathogen with gamma and lnorm", {
  sars_summary <- pathogen_summary(pathogen = "SARS_CoV")
  expect_s3_class(sars_summary, "data.frame")
  expect_identical(dim(sars_summary), c(3L, 7L))
  expect_named(
    sars_summary,
    c("pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI")
  )
  expect_type(sars_summary$pathogen, "character")
  expect_type(sars_summary$delay_dist, "character")
  expect_type(sars_summary$distribution, "character")
  expect_type(sars_summary$mean, "double")
  expect_type(sars_summary$sd, "double")
  expect_type(sars_summary$study, "character")
  expect_type(sars_summary$DOI, "character")
  expect_snapshot(pathogen_summary(pathogen = "SARS_CoV"))
})

test_that("pathogen_summary works with pathogen with weibull", {
  h5n1_summary <- pathogen_summary(pathogen = "influenza_H5N1")
  expect_s3_class(h5n1_summary, "data.frame")
  expect_identical(dim(h5n1_summary), c(2L, 7L))
  expect_named(
    h5n1_summary,
    c("pathogen", "delay_dist", "distribution", "mean", "sd", "study", "DOI")
  )
  expect_type(h5n1_summary$pathogen, "character")
  expect_type(h5n1_summary$delay_dist, "character")
  expect_type(h5n1_summary$distribution, "character")
  expect_type(h5n1_summary$mean, "double")
  expect_type(h5n1_summary$sd, "double")
  expect_type(h5n1_summary$study, "character")
  expect_type(h5n1_summary$DOI, "character")
  expect_snapshot(pathogen_summary(pathogen = "influenza_H5N1"))
})
