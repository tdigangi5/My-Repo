def print_to(*args):
    arg1, arg2 = args
    print "arg1: %r, arg2: %r" % (arg1, arg2)

def print_two(arg1, arg2):
    print "arg1: %r, arg2: %r" % (arg1, arg2)

print_to("zed", "tony")
print_two("This", "That ")
