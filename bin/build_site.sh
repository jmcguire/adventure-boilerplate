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

cp LICENSES/HTML5_Boilerplate.txt $project/licenses/
cp LICENSE.md $project/licenses/Adventure_Boilerplate.md
cp basic_files/404.html $project/404.html
cp basic_files/crossdomain.xml $project/crossdomain.xml
cp basic_files/fonts/* $project/fonts
cp basic_files/img/* $project/img
cp css/main.css $project/css
cp css/normalize.css $project/css
cp basic_files/favicons/* $project/
cp -r basic_files/js/* $project/js
cp $file $project
#copy appropriate image and image license

PYTHONPATH=`pwd`/lib:$PYTHONPATH
python -m markdown \
       -x markdown.extensions.toc \
       -x markdown.extensions.tables \
       -x markdown.extensions.def_list \
       -x markdown.extensions.attr_list \
       -x markdown.extensions.meta \
       -x dice \
       -x wrap \
       -x attribute_list \
       $file >> $project/index.html \
       || err "python markdown conversion failed."

echo "...finished building $project webpage"

exit 0

