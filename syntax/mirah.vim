" Vim syntax file
" Language:		mirah
" Maintainer:		Doug Kearns <dougkearns@gmail.com>
" Last Change:		2009 Dec 2
" URL:			http://vim-mirah.mirahforge.org
" Anon CVS:		See above site
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>
" ----------------------------------------------------------------------------
"
" Previous Maintainer:	Mirko Nasato
" Thanks to perl.vim authors, and to Reimer Behrends. :-) (MN)
" ----------------------------------------------------------------------------

if exists("b:current_syntax")
  finish
endif

if has("folding") && exists("mirah_fold")
  setlocal foldmethod=syntax
endif

syn cluster mirahNotTop contains=@mirahExtendedStringSpecial,@mirahRegexpSpecial,@mirahDeclaration,mirahConditional,mirahExceptional,mirahMethodExceptional,mirahTodo

if exists("mirah_space_errors")
  if !exists("mirah_no_trail_space_error")
    syn match mirahSpaceError display excludenl "\s\+$"
  endif
  if !exists("mirah_no_tab_space_error")
    syn match mirahSpaceError display " \+\t"me=e-1
  endif
endif

" Operators
if exists("mirah_operators")
  syn match  mirahOperator	 "\%([~!^&|*/%+-]\|\%(class\s*\)\@<!<<\|<=>\|<=\|\%(<\|\<class\s\+\u\w*\s*\)\@<!<[^<]\@=\|===\|==\|=\~\|>>\|>=\|=\@<!>\|\*\*\|\.\.\.\|\.\.\|::\)"
  syn match  mirahPseudoOperator  "\%(-=\|/=\|\*\*=\|\*=\|&&=\|&=\|&&\|||=\||=\|||\|%=\|+=\|!\~\|!=\)"
  syn region mirahBracketOperator matchgroup=mirahOperator start="\%(\w[?!]\=\|[]})]\)\@<=\[\s*" end="\s*]" contains=ALLBUT,@mirahNotTop
endif

" Expression Substitution and Backslash Notation
syn match mirahStringEscape "\\\\\|\\[abefnrstv]\|\\\o\{1,3}\|\\x\x\{1,2}"						    contained display
syn match mirahStringEscape "\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)" contained display
syn match mirahQuoteEscape  "\\[\\']"											    contained display

syn region mirahInterpolation	      matchgroup=mirahInterpolationDelimiter start="#{" end="}" contained contains=ALLBUT,@mirahNotTop
syn match  mirahInterpolation	      "#\%(\$\|@@\=\)\w\+"    display contained contains=mirahInterpolationDelimiter,mirahInstanceVariable,mirahClassVariable,mirahGlobalVariable,mirahPredefinedVariable
syn match  mirahInterpolationDelimiter "#\ze\%(\$\|@@\=\)\w\+" display contained
syn match  mirahInterpolation	      "#\$\%(-\w\|\W\)"       display contained contains=mirahInterpolationDelimiter,mirahPredefinedVariable,mirahInvalidVariable
syn match  mirahInterpolationDelimiter "#\ze\$\%(-\w\|\W\)"    display contained
syn region mirahNoInterpolation	      start="\\#{" end="}"            contained
syn match  mirahNoInterpolation	      "\\#{"		      display contained
syn match  mirahNoInterpolation	      "\\#\%(\$\|@@\=\)\w\+"  display contained
syn match  mirahNoInterpolation	      "\\#\$\W"		      display contained

syn match mirahDelimEscape	"\\[(<{\[)>}\]]" transparent display contained contains=NONE

syn region mirahNestedParentheses    start="("  skip="\\\\\|\\)"  matchgroup=mirahString end=")"	transparent contained
syn region mirahNestedCurlyBraces    start="{"  skip="\\\\\|\\}"  matchgroup=mirahString end="}"	transparent contained
syn region mirahNestedAngleBrackets  start="<"  skip="\\\\\|\\>"  matchgroup=mirahString end=">"	transparent contained
syn region mirahNestedSquareBrackets start="\[" skip="\\\\\|\\\]" matchgroup=mirahString end="\]"	transparent contained

