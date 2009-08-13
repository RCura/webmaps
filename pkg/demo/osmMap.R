
### show the PDF document

pdf = system.file("doc/sample.pdf",package="webmaps")

if (.Platform$OS.type == "windows") {
  shell.exec(pdf)
}else{
  system(paste(shQuote(getOption("pdfviewer")), shQuote(pdf)), 
            wait = FALSE)
}
