class Unihan2
  DATA_DIR = File.join(File.dirname(__FILE__), '../data')
  
  def initialize
    fn = File.join(DATA_DIR, 'Unihan_DictionaryLikeData.txt')
    @strokes = {}
    File.foreach(fn) do |line|
      next if line.start_with? '#'
      line.chomp!
      cells = line.split("\t")
      if cells[1] == 'kTotalStrokes'
        c = [cells[0].sub(/^U\+(.*)$/, '\1').hex].pack('U')
        i = cells[2].to_i
        @strokes[c] = i
      end
    end
  end

  # return total strokes of the character char
  # @param char [String] the character
  # @return [Integer] the total strokes
  def strokes(char)
    @strokes[char]
  end
end
