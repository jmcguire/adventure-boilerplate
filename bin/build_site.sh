#!/bin/sh
#
# Build the entire adventure website from a single markdown file

function usage {
  echo "usage: $0 [-f folder] [-i image] [-h] [-?] file.md"
  echo "  file.md     the adventure text file, in markdown format"
  echo "  -f folder   specify the output folder"
  echo "  -i image    the header image, used for parallax scrolling"
  echo "  -h | -?     display this usage message"
  echo ""
  echo "Note that this command must be run from the home directory of adventure-boilerplate."
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
  || err "SASS styles conversion failed."

sass scss/statblock.scss >$project/css/statblock.css \
  || err "SASS statblock conversion failed."

## possible error: these copies assuming that we're being executed from the
## adventure-boilerplate directory, which may not be true? it's not an important
## bug, but something to fix in the future.

cp licenses/HTML5_Boilerplate.txt $project/licenses/
cp LICENSE.md $project/licenses/Adventure_Boilerplate.md
cp 404.html $project/404.html
cp crossdomain.xml $project/crossdomain.xml
cp fonts/* $project/fonts
cp css/main.css $project/css
cp css/normalize.css $project/css
cp favicons/* $project/
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

    <link rel="apple-touch-icon" sizes="57x57" href="./apple-touch-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="./apple-touch-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="./apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="./apple-touch-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="./apple-touch-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="./apple-touch-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="./apple-touch-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="./apple-touch-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="./apple-touch-icon-180x180.png">
    <link rel="icon" type="image/png" href="./favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="./favicon-194x194.png" sizes="194x194">
    <link rel="icon" type="image/png" href="./favicon-96x96.png" sizes="96x96">
    <link rel="icon" type="image/png" href="./android-chrome-192x192.png" sizes="192x192">
    <link rel="icon" type="image/png" href="./favicon-16x16.png" sizes="16x16">
    <link rel="manifest" href="./manifest.json">
    <meta name="apple-mobile-web-app-title" content="Adventure Boilerplate">
    <meta name="application-name" content="Adventure Boilerplate">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-TileImage" content="./mstile-144x144.png">
    <meta name="theme-color" content="#d00000">

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

PYTHONPATH=`pwd`/lib:$PYTHONPATH
python -m markdown \
       -x markdown.extensions.toc \
       -x markdown.extensions.tables \
       -x markdown.extensions.def_list \
       -x markdown.extensions.attr_list \
       -x dice \
       $file >> $project/index.html \
       || err "python markdown conversion failed."

## bottom part of the HTML document
cat << BOTTOMPART >>$project/index.html
<footer>
  AUTHOR INFO
  AUTHOR CHOOSEN LICENSE
  <p>Formatting courtesy of <a href="http://github.com/jmcguire/adventure-boilerplate">Adventure Boilerplate</a> &copy; 2015 Justin McGuire with the <a href="https://opensource.org/licenses/MIT">MIT license</a>.</p>
</footer>
</body>
</html>
BOTTOMPART

echo "...finished building $project webpage"

exit 0

