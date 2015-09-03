Markdown converter:

 - altered to produce adventure-flavored HTML
 - with definition lists extension
 - need a way to include that statblocks weird SVG-style line
 - need a way to create the two statblock types of dl's
 - classes?
 - produce header and footer from metadata? from certain HTML lines?
 - [TOC] ? (convert it from div to nav)

Finish typing up jm01 adventure

Build script:

 - converts all sass and markdown
 - takes in a variable to decide which picture should be parallaxed
 - something like `build.sh --adventure=samples/jm01.md --top-image=img/top.jpg --out=jm01`
 - produces a folder with all files needed
 - should include necessary licences

Styles:

 - print stylesheet
 - include that unsupported printing css extension?
 - convert statblock.css to sass, use h4 and h5
 - do i want to experiment with OOCSS, BEM?
 - css that looks for (xdx + x) and makes it special
 - dialog options css for NPCs
 - footer styles
 - navigation styles
 - parallax styles
 - style for referencing PHB, MM, DMG

need a dummy img, a simple pattern, slate grey, for a default parallax image

a button up top that says "Show Just NPCs", to get an easy-to-print page

