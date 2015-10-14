SimpleTagPattern

 - when you have control characters surrounding some text, like ~~text~~, and you want to remove the control characters and wrap the text with a simple tag
 - the pattern needs two groups, the first if the group of the surrounding control characters, the second is the text
 - like r'(~~)(.+?)\2'

SimpleTextPattern

 - when the whole string gets matched, and not replaced
 - the pattern needs one group
 - this is if you want to prevent a piece of text from being matched by some other pattern.


