require 'nokogiri'
require 'csv'

class UnicodeCharsVer
  # @param xml_file_in [String] input unicode xml file path, ex: "ucd.all.flat.xml"
  # @param csv_file_out [String] csv file path for output
  def convert(xml_file_in, csv_file_out)
    print "parse xml..."
    doc = File.open(xml_file_in) { |f| Nokogiri::XML(f) }
    doc.remove_namespaces!
    puts 'done.'

    @rows = []
    read_chars(doc)
    
    CSV.open(csv_file_out, 'wb', headers: true) do |csv|
      csv << %w[cp1 cp2 age]
      @rows.each do |row|
        csv << [row[:cp1], row[:cp2], row[:age]]
      end
    end

    true
  end

  private

  def new_range(e)
    @rows << { 
      cp1: e.key?('cp') ? e['cp'] : e['first-cp'],
      cp2: e.key?('cp') ? e['cp'] : e['last-cp'],
      age: e['age']
    }
  end

  def read_chars(doc)
    doc.xpath('//char').each do |e|
      if @rows.empty?
        new_range(e)
        next
      end
    
      row = @rows.last
      if e.key?('cp')
        if e['age'] == row[:age]
          row[:cp2] = e['cp']
        else
          new_range(e)
        end
      else
        new_range(e)
      end
    end
  end 
end

IN = '../13.0.0/ucd.all.flat.xml'
OUT = '../out/unicode-chars-ver.csv'

