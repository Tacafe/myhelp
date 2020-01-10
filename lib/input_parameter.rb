require 'arg_parser'

class InputParameter
  include ArgParser

  @@symbolic_options = %i[a, c, e, f, g, h, rn, rm]

  attr_accessor  :sub_command
  attr_accessor  :option
  attr_accessor  :target
  attr_accessor  :grep
  attr_accessor  :prev_filename
  attr_accessor  :new_filename
  attr_accessor  :is_grep
  attr_accessor  :is_choose
  attr_accessor  :is_valid

  def initialize(argv)
    @sub_command = :help

    # output myhelp's help contents
    if argv.size == 0
      @is_valid = true
      return
    end

    words, options = ArgParser.analyze_argv

    return self.evaluate(words, options)

  end

  def evaluate words, options
    @option = options
    @is_grep = options.any? {|o| [:g, :s].include?(o) }
    @is_choose = options.any? {|o| [:c, :f].include?(o) }

    if words.length == 0
      # help option include
      if options.include?(:h)
        @is_valid = true
      end

    # simple case
    elsif words.length == 1 && options.length == 0
      @is_valid = true
      @sub_command = :show
      @target = words[0]

    # valid exept :rn option
    elsif words.length == 1 && options.length == 1 && [:f, :c, :h, :rm].include?(options[0])
      @is_valid = true
      @sub_command = :show
      @target = words[0]

    elsif words.length == 1 && options.length == 1 && [:a, :e].include?(options[0])
      @is_valid = true
      @sub_command = :edit
      @target = words[0]

    elsif @is_choose || @is_grep
      if words.length == 1
        @is_valid = true
        @sub_command = :show
        @target = words[0]
      elsif words.length == 2
        @is_valid = true
        @sub_command = :show
        @target = words[0]
      end

    elsif words.length == 2 && options.length == 1
      if options[0] = :rn
        @is_valid = true
        @sub_command = :rename
        @prev_filename = words[0]
        @new_filename = words[1]
      end
    end
  end
end
