# adventure-boilerplate

HTML/CSS Boilerplate (and one-click Markdown conversion) for RPG Adventures. Currently supporting D&amp;D 5e.

## Description

Authors should be proud of how their adventures look. This project gives that to them. Using simple HTML, or even simpler Markdown, adventure authors will be able to produce a great-looking adventure, suitable for web viewing or printing.

This project is really two projects mooshed together.

**The first part is HTML/CSS boilerplate for Dungeons and Dragons adventures.** Inspired by the HTML5 boierplate project, this aims to be an easy-to-use CSS file and HTML standard that anyone can use to markup their adventure with.

The result will be a professional webpage. It will work well on screens, tablets, mobile devices, and will even print beautifully.

**The second part is an adventure markdown converter.** People who don't know HTML should still be able to build a nice looking adventure.

We're accomplishing that by using the simple and increasingly-common Markdown language. Authors will be able to write a markdown document, then run a simple build script called "build.sh", and an entire HTML website will be produced for them.

We're using Python markdown, with some custom extensions to make a lot of magic happen without the author worrying about it. The goal is to default to a great looking adventure.

## Installation

Download this software.

Install a couple python packages, if you don't already have them:

  $ pip install markdown
  $ pip install pyyaml

If you're on Mac, which this program was developed on, use this:

  $ brew install libyaml
  $ sudo python -m easy_install pyyaml

You're also going to need SASS.

## Usage

Write an adventure using markdown.

Run the build.sh command.

Further documentation coming when the build.sh command is in build.

## Credits

Justin McGuire &mdash; <jm@landedstar.com> &mdash; <a href="https://twitter.com/landedstar">@landedstar.com</a> &mdash; http://landedstar.com

## License

MIT

