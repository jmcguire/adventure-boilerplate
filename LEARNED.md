SimpleTagPattern

 - when you have control characters surrounding some text, like ~~text~~, and you want to remove the control characters and wrap the text with a simple tag
 - the pattern needs two groups, the first if the group of the surrounding control characters, the second is the text
 - like r'(~~)(.+?)\2'

SimpleTextPattern

 - when the whole string gets matched, and not replaced
 - the pattern needs one group
 - this is if you want to prevent a piece of text from being matched by some other pattern.
 - (each piece of text is only matched once, and it is replaced with a placeholder, and the markdowned-up piece of text is reinserted later. see markdown.util.HTMLStash. of rouce, I don't know how that interacts with nested structures. but, like, em>strong is specified, and is different from strong>em.)

BlockProcessor

 - when you need to process a block of text. a block is a series of lines, separated by a blank line at the begining and end.
 - need two methods:
    - test: given the block, and looks at it, and returns true if we should process it, false otherwise
    - run: given a parent etree, and all remaining blocks including the first one which has already passed test(), you should remove and process the first block, and add the result to the parent.

