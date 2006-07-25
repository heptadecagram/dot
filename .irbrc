#!/usr/local/bin/ruby
# Project  Name: None
# File / Folder: .irbrc
# File Language: ruby
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.03.17 20:33:27
# Last Modifier: Liam Bryan
# Last Modified: 2006.07.25 06:38:03

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
	IRB.conf[:LOAD_MODULES] << 'irb/completion'
end

class Object
	def megaClone
		begin
			self.clone
		rescue
			self
		end
	end
end

class MethodFinder
	def self.find(object, expected, *args)
		object.methods.select { |name|
			object.method(name).arity == args.size
		}.select { |name|
			begin
				object.megaClone.method(name).call(*args) == expected
			rescue
			end
		}
	end

	def self.show(object, expected, *args)
		find(object, expected, *args).each { |name|
			print "#{object.inspect}.#{name}"
			print '(' + args.map { |arg| arg.inspect }.join(', ') + ')' unless args.empty?
			puts " == #{expected.inspect}"
		}
	end

	def initialize(object, *args)
		@object = object
		@args = args
	end

	def ==(value)
		MethodFinder.find(@object, value, *@args)
	end
end

class Object
	def what?(*a)
		MethodFinder.new(self, *a)
	end
end
