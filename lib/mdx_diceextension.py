from markdown.extensions import Extension
from markdown.inlinepatterns import Pattern
from markdown import util

# look for things like 1d4, 18d6, 12d10 + 13, 10d12+1
DICE_RE = r'\b(\d+d\d+(?:\s*\+\s*\d+)?)\b'

class DiceExtension(Extension):
  """Adds dice extension to Markdown class."""
  def extendMarkdown(self, md, md_globals):
    md.inlinePatterns.add('dice', DicePattern(DICE_RE, md), '<strong')

class DicePattern(Pattern):
  """Returns a strong element, given a dice string (`1d10 + 4`)."""
  def handleMatch(self, m):
    el = util.etree.Element("strong")
    el.set('class', 'dice')
    el.text = util.AtomicString(m.group(2))
    return el

def makeExtension(configs={}):
    return DiceExtension(configs=dict(configs))

