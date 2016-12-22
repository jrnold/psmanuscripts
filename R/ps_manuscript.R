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
#'
#' @export
ps_manuscript_pdf <- function(...,
                              dev = "pdf",
                              citation_package = "natbib",
                              highlight = NULL,
                              latex_engine = "xelatex",
                              keep_tex = TRUE,
                              toc = FALSE,
                              number_sections = FALSE) {
  # template <- find_resource("ps_manuscript_pdf", "template.tex")
  inherit_pdf_document(...,
                       template = "default",
                       keep_tex = keep_tex)
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
