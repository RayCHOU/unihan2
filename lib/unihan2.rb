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

  def self.unicode_version(code)
    if code.is_a? Integer
      i = code
    else
      i = code.hex
    end

    if i < 0xF000
      case i
      when 0x3400..0x4DB5 # Unicode 3.0: Extension A
        3.0
      when 0x4DB6..0x4DBF # Unicode 13.0: Extension A
        13.0
      when 0x4E00..0x9FA5 # CJK Unified Ideographs
        1.1
      when 0x9FA6..0x9FBB # CJK Unified Ideographs
        4.1
      when 0x9FBC..0x9FC3 # CJK Unified Ideographs
        5.1
      when 0x9FC4..0x9FCB # CJK Unified Ideographs
        5.2
      when 0x9FCC # CJK Unified Ideographs
        6.1
      when 0x9FCD..0x9FD5 # CJK Unified Ideographs
        8.0
      when 0x9FD6..0x9FEA # CJK Unified Ideographs
        10.0
      when 0x9FEB..0x9FEF # CJK Unified Ideographs
        11.0
      when 0x9FF0..0x9FFC # CJK Unified Ideographs
        13.0
      end
    elsif i < 0x20000
      case i
      when 0xF900..0xFA2D # CJK Compatibility Ideographs
        1.1
      when 0xFA2E..0xFA2F # CJK Compatibility Ideographs
        6.1
      when 0xFA30..0xFA6A # CJK Compatibility Ideographs
        3.2
      when 0xFA6B..0xFA6D # CJK Compatibility Ideographs
        5.2
      when 0xFA70..0xFAD9 # CJK Compatibility Ideographs
        4.1
      end
    else
      case i
      when 0x20000..0x2A6D6 # Extension B
        3.1
      when 0x2A6D7..0x2A6DD # Extension B
        13.0
      when 0x2A700..0x2B734 # extension C
        5.2
      when 0x2B740..0x2B81D # extension D
        6.0
      when 0x2B820..0x2CEA1 # extension E
        8.0
      when 0x2CEB0..0x2EBE0 # extension F
        10.0
      when 0x2F800..0x2FA1D # Unicode 3.1: CJK Compatibility Supplement
        3.1
      when 0x30000..0x3134A # extension G
        13.0
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
