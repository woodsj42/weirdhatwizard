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
class_feats_file = "class_feats.txt"
archetype_feats_file = "archetype_feats.txt"
class_spell_file = "class_spell_list_all.txt"
archetype_spell_file = "archetype_spell_list_all.txt"


File.open(dnd5e + "spell_types.txt") do |f|
	while line = f.gets
			cleaned_spell_type = line.titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if !Dnd5eSpellType.exists?(:name => cleaned_spell_type)
				Dnd5eSpellType.create(:name => cleaned_spell_type)
			end
	end
end

File.open( dnd5e + "encounter_multipliers.txt" ) do |f|
	while line = f.gets
		arr = line.split('$')
		Dnd5eEncounterMultiplier.create( number_of_monsters: arr[0], multiplier: arr[1], number_of_characters: arr[2].chomp )
	end
end

File.open( dnd5e + "xp_thresholds_by_character_level.txt" ) do |f|
	while line = f.gets
		arr  =  line.split('$')
		Dnd5eXpThresholdsByCharacterLevel.create(character_level: arr[0], easy: arr[1], medium: arr[2], hard: arr[3], deadly: arr[4].chomp)
	end
end

File.open( Dir.pwd + "/db/monster_categories.txt" ) do |f|
	while line = f.gets
		MonsterCategory.create(name: line.chomp)
#		print cleaned_category + "\n"
	end
end

File.open( dnd5e + class_file) do |f|
	while line = f.gets
		arr = line.split('$')
		cleaned_class =  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		Dnd5eClass.create(name: cleaned_class,
				  hit_die: arr[1],
				  armor_proficiencies: arr[2],
				  weapon_proficiencies: arr[3],
				  tools: arr[4],
				  saving_throws: arr[5],
				  skill_proficiencies: arr[6],
				  main_ability: arr[7])
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
			cleaned_cast_time =  arr[3].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_duration =  arr[6].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			cleaned_spell_type = arr[2].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if !Dnd5eDuration.exists?(:name => cleaned_duration)
				Dnd5eDuration.create(:name => cleaned_duration)
			end

			if !Dnd5eCastTime.exists?(:name => cleaned_cast_time)
				Dnd5eCastTime.create(:name => cleaned_cast_time)
			end
			print Dnd5eSpellType.find_by_name(cleaned_spell_type)
			if !Dnd5eSpell.exists?(:name => cleaned_name) 
