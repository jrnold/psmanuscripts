library("rmarkdown")
library("rmdmanuscripts")

output_formats <- c("ps_manuscript_word", "ps_manuscript_pdf")

for (fmt in output_formats) {
  render("examples/manuscript.Rmd",
         output_format = fmt)

}
