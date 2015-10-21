create a styleguide for the HTML/CSS

create a users manual for the markdown

Finish typing up jm01 adventure

Build script:

 - should include necessary licences
 - create parallax from supplied image
 - create footer

Styles:

 - print stylesheet
 - include that unsupported printing css extension?
 - convert statblock.css to sass, use h4 and h5
 - do i want to experiment with OOCSS, BEM?
 - dialog options css for NPCs
 - footer styles
 - navigation styles
 - style for referencing PHB, MM, DMG
 - aside for major inmformation with title, nice borders, and probably crimson
 - aside for dialog to read to players, also crimson, including a title
 - aside for a small "note for dms"

Extensions, more important:

 - statblock
   - need a way to include that statblocks weird SVG-style line
   - need a way to create the two statblock types of dls
 - [TOC] ? (convert it from div to nav)

Extensions, nice to have:

 - special formatting for the author h2
 - recognize a dice options ol, and give it a class
 - append a custom css
 - add contact info to author h2, like social media icons
 - npc formatting, with dialog stuff
 - wrap each h2 section in section tag
 - create general menu from h2 tags
 - create scene menu from the h3 tags in the scene section
 - do something for the paper book references, like DMG 100
 - highlight DC and saving throws, just like dice rolls

need a dummy img, a simple pattern, slate grey, for a default parallax image

a button up top that says "Show Just NPCs", to get an easy-to-print page

statblocks should have a triple state, little piece of js to click between them:

  - just the name
  - mini statblock
  - full statblock

Eventually I'll have to put lib/ in a proper directory format, which will probably be something wordy like lib/python/2.7/adventure-boilerplate/

Include external MD files? like I can import everything from the free Starter Set, and then people can include them with {{include monster}}


