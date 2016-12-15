# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
find_file <- function(template, file) {
  template <- system.file("rmarkdown", "templates", template, file,
                          package = "rmdmanuscripts")
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }

  template
}

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
}

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
knitr_fun <- function(name) utils::getFromNamespace(name, 'knitr')

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
output_asis <- knitr_fun('output_asis')

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
template_pandoc <- function(metadata, template, output, verbose = FALSE) {
  tmp <- tempfile(fileext = ".md")
  on.exit(unlink(tmp))

  cat("---\n", file = tmp)
  cat(yaml::as.yaml(metadata), file = tmp, append = TRUE)
  cat("---\n", file = tmp, append = TRUE)
  cat("\n", file = tmp, append = TRUE)

  rmarkdown::pandoc_convert(tmp, "markdown", output = output,
                            options = paste0("--template=", template), verbose = verbose)

  invisible(output)
}

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
# Call rmarkdown::pdf_documet and mark the return value as inheriting pdf_document
inherit_pdf_document <- function(...) {
  fmt <- rmarkdown::pdf_document(...)
  fmt$inherits <- "pdf_document"
  fmt
}

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
# Helper function to create a custom format derived from pdf_document
# that includes a custom LaTeX template and custom CSL definition
pdf_document_format <- function(..., format, template, csl) {

  # base format
  fmt <- inherit_pdf_document(..., template = find_resource(format, template))

  # add csl to pandoc_args
  fmt$pandoc$args <- c(fmt$pandoc$args,
                       "--csl",
                       rmarkdown::pandoc_path_arg(find_resource(format, csl)))


  # return format
  fmt
}
