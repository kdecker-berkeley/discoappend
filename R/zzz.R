.onAttach <- function(libname, pkgname) {
    msg <- paste0(
        "Welcome to Disco Append version ", packageVersion("discoappend"), "\n",
        "Find an introduction and examples here: https://github.com/cwolfsonseeley/discoappend/blob/master/README.md"
    )
    packageStartupMessage(msg)
}
