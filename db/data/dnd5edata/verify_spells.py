import os


path = os.getcwd()
verify  = open(path + '/verifiers/spells.txt','r')
to_verify = open(path + '/lists/spells.txt','r')
str_v = verify.read()
str_2v = to_verify.read()

verify.close()
to_verify.close()

spell_list2 = str_2v.split('**')
spell_list1 = str_v.split('\n')
found = False
num = 0
notfound = 0
notfoundlist = []
notfoundbooklist = []
print str(len(spell_list1)) + '\n'
print str(len(spell_list2)) + '\n'
print str(spell_list2) + '\n'
spell_list1.pop()
for i in spell_list1:
	for j in spell_list2:
#		print i.split('$')
		if i.split('$')[0].lower() == j.split('$')[0].lower():
			found = True
	if found == False:#and i.split('$')[7].split()[0] == 'phb':
		notfoundlist.append(i.split('$')[0] + ' ' + i.split('$')[7])
		notfound += 1
	found = False

notfoundlist.sort()
print '\n'.join(notfoundlist)

print str(notfound) + '\n'
