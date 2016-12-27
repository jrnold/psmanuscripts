#' @importFrom rmarkdown pandoc_variable_arg
NULL

#' Political Science PDF manuscript format
#'
#' Format for submitting a manuscript to a political science journal.
#' Adapted from
#' \href{http://www.apsanet.org/Portals/54/APSA\%20Files/publications/APSAStyleManual2006.pdf}{APSA Style Manual for Political Science},
#' and the submission instructions for \emph{APSA}, \emph{AJPS}, \emph{JOP}, and \emph{Political Analysis}.
#'
#' @inheritParams rmarkdown::pdf_document
#' @param ... Additional arguments to \code{rmarkdown::pdf_document}
#'
#' @return R Markdown output format to pass to
#'   \code{\link[rmarkdown:render]{render}}
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("MyManuscript.Rmd", template = "ps_manuscript_pdf", package = "rmdmanuscript")
#' }
#' @export
ps_manuscript_pdf <- function(...,
                              number_sections = FALSE,
                              fig_caption = TRUE,
                              dev = "pdf",
                              highlight = NULL,
                              latex_engine = "xelatex",
                              citation_package = "natbib",
                              pandoc_args = NULL,
                              # metadata
                              margin = 1,
                              fontsize = 12,
                              linestretch = 2,
                              anonymous = FALSE
                              )
  {
  args <- c()
  args <- c(args, pandoc_variable_arg("fontsize", fontsize))
  args <- c(args, pandoc_variable_arg("linestretch", linestretch))
  args <- c(args, pandoc_variable_arg("margin", margin))
  args <- c(args, pandoc_variable_arg("biblio-title", "References"))
  if (anonymous) {
    args <- c(args, "--variable", "anonymous")
  }
  args <- c(args, pandoc_args)

  template <- find_resource("ps_manuscript_pdf", "template.tex")
  fmt <- inherit_pdf_document(template = template,
                              # from call
                              number_sections = number_sections,
                              fig_caption = fig_caption,
                              dev = dev,
                              highlight = highlight,
                              latex_engine = latex_engine,
                              citation_package = citation_package,
                              toc = FALSE,
                              #
                              pandoc_args = args,
                              ...)
  fmt
}


#' @rdname ps_manuscript_pdf
#' @param csl Path to CSL file to use
#' @export
ps_manuscript_word <- function(..., csl = NULL) {
  reference_docx <- find_resource("ps_manuscript_word", "reference.docx")
  fmt <- rmarkdown::word_document(..., reference_docx = reference_docx)
  if (is.null(csl)) {
    csl <- find_csl("american-political-science-review")
  }
  fmt$pandoc$args <- c(fmt$pandoc$args,
                       "--csl",
                       rmarkdown::pandoc_path_arg(csl))
  fmt
}
