# Unihan2

gem install unihan2

## Unicode version

15.1.0

## example

get strokes of chinese character:

    require 'unihan2'
    unihan = Unihan2.new
    unihan.strokes('三')  # return 3

Get Unicode Version by codepoint:

    unihan.ver('2A6D7') # 13.0
    unihan.ver(0x2A6D7) # 13.0

Get Unicode Version by character:

    unihan.ver('中') # 1.1
