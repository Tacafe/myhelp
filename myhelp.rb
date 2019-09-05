#!/usr/bin/env ruby

puts "test"
# add myhelp root folder
$:.unshift(File.dirname(__FILE__))

module MyHelp
  class << self
    def get_helpfile
      puts "hello helpfile"
    end

    def chose
      puts "hello chose"
    end

    def main 
      self.get_helpfile
      self.chose
    end
  end

end

MyHelp.main()



