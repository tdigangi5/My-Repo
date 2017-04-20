from sys import argv
script, filename = argv

txt = open(filename)

print "Here's your file %r:" % filename

print txt.read()


fileagain = raw_input("Enter your real file: ")
moretext = raw_input("This is your text: ")

txt_retry = open(fileagain, 'w')
txt_retry.write(moretext)
txt_retry.close()


openfile = open(fileagain)
print openfile.read()

openfile = open(fileagain, 'w')
openfile.truncate()