#				print cleaned_name + "\n"
				Dnd5eSpell.create(name: cleaned_name,
					level: arr[1],
				  	spell_type: cleaned_spell_type,
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
				Dnd5eClassSpell.create( dnd5e_class_id: Dnd5eClass.find_by_name(cleaned_class).id,
						        dnd5e_spell_id: Dnd5eSpell.find_by_name(cleaned_name).id,
						        level: arr[2].chomp)
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
				Dnd5eArchetypeSpell.create( dnd5e_archetype_id: Dnd5eArchetype.find_by_name(cleaned_archetype).id,
					                    dnd5e_spell_id:Dnd5eSpell.find_by_name(cleaned_name).id,
							    level: arr[2].chomp)
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
			if arr[0]
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
				print cleaned_name + "\n"
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
			cleaned_name =  arr[3].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd35eSpell.exists?( :name => cleaned_name ) and Dnd35eClass.exists?( :name => cleaned_class ) and !Dnd35eClassSpell.exists?(:dnd35e_spell_id => Dnd35eSpell.find_by_name(cleaned_name).id, :dnd35e_class_id => Dnd35eClass.find_by_name(cleaned_class).id   ) 
				Dnd35eClassSpell.create(dnd35e_class_id: Dnd35eClass.find_by_name(cleaned_class).id,
					                dnd35e_spell_id: Dnd35eSpell.find_by_name(cleaned_name).id,
							level: arr[1].to_i, 
							class_level: arr[2].to_i )
				print cleaned_name + " for " + cleaned_class + ".\n"
			else
#				print cleaned_name + " wasn't found for " + cleaned_class + ".\n"
			end
		end

end


File.open(dnd5e + class_attr_file) do |f2|
	probono = "<p></p>"
	rages_per_day = "<p> This is the Number of times you can rage in between long rests.</p>"
	rage_damage = "<p> The amount of damage you can do while ragins and using melee strength attacks.</p>"
	cantrips_known = "<p>The Number of cantrips that you know and can cast.</p>"
	num_spells_known = "<p>The Number of spells 1st-level and higher that you know.</p>"
	level1 = "<p>The Number of 1st-level spell slots that you have and can use to cast that level of spell</p>"
	level2 = "<p>The Number of 2nd-level spell slots that you have and can use to cast that level of spell</p>"
	level3 = "<p>The Number of 3rd-level spell slots that you have and can use to cast that level of spell</p>"
	level4 = "<p>The Number of 4th-level spell slots that you have and can use to cast that level of spell</p>"
	level5 = "<p>The Number of 5th-level spell slots that you have and can use to cast that level of spell</p>"
	level6 = "<p>The Number of 6th-level spell slots that you have and can use to cast that level of spell</p>"
	level7 = "<p>The Number of 7th-level spell slots that you have and can use to cast that level of spell</p>"
	level8 = "<p>The Number of 8th-level spell slots that you have and can use to cast that level of spell</p>"
	level9 = "<p>The Number of 9th-level spell slots that you have and can use to cast that level of spell</p>"
	martial_arts = "<p>The damage die for any monk weapons you use or if you use unarmed strikes.</p>"
	unarmored_movement = "<p>The additional amount of movement granted if you are wearing no armor at all.</p>"
	ki_points = "<p>The maximum Number of ki points you can have.</p>"
	sneak_attack_damage = "<p>The damage dice that you add to you damage when you trigger a sneak attack</p>"
	sorcery_points = "<p>The maximum Number of sorcery points that you can have at one time.</p>"
	num_invocations = "<p>The maximum Number of Eldritch invocations that you can know</p>"
	spell_slots = "<p>The Number of spells that you can cast in between long rests. This only includes spells that expend spell slots.</p>"
	slot_level = "<p>The highest level spell you can cast.</p>"
	superiority_die = "<p>The die you use with you maneuvers. </p>"
	num_superiority_dice = "<p>The Number of maneuvers that you can use in between long rests.</p>"
	num_known_maneuvers = "<p> The Number of maneuvers that you know.</p>"
	num_disciplines = "<p>The Number of disciplines that you know.</p>"
	max_ki_points = "<p>The maximum Number of ki points you can use to increase the spell level if the disciplines you cast.</p>"
	asi = "<p>This is the Number of times that you can do one of the following</p>
	       <p><ul>
               <li>Increase one ability score of your choice by 2.</li>
               <li>Increase two ability scores of your choice by 1.</li>
               <li>choose a feat from the feats list.</li>
               </ul></p>
	       <p>As normal you can't increase an ability score above 20 using this feature.</p>"

	while line = f2.gets
		arr = line.split('$')
		arr[0]=  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		if arr[0] == "Barbarian" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: arr[2], level: arr[1], description: probono )
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Rages Per Day',value: arr[4], level: arr[1],  description: rages_per_day )
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Rage Damage',value: arr[5].chomp, level: arr[1], description: rage_damage )
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Bard" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0]).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Cantrips Known',value: arr[4], level: arr[1], description: cantrips_known)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Number of Spells Known',value: arr[5], level: arr[1], description: num_spells_known)
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[6], level: arr[1], description: level1)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[7], level: arr[1], description: level2)
			end
			if arr[8] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[8], level: arr[1], description: level3)
			end
			if arr[9] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[9], level: arr[1], description: level4)
			end
			if arr[10] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[10], level: arr[1], description: level5)
			end
			if arr[11] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th Level Spells',value: arr[11], level: arr[1], description: level6)
			end
			if arr[12] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th Level Spells',value: arr[12], level: arr[1], description: level7)
			end
			if arr[13] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th Level Spells',value: arr[13], level: arr[1], description: level8)
			end
			if arr[14].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th Level Spells',value: arr[14].chomp, level: arr[1], description: level9)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Cleric" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value:arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Cantrips Known',value: arr[4], level: arr[1], description: cantrips_known)
			if arr[5] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[5], level: arr[1], description: level1)
			end
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[6], level: arr[1], description: level2)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[7], level: arr[1], description: level3)
			end
			if arr[8] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[8], level: arr[1], description: level4)
			end
			if arr[9] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[9], level: arr[1], description: level5)
			end
			if arr[10]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th Level Spells',value: arr[10], level: arr[1], description: level6)
			end
			if arr[11]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th Level Spells',value: arr[11], level: arr[1], description: level7)
			end
			if arr[12]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th Level Spells',value: arr[12], level: arr[1], description: level8)
			end
			if arr[13].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th Level Spells',value: arr[13].chomp, level: arr[1], description: level9)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Druid" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus',value: arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Cantrips Known',value: arr[4], level: arr[1], description: cantrips_known)
			if arr[5] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[5], level: arr[1], description: level1)
			end
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[6], level: arr[1], description: level2)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[7], level: arr[1], description: level3)
			end
			if arr[8] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[8], level: arr[1], description: level4)
			end
			if arr[9] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[9], level: arr[1], description: level5)
			end
			if arr[10]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th Level Spells',value: arr[10], level: arr[1], description: level6)
			end
			if arr[11]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th Level Spells',value: arr[11], level: arr[1], description: level7)
			end
			if arr[12]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th Level Spells',value: arr[12], level: arr[1], description: level8)
			end
			if arr[13].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th Level Spells',value: arr[13].chomp, level: arr[1], description: level9)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Fighter" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0]).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus',value: arr[2].chomp, level: arr[1], description: probono)
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Eldritch Knight" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Cantrips Known',value: arr[2], level: arr[1], description: cantrips_known)
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Number of Spells Known',value: arr[3], level: arr[1], description: num_spells_known)
			if arr[4] != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '1st Level Spells',value: arr[4], level: arr[1], description: level1)
			end
			if arr[5] != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '2nd Level Spells',value: arr[5], level: arr[1], description: level2)
			end
			if arr[6] != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '3rd Level Spells',value: arr[6], level: arr[1], description: level3)
			end
			if arr[7].chomp != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '4th Level Spells',value: arr[7].chomp, level: arr[1], description: level4)
			end
		elsif arr[0] == "Monk" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value:arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Martial Arts',value: arr[3], level: arr[1], description: martial_arts)
			if arr[4] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ki Points',value: arr[4], level: arr[1], description: ki_points)
			end
			if arr[5].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Unarmored Movement',value: arr[5].chomp, level: arr[1], description: unarmored_movement)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Paladin" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: arr[2], level: arr[1], description: probono)
			if arr[4] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[4], level: arr[1], description: level1)
			end
			if arr[5] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[5], level: arr[1], description: level2)
			end
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[6], level: arr[1], description: level3)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[7], level: arr[1], description: level4)
			end
			if arr[8].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[8].chomp, level: arr[1], description: level5)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Ranger" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: arr[2], level: arr[1], description: probono)
			if arr[4] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Number of Spells Known',value: arr[4], level: arr[1], description: num_spells_known)
			end
			if arr[5] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[5], level: arr[1], description: level1)
			end
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[6], level: arr[1], description: level2)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[7], level: arr[1], description: level3)
			end
			if arr[8] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[8], level: arr[1], description: level4)
			end
			if arr[9].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[9].chomp, level: arr[1], description: level5)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Rogue" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus',value: arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Sneak Attack Damage',value: arr[3].chomp, level: arr[1], description: sneak_attack_damage)
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Arcane Trickster" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Cantrips Known',value: arr[2], level: arr[1], description: cantrips_known)
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Number of Spells Known',value: arr[3], level: arr[1], description: num_spells_known)
			if arr[4] != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '1st Level Spells',value: arr[4], level: arr[1], description: level1)
			end
			if arr[5] != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '2nd Level Spells',value: arr[5], level: arr[1], description: level2)
			end
			if arr[6] != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '3rd Level Spells',value: arr[6], level: arr[1], description: level3)
			end
			if arr[7].chomp != "-"
				Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: '4th Level Spells',value: arr[7].chomp, level: arr[1], description: level4)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Sorcerer" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Cantrips Known',value: arr[4], level: arr[1], description: cantrips_known)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Number of Spells Known',value: arr[5], level: arr[1], description: num_spells_known)
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[6], level: arr[1], description: level1)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[7], level: arr[1], description: level2)
			end
			if arr[8] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[8], level: arr[1], description: level3)
			end
			if arr[9] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[9], level: arr[1], description: level4)
			end
			if arr[10]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[10], level: arr[1], description: level5)
			end
			if arr[11]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th Level Spells',value: arr[11], level: arr[1], description: level6)
			end
			if arr[12]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th Level Spells',value: arr[12], level: arr[1], description: level7)
			end
			if arr[13]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th Level Spells',value: arr[13], level: arr[1], description: level8)
			end
			if arr[14] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th Level Spells',value: arr[14], level: arr[1], description: level9)
			end
			if arr[15].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Sorcery Points',value: arr[15].chomp, level: arr[1], description: sorcery_points)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Warlock" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value:arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Cantrips Known',value: arr[4], level: arr[1], description: cantrips_known)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Number of spells known',value: arr[5], level: arr[1], description: num_spells_known)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Spell Slots',value: arr[6], level: arr[1], description: spell_slots)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Slot Level',value: arr[7], level: arr[1], description: slot_level)
			if arr[8].chomp != "-"
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Number of invocations known',value: arr[8].chomp, level: arr[1], description: num_invocations)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Wizard" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value:arr[2], level: arr[1], description: probono)
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Cantrips Known',value: arr[4], level: arr[1], description: cantrips_known)
			if arr[5] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '1st Level Spells',value: arr[5], level: arr[1], description: level1)
			end
			if arr[6] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '2nd Level Spells',value: arr[6], level: arr[1], description: level2)
			end
			if arr[7] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '3rd Level Spells',value: arr[7], level: arr[1], description: level3)
			end
			if arr[8] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '4th Level Spells',value: arr[8], level: arr[1], description: level4)
			end
			if arr[9] != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '5th Level Spells',value: arr[9], level: arr[1], description: level5)
			end
			if arr[10]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '6th Level Spells',value: arr[10], level: arr[1], description: level6)
			end
			if arr[11]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '7th Level Spells',value: arr[11], level: arr[1], description: level7)
			end
			if arr[12]!= "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '8th Level Spells',value: arr[12], level: arr[1], description: level8)
			end
			if arr[13].chomp != "-"
				Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: '9th Level Spells',value: arr[13].chomp, level: arr[1], description: level9)
			end
			case arr[1].to_i
				when 4..7
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "1", level: arr[1], description: asi )
				when 8..11
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "2", level: arr[1], description: asi )
				when 12..15
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "3", level: arr[1], description: asi )
				when 16..18
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "4", level: arr[1], description: asi )
				when 19..20
					Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Ability Score Improvement',value: "5", level: arr[1], description: asi )
			end 
		elsif arr[0] == "Battle Master" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Superiority Die',value: arr[2], level: arr[1], description: superiority_die)
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Number of Superiority Dice',value: arr[3], level: arr[1], description: num_superiority_dice)
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Number of Known Maneuvers',value: arr[4].chomp, level: arr[1], description: num_known_maneuvers)
		elsif arr[0] == "Four Elements" && Dnd5eArchetype.exists?( :name => arr[0] )
			temp_archetype = Dnd5eArchetype.where(name: arr[0] ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Number of Disciplines Known', value: arr[2], level: arr[1], description: num_disciplines)
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: 'Maximum Ki Points for a Spell',value: arr[3].chomp, level: arr[1], description: max_ki_points)
		else
			print "couldn't find -"+arr[0]+"-\n"
		end
	end
end


File.open(dnd5e + archetype_feats_file) do |f|
		for i in f.read().split("**")
			arr = i.split('$')
			temp_archetype = Dnd5eArchetype.where(name: arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the') ).take
			Dnd5eArchetypeAttribute.create(dnd5e_archetype_id: temp_archetype.id, name: arr[2].titleize.chomp.gsub('And','and').gsub('With','with').gsub('Into','into').gsub('The', 'the').gsub('Of ', 'of '), value: '*', level: arr[1], description: arr[3])
		end
end

File.open(dnd5e + class_feats_file) do |f|
		for i in f.read().split("**")
			arr = i.split('$')
			temp_class = Dnd5eClass.where(name: arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the') ).take
			if arr[4].nil?
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: arr[2].titleize.chomp.gsub('And','and').gsub('With','with').gsub('Into','into').gsub('The', 'the').gsub('Of ', 'of '), value: '*', level: arr[1], description: arr[3])
			else
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: arr[2].titleize.chomp.gsub('And','and').gsub('With','with').gsub('Into','into').gsub('The', 'the').gsub('Of ', 'of '), value: arr[4], level: arr[1], description: arr[3])
			end
		end
end

File.open(Dir.pwd + '/db/spell_tags.txt') do |f|
		while line = f.gets
			SpellTag.create(name: line.chomp.titleize )
		end
end

File.open(dnd5e + 'spell_tags.txt') do |f|
		while line = f.gets
			arr = line.split('$')
			temp = ''
			arr[1].split(',').each do |m|
				temp = temp + m.titleize.chomp.gsub('And','and').gsub('With','with').gsub('Into','into').gsub('The', 'the').gsub('Of ', 'of ') + ','
			end
			spell = Dnd5eSpell.find_by_name(arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the'))
			spell.tags = temp[0..-2]
			spell.save
		end
end
