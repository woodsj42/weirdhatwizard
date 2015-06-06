# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

path = "/home/woodsj42/workspace/weirdhatwizard/db/data/dnd5edata/lists/"
class_file = "classes.txt"
archetype_file = "archetypes.txt"
spell_file = "spells.txt"
class_spell_file = "class_spell_list_all.txt"
archetype_spell_file = "archetype_spell_list_all.txt"
File.open(path + class_file) do |f|
	while line = f.gets
		cleaned_class =  line.titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		Dnd5eClass.create(name: cleaned_class)
		print cleaned_class + "\n"
	end
end

File.open(path + archetype_file) do |f|
	while line = f.gets
		arr = line.split('$')
		cleaned_class =  arr[1].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		cleaned_archetype =  arr[0].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		temp = Dnd5eClass.find_by_name(cleaned_class).id
		Dnd5eArchetype.create(name: cleaned_archetype, dnd5e_class_id: temp)
#		print arr[0] + "-" + arr[1].chomp + "-" + temp.to_s +  "\n"
	end
end

File.open(path + spell_file) do |f|
		for i in f.read().split("**")
			arr = i.split('$')
#			print arr[1] + "\n"
#			print arr[2] + "\n"
#			print arr[3] + "\n"
#			print arr[4] + "\n"
#			print arr[5] + "\n"
#			print arr[6] + "\n"
#			print arr[7] + "\n"
#			print arr[8] + "\n"
#			print arr[9] + "\n"
			cleaned_name =  arr[0].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if !Dnd5eSpell.exists?(:name => cleaned_name) 
#				print cleaned_name + "\n"
				Dnd5eSpell.create(name: cleaned_name,
					level: arr[1],
				  	spell_type: arr[2].titleize,
					cast: arr[3],
					range: arr[4],
					components: arr[5],
					duration: arr[6],
					description: arr[7],
				        concentration: arr[8],
					ritual: arr[9].chomp )
			end
		end

end

File.open(path + class_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_name =  arr[0].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_class =  arr[1].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd5eSpell.exists?( :name => cleaned_name ) and Dnd5eClass.exists?( :name => cleaned_class )
				Dnd5eClassSpell.create(dnd5e_class_id: Dnd5eClass.find_by_name(cleaned_class).id,
					               dnd5e_spell_id:Dnd5eSpell.find_by_name(cleaned_name).id)
			else
#				print cleaned_name + " wasn't found for " + cleaned_class + ".\n"
			end
		end

end

File.open(path + archetype_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
#			print arr[0].chomp.titleize + "\n"
			cleaned_name =  arr[0].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_archetype =  arr[1].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd5eSpell.exists?( :name => cleaned_name ) and Dnd5eArchetype.exists?( :name => cleaned_archetype )
				Dnd5eArchetypeSpell.create(dnd5e_archetype_id: Dnd5eArchetype.find_by_name(cleaned_archetype).id,
					               dnd5e_spell_id:Dnd5eSpell.find_by_name(cleaned_name).id)
			else
#				print cleaned_name + " wasn't found for " + cleaned_archetype + ".\n"
			end
		end

end



path = "/home/woodsj42/workspace/weirdhatwizard/db/data/dnd35edata/lists/"
class_file = "classes.txt"
spell_file = "spells.txt"
class_spell_file = "class_spells.txt"

File.open(path + spell_file) do |f|
		for i in f.read().split("**")
			arr = i.split('$')
#			print arr[1] + "\n"
#			print arr[2] + "\n"
#			print arr[3] + "\n"
#			print arr[4] + "\n"
#			print arr[5] + "\n"
#			print arr[6] + "\n"
#			print arr[7] + "\n"
#			print arr[8] + "\n"
#			print arr[9] + "\n"
			cleaned_name =  arr[9].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if !Dnd35eSpell.exists?(:name => cleaned_name) 
				File.open('test.txt', 'w').write(cleaned_name) 
				print cleaned_name + "\n"
				Dnd35eSpell.create(
					spell_type: arr[0],
					target: arr[1],
				  	components: arr[2].titleize,
					cast_time: arr[3],
					duration: arr[4],
					saving_throw: arr[5],
					spell_resistance: arr[6],
					description: arr[7],
				        area: arr[8],
					name: cleaned_name )
			end
		end

end


File.open(path + class_file) do |f|
	while line = f.gets
		cleaned_class =  line.titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		Dnd35eClass.create(name: cleaned_class)
#		print cleaned_class + "\n"
	end
end


File.open(path + class_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_class =  arr[0].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_name =  arr[2].titleize.chomp.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd35eSpell.exists?( :name => cleaned_name ) and Dnd35eClass.exists?( :name => cleaned_class )
				Dnd35eClassSpell.create(dnd35e_class_id: Dnd35eClass.find_by_name(cleaned_class).id,
					                dnd35e_spell_id: Dnd35eSpell.find_by_name(cleaned_name).id,
							level: arr[1].to_i )
			else
#				print cleaned_name + " wasn't found for " + cleaned_class + ".\n"
			end
		end

end

