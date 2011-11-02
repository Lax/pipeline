#!/usr/bin/env ruby

class Pipeline
	attr_accessor :name, :actions
	def initialize(name)
		self.name = name
		self.actions = {:begin => [], :process => [], :end => []}
	end

	def push(stage, filter)
		self.actions[stage].push(filter)
	end

	def run
		run_filter_queue(:begin)
		while line = gets
			run_filter_queue(:process, line)
		end
		run_filter_queue(:end)
	end

	def run_filter_queue(stage, aim=nil)
		self.actions[stage].each do |action|
			if aim
				action.call aim
			else
				action.call
			end
		end
	end
end


if __FILE__ == $0
	require 'yaml'
	a = Pipeline.new('word-count-example')
	a.push(:begin, lambda {@inv = Hash.new 0})
	a.push(:process, lambda {|line| @inv[:word_count] += line.split.length})
	a.push(:process, lambda {|line| @inv[:line_count] += 1})
	a.push(:end, lambda {puts @inv.to_yaml})
	a.run
end
