import requests
import re
import os


path = os.getcwd()

g = open('/home/woodsj/workspace/weirdhatwizard/db/data/lists/class_spell_list_all.txt','r')
class_spells = g.read()
g.close()
arr = class_spells.split('\n')
t = open('/home/woodsj/workspace/weirdhatwizard/db/data/lists/archetype_spell_list_all.txt','w')

split = False
for i in arr:
	if i == "bane$vengeance":
		split = True 
	if split:
	 t.write(i+'\n')
		
