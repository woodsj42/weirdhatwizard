import requests
import re
import os


path = os.getcwd()

def replace_all(text, dic):
    for i, j in dic.iteritems():
        text = text.replace(i, j)
    return text

reps = { }# '$':'', '\n':'@' }#{'<strong>':'', '</strong>':'', '<p>':'', '</p>':'', '<em>':'', '</em>':'', '<ul>':'', '</ul>':'', '<li>':'', '</li>':'', '<ol>':'', '</ol>':'', '\n':' '}
whole = ""
first_page = requests.get("http://ephe.github.io/grimoire/").text

first_page_pattern = re.compile('spells/([\w\-\s]*)">(.*)</a>')
second_page_pattern_class_spell = re.compile('<a href="/grimoire/.*\">([\w\d]*)</a>')
second_page_pattern_spell_parts = re.compile('<p><strong>(.*)</strong></p>\n*<p><strong>[\sCastingTime]*</strong>:\s*(.*)</p>\n*<p><strong>[Range]*</strong>:\s*(.*)</p>\n*<p><strong>[Compents]*</strong>:\s*(.*)</p>\n*<p><strong>[Duration]*</strong>:\s*(.*)</p>\n*([\w\s\W\d]*)\s*</article>')
spell_description = ""

for i in re.finditer(first_page_pattern,first_page):
	second_page = requests.get("http://ephe.github.io/grimoire/spells/"+i.group(1)+"/").text.encode('ascii','ignore')
	whole += '**' + i.group(2)+"$"
	name = i.group(2)
	print i.group(2) + '\n'
	for i in re.finditer(second_page_pattern_spell_parts,second_page):
		concentration = "false"
		ritual = "false"
		spell_type = replace_all(i.group(1),reps)
		print spell_type + '\n'
		mylist = spell_type.split()
		if mylist[1] == 'cantrip':
			whole += mylist[1] + '$'
			whole += mylist[0] + '$'
		else:
			whole += mylist[0] + '$'
			whole += mylist[1] + '$'
		casting_time = replace_all(i.group(2),reps)
		print casting_time + '\n'
		whole += casting_time + "$"
		spell_range = replace_all(i.group(3),reps)
		print spell_range + '\n'
		whole += spell_range + "$"
		components = replace_all(i.group(4),reps)
		whole += components + "$"
		print components + '\n'
                duration = replace_all(i.group(5),reps)
		whole += duration + "$"
		print duration + '\n'
		description = replace_all(i.group(6),reps)
		print description + '\n'
		whole += description + '$'
		d_list = duration.split(', up to ')
		if d_list[0].lower() == 'concentration':
			concentration = "true"

		rituals = open(path + '/lists/rituals.txt','r').read()
		rituals_list = rituals.split('\n')

		for r in rituals_list:
			if r.split('$')[0].lower() == name.lower() and ritual == "false":
				ritual = "true"
		whole += concentration + '$' + ritual + '\n'


g = open(path + '/lists/my_spell_entries.txt','r')
my_spell_entries = g.read()
g.close()

mySpellList = my_spell_entries.split('**')
mySpellList.remove('')
reps = { }#'\n':'@' }#{'<strong>':'', '</strong>':'', '<p>':'', '</p>':'', '<em>':'', '</em>':'', '<ul>':'', '</ul>':'', '<li>':'', '</li>':'', '<ol>':'', '</ol>':'', '\n':' '}
for i in mySpellList:
	concentration = "false"
	ritual = "false"
	new_str = i
	d_list = new_str.split('$')
	m = d_list[6].split(', up to ')
	if m[0].lower() == "concentration":
		concentration = "true"

	rituals = open(path + '/lists/rituals.txt','r').read()
	rituals_list = rituals.split('\n')
	for r in rituals_list:
		if r.split('$')[0] == d_list[0] and ritual == "false":
			ritual = "true"
	new_str += '$' + concentration + '$' + ritual
	whole += '**' + new_str + '\n'
	
open(path + '/lists/spells.txt','w').close()
f = open(path + '/lists/spells.txt','w')
whole = whole[2:]
f.write(whole)
f.close()

#check = whole.split('**')
#for i in check:
#	print i + '\n'
