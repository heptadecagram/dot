
set spell

function! LDAPCompleteFn(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && line[start - 1] =~ '[^:,]'
			let start -= 1
		endwhile
		while start < col('.') && line[start] =~ '[:, ]'
			let start += 1
		endwhile
		return start
	else
		let result = []
		let query = substitute(substitute(a:base, '"', '', 'g'), '\s*<.*>\s*', '', 'g')

		let output = system("~/.mutt/sfLDAP.pl '" . query . "'")
		for line in split(output, "\n")[1:]
			let fields = split(line, "\t")
			call add(result, printf('"%s" <%s>', escape(fields[1], '"'), fields[0]))
		endfor

		return result
	endif
endfun

function! Integration()
	0,$delete
	0read ~/.mutt/integration-template
	8
	set omnifunc=
endfunction

set omnifunc=LDAPCompleteFn