" These are mostly Oniguruma ready
syn region mirahRegexpComment	matchgroup=mirahRegexpSpecial   start="(?#"								  skip="\\)"  end=")"  contained
syn region mirahRegexpParens	matchgroup=mirahRegexpSpecial   start="(\(?:\|?<\=[=!]\|?>\|?<[a-z_]\w*>\|?[imx]*-[imx]*:\=\|\%(?#\)\@!\)" skip="\\)"  end=")"  contained transparent contains=@mirahRegexpSpecial
syn region mirahRegexpBrackets	matchgroup=mirahRegexpCharClass start="\[\^\="								  skip="\\\]" end="\]" contained transparent contains=mirahStringEscape,mirahRegexpEscape,mirahRegexpCharClass oneline
syn match  mirahRegexpCharClass	"\\[DdHhSsWw]"	       contained display
syn match  mirahRegexpCharClass	"\[:\^\=\%(alnum\|alpha\|ascii\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\):\]" contained
syn match  mirahRegexpEscape	"\\[].*?+^$|\\/(){}[]" contained
syn match  mirahRegexpQuantifier	"[*?+][?+]\="	       contained display
syn match  mirahRegexpQuantifier	"{\d\+\%(,\d*\)\=}?\=" contained display
syn match  mirahRegexpAnchor	"[$^]\|\\[ABbGZz]"     contained display
syn match  mirahRegexpDot	"\."		       contained display
syn match  mirahRegexpSpecial	"|"		       contained display
syn match  mirahRegexpSpecial	"\\[1-9]\d\=\d\@!"     contained display
syn match  mirahRegexpSpecial	"\\k<\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\=>" contained display
syn match  mirahRegexpSpecial	"\\k'\%([a-z_]\w*\|-\=\d\+\)\%([+-]\d\+\)\='" contained display
syn match  mirahRegexpSpecial	"\\g<\%([a-z_]\w*\|-\=\d\+\)>" contained display
syn match  mirahRegexpSpecial	"\\g'\%([a-z_]\w*\|-\=\d\+\)'" contained display

syn cluster mirahStringSpecial	      contains=mirahInterpolation,mirahNoInterpolation,mirahStringEscape
syn cluster mirahExtendedStringSpecial contains=@mirahStringSpecial,mirahNestedParentheses,mirahNestedCurlyBraces,mirahNestedAngleBrackets,mirahNestedSquareBrackets
syn cluster mirahRegexpSpecial	      contains=mirahInterpolation,mirahNoInterpolation,mirahStringEscape,mirahRegexpSpecial,mirahRegexpEscape,mirahRegexpBrackets,mirahRegexpCharClass,mirahRegexpDot,mirahRegexpQuantifier,mirahRegexpAnchor,mirahRegexpParens,mirahRegexpComment

" Numbers and ASCII Codes
syn match mirahASCIICode	"\%(\w\|[]})\"'/]\)\@<!\%(?\%(\\M-\\C-\|\\C-\\M-\|\\M-\\c\|\\c\\M-\|\\c\|\\C-\|\\M-\)\=\%(\\\o\{1,3}\|\\x\x\{1,2}\|\\\=\S\)\)"
syn match mirahInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[xX]\x\+\%(_\x\+\)*\>"								display
syn match mirahInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0[dD]\)\=\%(0\|[1-9]\d*\%(_\d\+\)*\)\>"						display
syn match mirahInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[oO]\=\o\+\%(_\o\+\)*\>"								display
syn match mirahInteger	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<0[bB][01]\+\%(_[01]\+\)*\>"								display
syn match mirahFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\.\d\+\%(_\d\+\)*\>"					display
syn match mirahFloat	"\%(\%(\w\|[]})\"']\s*\)\@<!-\)\=\<\%(0\|[1-9]\d*\%(_\d\+\)*\)\%(\.\d\+\%(_\d\+\)*\)\=\%([eE][-+]\=\d\+\%(_\d\+\)*\)\>"	display

" Identifiers
syn match mirahLocalVariableOrMethod "\<[_[:lower:]][_[:alnum:]]*[?!=]\=" contains=NONE display transparent
syn match mirahBlockArgument	    "&[_[:lower:]][_[:alnum:]]"		 contains=NONE display transparent

