#' Political science manuscript format
#'
#' Format for submitting a manuscript to a political science journal.
#' Adapted from
#' \href{http://www.apsanet.org/Portals/54/APSA\%20Files/publications/APSAStyleManual2006.pdf}{APSA Style Manual for Political Science},
#' and the submission instructions for \emph{APSA}, \emph{AJPS}, \emph{JOP}, and \emph{Political Analysis}.
#'
#' @inheritParams rmarkdown::pdf_document
#'
#' @return R Markdown output format to pass to
#'   \code{\link[rmarkdown:render]{render}}
#'
#' @examples
#'
#' \dontrun{
#' library(rmarkdown)
#' draft("MyManuscript.Rmd", template = "apsa_manuscript", package = "apsamanu")
#' }
#'
#' @export
apsa_manuscript <- function(fig_width = 6.5,
                            fig_height = 4.5,
                            fig_crop = TRUE,
                            highlight = "default",
                            dev = "pdf",
                            keep_tex = TRUE,
                            latex_engine = "pdflatex",
                            includes = NULL,
                            md_extensions = NULL,
                            pandoc_args = NULL) {
  template <- system.file("rmarkdown",
                          "templates",
                          "apsa_manuscript",
                          "resources",
                          "apsa_manuscript.tex",
                          package = "apsamanu")
  base <- rmarkdown::pdf_document(fig_width = fig_width,
                                   fig_height = fig_height,
                                   fig_crop = fig_crop,
                                   highlight = highlight,
                                   dev = dev,
                                   keep_tex = keep_tex,
                                   latex_engine = latex_engine,
                                   includes = includes,
                                   md_extensions = md_extensions,
                                   pandoc_args = pandoc_args,
                                   fig_caption = TRUE,
                                   template = template)
  base
}
