require "optparse"

class Parser
  @@available_options = %w(-a -c -e -f -g --grep -grep -h --help -help -rn -rename --rename -rm -remove --remove)

  class << self

    def analyze_argv
      words, options = [], []

      # divide into words and options
      ARGV.each do |arg|
        if arg[0] == "-"
          options.push(arg)
        else
          words.push(arg)
        end
      end

      # ignore non-available option input
      valid_options = options.map {|opt|
        opt if @@available_options.include?(opt)
      }.compact

      # regularize available option input
      valid_options = valid_options.map {|opt|
        opt = opt[1..]
        opt = "g" if opt.include?("grep")
        opt = "rm" if opt.include?("remove")
        opt = "rn" if opt.include?("rename")
        opt.to_sym
      }.compact.uniq

      return words, valid_options
    end

  end
end

