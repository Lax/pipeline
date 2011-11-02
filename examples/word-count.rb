#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
require 'pipeline'

a = Pipeline.new('word-count-example')
a.push(:begin, lambda {@inv = Hash.new 0})
a.push(:process, lambda {|line| @inv[:word_count] += line.split("|").length})
a.push(:process, lambda {|line| @inv[:line_count] += 1})
a.push(:end, lambda {p @inv})
a.run
