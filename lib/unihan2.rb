require 'csv'

class Unihan2
  DATA_DIR = File.join(File.dirname(__FILE__), '../data')
  
  def initialize
    read_strokes
    read_version
  end


  # return total strokes of the character char
  # @param char [String] the character
  # @return [Integer] the total strokes
  def strokes(char)
    @strokes[char]
  end

  # return unicode version of specific character
  # @param code [String] character or codepoing
  # @return [Float] unicode version
  def ver(code)
    return nil if code.nil?

    if code.is_a? Integer
      i = code
    elsif code.size == 1
      i = code.codepoints.first
    else
      i = code.hex
    end

    ver_bsearch(i, 0, @vers.size-1)
  end

  private

  def read_strokes
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

  def read_version
    @vers = []
    fn = File.join(DATA_DIR, 'unicode-chars-ver.csv')
    CSV.foreach(fn, headers: true) do |row|
      @vers << {
        range: (row['cp1'].hex..row['cp2'].hex),
        age: row['age'].to_f
      }
    end
  end

  def ver_bsearch(code, start, stop)
    return nil if start > stop
    middle = (stop - start) / 2 + start
    h = @vers[middle]
    if h[:range].include?(code)
      return h[:age]
    elsif middle == start
      return nil if code < h[:range].begin
      return ver_bsearch(code, middle+1, stop)
    else
      if code < h[:range].begin
        return ver_bsearch(code, start, middle)
      else
        return ver_bsearch(code, middle, stop)
      end
    end
  end

end