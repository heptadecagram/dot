#!/usr/local/bin/ruby

IRB.conf[:AUTO_INDENT] = true
#IRB.conf[:USE_READLINE] = true

#unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
#	IRB.conf[:LOAD_MODULES] << 'irb/completion'
#end

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
