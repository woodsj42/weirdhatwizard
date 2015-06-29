import requests
import re
import os


path = os.getcwd()

def replace_all(text, dic):
    for i, j in dic.iteritems():
        text = text.replace(i, j)
    return text

reps = { '<a href="http://www.d20pfsrd.com/gamemastering/combat#TOC-Standard-Actions">':'', '</a>':'', '<a href="http://www.d20pfsrd.com/gamemastering/combat#TOC-Touch-Attacks">':'' }
whole = ""
first_page = requests.get("http://www.d20pfsrd.com/magic/all-spells").text

first_page_pattern = re.compile('<a href="/magic/all-spells(/\w/[-\w]*)"')
second_page_pattern_name = re.compile('<title>([\w\s\'\-]*) - Pathfinder_OGC</title>')
second_page_pattern_school = re.compile('<p><b>School</b> <a href="http://www\.d20pfsrd\.com/magic#TOC-(\w*)">')
second_page_pattern_cast_time = re.compile('<p><b>Casting Time</b>([\d\w\s\<\=\"\.\:\/\#\-\>]*)<br />')
second_page_pattern_components = re.compile('Components</b>([\d\w\s\<\=\"\.\:\/\#\-\>\,\(\)]*)</p>')
second_page_pattern_casttime_components_range_target_duration_savingthrow_spellresistance = re.compile('Casting Time</b> ([\d\w\s\<\=\"\.\:\/\#\-\>\,\(\)\+\;]*)<br />')
spell_description = ""

for i in re.finditer(first_page_pattern,first_page):
	second_page = requests.get("http://www.d20pfsrd.com/magic/all-spells" + i.group(1)).text.encode('ascii','ignore')
	print second_page	
#	for i in re.finditer(second_page_pattern_spell_parts,second_page):


#open(path + 'spells.txt','w').close()
#f = open(path + 'spells.txt','w')
#f.write(whole)
#f.close()
