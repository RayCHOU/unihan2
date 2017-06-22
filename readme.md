# Unihan2

gem install unihan2

# example

get strokes of chinese character:

	require 'unihan2'
	
	unihan = Unihan2.new
	unihan.strokes('三')  # return 3
