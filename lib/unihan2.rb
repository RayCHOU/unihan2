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

  # Listing of Characters Covered by the Unihan Database
  #   https://www.unicode.org/reports/tr38/tr38-29.html#BlockListing
  def self.ver(code)
    return nil if code.nil?

    if code.is_a? Integer
      i = code
    elsif code.size == 1
      i = code.codepoints.first
    else
      i = code.hex
    end

    case i
    when 0..0xFFFF        then uv0(i)
    when 0x20000..0x2FFFF then uv2(i)
    when 0x30000..0x3134A then 13.0
    end
  end

  # return total strokes of the character char
  # @param char [String] the character
  # @return [Integer] the total strokes
  def strokes(char)
    @strokes[char]
  end

  private

  def self.uv0(i)
    case i
    when 0..0x0FFF then uv00(i)
    when 0x1E00..0x1EFF
      case i
      when 0x1E00..0x1E9A then 1.1
      when 0x1E9B         then 2.0
      when 0x1E9C..0x1E9F then 5.1
      when 0x1EA0..0x1EF9 then 1.1
      when 0x1EFA..0x1EFF then 5.1
      end
    when 0x2000..0x2FFF then uv02(i)
    when 0x3000..0x33FF then uv03(i)
    when 0x3400..0x9FA5
      case i
      when 0x3400..0x4DB5 then 3.0 # CJK Extension A 中日韓統一表意文字擴充 A 區
      when 0x4DB6..0x4DBF then 13.0 # Extension A
      when 0x4E00..0x9FA5 then 1.1 # CJK Unified Ideographs
      end
    when 0x9FA6..0x9FFF
      case i
      when 0x9FA6..0x9FBB then 4.1 # CJK Unified Ideographs
      when 0x9FBC..0x9FC3 then 5.1 # CJK Unified Ideographs
      when 0x9FC4..0x9FCB then 5.2 # CJK Unified Ideographs
      when 0x9FCC         then 6.1 # CJK Unified Ideographs
      when 0x9FCD..0x9FD5 then 8.0 # CJK Unified Ideographs
      when 0x9FD6..0x9FEA then 10.0 # CJK Unified Ideographs
      when 0x9FEB..0x9FEF then 11.0 # CJK Unified Ideographs
      when 0x9FF0..0x9FFC then 13.0 # CJK Unified Ideographs
      end
    when 0xA000..0xDFFF
      case i
      when 0xA000..0xA48C then 3.0 # Yi Syllables 彝族文字區
      when 0xAC00..0xD7A3 then 2.0 # Hangul Syllables 韓文拼音
      end
    when 0xF000..0xFFFF
      case i
      when 0xF900..0xFA2D then 1.1 # CJK Compatibility Ideographs
      when 0xFA2E..0xFA2F then 6.1 # CJK Compatibility Ideographs
      when 0xFA30..0xFA6A then 3.2 # CJK Compatibility Ideographs
      when 0xFA6B..0xFA6D then 5.2 # CJK Compatibility Ideographs
      when 0xFA70..0xFAD9 then 4.1 # CJK Compatibility Ideographs
      when 0xFE10..0xFE19 then 4.1 # Vertical Forms 中文直排標點
      when 0xFE20..0xFE23 then 1.1 # Combining Half Marks
      when 0xFE24..0xFE26 then 5.1 # Combining Half Marks
      when 0xFE30..0xFE44 then 1.0 # CJK Compatibility Forms 兼容性表格
      when 0xFE45..0xFE46 then 3.2 # CJK Compatibility Forms 兼容性表格
      when 0xFE47..0xFE48 then 4.0 # CJK Compatibility Forms 兼容性表格
      when 0xFE49..0xFE4F then 1.0 # CJK Compatibility Forms 兼容性表格
      when 0xFE50..0xFE52 then 1.0 # Small Form Variants
      when 0xFE54..0xFE66 then 1.0 # Small Form Variants
      when 0xFE68..0xFE6B then 1.0 # Small Form Variants
      when 0xFF01..0xFF5E then 1.0 # Halfwidth and Fullwidth Forms
      when 0xFF5F..0xFF60 then 3.2 # Halfwidth and Fullwidth Forms
      when 0xFF61..0xFF9F then 1.0 # Halfwidth and Fullwidth Forms
      end
    end
  end

  def self.uv00(i)
    case i
    when 0..0x01FF
      case i
      when 0..0x017E then 1.0
      when 0x017F    then 1.1
      when 0x0180..0x01F0 then 1.0
      when 0x01F1..0x01F5 then 1.1
      when 0x01F6..0x01F9 then 3.0
      when 0x01FA..0x0217 then 1.1
      end
    when 0x0200..0x02FF
      case i
      when 0x0218..0x021F then 3.0
      when 0x0220         then 3.2
      when 0x0221         then 4.0
      when 0x0222..0x0233 then 3.0
      when 0x0234..0x0236 then 4.0
      when 0x0237..0x0241 then 4.1
      when 0x0242..0x024F then 5.0
      when 0x0250..0x02A8 then 1.0
      when 0x02A9..0x02AD then 3.0
      when 0x02AE..0x02AF then 4.0
      when 0x02B0..0x02DE then 1.0
      when 0x02DF         then 3.0
      when 0x02E0..0x02E9 then 1.0
      when 0x02EA..0x02EE then 3.0
      when 0x02EF..0x02FF then 4.0
      end
    when 0x0300..0x0341 then 1.0
    when 0x0400..0x04FF
      case i
      when 0x0401..0x040C then 1.0
      when 0x040D         then 3.0
      when 0x040E..0x044F then 1.0
      end
    end
  end

  def self.uv02(i)
    case i
    when 0x2000..0x20FF
      case i
      when 0x2000..0x202E then 1.0
      when 0x2045..0x2046 then 1.1
      when 0x2047         then 3.2
      when 0x2048..0x204F then 3.0
      end
    when 0x2100..0x21FF
      case i
      when 0x2100..0x2138 then 1.0
      when 0x2153..0x2182 then 1.0
      when 0x2190..0x21EA then 1.0
      end
    when 0x2200..0x22F1 then 1.0
    when 0x2400..0x24FF
      case i
      when 0x2460..0x24EA then 1.0
      when 0x24EB..0x24FE then 3.2
      when 0x24FF         then 4.0
      end
    when 0x2500..0x25FF
      case i
      when 0x2500..0x2595 then 1.0
      when 0x2596..0x259F then 3.2
      when 0x25A0..0x25EE then 1.0
      when 0x25EF         then 1.1
      end
    when 0x2600..0x26FF
      case i
      when 0x2600..0x2613 then 1.0
      when 0x261A..0x266F then 1.0
      end
    when 0x2E00..0x2FFF
      case i
      when 0x2E80..0x2EF3 then 3.0
      when 0x2F00..0x2FD5 then 3.0
      when 0x2FF0..0x2FFB then 3.0
      end
    end
  end

  def self.uv03(i)
    case i
    when 0x3000..0x30FF
      case i
      when 0x3000..0x3036 then 1.0 # CJK Symbols and Punctuation
      when 0x3037         then 1.1 # CJK Symbols and Punctuation
      when 0x3038..0x303A then 3.0 # CJK Symbols and Punctuation
      when 0x303B..0x303D then 3.2 # CJK Symbols and Punctuation
      when 0x303E         then 3.0 # CJK Symbols and Punctuation
      when 0x303F         then 1.0 # CJK Symbols and Punctuation
      when 0x3041..0x3094 then 1.0 # Hiragana 日文平假名
      when 0x3095..0x3096 then 3.2 # Hiragana 日文平假名
      when 0x3099..0x309E then 1.0 # Hiragana 日文平假名
      when 0x309F         then 3.2 # Hiragana 日文平假名
      when 0x30A0         then 3.2 # Katakana 日文片假名
      when 0x30A1..0x30F6 then 1.0 # Katakana 日文片假名
      when 0x30F7..0x30FA then 1.1 # Katakana 日文片假名
      when 0x30FB..0x30FE then 1.0 # Katakana 日文片假名
      when 0x30FF         then 3.2 # Katakana 日文片假名 (Unicode 3.2)
      end
    when 0x3100..0x31FF
      case i
      when 0x3105..0x312C then 1.0 # Bopomofo 注音符號
      when 0x312D         then 5.1 # Bopomofo 上下顛倒的 'ㄓ'
      when 0x3131..0x318E then 1.0 # Hangul Compatibility Jamo 韓文
      when 0x3190..0x319F then 1.0 # Kanbun 在上方的小漢字
      when 0x31A0..0x31B7 then 3.0 # Bopomofo Extended 注音擴展
      when 0x31B8..0x31BA then 6.0 # Bopomofo Extended 注音擴展
      when 0x31C0..0x31CF then 4.1 # CJK Strokes 筆劃 (基本筆劃, 如撇, 勾, 點...)
      when 0x31D0..0x31E3 then 5.1 # CJK Strokes 筆劃 (基本筆劃, 如撇, 勾, 點...)
      when 0x31F0..0x31FF then 3.2 # Katakana Phonetic Extensions 日文片假名語音擴展
      end
    when 0x3200..0x32FF
      case i
      when 0x3200..0x321C then 1.0 # Enclosed CJK Letters and Months 括號韓文
      when 0x321D..0x321E then 4.0 # Enclosed CJK Letters and Months 括號韓文
      when 0x3220..0x3243 then 1.0 # Enclosed CJK Letters and Months 括號一~十及漢字
      when 0x3244..0x324F then 5.2 # Enclosed CJK Letters and Months 圓圈中有字及10~80
      when 0x3250         then 4.0 # Enclosed CJK Letters and Months 'PTE' 組成一字
      when 0x3251..0x325F then 3.2 # Enclosed CJK Letters and Months 圓圈 21~35
      when 0x3260..0x327B then 1.0 # Enclosed CJK Letters and Months 圓圈韓文
      when 0x327C..0x327D then 4.0 # Enclosed CJK Letters and Months 圓圈韓文
      when 0x327E         then 4.1 # Enclosed CJK Letters and Months 圓圈韓文
      when 0x327F..0x32B0 then 1.0 # Enclosed CJK Letters and Months 圓圈一~十及漢字
      when 0x32B1..0x32BF then 3.2 # Enclosed CJK Letters and Months 圓圈 36~50
      when 0x32C0..0x32CB then 1.1 # Enclosed CJK Letters and Months 1月~12月
      when 0x32CC..0x32CF then 4.0 # Enclosed CJK Letters and Months 多英文組成一個字
      when 0x32D0..0x32FE then 1.0 # Enclosed CJK Letters and Months 圓圈日文
      end
    when 0x3300..0x33FF
      case i
      when 0x3300..0x3357 then 1.0 # CJK Compatibility 多個日文組成一字
      when 0x3358..0x3376 then 1.1 # CJK Compatibility 0点~24点 及多英文組成一字
      when 0x3377..0x337A then 4.0 # CJK Compatibility 多英文組成一字
      when 0x337B..0x33DD then 1.0 # CJK Compatibility 多日本漢字及多英文組成一字
      when 0x33DE..0x33DF then 4.0 # CJK Compatibility 多英文組成一字
      when 0x33E0..0x33FE then 1.1 # CJK Compatibility 1日~31日
      when 0x33FF         then 4.0 # CJK Compatibility 'gal' 組成一字
      end
    end
  end

  def self.uv2(i)
    case i
    when 0x20000..0x2A6D6 then 3.1  # Extension B
    when 0x2A6D7..0x2A6DD then 13.0 # Extension B
    when 0x2A700..0x2B734 then 5.2  # extension C
    when 0x2B740..0x2B81D then 6.0  # extension D
    when 0x2B820..0x2CEA1 then 8.0  # extension E
    when 0x2CEB0..0x2EBE0 then 10.0 # extension F
    when 0x2F800..0x2FA1D then 3.1  # Unicode 3.1: CJK Compatibility Supplement
    end
  end

  private_class_method :uv0, :uv00, :uv02, :uv03, :uv2

end