syn match  mirahConstant		"\%(\%([.@$]\@<!\.\)\@<!\<\|::\)\_s*\zs\u\w*\%(\>\|::\)\@=\%(\s*(\)\@!"
syn match  mirahClassVariable	"@@\h\w*" display
syn match  mirahInstanceVariable "@\h\w*"  display
syn match  mirahGlobalVariable	"$\%(\h\w*\|-.\)"
syn match  mirahSymbol		"[]})\"':]\@<!:\%(\^\|\~\|<<\|<=>\|<=\|<\|===\|==\|=\~\|>>\|>=\|>\||\|-@\|-\|/\|\[]=\|\[]\|\*\*\|\*\|&\|%\|+@\|+\|`\)"
syn match  mirahSymbol		"[]})\"':]\@<!:\$\%(-.\|[`~<=>_,;:!?/.'"@$*\&+0]\)"
syn match  mirahSymbol		"[]})\"':]\@<!:\%(\$\|@@\=\)\=\h\w*"
syn match  mirahSymbol		"[]})\"':]\@<!:\h\w*\%([?!=]>\@!\)\="
syn match  mirahSymbol		"\%([{(,]\_s*\)\@<=\l\w*[!?]\=::\@!"he=e-1
syn match  mirahSymbol		"[]})\"':]\@<!\h\w*[!?]\=:\s\@="he=e-1
syn region mirahSymbol		start="[]})\"':]\@<!:'"  end="'"  skip="\\\\\|\\'"  contains=mirahQuoteEscape fold
syn region mirahSymbol		start="[]})\"':]\@<!:\"" end="\"" skip="\\\\\|\\\"" contains=@mirahStringSpecial fold

syn match  mirahBlockParameter	  "\h\w*" contained
syn region mirahBlockParameterList start="\%(\%(\<do\>\|{\)\s*\)\@<=|" end="|" oneline display contains=mirahBlockParameter

syn match mirahInvalidVariable	 "$[^ A-Za-z_-]"
syn match mirahPredefinedVariable #$[!$&"'*+,./0:;<=>?@\`~1-9]#
syn match mirahPredefinedVariable "$_\>"											   display
syn match mirahPredefinedVariable "$-[0FIKadilpvw]\>"									   display
syn match mirahPredefinedVariable "$\%(deferr\|defout\|stderr\|stdin\|stdout\)\>"					   display
syn match mirahPredefinedVariable "$\%(DEBUG\|FILENAME\|KCODE\|LOADED_FEATURES\|LOAD_PATH\|PROGRAM_NAME\|SAFE\|VERBOSE\)\>" display
syn match mirahPredefinedConstant "\%(\%(\.\@<!\.\)\@<!\|::\)\_s*\zs\%(MatchingData\|ARGF\|ARGV\|ENV\)\>\%(\s*(\)\@!"
syn match mirahPredefinedConstant "\%(\%(\.\@<!\.\)\@<!\|::\)\_s*\zs\%(DATA\|FALSE\|NIL\|mirah_PLATFORM\|mirah_RELEASE_DATE\)\>\%(\s*(\)\@!"
syn match mirahPredefinedConstant "\%(\%(\.\@<!\.\)\@<!\|::\)\_s*\zs\%(mirah_VERSION\|STDERR\|STDIN\|STDOUT\|TOPLEVEL_BINDING\|TRUE\)\>\%(\s*(\)\@!"
"Obsolete Global Constants
"syn match mirahPredefinedConstant "\%(::\)\=\zs\%(PLATFORM\|RELEASE_DATE\|VERSION\)\>"
"syn match mirahPredefinedConstant "\%(::\)\=\zs\%(NotImplementError\)\>"

" Normal Regular Expression
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="\%(\%(^\|\<\%(and\|or\|while\|until\|unless\|if\|elsif\|when\|not\|then\|else\)\|[;\~=!|&(,[>]\)\s*\)\@<=/" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@mirahRegexpSpecial keepend fold
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="\%(\h\k*\s\+\)\@<=/[ \t=]\@!" end="/[iomxneus]*" skip="\\\\\|\\/" contains=@mirahRegexpSpecial fold

" Generalized Regular Expression
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="%r\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)"	end="\z1[iomxneus]*" skip="\\\\\|\\\z1" contains=@mirahRegexpSpecial fold
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="%r{"				end="}[iomxneus]*"   skip="\\\\\|\\}"	contains=@mirahRegexpSpecial fold
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="%r<"				end=">[iomxneus]*"   skip="\\\\\|\\>"	contains=@mirahRegexpSpecial,mirahNestedAngleBrackets,mirahDelimEscape fold
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="%r\["				end="\][iomxneus]*"  skip="\\\\\|\\\]"	contains=@mirahRegexpSpecial fold
syn region mirahRegexp matchgroup=mirahRegexpDelimiter start="%r("				end=")[iomxneus]*"   skip="\\\\\|\\)"	contains=@mirahRegexpSpecial fold

