#!/usr/local/bin/ruby
# Project  Name: None
# File / Folder: statistics.rb
# File Language: ruby
# Copyright (C): 2007 Liam Bryan
# First  Author: Liam Bryan
# First Created: 2007.10.23 08:00:53
# Last Modifier: Liam Echlin
# Last Modified: 2008.05.02

module Enumerable
	def size
		inject(0) { |size, k| size + 1 }
	end
	def arithmetic_mean
		return nil unless any?

		sum / size.to_f
	end
	alias :mean :arithmetic_mean

	def harmonic_mean
		return nil unless any?

		size / sum { |n| 1.0/n }
	end
	def quadratic_mean
		return nil unless any?

		Math.sqrt(sum { |n| n**2 } / size)
	end
	def geometric_mean
		return nil unless any?

		inject { |product, n| product * n } ** (1.0/size)
	end

	def variance
		return nil unless any?

		m = mean
		sum { |n| (n - m)**2 } / size
	end
	def mean_absolute_deviation
		return nil unless any?

		m = mean
		sum { |n| (n - m).abs } / size
	end
	def median_absolute_deviation
		return nil unless any?

		m = median
		sum { |n| (n - m).abs } / size
	end
	def standard_deviation
		return nil unless any?

		Math.sqrt(variance)
	end
	def sample_standard_deviation
		return nil unless any?

		size * standard_deviation / (size - 1)
	end
	def geometric_standard_deviation
		return nil unless any?

		mean_log = Math.log(geometric_mean)
		Math.exp(Math.sqrt(sum { |n| (Math.log(n) - mean_log)**2 } / size) )
	end
	def kurtosis
		return nil unless any?

		m = mean
		sum { |n| (n - m)**4 } / size / variance**2 - 3
	end

	def skewness
		return nil unless any?

		m = mean
		sum { |n| (n - m)**3 } / standard_deviation**3 / size
	end

	def median
		return nil unless any?

		if size % 2 == 1
			sort[size/2]
		else
			sort[size/2-1, 2].sum / 2.0
		end
	end
	alias :second_quartile :median
	alias :q2 :median

	def first_quartile
		return nil unless any?

		sort[0 ... size/2].median
	end
	alias :q1 :first_quartile
	def third_quartile
		return nil unless any?

		sort[(size + 1)/2 .. -1].median
	end
	alias :q3 :third_quartile

	def interquartile_range
		return nil unless any?

		q3 - q1
	end
	alias :iqr :interquartile_range

	def outliers
		return nil unless any?

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
		return nil unless any?

		(max + min) / 2.0
	end

	def sum
		return nil unless any?

		if block_given?
			inject(0) { |sum, n| sum + yield(n) }
		else
			inject { |sum, n| sum + n }
		end
	end
end
