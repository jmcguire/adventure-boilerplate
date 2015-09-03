#!/bin/sh

file=$1
project=`basename $file | sed 's/\.md//'`

echo "Creating adventure webpage: $project"

if [ ! -w . ]
then
  echo "you do not have write permissions to this directory. quitting."
  exit 1
fi

if [ -d $project/ ]
then
  echo "the $project directory already exists. quitting."
  exit 1
fi

mkdir $project
mkdir $project/css
mkdir $project/img
mkdir $project/fonts
mkdir $project/licenses
mkdir $project/js

sass scss/styles.scss >$project/css/styles.css \
  || eval 'echo "SASS conversion failed. quitting." 1>&2; exit 1'

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
       || eval 'echo "python markdown conversion failed." 1>&2; exit 1'

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

