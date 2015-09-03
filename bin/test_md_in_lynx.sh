python -m markdown \
       -x markdown.extensions.toc \
       -x markdown.extensions.tables \
       -x markdown.extensions.def_list \
       $1 | lynx -stdin

