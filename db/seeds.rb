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
			cleaned_name =  arr[0].titleize.chomp.gsub(' Or ',' or ').gsub(' From ',' from ').gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
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

File.open( dnd5e + "saving_throws.txt") do |f|
		while line = f.gets
			Dnd5eSavingThrow.create(:name => line.titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the'))
		end
end

File.open(dnd5e + "damage_types.txt") do |f|
		while line = f.gets
			Dnd5eDamageType.create(:name => line.titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the'))
		end
end

File.open(dnd5e + "spell_saving_throw.txt") do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_name = arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			Dnd5eSpell.update( Dnd5eSpell.where(:name => cleaned_name ).take.id, :saving_throw => arr[1].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the') )
		end
end

File.open(dnd5e + "spell_damage.txt") do |f|
		while line = f.gets
			arr = line.split('$')
			cleaned_name = arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			temp1 = arr[1].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With',     'with').gsub('Into','into').gsub('The', 'the').split(', ')
			temp1.sort!
			cleaned_damage = temp1.join(", ")	
			Dnd5eSpell.update( Dnd5eSpell.where(:name => cleaned_name ).take.id, :damage_type => cleaned_damage )
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
	probono = "<p>Your proficiency bonus applies to many of numbers that you will be rolling for including:</p>
			<p><ul>
			<li>Attack rolls using weapons that you are proficient with</li>
			<li>Attack rolls with spells you cast</li>
			<li>Ability checks using skills you're proficient in</li>
			<li>Ability checks using tolls you're proficient with</li>
			<li>Saving throws you're proficient in</li>
			<li>Saving throw DCs for spells you cast</li>
			</ul></p>
			<p>Your proficiency bonus can't be added more than once to a single die roll or other number more than once. Occasionally your proficiency bonus might be modified ( doubled or halved, for example) before you apply it. If a circumstance suggests that your proficiency bonus applies more than once to the same roll or that it should be multiplied mroe than once, you neverthelessadd it only once, multiply it only once, and halve it only once.</p>"
	rages_per_day = "<p> This is the Number of times you can rage in between long rests.</p>"
	rage_damage = "<p> The amount of damage you can do while raging and using melee strength attacks.</p>"
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
	       <p>As normal you can't increase an ability score above 20 using this feature.</p>
		<h2 style='"'text-align:left;'"'>Feats List</h2>
		<h3>Alert</h3>
		<p>Always on the lookout for danger, you gain the following benefits:</p>
		<p><ul>
		<li>You gain a +5 bonus to intiative.</li>
		<li>You can't be surprised while you are conscious.</li>
		<li>Other creatures don't gan advantage on attack rolls.</li>
		</ul></p>
		<h3>Athlete</h3>
		<p>You have undergone extensive physical training to gain the following benefits:</p>
		<p><ul>
		<li>Increase you strength or dexterity score by 1, to a maximum of 20.</li>
		<li>When you are prone, standing up uses only 5 feet of your movement.</li>
		<li>Climbing doesn't halve your speed.</li>
		<li>You can make a running long jump or a running high jump after moving only 5 feet on foot, rather than 10 feet.</li>
		<p></ul>
		<h3>Actor</h3>
		<p>Skill at mimicry and dramatics, you gain the following benefits:</p>
		<p><ul>
		<li>Increase you charisma score by 1, to a maximum of 20.</li>
		<li>You have advantage on charisma ( deception ) and charisma ( performance ) checks when trying to pass yourself off as a different person.</li>
		<li>You can mimic the speech of another person or the sounds made by other creatures. You must have heard the person speaking, or heard the creature make the sound, for at least 1 minute. A successful wisdom ( insight ) check contested by your charisma ( deception ) check allows a listener to determine that the effect is faked. </li>
		<p></ul>
		<h3>Charger</h3>
		<p>When you use your action to dash, you can use a bonus action to make one melee weapon attack or to shove a creature.</p>
		<p>If you move at least 10 feet in a straight line immediately before taking this bonus action, you either gain a +5 bonus to the attack's damage roll ( if you chose to make a melee attack and hit ) or push the target up to 10 feet away from you ( if you chose to shove and you succeed ). </p>
		<h3>Crossbow Expert</h3>
		<p>Thanks to extensive practice with the crossbow, you gain the following benefits:</p>
		<p><ul>
		<li>You ignore the loading quality of crossbows with which you are proficient.</li>
		<li>Being within 5 feet of a hostile creature doesn't impose disadvantage on your ranged attack rolls.</li>
		<li>When you use the attack action and attack with a one-handed weapon, you can use a bonus action to attack with a loaded hand crossbow you are holding.</li>
		<p></ul>
		<h3>Defensive Duelist</h3>
		<p>Prerequisite: Dexterity 13 or higher</p>
		<p>When you are wielding a finesse wweapon with which you are proficent and another creature hits you with a melee attack, you can use your reaction to add your proficency bonus to your AC for that attack, potentially causing the attack to miss you.</p>
		<h3>Dual Wielder</h3>
		<p>You master fighting with two weapons, gaining the following benefits:</p>
		<p><ul>
		<li>You gain a +1 bonus to AC while you are wielding a separate melee weapon in each hand. </li>
		<li>You can use two-weapon fighting even when the one-handed melee weapons you are wielding aren't light.</li>
		<li>You can draw or stow two one-handed weapons when you would normally be able to draw or stow only one.</li>
		<p></ul>
		<h3>Dungeon Delver</h3>
		<p>Alert to the hidden traps and secret doors found in many dungeons, you gain the following benefits:</p>
		<p><ul>
		<li>You have advantage on wisdom ( perception ) and intelligence ( investigation ) checks made to detect the presence of secret doors.</li>
		<li>You have advantage on saving throws made to avoid or resist traps.</li>
		<li>You have resistance to the damage dealt by traps.</li>
		<li>You can search for traps while traveling at a normal pace, instead of at a slow pace.</li>
		<p></ul>
		<h3>Durable</h3>
		<p>Hardy and resilient, you gain the following benefits:</p>
		<p><ul>
		<li>Increase your constitution score by 1, to a maximum of 20.</li>
		<li> When you roll a hit die to regain hit points, the minimum number of hit points you regain from the roll equals twice your constitution modifier ( minimum of 2 ).</li>
		<p></ul>
		<h3>Elemental Adept</h3>
		<p>Prerequisite: the ability to cast at least one spell</p>
		<p>When you gain this feat, choose one of the following damage types: acid, cold, fire, lightning, or thunder.</p>
		<p>Spells you cast ignore resistance to damage for a spell you cast that deals damage of that type, you can treat any 1 on a damage die as a 2.</p>
		<p>You can select this feat multipe times. Each time you do so, you must choose a different damage type.</p>
		<h3>Grappler</h3>
		<p>Prerequisite: strength 13 or higher</p>
		<p>You've developed the skills necessary to hold your own in close-quarters grappling. You gain the following benefits.</p>
		<p><ul>
		<li>You have advantage on attack rolls against a creature you are grappling.</li>
		<li>You can use your action to try to pin a creature grappled by you. To do so, make another grapple check. If you succeed, you and the creature are both restrained until the grapple ends.</li>
		<li>Creatures that are one size larger than you don't automatically succeed on checks to escape your grapple.</li>
		<p></ul>
		<h3>Great Weapon Master</h3>
		<p>You've learned to put the weight to your advantage, letting its momentum empower your strikes. You gain the following benefits.</p>
		<p><ul>
		<li>On your turn, when you score a critical hit with a melee weapon or reduce a creature to 0 hit points with one, you can make one melee weapon attack as a bonus action</li>
		<li>Before you make a melee attack attack with a heavy weapon that you are proficient with, you can choose to take a -5 penalty to the attack roll. If the attack hits, you add +10 to the attack's damage.</li>
		<p></ul>
		<h3>Healer</h3>
		<p>You are an able physician, allowing you to mend wounds quickly and get your allies back in the fight. You gain the following benefits:</p>
		<p><ul>
		<li>When you use a healer's kit to stabilize a dying creature, that creature also regains 1 hit point.</li>
		<li>As an action, you can spend one use of a healer's kit to tend to a creature and resotre 1d6 + 4 hit points to it, plus additional hit points equal to the creature's maximum number of hit dice. The creature can't regain hit points from this feat again until it finishes a short or long rest</li>
		<p></ul>
		<h3>Heavily Armored</h3>
		<p>Prerequisite: proficiency with medium armor</p>
		<p>You have trained to master the use of heavy armor, gaining the following benefits:</p>
		<p><ul>
		<li>Increase you strength score by 1, to a maximum of 20.</li>
		<li>You gain proficiency with heavy armor.</li>
		<p></ul>
		<h3>Heavy Armor Master</h3>
		<p>Prerequisite: proficiency with heavy armor</p>
		<p>You can use your armor to defelct strikes that would kill others.</p>
		<p><ul>
		<li>Increase you strength score by 1, to a maximum of 20.</li>
		<li>While you are wearing heavy armor, bludgeoning, piercing and slashing damage that you take from nonmagical weapons is reduced by 3.</li>
		<p></ul>
		<h3>Inspiring Leader</h3>
		<p>Prerequisite: charisma 13 or higher</p>
		<p>You can spend 10 minutes inspiring your companions, shoring up their resolve to fight. When you do so, choose up to six friendly creatures ( which can include yourself ) within 30 feet of you who can see or hear you and who can understand you. Each creature can gain temporary hit points equal to <strong>your level + your charisma modifier.</strong> A creature can't gain temporary hit points from this feat agaun until it has finished a short or long rest.</p>
		<h3>Keen Mind</h3>
		<p>You have a mind track time, direction, and detail with uncanny precision. You gain the following benefits.</p>
		<p><ul>
		<li>Increase you Intelligence score by 1, to a maximum of  20.</li>
		<li>You always know which way is north.</li>
		<li>You always know the number of hours left before the next sunrise.</li>
		<li>You can accurately recall anything you have seen or heard within the past month</li>
		<p></ul>
		<h3>Lightly Armored</h3>
		<p>YOu have trained to master the use of light armor, gaining the following benefits:</p>
		<p><ul>
		<li>Increase your strength or dexterity score by 1, to a maximum of 20.</li>
		<li>ou gain proficiency with light armor.</li>
		<p></ul>
		<h3>Linguist</h3>
		<p>You have studied languages and codes, gaining the following benefits:</p>
		<p><ul>
		<li>Increase your Intelligence score by 1, to a maximum of 20.</li>
		<li>You learn three languages of you choice.</li>
		<li> You can ably create ciphers. Others can't deciipher a code you create unless you teach them, they succeed on an Intelligence sheck ( DC equal to <strong>your intelligence score + your proficiency bonus</strong> ), or they use magic to decipher it.</li>
		<p></ul>
		<h3>Lucky</h3>
		<p>You have inexplicable luck that seems to kick in at just the right moment.</p>
		<p>You have 3 luck points. Whenever you make an attack roll, an ability check, or a saving throw, you can spend on luck point to roll and additional d20. You can choose to spend one of your luck points after you roll the die, but before the outcome is determined. You choose which of the d20s is used for the attack roll, ability check, or saving throw.</p>
		<p>You can also spend one luk point when an attack roll is made against you. ROll a d20, and then choose whether the attack uses the attack's roll or yours. If more than one creature spends a luck point to influcne the outcome of a roll, the points ancel each other out; no additional dice are rolled.</p>
		<p>You regain your expended luck points when you finish a long rest.</p>
		<h3>Mage Slayer</h3>
		<p>You have practiced techniques useful in melee combat against spellcasters, gaining the following benefits:</p>
		<p><ul>
		<li>When a creature within 5 feet of you casts a spell, you can use your reaction to ame a melee weapon attack against that creature.</li>
		<li>When you damage a creature that is concentrating on a spell, that creature has disadvantage on the saving throw it makes to maintain its concentration.</li>
		<li>You have advantage on saving throws against spells cast by creatures within 5 feet of you.</li>
		<p></ul>
		<h3>Magic Initiate</h3>
		<p>Choose a class: bar, cleric. druid, sorcerer, warlock, or wizard. You learn two cantrips of you choice from that class's spell list.</p>
		<p>In addition, choose one 1st-level spell from that same list. You learn that spell and can cast it at its lowest level. Once you cast it, you must finish a long rest before you can cast it again.</p>
		<p>You spellcasting ability for these spells depends on the class you chose: charisma for bard, sorcerer, or warlock: wisdom for cleric or druid; or intelligence for wizard.</p>
		<h3>Martial Adept</h3>
		<p>You have martial training that allows you to perform special combat maneuvers. You gain the following benefits:</p>
		<p><ul>
		<li>You learn two maneuvers of you choice from among thse available to the battle master archetype in the fighter class. If a maeuver you use requires your target to make a saving throw to resist the maneuver's effects, the saving throw to resist the maneuver's effects, the saving throw DC equas <strong> 8 + your proficiency bonus + your strength or dexterity modifier ( your choice ).</strong></li>
		<li>If you already have superiority dice, you gain one more; otherwise, you hhave one superiority die, which is a d6.This die is used to fuel your maneuvers. A superiority die is expended when you use it You regain your expended superiority dice when you ginish a short or long rest.</li>
		<p></ul>
		<h3>Medium Armor Master</h3>
		<p>Prerequisite: proficiency with medium armor</p>
		<p>You have practiced in medium armor to gain the following benefits: </p>
		<p><ul>
		<li>Wearing medium armor doesn't impose disadvantage on your dexterity ( stealth ) checks.</li>
		<li>When you wear medium armor, you can add 3 rather than 2, to your AC if you have a dexterity of 16 or higher.</li>
		<p></ul>
		<h3>Mobile</h3>
		<p>You are exceptionally speedy and agile. You gain the following benefits:</p>
		<p><ul>
		<li>You speed increases by 10 feet.</li>
		<li>When you use the dash action, dificult terrain doesn't cost you extra movement on that turn.</li>
		<li>When you make a melee attack against a creature, you don't provoke opportunity attacks from that creature for the rest of the turn, whether you hit or not.</li>
		<p></ul>
		<h3>Moderately Armored</h3>
		<p>Prerequisite: proficiency with light armor</p>
		<p>You have trained to master the use of medium armor and shields. gaining the following benefits:</p>
		<p><ul>
		<li>Increase you strength or dexterity by 1, to a maximum of 20.</li>
		<li>You gain proficiency with medium armor and shields.</li>
		<p></ul>
		<h3>Mounted Combat</h3>
		<p>You are a dangerous foe to face while mounted. While you are mounted and aren't incapacitated, you gain the following benefits:</p>
		<p><ul>
		<li>You have advantage on melee attack rolls against any unmounted creature that is smaller than your mount.</li>
		<li>You can force an attack target at your mount to target you instead. </li>
		<li>If your mount is subjected to an effect that allows it to make a dexterity saving throw to take only half damage, it instead takes no damage if it succeeds on the saving throw, and only damage if it fails.</li>
		<p></ul>
		<h3>Observant</h3>
		<p>Quick to notice details of your environment, you gain the following benefits.</p>
		<p><ul>
		<li>Increase your intelligence or wisdom score by 1, to a maximum of 20.</li>
		<li> If you can see a creature's mouth while it is speaking a language you understand, you can interpret what it's saying by reading its lips.</li>
		<li>You have a +5 bonus to your passive wisdom ( perception ) and passive intelligence ( investigation ) scores.</li>
		<p></ul>
		<h3>Polearm Master</h3>
		<p>You can keep your enemies at bay with reach weapons. You gain the following benefits:</p>
		<p><ul>
		<li>When you take the attack action and attack with only a galive, haldberd, or quarterstaff, you can use a bonus action to make a melee attack with the opposite end of the weapon. The weapon's damage die for this attack is a d4, and the attack deals bludgeoning damage.</li>
		<li>While you are wielding a glaive, halberd, pike, or quarterstaff, other creatures provoke an attack of oppurtunity from you when they enter your reach. </li>
		<p></ul>
		<h3>Resilent</h3>
		<p>Choose one ability score. You gain the following benefits:</p>
		<p><ul>
		<li>You increase the chosen ability score by 1, to a maximum of 20.</li>
		<li>You gain proficiency in saving throws using the chosen ability.</li>
		<p></ul>
		<h3>Ritual Caster</h3>
		<p>Prerequisite: intelligence or wisdom 13 or higher</p>
		<p>You have learned a number of spells that you can cast as rituals. These spells are written in a ritual book which you must ave in hand while casting one of them.</p>
		<p>When you choose this feat, you acquire a ritual book holding two 1st-level spells of your choice. CHoose one of the following classes: bard, cleric, druid, sorcerer, warlock, or wizard. You must choose your spells from that class's spell list, and the spells you choose must hae the ritual tag. The classyou choose also determines your spellcasting ability for these spells: charisma for bard, sorcerer, or warlock; wisdom for cleric or druid; or intelligence for wizard.</p>
		<p>If you come across a spell in written form, such as a magical spell scroll or a wizard's spellbook, you might be able to add it to your ritual book. the spell must be on the spell list for the class you chose, the spell's level can be no higher than half your level ( rounded up ), and it must have the ritual tag. THe process of copying the spellinto your ritual bookk takes 2 hours per level of the spell, and costs 50 gp per level. The cost represents material components you expend as you experiment with the spell to master it, as well as the fin inks you need to record it.</p>
		<h3>Savage Attacker</h3>
		<p>Once per turn when you roll damage for a melee weapon attack, you can reroll the weapon's damage dice and use either total.</p>
		<h3>Sentinel</h3>
		<p>You have mastered techniques to take advantage of every drop in any enemy's guard, gaining the following benefits:</p>
		<p><ul>
		<li>When you hit a creature with an opportunity attack, the creature's speed becomes 0 for the rest of the turn.</li>
		<li>Creatures within 5 feet of you provoke opportunity attacks from you even if they take the disengage action before leaving your reack.</li>
		<li>When a creature within 5 feet of you makes an attack against a target other than you ( and that target doesn't have this feat), you can use your reaction to mae a melee attack against the attacking creature.</li>
		<p></ul>
		<h3>Sharpshooter</h3>
		<p>You have mastered ranged weapons and can make shots that others find impossible. You gain the following benefits:</p>
		<p><ul>
		<li>Attacking at long range doesn't impose disadvantage on your ranged weapon attack rolls.</li>
		<li>Your ranged weapon attacks ignore half cover and three-quarters cover.</li>
		<li>Before you make an attack with a ranged weapon that you are proficient with, you can choose to take a -5 penalty to that attack roll. If the attack hits, you hadd +10 to the attack's damage.</li>
		<p></ul>
		<h3>Shield Master</h3>
		<p>You use shields not just for protection but also for offense. You gain the following benefits while you are wielding a shield:</p>
		<p><ul>
		<li>If you take the attack action on your turn, you can use a bonus action to ttry to shove a creature within 5 feet of youwith your shield.</li>
		<li>If you aren't incapacitated, you can add your shield's AC bonus to any dexterity saving throw you make against a spell or other harmful effect that targets only you.</li>
		<li>If you are subjected to an effect that allows you to make a dexterity saving throw to take only half damage, you can use your reaction to take no damage if you succeed on the saving throw, interposing your shield between yourself and the source of the effect.</li>
		<p></ul>
		<h3>Skilled</h3>
		<p>You gain proficiency in any combination of three skills or tools of your choice.</p>
		<h3>Skulker</h3>
		<p>Prerequisite: dexterity 13 or higher</p>
		<p>You are expert at slinking through shadows. You gain the following benefits:</p>
		<p><ul>
		<li>You can try to hide when you are lightly obscured from the creature from which you are hiding.</li>
		<li>When you are hidden from a creature an miss it wth a ranged weapon attack, making the attack doesn't reveal our position.</li>
		<li>Dim light doesn't impose disadvantage on your wisdom ( perception ) checks relying on sight.</li>
		<p></ul>
		<h3>Spell Sniper</h3>
		<p>Prerequisite: the ability to cast at least one spell</p>
		<p>You have learned techniques to enhance your attacks with certain kinds of spells, gaining the following benefits.</p>
		<p><ul>
		<li>When you cast a spell taht requires you to make an attack roll, the spell's range is doubled.</li>
		<li>Your ranged spell attacks ignore half cover and three-quarters cover.</li>
		<li>You learn on cantrip taht requires an attack roll. Choose the cantrip from the bard, cleric, druid, sorcerer, warlock, or wizard spell list. You spellcasting ability for this cantrip depends on the spelll list you chose from: charisma for bard, sorcerer, warlock: wisdom for cleric or druid; intelligence for wizard.</li>
		<p></ul>
		<h3>Tavern Brawler</h3>
		<p>Accustomed to rough-and-tumble fighting using whatever weapons happen to be at hand, you gain the following benefits:</p>
		<p><ul>
		<li>Increase your strength or constitution socre by 1, to a maxiumum of 20.</li>
		<li>You are proficient with improvised weapons and unarmed strikes</li>
		<li>Your unarmed strike uses a d4 for damage.</li>
		<li>When you hit a creature withh an unarmed strike or an improvised weapon on your turn, you can use a bonus action to attempt to grapple target.</li>
		<p></ul>
		<h3>Tough</h3>
		<p>Your hit point maximum increases by an amount equal to twice you level when you gain this feat. Whenever you gain a level thereafter, your hit point maximum increases by an additional 2 hit points.</p>
		<h3>War Caster</h3>
		<p>Prerequisite the ability to cast at least one spell</p>
		<p>You have practiced casting spells in the midst of combat, learning techniques that grant you the following benefits:</p>
		<p><ul>
		<li>You have advantage on constitution saving throws that you make to maintain your concentration on a spell when you take damage.</li>
		<li>You can perform the somatic components of spells even when you have weapons or shield in one or both hands.</li>
		<li>When a hostile creature's movement provokes an opportunity attack from you, you can use your reactiont to cast a spell at the creature, rather than making an opportunity attack the spell must have a casting time of 1 action and must target only that creature.</li>
		<p></ul>
		<h3>Weapon Master</h3>
		<p>You have practiced extensively with a variety of weapons, gaining the following benefits:</p>
		<li>increase your strength or dexterity score by 1, to a maximum of 20.</li>
		<li>You gain proficiency with four weapons of your choice.</li>"

	while line = f2.gets
		arr = line.split('$')
		arr[0]=  arr[0].titleize.chomp.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
		if arr[0] == "Barbarian" && Dnd5eClass.exists?( :name => arr[0] )
			temp_class = Dnd5eClass.where(name: arr[0] ).take
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono )
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Rages Per Day',value: arr[4], level: arr[1],  description: rages_per_day )
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Rage Damage',value: "+" + arr[5].chomp, level: arr[1], description: rage_damage )
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus',value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus',value: "+"+arr[2].chomp, level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus',value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			Dnd5eClassAttribute.create(dnd5e_class_id: temp_class.id, name: 'Proficiency Bonus', value: "+"+arr[2], level: arr[1], description: probono)
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
			SpellTag.create(name: line.chomp.titleize.gsub('And','and').gsub('With','with').gsub('Into','into').gsub('The', 'the').gsub('Of ', 'of ') )
		end
end

File.open(dnd5e + 'spell_tags.txt') do |f|
		while line = f.gets
			arr = line.split('$')
			temp = ''
			arr[1].split(',').each do |m|
				temp = temp + m.titleize.chomp.gsub('And','and').gsub('With','with').gsub('Into','into').gsub('The', 'the').gsub('Of ', 'of ') + ','
			end
			spell = Dnd5eSpell.find_by_name(arr[0].titleize.chomp.gsub('From','from').gsub(' Or ',' or ').gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the'))
			temp1 = temp[0..-2].split(',')
			temp1.sort!
			spell.tags = temp1.join(",")	
			spell.save
		end
end
