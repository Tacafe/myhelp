require 'arg_parser'

class InputParameter
  include ArgParser

  @@symbolic_options = %s[a, c, e, f, g, h, rn, rm]

  attr_accessor  :command
  attr_accessor  :option
  attr_accessor  :target
  attr_accessor  :grep
  attr_accessor  :prev_filename
  attr_accessor  :new_filename
  attr_accessor  :is_valid

  def initialize()
    @command = :help

    # output myhelp's help contents
    if ARGV.size == 0
      @is_valid = true
      return
    end

    words, options = ArgParser.analyze_argv

    return self.evaluate(words, options)
  
  end

  def evaluate words, options
    if words.length == 0
      # help option include
      if options.include?(:h)
        @is_valid = true
      end

    # simple case
    elsif words.length == 1 && options.length == 0
      @is_valid = true
      @command = :show
      @target = words[0]

    # valid exept :rn option
    elsif words.length == 1 && options.length == 1 && %s(a c e h rm).include?(options[0])
      @is_valid = true
      @command = :show
      @target = words[0]
      @option = options[0]

    elsif words.length == 1 && options.length > 1
      

    elsif words.length == 2 && options.length = 1
      if options[0] = :rn
        @is_valid = true
        @command = :rename
        @option = options[0]
        @prev_filename = words[0]
        @new_filename = words[1]
      end

    end
  end
end
