from sys import argv
from os.path import exists

script, from_file, to_file = argv

print "Copy from_file %s to %s" % (from_file, to_file)

indata = open(from_file).read()

# print "The input file %d bytes long" % len(indata)
#
# print "Does the output file exist? %r" % exists(to_file)
# print "Ready, hit RETURN to continue, CTRL-C to about."
# raw_input()

out_file = open(to_file, 'w').write(indata)

print "We done"
# out_file.close()
# in_file.close()
