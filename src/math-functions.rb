#!/usr/local/bin/ruby

module Math
	PHI = (1 + sqrt(5))/2
	SQRT5 = sqrt(5)

	def combination(n, j)
		(n-j+1..n).inject{|product,m| product*m}/j.factorial
	end
	alias :C :combination

	def permutation(n, j)
		(n-j+1..n).inject{|product,m| product*m}
	end
	alias :P :permutation
end

class Array
	def rand
		self[rand(self.size)]
	end
end

class Integer
	def factorial
		return 1 if self < 2
		(2..self).inject{|product,n| product*n}
	end

	def fibonacci
		# Accuracy is lost in floats above n=70
		return (Math::PHI**self / Math::SQRT5).round if self < 71

		previous = -1
		current = 1
		(self+1).times do
			sum = previous + current
			previous = current
			current = sum
		end
		current
	end
end

