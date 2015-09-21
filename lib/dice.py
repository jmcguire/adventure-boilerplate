from markdown.extensions import Extensions
from markdown.postprocessors import Postprocessor
from markdown.inlinepatterns import Pattern
import re

DICEPATTERN = r'\d+d\d+(?\s*\+\s*\d+)?'

class DiceExtension(Extension):
  def extendMarkdown(self, md, md_globals):
    md.inlinePatterns.add('dice', DicePattern(md), '<references')

class DicePattern(Pattern):
  """ Dice inline pattern """

  def __init__(self, pattern, title):
    super(DicePattern, self).__init__(pattern)
    self.title = title

  def handleMatch(self m):
    dice = etree.Element('dice')
    
    return 