" Normal String and Shell Command Output
syn region mirahString matchgroup=mirahStringDelimiter start="\"" end="\"" skip="\\\\\|\\\"" contains=@mirahStringSpecial fold
syn region mirahString matchgroup=mirahStringDelimiter start="'"	end="'"  skip="\\\\\|\\'"  contains=mirahQuoteEscape    fold
syn region mirahString matchgroup=mirahStringDelimiter start="`"	end="`"  skip="\\\\\|\\`"  contains=@mirahStringSpecial fold

" Generalized Single Quoted String, Symbol and Array of Strings
syn region mirahString matchgroup=mirahStringDelimiter start="%[qw]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)" end="\z1" skip="\\\\\|\\\z1" fold
syn region mirahString matchgroup=mirahStringDelimiter start="%[qw]{"				   end="}"   skip="\\\\\|\\}"	fold contains=mirahNestedCurlyBraces,mirahDelimEscape
syn region mirahString matchgroup=mirahStringDelimiter start="%[qw]<"				   end=">"   skip="\\\\\|\\>"	fold contains=mirahNestedAngleBrackets,mirahDelimEscape
syn region mirahString matchgroup=mirahStringDelimiter start="%[qw]\["				   end="\]"  skip="\\\\\|\\\]"	fold contains=mirahNestedSquareBrackets,mirahDelimEscape
syn region mirahString matchgroup=mirahStringDelimiter start="%[qw]("				   end=")"   skip="\\\\\|\\)"	fold contains=mirahNestedParentheses,mirahDelimEscape
syn region mirahSymbol matchgroup=mirahSymbolDelimiter start="%[s]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)"  end="\z1" skip="\\\\\|\\\z1" fold
syn region mirahSymbol matchgroup=mirahSymbolDelimiter start="%[s]{"				   end="}"   skip="\\\\\|\\}"	fold contains=mirahNestedCurlyBraces,mirahDelimEscape
syn region mirahSymbol matchgroup=mirahSymbolDelimiter start="%[s]<"				   end=">"   skip="\\\\\|\\>"	fold contains=mirahNestedAngleBrackets,mirahDelimEscape
syn region mirahSymbol matchgroup=mirahSymbolDelimiter start="%[s]\["				   end="\]"  skip="\\\\\|\\\]"	fold contains=mirahNestedSquareBrackets,mirahDelimEscape
syn region mirahSymbol matchgroup=mirahSymbolDelimiter start="%[s]("				   end=")"   skip="\\\\\|\\)"	fold contains=mirahNestedParentheses,mirahDelimEscape

" Generalized Double Quoted String and Array of Strings and Shell Command Output
" Note: %= is not matched here as the beginning of a double quoted string
syn region mirahString matchgroup=mirahStringDelimiter start="%\z([~`!@#$%^&*_\-+|\:;"',.?/]\)"	    end="\z1" skip="\\\\\|\\\z1" contains=@mirahStringSpecial fold
syn region mirahString matchgroup=mirahStringDelimiter start="%[QWx]\z([~`!@#$%^&*_\-+=|\:;"',.?/]\)" end="\z1" skip="\\\\\|\\\z1" contains=@mirahStringSpecial fold
syn region mirahString matchgroup=mirahStringDelimiter start="%[QWx]\={"				    end="}"   skip="\\\\\|\\}"	 contains=@mirahStringSpecial,mirahNestedCurlyBraces,mirahDelimEscape    fold
syn region mirahString matchgroup=mirahStringDelimiter start="%[QWx]\=<"				    end=">"   skip="\\\\\|\\>"	 contains=@mirahStringSpecial,mirahNestedAngleBrackets,mirahDelimEscape  fold
syn region mirahString matchgroup=mirahStringDelimiter start="%[QWx]\=\["				    end="\]"  skip="\\\\\|\\\]"	 contains=@mirahStringSpecial,mirahNestedSquareBrackets,mirahDelimEscape fold
syn region mirahString matchgroup=mirahStringDelimiter start="%[QWx]\=("				    end=")"   skip="\\\\\|\\)"	 contains=@mirahStringSpecial,mirahNestedParentheses,mirahDelimEscape    fold

