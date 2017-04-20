from sys import argv

script, user_name = argv
prompt = '> '

print "Hi %s, I'm  the %s script." % (user_name, script)
print "I'd like to ask you a few questions."
print "Do you like me %s?" % user_name
likes = raw_input(prompt)

print "Where do you live %s?" % user_name
lives = raw_input(prompt)

print "What type of comp do you have"
computer = raw_input(prompt)

print """
This things like %r
I live %r
And you have a comp %r
""" % (likes, lives, computer)
