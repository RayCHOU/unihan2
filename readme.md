# Unihan2

gem install unihan2

## example

get strokes of chinese character:

    require 'unihan2'
    unihan = Unihan2.new
    unihan.strokes('三')  # return 3

Get Unicode Version by codepoint:

    Unihan2.unicode_version('2A6D7') # 13.0
    Unihan2.unicode_version(0x2A6D7) # 13.0