" Here Document
syn region mirahHeredocStart matchgroup=mirahStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs\%(\h\w*\)+	 end=+$+ oneline contains=ALLBUT,@mirahNotTop
syn region mirahHeredocStart matchgroup=mirahStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs"\%([^"]*\)"+ end=+$+ oneline contains=ALLBUT,@mirahNotTop
syn region mirahHeredocStart matchgroup=mirahStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs'\%([^']*\)'+ end=+$+ oneline contains=ALLBUT,@mirahNotTop
syn region mirahHeredocStart matchgroup=mirahStringDelimiter start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<-\=\zs`\%([^`]*\)`+ end=+$+ oneline contains=ALLBUT,@mirahNotTop

syn region mirahString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<\z(\h\w*\)\ze+hs=s+2	matchgroup=mirahStringDelimiter end=+^\z1$+ contains=mirahHeredocStart,@mirahStringSpecial fold keepend
syn region mirahString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<"\z([^"]*\)"\ze+hs=s+2	matchgroup=mirahStringDelimiter end=+^\z1$+ contains=mirahHeredocStart,@mirahStringSpecial fold keepend
syn region mirahString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<'\z([^']*\)'\ze+hs=s+2	matchgroup=mirahStringDelimiter end=+^\z1$+ contains=mirahHeredocStart			fold keepend
syn region mirahString start=+\%(\%(class\s*\|\%([]})"'.]\|::\)\)\_s*\|\w\)\@<!<<`\z([^`]*\)`\ze+hs=s+2	matchgroup=mirahStringDelimiter end=+^\z1$+ contains=mirahHeredocStart,@mirahStringSpecial fold keepend

syn region mirahString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-\z(\h\w*\)\ze+hs=s+3    matchgroup=mirahStringDelimiter end=+^\s*\zs\z1$+ contains=mirahHeredocStart,@mirahStringSpecial fold keepend
syn region mirahString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-"\z([^"]*\)"\ze+hs=s+3  matchgroup=mirahStringDelimiter end=+^\s*\zs\z1$+ contains=mirahHeredocStart,@mirahStringSpecial fold keepend
syn region mirahString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-'\z([^']*\)'\ze+hs=s+3  matchgroup=mirahStringDelimiter end=+^\s*\zs\z1$+ contains=mirahHeredocStart		     fold keepend
syn region mirahString start=+\%(\%(class\s*\|\%([]}).]\|::\)\)\_s*\|\w\)\@<!<<-`\z([^`]*\)`\ze+hs=s+3  matchgroup=mirahStringDelimiter end=+^\s*\zs\z1$+ contains=mirahHeredocStart,@mirahStringSpecial fold keepend

if exists('main_syntax') && main_syntax == 'emirah'
  let b:mirah_no_expensive = 1
end

syn match  mirahAliasDeclaration    "[^[:space:];#.()]\+" contained contains=mirahSymbol,mirahGlobalVariable,mirahPredefinedVariable nextgroup=mirahAliasDeclaration2 skipwhite
syn match  mirahAliasDeclaration2   "[^[:space:];#.()]\+" contained contains=mirahSymbol,mirahGlobalVariable,mirahPredefinedVariable
syn match  mirahMethodDeclaration   "[^[:space:];#(]\+"	 contained contains=mirahConstant,mirahBoolean,mirahPseudoVariable,mirahInstanceVariable,mirahClassVariable,mirahGlobalVariable
syn match  mirahClassDeclaration    "[^[:space:];#<]\+"	 contained contains=mirahConstant,mirahOperator
syn match  mirahModuleDeclaration   "[^[:space:];#<]\+"	 contained contains=mirahConstant,mirahOperator
syn match  mirahFunction "\<[_[:alpha:]][_[:alnum:]]*[?!=]\=[[:alnum:]_.:?!=]\@!" contained containedin=mirahMethodDeclaration
syn match  mirahFunction "\%(\s\|^\)\@<=[_[:alpha:]][_[:alnum:]]*[?!=]\=\%(\s\|$\)\@=" contained containedin=mirahAliasDeclaration,mirahAliasDeclaration2
syn match  mirahFunction "\%([[:space:].]\|^\)\@<=\%(\[\]=\=\|\*\*\|[+-]@\=\|[*/%|&^~]\|<<\|>>\|[<>]=\=\|<=>\|===\|==\|=\~\|`\)\%([[:space:];#(]\|$\)\@=" contained containedin=mirahAliasDeclaration,mirahAliasDeclaration2,mirahMethodDeclaration

syn cluster mirahDeclaration contains=mirahAliasDeclaration,mirahAliasDeclaration2,mirahMethodDeclaration,mirahModuleDeclaration,mirahClassDeclaration,mirahFunction,mirahBlockParameter

" Keywords
" Note: the following keywords have already been defined:
" begin case class def do end for if module unless until while
syn match   mirahControl	       "\<\%(and\|break\|in\|next\|not\|or\|redo\|rescue\|retry\|return\)\>[?!]\@!"
syn match   mirahOperator       "\<defined?" display
syn match   mirahKeyword	       "\<\%(super\|yield\)\>[?!]\@!"
syn match   mirahBoolean	       "\<\%(true\|false\)\>[?!]\@!"
syn match   mirahPseudoVariable "\<\%(nil\|self\|__FILE__\|__LINE__\)\>[?!]\@!"
syn match   mirahBeginEnd       "\<\%(BEGIN\|END\)\>[?!]\@!"

" Expensive Mode - match 'end' with the appropriate opening keyword for syntax
" based folding and special highlighting of module/class/method definitions
if !exists("b:mirah_no_expensive") && !exists("mirah_no_expensive")
  syn match  mirahDefine "\<alias\>"  nextgroup=mirahAliasDeclaration  skipwhite skipnl
  syn match  mirahDefine "\<def\>"    nextgroup=mirahMethodDeclaration skipwhite skipnl
  syn match  mirahDefine "\<undef\>"  nextgroup=mirahFunction	     skipwhite skipnl
  syn match  mirahClass	"\<class\>"  nextgroup=mirahClassDeclaration  skipwhite skipnl
  syn match  mirahModule "\<module\>" nextgroup=mirahModuleDeclaration skipwhite skipnl

  syn region mirahMethodBlock start="\<def\>"	matchgroup=mirahDefine end="\%(\<def\_s\+\)\@<!\<end\>" contains=ALLBUT,@mirahNotTop fold
  syn region mirahBlock	     start="\<class\>"	matchgroup=mirahClass  end="\<end\>"		       contains=ALLBUT,@mirahNotTop fold
  syn region mirahBlock	     start="\<module\>" matchgroup=mirahModule end="\<end\>"		       contains=ALLBUT,@mirahNotTop fold

  " modifiers
  syn match mirahConditionalModifier "\<\%(if\|unless\)\>"    display
  syn match mirahRepeatModifier	     "\<\%(while\|until\)\>" display

  syn region mirahDoBlock      matchgroup=mirahControl start="\<do\>" end="\<end\>"                 contains=ALLBUT,@mirahNotTop fold
  " curly bracket block or hash literal
  syn region mirahCurlyBlock   start="{" end="}"							  contains=ALLBUT,@mirahNotTop fold
  syn region mirahArrayLiteral matchgroup=mirahArrayDelimiter start="\%(\w\|[\]})]\)\@<!\[" end="]" contains=ALLBUT,@mirahNotTop fold

  " statements without 'do'
  syn region mirahBlockExpression       matchgroup=mirahControl	  start="\<begin\>" end="\<end\>" contains=ALLBUT,@mirahNotTop fold
  syn region mirahCaseExpression	       matchgroup=mirahConditional start="\<case\>"  end="\<end\>" contains=ALLBUT,@mirahNotTop fold
  syn region mirahConditionalExpression matchgroup=mirahConditional start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+=-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![?!]\)\s*\)\@<=\%(if\|unless\)\>" end="\<end\>" contains=ALLBUT,@mirahNotTop fold

  syn match mirahConditional "\<\%(then\|else\|when\)\>[?!]\@!"	contained containedin=mirahCaseExpression
  syn match mirahConditional "\<\%(then\|else\|elsif\)\>[?!]\@!" contained containedin=mirahConditionalExpression

  syn match mirahExceptional	  "\<\%(\%(\%(;\|^\)\s*\)\@<=rescue\|else\|ensure\)\>[?!]\@!" contained containedin=mirahBlockExpression
  syn match mirahMethodExceptional "\<\%(\%(\%(;\|^\)\s*\)\@<=rescue\|else\|ensure\)\>[?!]\@!" contained containedin=mirahMethodBlock

  " statements with optional 'do'
  syn region mirahOptionalDoLine   matchgroup=mirahRepeat start="\<for\>[?!]\@!" start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!=?]\)\s*\)\@<=\<\%(until\|while\)\>" matchgroup=mirahOptionalDo end="\%(\<do\>\)" end="\ze\%(;\|$\)" oneline contains=ALLBUT,@mirahNotTop
  syn region mirahRepeatExpression start="\<for\>[?!]\@!" start="\%(\%(^\|\.\.\.\=\|[{:,;([<>~\*/%&^|+-]\|\%(\<[_[:lower:]][_[:alnum:]]*\)\@<![!=?]\)\s*\)\@<=\<\%(until\|while\)\>" matchgroup=mirahRepeat end="\<end\>" contains=ALLBUT,@mirahNotTop nextgroup=mirahOptionalDoLine fold

  if !exists("mirah_minlines")
    let mirah_minlines = 50
  endif
  exec "syn sync minlines=" . mirah_minlines

