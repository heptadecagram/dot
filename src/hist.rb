#!/usr/bin/ruby

command = {}
execution = {}
$total = 0

IO.foreach('.bash_history') do |line|
	line.chomp! =~ /^(\S+)/
	execution[line] = 1 + execution[line].to_i
	command[$1] = 1 + command[$1].to_i
	$total += 1
end

execution = execution.select {|a,b| b.to_f / $total > 0.05}
command = command.select {|a,b| b.to_f / $total > 0.05}

Max_length = execution.sort_by {|a| a[0].length }.reverse[0][0].length

def print_hash(hash)
	sorted = hash.sort {|a,b| b[1] <=> a[1] }
	sorted.each do |cmd,value|
		printf " %#{Max_length}s: %3d(%.2f%%)\n", cmd, value, value.to_f / $total
	end
end


puts "Executions:\n"
print_hash(execution)
puts "Commands:\n"
print_hash(command)
