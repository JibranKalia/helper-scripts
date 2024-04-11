#!/usr/bin/env ruby

require 'open3'

output = ""
ARGV.each do |filename|
  begin
    content = File.read(filename)
    output += "\n\"\"\"\n// #{filename}\n\n#{content}\n\"\"\"\n"
  rescue Errno::ENOENT
    puts "File '#{filename}' not found. Please check the filename and try again."
  end
end

Open3.popen2('pbcopy') do |i, o, th|
  i.write(output)
  i.close
end
