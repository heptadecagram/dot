set disassembly-flavor intel
set history save on


define viewstack
	gef config context.nb_lines_stack 100
end

define pgraph
	set var $n = $arg0
	while $n
		print *$n
		set var $n = $n->next
	end
end
# set disable-randomization off

# C-X C-A
#  layout asm
#  layout regs

# checkpoint
#  restart <checkpoint-id>
#  info checkpoints

# directory <path> # find source files within
