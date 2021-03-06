import requests
import re
import os


path = os.getcwd()

def replace_all(text, dic):
    for i, j in dic.iteritems():
        text = re.sub(i, j, text)
    return text

#reps = { '<a href="/srd/combat/actionsInCombat.htm#standardActions">':'' , '</a>':'' }
#reps = { '<a[\s\/\w="\.#]*>':'' , '</a>':'' }
reps = { '<h6>':'<h3>' , '</h6>':'</h3>'  , '</a>':'' , '<a[\s\w=\":(\d);\',+!]*">':'' , '<a[\s\w=\"/.#]*">':'' , '<a[\s\w=\":();\',+!]*\">':'' }
whole = ""
first_page = requests.get("http://www.d20srd.org/indexes/spells.htm").text

first_page_pattern = re.compile('<li><a href="(/srd/spells/[\w]*\.htm)">[\w\s\?\,/\(\)]*</a></li>')

second_page_pattern_name = re.compile('<h1>(.*)</h1>')
second_page_pattern_type = re.compile('<a href="/srd/magicOverview/spellDescriptions.htm#\w*">(\w*)</a>')
second_page_pattern_target = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#range">Range</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_components = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#components">Components</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_cast_time = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#castingTime">Casting Time</a>:</th>[\n\s]*<td>(1 <a href="/srd/combat/actionsInCombat.htm#standardActions">standard action</a>)</td>|<th><a href="/srd/magicOverview/spellDescriptions.htm#castingTime">Casting Time</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_duration = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#duration">Duration</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_saving_throw = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#savingThrow">Saving Throw</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_spell_resistance = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#spellResistance">Spell Resistance</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_description = re.compile('</table>[\n\s]*(<p>[\n\s\w\W]*)<div class="footer">')
second_page_pattern_area = re.compile('<th><a href="/srd/magicOverview/spellDescriptions.htm#area">Area</a>:</th>[\n\s]*<td>(.*)</td>')
second_page_pattern_classes = re.compile('<a href="/srd/spellLists/[\w]*Spells.htm#[\w]*Spells">([\s\w\d/]*)</a>')

spells = ""
class_spells = ""

second_page = requests.get("http://www.d20srd.org/srd/spells/summonNaturesAllyI.htm" ).text.encode('ascii','ignore')
#	print  "http://www.d20srd.org"+i.group(1) + '\n'
print  second_page + '\n'
spells += "**"

temp = ""	
for i in re.finditer(second_page_pattern_type,second_page):
	if i.group(1) != "Range" and  i.group(1) != "Duration" and i.group(1) != "Level" and  i.group(1) != "Effect" and  i.group(1) != "Components" and i.group(1) != "Target" and i.group(1) != "Targets" and i.group(1) != "Area":
			temp += i.group(1) + ", "
	temp = temp[:-2]
	print temp + "\n"
	if temp == "":
		temp = "-"	
	spells += temp + '$'
	else:
		print "-" + '\n'
#		spells += "-" + '$'
	temp = re.search(second_page_pattern_target,second_page)
	if temp:
		print temp.group(1) + '\n'
		spells += replace_all(temp.group(1),reps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_components,second_page)
	if temp:
		print temp.group(1) + '\n'
		creps = { 'f':'F' }
		spells += replace_all(temp.group(1),creps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_cast_time,second_page)
	if temp:
		if temp.group(1):
			print replace_all(temp.group(1),reps) + '\n'
			spells += replace_all(temp.group(1),reps) + '$'
		elif temp.group(2):
			print replace_all(temp.group(2),reps) + '\n'
			spells += replace_all(temp.group(2),reps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_duration,second_page)
	if temp:
		print temp.group(1) + '\n'
		spells += replace_all(temp.group(1),reps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_saving_throw,second_page)
	if temp:
		print temp.group(1) + '\n'
		spells += replace_all(temp.group(1),reps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_spell_resistance,second_page)
	if temp:
		print temp.group(1) + '\n'
		spells += replace_all(temp.group(1),reps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_description,second_page) 
	if temp:
		print replace_all(temp.group(1),reps) + '\n'
		spells += replace_all(temp.group(1),reps) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	temp = re.search(second_page_pattern_area,second_page)
	if temp:
		print temp.group(1) + '\n'
		spells += temp.group(1) + '$'
	else:
		print "-" + '\n'
		spells += "-" + '$'
	name = re.search(second_page_pattern_name,second_page)
	if name:
		if name == "Summon Nature?s Ally I":
			print name.group(1) + '\n'
		spells += name.group(1) + '\n'
	else:
		print "-" + '\n'
		spells += "-" 
	temp = ""
	for i in re.finditer(second_page_pattern_classes,second_page):
		temp += i.group(1) + ", "
		
		arr = i.group(1).split(' ')
		if arr[0].lower() == "brd":
			class_spells += "bard$" + arr[1] + '$' + name.group(1) + '\n'
		elif arr[0].lower() == "drd":
			class_spells += "druid$" + arr[1] + '$' + name.group(1) + '\n'
		elif arr[0].lower() == "clr":
			class_spells += "cleric$" + arr[1] + '$' + name.group(1) + '\n'
		elif arr[0].lower() == "pal":
			class_spells += "paladin$" + arr[1] + '$' + name.group(1) + '\n'
		elif arr[0].lower() == "sor/wiz":
			class_spells += "sorcerer$" + arr[1] +  '$' + name.group(1) + '\n'
			class_spells += "wizard$" + arr[1] + '$' + name.group(1) + '\n'
		elif arr[0].lower() == "rgr":
			class_spells += "ranger$" + arr[1] + '$' + name.group(1) + '\n'
	
#	class_spells = class_spells[:-1]		
	temp = temp[:-2]
#	print temp + '\n'	

#/home/woodsj/workspace/weirdhatwizard/db/data/dnd35edata
#print path + '/lists/spells.txt' + '\n'
#open(path + '/lists/spells.txt','w').close()
#f = open(path + '/lists/spells.txt','w')
#spells = spells[2:]
#f.write(spells)
#f.close()

#print path + '/lists/class_spells.txt' + '\n'
#open(path + '/lists/class_spells.txt','w').close()
#f = open(path + '/lists/class_spells.txt','w')
#f.write(class_spells)
#f.close()
#check = whole.split('**')
#for i in check:
#	print i + '\n'
