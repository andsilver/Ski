#!/usr/bin/env ruby

require "nokogiri"
require "open-uri"

doc = Nokogiri::XML(open("http://www.user-agents.org/allagents.xml"))
puts doc.css("user-agents user-agent")
  .select {|node| ["R", "S"].include? node.css("Type").text}
  .map {|node| node.css("String").text}
