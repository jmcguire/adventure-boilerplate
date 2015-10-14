from markdown.extensions import Extension
from markdown.inlinepatterns import Pattern
from markdown import util

# look for an attribute list like `attr: 8 9 10 11 12 13'
# `attr' could be `attrs', `attribute, or `attributes'
# spacing is as flexible as possible
ATTRIBUTE_LIST_RE = r'\battr(?:ibute)?s?:\s*(\d{1,2})\s+(\d{1,2})\s+(\d{1,2})\s+(\d{1,2})\s+(\d{1,2})\s+(\d{1,2})\b'
ATTRIBUTE_LIST_REGEX = r'\battr(?:ibute)?s?:\s*(?:(\d{1,2})\s+){5}(\d{1,2})\b'

class AttributeListExtension(Extension):
  """Adds attribute_list extension to Markdown class."""
  def extendMarkdown(self, md, md_globals):
    md.inlinePatterns.add('attribute_list', AttributeListPattern(ATTRIBUTE_LIST_RE, md), '<strong')

class AttributeListPattern(Pattern):
  """Returns a table.attribute-list element"""
  def handleMatch(self, m):
    table = util.etree.Element('table', {'class': 'attribute-list'})

    # the first row is the attribute list
    tr1 = util.etree.SubElement(table, 'tr')
    attrs = ['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA']
    for attr in attrs:
      th = util.etree.SubElement(tr1, 'th')
      th.text = util.AtomicString(attr)

    # the second row is the stat list with the calculated bonus
    tr2 = util.etree.SubElement(table, 'tr')
    for i in range (2,8):

      stat = int(m.group(i))
      bonus = (stat - 10) / 2
      sign = '+' if bonus > 0 else '-'
      if bonus == 0:
        sign = ''

      td = util.etree.SubElement(tr2, 'td')
      td.text = util.AtomicString('%d (%s%d)' % (stat, sign, abs(bonus)))

    return table

def makeExtension(configs={}):
    return AttributeListExtension(configs=dict(configs))

