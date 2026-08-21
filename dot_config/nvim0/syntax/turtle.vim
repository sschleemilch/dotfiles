" Vim syntax file for Turtle RDF
" Language: Turtle (.ttl)
" Last Change: 2026-08-18
" Grammar reference: https://www.w3.org/TR/turtle/#sec-grammar

if exists("b:current_syntax")
  finish
endif

syn iskeyword @,48-57,_,192-255

" ---------------------------------------------------------------------------
" Directives (production [3] directive)
" '@prefix'/'@base' are case-sensitive; PREFIX/BASE (SPARQL style) are not.
" ---------------------------------------------------------------------------
syn match turtleDirective "@prefix\>"
syn match turtleDirective "@base\>"
syn match turtleDirective "\c\<prefix\>"
syn match turtleDirective "\c\<base\>"

" 'a' as shorthand for rdf:type (production [9] verb)
syn match turtleAbbrev "\(^\|\s\)\zsa\ze\s"

" Boolean literals (case-sensitive, production [133s])
syn keyword turtleBoolean true false

" ---------------------------------------------------------------------------
" IRIs (production [18] IRIREF) - allow numeric escapes \uXXXX / \UXXXXXXXX
" and disallow control chars / space / <>"{}|^`\
" ---------------------------------------------------------------------------
syn match turtleUCHAR contained "\\u[0-9A-Fa-f]\{4}\|\\U[0-9A-Fa-f]\{8}"
syn match turtleIRI '<\%(\\u[0-9A-Fa-f]\{4}\|\\U[0-9A-Fa-f]\{8}\|[^\x00-\x20<>"{}|^`\\]\)*>' contains=turtleUCHAR

" ---------------------------------------------------------------------------
" Prefixed names (productions [136s] PrefixedName -> PNAME_LN | PNAME_NS)
" PN_PREFIX is optional (allows leading ':' for default namespace)
" PN_LOCAL may contain PLX escapes (\-escaped reserved chars or %HH)
" ---------------------------------------------------------------------------
syn match turtlePNLocalEsc contained "\\[_~.\-!$&'()*+,;=/?#@%]"
syn match turtlePercentEsc contained "%[0-9A-Fa-f]\{2}"
syn match turtlePrefixedName "\%(\<[A-Za-z][A-Za-z0-9_.\-]*\)\?:\%([A-Za-z0-9_:%.\-]\|\\[_~.\-!$&'()*+,;=/?#@%]\)*" contains=turtlePNLocalEsc,turtlePercentEsc

" Namespace declared in @prefix/PREFIX: highlight the PNAME_NS token itself
syn match turtlePrefixDecl "\%(\<[A-Za-z][A-Za-z0-9_.\-]*\)\?:" contained

" ---------------------------------------------------------------------------
" Blank nodes: labelled (production [141s] BLANK_NODE_LABEL) and ANON [162s]
" ---------------------------------------------------------------------------
syn match turtleBlankNode "_:[A-Za-z0-9_][A-Za-z0-9_.\-]*"
syn match turtleAnon "\[\s*\]"

" ---------------------------------------------------------------------------
" Collections and blank node property lists (punctuation)
" ---------------------------------------------------------------------------
syn match turtleCollection "[()]"
syn match turtleBNodeList "[][]"

" Statement / triple punctuation
syn match turtlePunct "[.,;]"

" ---------------------------------------------------------------------------
" Literals: strings (productions [22]-[25]), long strings first (longest match)
" ECHAR [159s]: \t \b \n \r \f \" \' \\    UCHAR [26]: \uXXXX \UXXXXXXXX
" ---------------------------------------------------------------------------
syn match turtleStringEscape contained "\\[tbnrf"'\\]"

syn region turtleString start=+"""+ end=+"""+ contains=turtleStringEscape,turtleUCHAR
syn region turtleString start=+'''+ end=+'''+ contains=turtleStringEscape,turtleUCHAR
syn region turtleString start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline contains=turtleStringEscape,turtleUCHAR
syn region turtleString start=+'+ skip=+\\\\\|\\'+ end=+'+ oneline contains=turtleStringEscape,turtleUCHAR

" Language tag (production [144s] LANGTAG): '@' [a-zA-Z]+ ('-' [a-zA-Z0-9]+)*
syn match turtleLangTag "@[A-Za-z]\+\(-[A-Za-z0-9]\+\)*"

" Datatype marker '^^' followed by an IRI or prefixed name
syn match turtleDatatypeMarker "\^\^"

" ---------------------------------------------------------------------------
" Numbers (productions [19]-[21] INTEGER, DECIMAL, DOUBLE)
" ---------------------------------------------------------------------------
syn match turtleNumber "[+-]\=\d\+\.\d*[eE][+-]\=\d\+\>"
syn match turtleNumber "[+-]\=\.\d\+[eE][+-]\=\d\+\>"
syn match turtleNumber "[+-]\=\d\+[eE][+-]\=\d\+\>"
syn match turtleNumber "[+-]\=\d\+\.\d\+\>"
syn match turtleNumber "[+-]\=\d\+\>"

" ---------------------------------------------------------------------------
" Comments (production 6.2): '#' to end of line, not inside IRIREF/String
" ---------------------------------------------------------------------------
syn match turtleComment "#.*$"

" ---------------------------------------------------------------------------
" Highlight groups
" ---------------------------------------------------------------------------
hi def link turtleDirective     PreProc
hi def link turtleAbbrev        Keyword
hi def link turtleBoolean       Boolean
hi def link turtleIRI           String
hi def link turtleUCHAR         SpecialChar
hi def link turtlePrefixedName  Identifier
hi def link turtlePrefixDecl    Identifier
hi def link turtleBlankNode     Identifier
hi def link turtleAnon          Identifier
hi def link turtleCollection    Delimiter
hi def link turtleBNodeList     Delimiter
hi def link turtlePunct         Delimiter
hi def link turtleString        String
hi def link turtleStringEscape  SpecialChar
hi def link turtlePNLocalEsc    SpecialChar
hi def link turtlePercentEsc    SpecialChar
hi def link turtleLangTag       Special
hi def link turtleDatatypeMarker Operator
hi def link turtleNumber        Number
hi def link turtleComment       Comment

let b:current_syntax = "turtle"
