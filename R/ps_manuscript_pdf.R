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
ps_manuscript_pdf <- function(..., keep_tex = TRUE) {
  template <- find_resource("ps_manuscript_pdf", "template.tex")
  inherit_pdf_document(...,
                       template = template,
                       keep_tex = keep_tex)
}
