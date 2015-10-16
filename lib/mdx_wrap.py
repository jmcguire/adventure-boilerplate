#!/usr/bin/env python

"""
Wrap Markdown Extension for Adventure Boilerplate
"""

import markdown
import yaml
from datetime import datetime

class WrapExtension(markdown.Extension):

    def __init__(self, configs):
        self.config = dict(title="...")

    def extendMarkdown(self, md, md_globals):
        md.advboil_wrap_opts = self.config
        md.postprocessors['adventure-boilerplate-wrap'] = WrapProcessor(md)

class WrapProcessor(markdown.postprocessors.Postprocessor):

    def run(self, text):
      top_part = """\
<!doctype html>
<html class="no-js" lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>{title} - {author}</title>
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

    <script src="https://use.typekit.net/kff4qkp.js"></script>
    <script>try{{Typekit.load({{ async: true }});}}catch(e){{}}</script>
  </head>
  <body>
    <!--[if lt IE 8]>
      <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
    <![endif]-->
    <div id="parallax">
      <div class="text-vcenter">
        <h1>{title}<span>{subtitle}</span></h1>
        <p class="byline">by {author}</p>
      </div>
    </div>
    <main>
"""

      bottom_part="""
    </main>
    <footer>
      <p>{author}</p>
      <p>{license_html}</p>
      <p>Formatting courtesy of <a href="http://github.com/jmcguire/adventure-boilerplate">Adventure Boilerplate</a> &copy; 2015 Justin McGuire with the <a href="https://opensource.org/licenses/MIT">MIT license</a>.</p>
    </footer>
  </body>
</html>
"""

      meta = self.markdown.Meta
      # set good-enough defaults
      meta.setdefault('title', ['A D&amp;D5 Adventure'])
      meta.setdefault('author', ['Anonymous'])
      meta.setdefault('subtitle', [''])
      meta.setdefault('license', ['None'])

      ## create the license html snippet
      licenses=yaml.load(file('licenses.yaml'))
      license_code = meta['license'][0].upper()
      if license_code == 'None':
        license_html='License: &copy; %d %s' % (datetime.now().year, meta['author'][0])
      elif license_code in licenses:
        license_html='<p>License: <a href="%s">%s</a></p>' % ( licenses[license_code]['url'], licenses[license_code]['title'] )
      else:
        license_html='License: %s' % meta['license'][0]

      html = top_part + text + bottom_part
      return (html.format(title=meta['title'][0], author=meta['author'][0], subtitle=meta['subtitle'][0], license_html=license_html))

def makeExtension(configs=None):
    return WrapExtension(configs=configs)

