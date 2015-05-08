
unlet b:current_syntax
syntax include @SQLString syntax/sql.vim
"syntax sync clear

syntax cluster perlQQ add=@SQLString

syntax sync minlines=200

syntax clear perlVarPlain

syn match  perlVarPlain          "$^[ADEFHILMOPSTWX]\="
syn match  perlVarPlain          "$[\\\"\[\]'&`+*.,;=%~!?@$<>(-]"
syn match  perlVarPlain          "$\(0\|[1-9][0-9]*\)"
" Same as above, but avoids confusion in $::foo (equivalent to $main::foo)
syn match  perlVarPlain          "$:[^:]"

if exists("perl_want_scope_in_variables")
	syn match  perlVarPlain       "\\\=\([@$]\|\$#\)\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" contains=perlPackageRef nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
else
	syn match  perlVarPlain       "\\\=\([@$]\|\$#\)\$*\(\I\i*\)\=\(\(::\|'\)\I\i*\)*\>" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod
endif

if exists("perl_extended_vars")
	syn match  perlVarPlain       "\\\=\(\$#\|[@%&$]\)\$*{\I\i*}" nextgroup=perlVarMember,perlVarSimpleMember
endif
