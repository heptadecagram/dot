#!/usr/local/bin/ruby

class Alef
	def self.SIUnit(abbreviation, name)
				puts "#{self.to_s}  #{abbreviation} passed value #{name}"
		self.class.class_eval do
				puts "#{self.to_s}  #{abbreviation} passed value #{name}"
			define_method(abbreviation) do |value|
				puts "#{self.to_s}  #{abbreviation} passed value #{name}"
			end
		end
	end

	#monkey :one, :two
end

class Bet < Alef

	SIUnit :m, :meter
end

Bet.new.methods
