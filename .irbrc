#!/usr/local/bin/ruby
# Project  Name: None
# File / Folder: .irbrc
# File Language: ruby
# Copyright (C): 2006 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2006.03.17 20:33:27
# Last Modifier: Liam Bryan
# Last Modified: 2007.07.27 07:31:04

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
#IRB.conf[:MATH_MODE] = true

unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
	IRB.conf[:LOAD_MODULES] << 'irb/completion'
end
unless IRB.conf[:LOAD_MODULES].include?('irb/ext/save-history')
	if File.exist? IRB.conf[:IRB_LIB_PATH] + '/ext/save-history'
		IRB.conf[:LOAD_MODULES] << 'irb/ext/save-history'

		IRB.conf[:SAVE_HISTORY] = 200
		IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
	end
end

IRB.conf[:LOAD_MODULES] << 'net/http'

def get_url(url)
	url =~ %r{http://([^/]+)(.*/)([^/]+)}
	Net::HTTP.start($1) do |http|
		resp = http.get($2 + $3)
		open($3, "w") { |file| file.write(resp.body) }
	end
end

class Symbol;def to_proc;lambda{|*a|a.shift.__send__(self, *a)};end;end

module Enumerable
	def size
		inject(0) { |size, k| size + 1 }
	end
	def arithmetic_mean
		sum / size.to_f
	end
	alias :mean :arithmetic_mean

	def harmonic_mean
		size / sum { |n| 1.0/n }
	end
	def quadratic_mean
		Math.sqrt(sum { |n| n**2 } / size)
	end
	def geometric_mean
		inject { |product, n| product * n } ** (1.0/size)
	end

	def variance
		sum { |n| (n - mean)**2 } / size
	end
	def standard_deviation
		Math.sqrt(variance)
	end
	def sample_standard_deviation
		size * standard_deviation / (size - 1)
	end
	def geometric_standard_deviation
		mean_log = Math.log(geometric_mean)
		Math.exp(Math.sqrt(sum { |n| (Math.log(n) - mean_log)**2 } / size) )
	end
	def kurtosis
		sum { |n| (n - mean)**4 } / size / variance**2 - 3
	end

	def skewness
		sum { |n| (n - mean)**3 } / standard_deviation**3 / size
	end

	def median
		if size % 2 == 1
			sort[size/2]
		else
			sort[size/2-1, 2].sum / 2.0
		end
	end
	alias :second_quartile :median
	alias :q2 :median

	def first_quartile
		sort[0 ... size/2].median
	end
	alias :q1 :first_quartile
	def third_quartile
		sort[(size + 1)/2 .. -1].median
	end
	alias :q3 :third_quartile

	def interquartile_range
		q3 - q1
	end
	alias :iqr :interquartile_range

	def outliers
		select do |k|
			k > q3 + 1.5*iqr || k < q1 - 1.5*iqr
		end
	end

	def mode
		stats = Hash.new(0)
		each { |item| stats[item] += 1 }
		stats.select { |item, times| times == stats.values.max }.map {|k| k[0] }
	end

	def midrange
		(max + min) / 2.0
	end

	def sum
		if block_given?
			inject(0) { |sum, n| sum + yield(n) }
		else
			inject { |sum, n| sum + n }
		end
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