else
  syn match mirahControl "\<def\>[?!]\@!"    nextgroup=mirahMethodDeclaration skipwhite skipnl
  syn match mirahControl "\<class\>[?!]\@!"  nextgroup=mirahClassDeclaration  skipwhite skipnl
  syn match mirahControl "\<module\>[?!]\@!" nextgroup=mirahModuleDeclaration skipwhite skipnl
  syn match mirahControl "\<\%(case\|begin\|do\|for\|if\|unless\|while\|until\|else\|elsif\|ensure\|then\|when\|end\)\>[?!]\@!"
  syn match mirahKeyword "\<\%(alias\|undef\)\>[?!]\@!"
endif

" Special Methods
if !exists("mirah_no_special_methods")
  syn keyword mirahAccess    public protected private module_function
  " attr is a common variable name
  syn match   mirahAttribute "\%(\%(^\|;\)\s*\)\@<=attr\>\(\s*[.=]\)\@!"
  syn keyword mirahAttribute attr_accessor attr_reader attr_writer
  syn match   mirahControl   "\<\%(exit!\|\%(abort\|at_exit\|exit\|fork\|loop\|trap\)\>[?!]\@!\)"
  syn keyword mirahEval	    eval class_eval instance_eval module_eval
  syn keyword mirahException raise fail catch throw
  " false positive with 'include?'
  syn match   mirahInclude   "\<include\>[?!]\@!"
  syn keyword mirahInclude   autoload extend load require
  syn keyword mirahKeyword   callcc caller lambda proc
