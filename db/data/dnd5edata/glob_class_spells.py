import glob

path = '/home/woodsj/Desktop/dnd_text/class_spells_lists/*spell_list.txt'
dest = '/home/woodsj/Desktop/dnd_text/class_spells_lists/class_spell_list_all.txt'

open(dest,'w').close()
h = open(dest,'a')


for file in glob.glob(path):
	f = open(file,'r')
	h.write(f.read())


