module ArgParser
  @@CommandNames = %i[myhelp, add, rm, edit, new]
  @@CommandOptions = {
    myhelp: %w[-a, -n],
    add: %w[],
    rm: %w[],
    edit: %w[],
    new: %w[],
  }

  class << self
    def parse 
      puts ARGV.length
      ARGV.each_with_index do |arg, i|
        puts "#{i}:#{arg}"
      end
    end

  end
end