endif

" Comments and Documentation
syn match   mirahSharpBang "\%^#!.*" display
syn keyword mirahTodo	  FIXME NOTE TODO OPTIMIZE XXX contained
syn match   mirahComment   "#.*" contains=mirahSharpBang,mirahSpaceError,mirahTodo,@Spell
if !exists("mirah_no_comment_fold")
  syn region mirahMultilineComment start="\%(\%(^\s*#.*\n\)\@<!\%(^\s*#.*\n\)\)\%(\(^\s*#.*\n\)\{1,}\)\@=" end="\%(^\s*#.*\n\)\@<=\%(^\s*#.*\n\)\%(^\s*#\)\@!" contains=mirahComment transparent fold keepend
  syn region mirahDocumentation	  start="^=begin\ze\%(\s.*\)\=$" end="^=end\s*$" contains=mirahSpaceError,mirahTodo,@Spell fold
else
  syn region mirahDocumentation	  start="^=begin\s*$" end="^=end\s*$" contains=mirahSpaceError,mirahTodo,@Spell
endif

" Note: this is a hack to prevent 'keywords' being highlighted as such when called as methods with an explicit receiver
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(alias\|and\|begin\|break\|case\|class\|def\|defined\|do\|else\)\>"		  transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(elsif\|end\|ensure\|false\|for\|if\|in\|module\|next\|nil\)\>"		  transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(not\|or\|redo\|rescue\|retry\|return\|self\|super\|then\|true\)\>"		  transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(undef\|unless\|until\|when\|while\|yield\|BEGIN\|END\|__FILE__\|__LINE__\)\>" transparent contains=NONE

