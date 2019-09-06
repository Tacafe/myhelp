require 'find'
$:.unshift(File.dirname(__FILE__) + '/../contents')

module FileLoader
  class << self
    def get_files
      return Dir.glob(File.expand_path('../../contents', __FILE__) + '/*.hhh')
    end

    def pick keyword, isOne
      if isOne
        return get_files().select {|item| File.basename(item).split(".")[0] = keyword}
      else
        return get_files().select {|item| File.basename(item).split(".")[0].include?(keyword)}
      end
    end

    def select candidates
      num_files = candidates.map_with_index { |path, idx| [idx + 1, path] }

      message = num_files.each { |num, path| "#{num.to_s}: #{File.basename(path, ".hhh")}" }
      message = "candidates:\n----------------\n" + message.join("\n") + "----------------\n"
      message += "input number:"

      input = gets.to_i







    end

    def load
    end

  end

end
