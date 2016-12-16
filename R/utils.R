package_file <- function(...) {
  system.file(..., package = "rmdmanuscripts")
}

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
find_file <- function(template, file) {
  template <- package_file("rmarkdown", "templates", template, file)
  if (template == "") {
    stop("Couldn't find template file ", template, "/", file, call. = FALSE)
  }
  template
}

find_csl <- function(name) {
  filename <- paste0(name, ".csl")
  csl <- package_file("rmarkdown", "csl", filename)
  if (csl == "") {
    stop("Couldn't find CSL file ", filename, call. = FALSE)
  }
  csl
}

# From https://github.com/rstudio/rticles/blob/10a396d3ffff0ffd7aeabf55391d2d60d9b5e859/R/utils.R
find_resource <- function(template, file) {
  find_file(template, file.path("resources", file))
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