syn match mirahKeywordAsMethod "\<\%(alias\|begin\|case\|class\|def\|do\|end\)[?!]" transparent contains=NONE
syn match mirahKeywordAsMethod "\<\%(if\|module\|undef\|unless\|until\|while\)[?!]" transparent contains=NONE

syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(abort\|at_exit\|attr\|attr_accessor\|attr_reader\)\>"   transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(attr_writer\|autoload\|callcc\|catch\|caller\)\>"	    transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(eval\|class_eval\|instance_eval\|module_eval\|exit\)\>" transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(extend\|fail\|fork\|include\|lambda\)\>"		    transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(load\|loop\|private\|proc\|protected\)\>"		    transparent contains=NONE
syn match mirahKeywordAsMethod "\%(\%(\.\@<!\.\)\|::\)\_s*\%(public\|require\|raise\|throw\|trap\)\>"		    transparent contains=NONE

" __END__ Directive
syn region mirahData matchgroup=mirahDataDirective start="^__END__$" end="\%$" fold

hi def link mirahClass			mirahDefine
hi def link mirahModule			mirahDefine
hi def link mirahMethodExceptional	mirahDefine
hi def link mirahDefine			Define
hi def link mirahFunction		Function
hi def link mirahConditional		Conditional
hi def link mirahConditionalModifier	mirahConditional
hi def link mirahExceptional		mirahConditional
hi def link mirahRepeat			Repeat
hi def link mirahRepeatModifier		mirahRepeat
hi def link mirahOptionalDo		mirahRepeat
hi def link mirahControl			Statement
hi def link mirahInclude			Include
hi def link mirahInteger			Number
hi def link mirahASCIICode		Character
hi def link mirahFloat			Float
hi def link mirahBoolean			Boolean
hi def link mirahException		Exception
if !exists("mirah_no_identifiers")
  hi def link mirahIdentifier		Identifier
else
  hi def link mirahIdentifier		NONE
endif
hi def link mirahClassVariable		mirahIdentifier
hi def link mirahConstant		Type
hi def link mirahGlobalVariable		mirahIdentifier
hi def link mirahBlockParameter		mirahIdentifier
hi def link mirahInstanceVariable	mirahIdentifier
hi def link mirahPredefinedIdentifier	mirahIdentifier
hi def link mirahPredefinedConstant	mirahPredefinedIdentifier
hi def link mirahPredefinedVariable	mirahPredefinedIdentifier
hi def link mirahSymbol			Constant
hi def link mirahKeyword			Keyword
hi def link mirahOperator		Operator
hi def link mirahPseudoOperator		mirahOperator
hi def link mirahBeginEnd		Statement
hi def link mirahAccess			Statement
hi def link mirahAttribute		Statement
hi def link mirahEval			Statement
hi def link mirahPseudoVariable		Constant

hi def link mirahComment			Comment
hi def link mirahData			Comment
hi def link mirahDataDirective		Delimiter
hi def link mirahDocumentation		Comment
hi def link mirahTodo			Todo

hi def link mirahQuoteEscape		mirahStringEscape
hi def link mirahStringEscape		Special
hi def link mirahInterpolationDelimiter	Delimiter
hi def link mirahNoInterpolation		mirahString
hi def link mirahSharpBang		PreProc
hi def link mirahRegexpDelimiter		mirahStringDelimiter
hi def link mirahSymbolDelimiter		mirahStringDelimiter
hi def link mirahStringDelimiter		Delimiter
hi def link mirahString			String
hi def link mirahRegexpEscape		mirahRegexpSpecial
hi def link mirahRegexpQuantifier	mirahRegexpSpecial
hi def link mirahRegexpAnchor		mirahRegexpSpecial
hi def link mirahRegexpDot		mirahRegexpCharClass
hi def link mirahRegexpCharClass		mirahRegexpSpecial
hi def link mirahRegexpSpecial		Special
hi def link mirahRegexpComment		Comment
hi def link mirahRegexp			mirahString

hi def link mirahInvalidVariable		Error
hi def link mirahError			Error
hi def link mirahSpaceError		mirahError

let b:current_syntax = "mirah"

" vim: nowrap sw=2 sts=2 ts=8 noet:
