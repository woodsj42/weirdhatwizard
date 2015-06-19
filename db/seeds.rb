# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dnd5e =  Dir.pwd + "/db/dnd5e_"
dnd35e = Dir.pwd + "/db/dnd35e_"
class_file = "classes.txt"
archetype_file = "archetypes.txt"
spell_file = "spells.txt"
class_attr_file = "class_attr.txt"
class_spell_file = "class_spell_list_all.txt"
archetype_spell_file = "archetype_spell_list_all.txt"

File.open( Dir.pwd + "/db/monster_categories.txt" ) do |f|
	while line = f.gets
		cleaned_category =  line.titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		MonsterCategory.create(name: cleaned_category)
#		print cleaned_category + "\n"
	end
end

File.open( dnd5e + class_file) do |f|
	while line = f.gets
		cleaned_class =  line.titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		Dnd5eClass.create(name: cleaned_class)
#		print cleaned_class + "\n"
	end
end

File.open(dnd5e + archetype_file) do |f|
	while line = f.gets
		arr = line.split('$')
		cleaned_class =  arr[1].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		cleaned_archetype =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		temp = Dnd5eClass.find_by_name(cleaned_class).id
		Dnd5eArchetype.create(name: cleaned_archetype, dnd5e_class_id: temp)
#		print arr[0] + "-" + arr[1].chomp + "-" + temp.to_s +  "\n"
	end
end

File.open(dnd5e + spell_file) do |f|
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
			cleaned_name =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_spell_type =  arr[2].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_cast_time =  arr[3].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_duration =  arr[6].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if !Dnd5eSpellType.exists?(:name => cleaned_spell_type)
				Dnd5eSpellType.create(:name => cleaned_spell_type)
			end

			if !Dnd5eDuration.exists?(:name => cleaned_duration)
				Dnd5eDuration.create(:name => cleaned_duration)
			end

			if !Dnd5eCastTime.exists?(:name => cleaned_cast_time)
				Dnd5eCastTime.create(:name => cleaned_cast_time)
			end

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

Dnd5eComponent.create(:name => "V")
Dnd5eComponent.create(:name => "S")
Dnd5eComponent.create(:name => "M")
Dnd35eComponent.create(:name => "V")
Dnd35eComponent.create(:name => "S")
Dnd35eComponent.create(:name => "M")
Dnd35eComponent.create(:name => "F")
Dnd35eComponent.create(:name => "DF")
Dnd35eComponent.create(:name => "XP")

File.open(dnd5e + class_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_name =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_class =  arr[1].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd5eSpell.exists?( :name => cleaned_name ) and Dnd5eClass.exists?( :name => cleaned_class )
				Dnd5eClassSpell.create(dnd5e_class_id: Dnd5eClass.find_by_name(cleaned_class).id,
					               dnd5e_spell_id:Dnd5eSpell.find_by_name(cleaned_name).id)
			else
#				print cleaned_name + " wasn't found for " + cleaned_class + ".\n"
			end
		end

end

File.open( dnd5e + archetype_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
#			print arr[0].chomp.titleize + "\n"
			cleaned_name =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_archetype =  arr[1].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd5eSpell.exists?( :name => cleaned_name ) and Dnd5eArchetype.exists?( :name => cleaned_archetype )
				Dnd5eArchetypeSpell.create(dnd5e_archetype_id: Dnd5eArchetype.find_by_name(cleaned_archetype).id,
					               dnd5e_spell_id:Dnd5eSpell.find_by_name(cleaned_name).id)
			else
#				print cleaned_name + " wasn't found for " + cleaned_archetype + ".\n"
			end
		end

end


class_file = "classes.txt"
spell_file = "spells.txt"
class_spell_file = "class_spells.txt"
domain_file = "domains.txt"
domain_spell_file = "domain_spells.txt"

File.open(dnd35e + spell_file) do |f|
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
			cleaned_name =  arr[9].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_spell_type =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_components =  arr[2].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_cast_time =  arr[3].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_duration =  arr[4].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			
			temp = cleaned_spell_type.gsub(',','').split(' ')
			temp.each do |m|
				if !Dnd35eSpellType.exists?(:name => m)
					Dnd35eSpellType.create(:name => m)
				end
			end

			if !Dnd35eDuration.exists?(:name => cleaned_duration)
				Dnd35eDuration.create(:name => cleaned_duration)
			end

			if !Dnd35eCastTime.exists?(:name => cleaned_cast_time)
				Dnd35eCastTime.create(:name => cleaned_cast_time)
			end
			
			if !Dnd35eSpell.exists?(:name => cleaned_name) 
				File.open('test.txt', 'w').write(cleaned_name) 
#				print cleaned_name + "\n"
				Dnd35eSpell.create(
					spell_type: arr[0],
					target: arr[1],
				  	components: arr[2],
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


File.open( dnd35e + domain_file) do |f|
	while line = f.gets
		arr = line.split('$')
		Dnd35eDomain.create(name: arr[0].chomp.titleize,
				    granted_power: arr[1])
#		print cleaned_class + "\n"
	end
end

File.open( dnd35e + class_file) do |f|
	while line = f.gets
		cleaned_class =  line.titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		Dnd35eClass.create(name: cleaned_class)
#		print cleaned_class + "\n"
	end
end

File.open( dnd35e + domain_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_class =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_name =  arr[2].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd35eSpell.exists?( :name => cleaned_name ) and Dnd35eDomain.exists?( :name => cleaned_class ) and !Dnd35eDomainSpell.exists?(:dnd35e_spell_id => Dnd35eSpell.find_by_name(cleaned_name).id, :dnd35e_domain_id => Dnd35eDomain.find_by_name(cleaned_class).id   ) 
				Dnd35eDomainSpell.create(dnd35e_domain_id: Dnd35eDomain.find_by_name(cleaned_class).id,
					                dnd35e_spell_id: Dnd35eSpell.find_by_name(cleaned_name).id,
							level: arr[1].to_i )
				print cleaned_name + " for " + cleaned_class + ".\n"
			else
#				print cleaned_name + " wasn't found for " + cleaned_class + ".\n"
			end
		end

end

File.open( dnd35e + class_spell_file) do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_class =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_name =  arr[2].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd35eSpell.exists?( :name => cleaned_name ) and Dnd35eClass.exists?( :name => cleaned_class ) and !Dnd35eClassSpell.exists?(:dnd35e_spell_id => Dnd35eSpell.find_by_name(cleaned_name).id, :dnd35e_class_id => Dnd35eClass.find_by_name(cleaned_class).id   ) 
				Dnd35eClassSpell.create(dnd35e_class_id: Dnd35eClass.find_by_name(cleaned_class).id,
					                dnd35e_spell_id: Dnd35eSpell.find_by_name(cleaned_name).id,
							level: arr[1].to_i )
				print cleaned_name + " for " + cleaned_class + ".\n"
			else
#				print cleaned_name + " wasn't found for " + cleaned_class + ".\n"
			end
		end

end

File.open(dnd5e + class_attr_file) do |f2|
	while line = f2.gets
		arr = line.split('$')
		arr[0]=  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		if arr[0] == "barbarian" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'rage',value: arr[0], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'rage damage',value: arr[0], level: arr[1])
		elsif arr[0] == "Bard" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0]).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[8], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[9], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[10], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th level spells',value: arr[11], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th level spells',value: arr[12], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th level spells',value: arr[13], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th level spells',value: arr[14], level: arr[1])
		elsif arr[0] == "Cleric" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value:arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[8], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[9], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[10], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th level spells',value: arr[11], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th level spells',value: arr[12], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th level spells',value: arr[13], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th level spells',value: arr[14], level: arr[1])
		elsif arr[0] == "Druid" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus',value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[8], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[9], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[10], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th level spells',value: arr[11], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th level spells',value: arr[12], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th level spells',value: arr[13], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th level spells',value: arr[14], level: arr[1])
		elsif arr[0] == "Fighter" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0]).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus',value: arr[2], level: arr[1])
		elsif arr[0] == "Eldritch Knight" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '1st level spells',value: arr[6], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '2nd level spells',value: arr[7], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '3rd level spells',value: arr[8], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '4th level spells',value: arr[9], level: arr[1])
		elsif arr[0] == "Monk" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value:arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'martial arts',value: arr[0], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'ki points',value: arr[0], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'unarmored movement',value: arr[0], level: arr[1])
		elsif arr[0] == "Paladin" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[8], level: arr[1])
		elsif arr[0] == "Ranger" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[8], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[9], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[10], level: arr[1])
		elsif arr[0] == "Rogue" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus',value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'sneak attack',value: arr[3], level: arr[1])
		elsif arr[0] == "Arcane Trickster" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'proficiency bonus',value: arr[2], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'sneak attack',value: arr[3], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'cantrips known',value: arr[5], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'number spells known',value: arr[6], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '1st level spells',value: arr[7], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '2nd level spells',value: arr[8], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '3rd level spells',value: arr[9], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '4th level spells',value: arr[10], level: arr[1])
		elsif arr[0] == "Sorcerer" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[8], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[9], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[10], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th level spells',value: arr[11], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th level spells',value: arr[12], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th level spells',value: arr[13], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th level spells',value: arr[14], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'sorcery points',value: arr[15], level: arr[1])
		elsif arr[0] == "Warlock" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value:arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'number spells known',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'spell slots',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'slot level',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'invocations known',value: arr[8], level: arr[1])
		elsif arr[0] == "Wizard" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'proficiency bonus', value:arr[2], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'cantrips known',value: arr[4], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st level spells',value: arr[5], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd level spells',value: arr[6], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd level spells',value: arr[7], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th level spells',value: arr[8], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th level spells',value: arr[9], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th level spells',value: arr[10], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th level spells',value: arr[11], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th level spells',value: arr[12], level: arr[1])
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th level spells',value: arr[13], level: arr[1])
		elsif arr[0] == "Battle Master" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'proficiency bonus', value: arr[2], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'superiority dice',value: arr[4], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'number of superiority dice',value: arr[5], level: arr[1])
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'number of known maneuvers',value: arr[6], level: arr[1])
		else
			print "couldn't find -"+arr[0]+"-\n"
		end
	end
end





