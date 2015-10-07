from markdown.extensions import Extensions
from markdown.inlinepatterns import Pattern, SimpleTagPattern
from markdown import util
import re

# look for things like 1d10, 18d4, 12d8 + 13, 10d6+1
DICE_RE = r'(\d+d\d+(?\s*\+\s*\d+)?)'

class DiceExtension(Extension):
  """Adds dice extension to Markdown class."""
  """Turns 1d10 to <strong class="dice">1d10</strong>."""
  def extendMarkdown(self, md, md_globals):
    md.inlinePatterns.add('dice', DicePattern(DICE_RE, md), '<references')
    #md.inlinePatterns.add('dice', SimpleTagPattern(DICE_RE, 'strong'), '<references')


class DicePattern(Pattern):
  """Returns a strong element, given a dice string (`1d10 + 4`)"""
  def handleMatch(self, m):
    el = util.etree.Element('strong')
    el.set('class', 'dice')
    el.text = util.AtomicString(m.group(2))
    return el

def makeExtension(configs=None):
    return DiceExtension(configs=None)

