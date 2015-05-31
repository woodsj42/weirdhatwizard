# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

path = "/home/woodsj/workspace/weirdhatwizard/db/data/lists/"
class_file = "classes.txt"
archetype_file = "archetypes.txt"
spell_file = "spells.txt"
class_spell_file = "class_spell_list_all.txt"
archetype_spell_file = "archetype_spell_list_all.txt"
File.open(path + class_file) do |f|
	while line = f.gets
		Dnd5eClass.create(name:line.titleize.chomp)
#		print line + "\n"
	end
end

File.open(path + archetype_file) do |f|
	while line = f.gets
		arr = line.split('$')
		temp = Dnd5eClass.where(name: arr[1].titleize.chomp).take.id
		Dnd5eArchetype.create(name: arr[0].titleize, dnd5e_class_id: temp)
#		print arr[0] + "-" + arr[1].chomp + "-" + temp.to_s +  "\n"
	end
end

File.open(path + spell_file) do |f|
		for i in f.read().split("**")
			arr = i.split('$')
#			print arr[0] + "\n"
#			print arr[1] + "\n"
#			print arr[2] + "\n"
#			print arr[3] + "\n"
#			print arr[4] + "\n"
#			print arr[5] + "\n"
#			print arr[6] + "\n"
#			print arr[7] + "\n"
#			print arr[8] + "\n"
#			print arr[9] + "\n"
			Dnd5eSpell.create(name: arr[0].titleize,
					  level: arr[1],
					  spell_type: arr[2],
					  cast: arr[3],
					  range: arr[4],
					  components: arr[5],
					  duration: arr[6],
					  description: arr[7],
				          concentration: arr[8],
					  ritual: arr[9].chomp )
		end

end

File.open(path + class_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
			if Dnd5eSpell.exists?( :name => arr[0].titleize ) and Dnd5eClass.exists?( :name => arr[1].titleize.chomp )
				Dnd5eClassSpell.create(dnd5e_class_id: Dnd5eClass.where(name: arr[1].titleize.chomp).take.id,
					               dnd5e_spell_id:Dnd5eSpell.where(name: arr[0].titleize).take.id)
			else
				print arr[0].chomp + " wasn't found for " + arr[1].chomp + ".\n"
			end
		end

end

File.open(path + archetype_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
#			print arr[0].chomp.titleize + "\n"
			if Dnd5eSpell.exists?( :name => arr[0].chomp.titleize ) and Dnd5eArchetype.exists?( :name => arr[1].titleize.chomp )
				Dnd5eArchetypeSpell.create(dnd5e_archetype_id: Dnd5eArchetype.where(name: arr[1].chomp.titleize).take.id,
					               dnd5e_spell_id:Dnd5eSpell.where(name: arr[0].chomp.titleize).take.id)
			else
				print arr[0].chomp + " wasn't found for " + arr[1].chomp + ".\n"
			end
		end

end
