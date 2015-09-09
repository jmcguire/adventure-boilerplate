#!/bin/sh
#
# Build the entire adventure website from a single markdown file

function usage {
  echo "usage: $0 [-f folder] [-i image] [-h] [-?] file.md"
  echo "  file.md     the adventure text file, in markdown format"
  echo "  -f folder   specify the output folder"
  echo "  -i image    the header image, used for parallax scrolling"
  echo "  -h | -?     display this usage message"
  exit 1
}

function err {
  echo "$1"
  echo "usage: $0 [-f folder] [-i image] [-h] [-?] file.md"
  exit 1;
}


## load project parameters

file=
project=
project_parent_dir=

while getopts ":f:i:" opt; do
  case $opt in
    f)    project=$OPTARG ;;
    i)    image=$OPTARG ;;
    [?h]) usage ;;
    \?)   echo "unknown option -$OPTARG"; exit 1 ;;
    :)    echo "option -$OPTARG requires an argument"; exit 1 ;;
  esac
done
shift $(($OPTIND - 1))

if [ $1 ]
then
  file=$1
else
  err "missing adventure file."
fi

[ ! $project ] && project=`basename $file | sed 's/\.md//'`

project_parent_folder=`dirname $project`


## begin our adventure

echo "Begin building our adventure: $project"


## setup our directory structure

[ ! -w $project_parent_dir ] && err "you do not have write permissions to this directory."

[ -d $project/ ] && err "the $project directory already exists."

mkdir $project
mkdir $project/css
mkdir $project/img
mkdir $project/fonts
mkdir $project/licenses
mkdir $project/js


## create, copy, and mangle necessary files

sass scss/styles.scss >$project/css/styles.css \
  || err "SASS conversion failed."

## possible error: these copies assuming that we're being executed from the
## adventure-boilerplate directory, which may not be true? it's not an important
## bug, but something to fix in the future.

cp licenses/HTML5_Boilerplate.txt $project/licenses/
cp LICENSE.md $project/licenses/Adventure_Boilerplate.md
cp fonts/* $project/fonts
cp css/main.css $project/css
cp css/normalize.css $project/css
cp -r js/* $project/js
cp $file $project
#copy appropriate image and image license


## top part of the HTML document
## (the title should come from the h1 and author tags. will probably need to
## convert this to markdown extension to get easy access to those.)
## (while i'm talking about good ideas, lets not accidentally create a new
## templating language.)
cat << TOPPART >$project/index.html
<!doctype html>
<html class="no-js" lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>$project</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/styles.css">
    <script src="js/vendor/modernizr-2.8.3.min.js"></script>
  </head>
  <body>
    <!--[if lt IE 8]>
      <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
TOPPART

python -m markdown \
       -x markdown.extensions.toc \
       -x markdown.extensions.tables \
       -x markdown.extensions.def_list \
       -x markdown.extensions.attr_list \
       $file >> $project/index.html \
       || err "python markdown conversion failed."

## bottom part of the HTML document
cat << BOTTOMPART >>$project/index.html
<footer>
AUTHOR INFO
AUTHOR CHOOSEN LICENSE
ADVENTURE BOILERPLATE INFO
ADVENTURE BOILERPLATE LICENSE
</footer>
</body>
</html>
BOTTOMPART

echo "...finished building $project webpage"

exit 0

