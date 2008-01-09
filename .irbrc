#!/usr/local/bin/ruby
# Project  Name: None
# File / Folder: .irbrc
# File Language: ruby
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.03.17 20:33:27
# Last Modifier: Liam Bryan
# Last Modified: 2008.01.09 05:29:16

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
#IRB.conf[:MATH_MODE] = true

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
	IRB.conf[:LOAD_MODULES] << 'irb/completion'
end
unless IRB.conf[:LOAD_MODULES].include?('irb/ext/save-history')
	if File.exist? IRB.conf[:IRB_LIB_PATH] + '/ext/save-history.rb'
		IRB.conf[:LOAD_MODULES] << 'irb/ext/save-history'
	end
end

IRB.conf[:LOAD_MODULES] << 'net/http'
IRB.conf[:LOAD_MODULES] << 'tempfile'
#IRB.conf[:LOAD_MODULES] << 'statistics'

def get_url(url)
	url =~ %r{http://([^/]+)(.*/)([^/]+)}
	Net::HTTP.start($1) do |http|
		resp = http.get($2 + $3)
		open($3, "w") { |file| file.write(resp.body) }
	end
end

def editor
	file = Tempfile.new("irb")
	system("vim #{file.path}")
	file.open
	eval(file.readlines.join('') )
	file.unlink
end

unless Symbol.instance_methods.member? 'to_proc'
	class Symbol;def to_proc;lambda{|*a|a.shift.__send__(self, *a)};end;end
end


class Integer
	def P(size)
		((self-size+1)..self).inject { |factorial,k| factorial*k }
	end
	def C(size)
		self.P(size) / (1..size).inject { |factorial,k| factorial*k }
	end
end

class Object
	def what?(*a)
		MethodFinder.new(self, *a) unless $in_method_find
	end
	def megaClone
		begin
			self.clone
		rescue
			self
		end
	end
end

class MethodFinder
	def initialize(object, *args)
		@object = object
		@args = args
	end

	def self.find(object, expected, *args, &block)
		$in_method_find = true
		eval 'class DummyOut; def write(*args); end; end;'
		stdout, stderr = $stdout, $stderr
		$stdout = $stderr = DummyOut.new
		result = object.methods.select{ |name|
			object.method(name).arity <= args.size
		}.select{ |name|
			begin
				object.megaClone.method(name).call(*args, &block) == expected
			rescue
				nil
			end
		}

		$stdout, $stderr = stdout, stderr
		$in_method_find = false
		result
	end

	def self.show(object, expected, *args)
		find(object, expected, *args).each { |name|
			print "#{object.inspect}.#{name}"
			print '(' + args.map { |arg| arg.inspect }.join(', ') + ')' unless args.empty?
			puts " == #{expected.inspect}"
		}
	end

	def ==(value)
		MethodFinder.find(@object, value, *@args)
	end
end
