#!/usr/local/bin/ruby
# Project  Name: None
# File / Folder: .irbrc
# File Language: ruby
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.03.17 20:33:27
# Last Modifier: Liam Bryan
# Last Modified: 2007.04.11 13:45:56

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
	IRB.conf[:LOAD_MODULES] << 'irb/completion'
end

IRB.conf[:LOAD_MODULES] << 'net/http'


def get_url(url)
	url =~ %r{http://([^/]+)(.*/)([^/]+)}
	Net::HTTP.start($1) do |http|
		resp = http.get($2 + $3)
		open($3, "w") { |file| file.write(resp.body) }
	end
end

module Enumerable
	def size
		inject(0) { |size, k| size + 1 }
	end
	alias :mean, :arithmetic_mean
	def arithmetic_mean
		inject{|sum,k| sum + k} / size.to_f
	end
	def harmonic_mean
		size / inject(0) { |sum, n| sum += 1.0/n }
	end
	def quadratic_mean
		Math.sqrt(inject(0) { |product, n| product + n**2 } / size)
	end
	def geometric_mean
		inject { |product, n| product * n } ** (1.0/size)
	end
	def standard_deviation
		Math.sqrt(inject(0) { |sum, n| sum + (n - mean)**2 } / size)
	end
	def sample_standard_deviation
		size * standard_deviation / (size - 1)
	end
	def geometric_standard_deviation
		Math.exp(Math.sqrt(inject(0) { |sum, n| sum + (Math.log(n) - Math.log(geometric_mean) )**2 } / size) )
	end
	def variance
		standard_deviation**2
	end
	def median
		if self.size % 2 == 1
			self.sort[self.size/2]
		else
			self.sort[self.size/2-1, 2].inject {|sum,k| sum+k}/2.0
		end
	end
	def mode
		stats = Hash.new(0)
		self.each { |item| stats[item] += 1 }
		stats.select { |item, times| times == stats.values.max }.map {|k| k[0] }
	end
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
