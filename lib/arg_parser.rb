require "optparse"

# keyword (ヘルプファイル名orその一部) options
#   -a [keyword] add 指定のヘルプファイルを新規作成
#   -c [keyword] choose ヘルプファイル内のサブコンテンツを対話的に選択できる
#   -e [keyword] edit 指定したヘルプファイルを編集する
#                指定したヘルプファイルが存在しない場合は新規作成
#   -f [optional keyword] find ヘルプファイルを絞り込む
#   -g --grep [keyword] ヘルプファイル内のコンテンツを検索して表示できる
#   -rn [keyword] [keyword] rename
#   -rm [keyword] remove
#
# commands
#   :show = output contents
#   :edit = call vim editor
#   :rename = mv file to new filename
#   :remove = rm file
#   :help = output help file of myhelp

module ArgParser
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

