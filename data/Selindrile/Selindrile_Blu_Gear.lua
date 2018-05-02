function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Fodder','Normal','MinAcc','SomeAcc','Acc','HighAcc','FullAcc','None')
	state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Normal','SomeAcc','Acc','HighAcc','FullAcc','Fodder')
    state.CastingMode:options('Normal','Resistant','Fodder')
    state.IdleMode:options('Normal','Sphere','PDT','DTHippo')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP','SuppaBrutal', 'DWEarrings','DWMax'}
	
	gear.da_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.stp_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.crit_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.wsd_jse_back = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.mab_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Luminary Sash"

	gear.obi_nuke_back = "Cornflower Cape"
	gear.obi_nuke_waist = "Yamabuki-no-Obi"
	
	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	update_combat_form()
	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +1"}
	sets.buff.Convergence = {head="Luh. Keffiyeh +1"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
	sets.buff.Enchainment = {} --body="Luhlaza Jubbah +1" (Don't have Enchainment, have Jubbah)
	sets.buff.Efflux = {back=gear.da_jse_back,legs="Hashishin Tayt +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +1"}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {legs="Dashing Subligar"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	sets.precast.Step = {ammo="Falcon Eye",
					head="Dampening Tam",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
					body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
					back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.precast.Flourish1 = {ammo="Falcon Eye",
			       head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Regal Earring",ear2="Digni. Earring",
                   body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
			       back="Cornflower Cape",waist="Olseni Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

	-- Fast cast sets for spells

	sets.precast.FC = {main="Vampirism",sub="Vampirism",ammo="Impatiens",
		head="Carmine Mask +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Carmine Greaves +1"}
		
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
		
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
				  head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
                  body="Adhemar Jacket",hands="Jhakri Cuffs +2",ring1="Epona's Ring",ring2="Apate Ring",
				  back=gear.da_jse_back,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

	sets.precast.WS.SomeAcc = {ammo="Ginsen",
				  head="Dampening Tam",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
                  body="Adhemar Jacket",hands="Jhakri Cuffs +2",ring1="Epona's Ring",ring2="Apate Ring",
				  back=gear.da_jse_back,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				  
	sets.precast.WS.Acc = {ammo="Falcon Eye",
				  head="Carmine Mask +1",neck="Fotia Gorget",ear1="Regal Earring",ear2="Telos Earring",
				  body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Epona's Ring",ring2="Ilabrat Ring",
			      back=gear.da_jse_back,waist="Fotia Belt",legs="Carmine Cuisses +1",feet=gear.herculean_ta_feet}
				  
	sets.precast.WS.HighAcc = {ammo="Falcon Eye",
				  head="Carmine Mask +1",neck="Fotia Gorget",ear1="Regal Earring",ear2="Telos Earring",
				  body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
			      back=gear.da_jse_back,waist="Fotia Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				  
	sets.precast.WS.FullAcc = {ammo="Falcon Eye",
				  head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
				  body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
			      back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head="Carmine Mask +1",ear1="Regal Earring",body="Jhakri Robe +2",hands="Assim. Bazu. +3",ring2="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Carmine Mask +1",ear1="Regal Earring",body="Jhakri Robe +2",hands="Assim. Bazu. +3",ring2="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Rufescent Ring"})
	sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ring1="Rufescent Ring"})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {head="Carmine Mask +1",ear1="Regal Earring",body="Jhakri Robe +2",hands="Assim. Bazu. +3",ring2="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Realmrazer'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Carmine Mask +1",ear1="Regal Earring",body="Jhakri Robe +2",hands="Assim. Bazu. +3",ring2="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Rufescent Ring"})
	sets.precast.WS['Realmrazer'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ring1="Rufescent Ring"})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ammo="Falcon Eye",head="Adhemar Bonnet",ear1="Moonshade Earring",body="Abnoba Kaftan",hands="Adhemar Wristbands",ring2="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	sets.precast.WS['Chant du Cygne'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Falcon Eye",ear1="Moonshade Earring",ear2="Cessance Earring",body="Abnoba Kaftan",hands="Adhemar Wristbands",ring2="Begrudging Ring",back=gear.crit_jse_back})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",ring2="Begrudging Ring",back=gear.crit_jse_back,legs="Carmine Cuisses +1"})
	sets.precast.WS['Chant du Cygne'].HighAcc = set_combine(sets.precast.WS.HighAcc, {back=gear.crit_jse_back})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Regal Earring",ear2="Moonshade Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ifrit Ring +1",ring2="Rufescent Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Carmine Mask +1",ear1="Moonshade Earring",ear1="Regal Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ifrit Ring +1",ring2="Rufescent Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Karieyh Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet})
	sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ear2="Moonshade Earring",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Karieyh Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",feet=gear.herculean_wsd_feet})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})
	
	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet",ear1="Cessance Earring", ear2="Brutal Earring",ring2="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet",ring2="Begrudging Ring",back=gear.crit_jse_back})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.crit_jse_back})
	sets.precast.WS['Vorpal Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})
	
	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ifrit Ring +1",ring2="Karieyh Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	sets.precast.WS['Expiacion'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ear1="Moonshade Earring",ear2="Ishvara Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Karieyh Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Rufescent Ring",ring2="Karieyh Ring",back=gear.wsd_jse_back,legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet})
	sets.precast.WS['Expiacion'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ear2="Moonshade Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",back=gear.wsd_jse_back,legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {body="Assim. Jubbah +3",hands="Jhakri Cuffs +2"})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})


	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
			         head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		             body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Archon Ring",
			         back=gear.mab_jse_back,waist="Yamabuki-no-Obi",legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
					 
	sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
			         head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
		             body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
			         back=gear.mab_jse_back,waist="Yamabuki-no-Obi",legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.precast.AccMaxTP = {ear1="Regal Earring",ear2="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Hasty Pinion +1",
		head="Carmine Mask +1",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Carmine Greaves +1"}
		
	sets.midcast['Blue Magic'] = {}
	
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = {main="Vampirism",sub="Vampirism",ammo="Mavi Tathlum",
		head="Lilitu Headpiece",neck="Caro Necklace",ear1="Suppanomimi",ear2="Telos Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Apate Ring",ring2="Rajas Ring",
		back="Cornflower Cape",waist="Grunfeld Rope",legs="Jhakri Slops +1",feet=gear.herculean_acc_feet}

	sets.midcast['Blue Magic'].Physical.Resistant = {main="Tanmogayi +1",sub="Colada",ammo="Falcon Eye",
		head="Jhakri Coronal +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
	    body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
	    back=gear.da_jse_back,waist="Grunfeld Rope",legs="Jhakri Slops +1",feet=gear.herculean_acc_feet}
		
	sets.midcast['Blue Magic'].Physical.Fodder = {main="Iris",sub="Iris",ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Caro Necklace",ear1="Suppanomimi",ear2="Telos Earring",
		body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Apate Ring",ring2="Rajas Ring",
		back="Cornflower Cape",waist="Grunfeld Rope",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
		
	sets.midcast['Blue Magic'].PhysicalAcc = {main="Tanmogayi +1",sub="Colada",ammo="Falcon Eye",
		head="Jhakri Coronal +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
	    body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
	    back=gear.da_jse_back,waist="Grunfeld Rope",legs="Jhakri Slops +1",feet=gear.herculean_acc_feet}

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder
		
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})


	-- Magical Spells --
	
	sets.midcast['Blue Magic'].Magical = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					 head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +2",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
				     back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
					 
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{neck="Sanctity Necklace",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",legs="Jhakri Slops +1",waist="Yamabuki-no-Obi"})
		
	sets.midcast['Blue Magic'].Magical.Fodder = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					 head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +2",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
				     back=gear.ElementalCape,waist=gear.ElementalObi,legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {neck="Sanctity Necklace",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",legs="Jhakri Slops +1",waist="Yamabuki-no-Obi"})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
	sets.midcast['Blue Magic'].MagicAccuracy = {main="Iris",sub="Iris",ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
				    body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring1="Stikini Ring",
					back="Cornflower Cape",waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

	sets.midcast['Enfeebling Magic'] = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
				    body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
					back=gear.mab_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}

	sets.midcast['Dark Magic'] = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
				    body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
					back=gear.mab_jse_back,waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
					
	sets.midcast['Enhancing Magic'] = {main="Vampirism", sub="Vampirism",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

	sets.midcast['Divine Magic'] = {ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
				    body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
					back=gear.mab_jse_back,waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
					
	sets.midcast['Elemental Magic'] = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Dosis Tathlum",
					 head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +2",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
				     back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}

	sets.midcast['Elemental Magic'].Resistant = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					 head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
				     back=gear.mab_jse_back,waist="Yamabuki-no-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
					 
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Fodder
	
	sets.DarkNuke = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.LightNuke = {} --ring2="Weatherspoon Ring"
					 
	sets.midcast.Cure = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					head="Carmine Mask +1",neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Mendi. Earring",
			        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
			        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Medium's Sabots"}
					
	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Mavi Scarf",ear1="Regal Earring",ear2="Digni. Earring",
		body="Assim. Jubbah +3",hands="Luh. Bazubands +1",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Cornflower Cape",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}

	-- Physical Added Effect Spells most notably "Stun" spells --
	
	sets.midcast['Blue Magic'].Stun = {main="Iris",sub="Iris",ammo="Pemphredo Tathlum",
			       head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
                   body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
			       back="Cornflower Cape",waist="Luminary Sash",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
				   
	sets.midcast['Blue Magic'].Stun.Resistant = {main="Iris",sub="Iris",ammo="Falcon Eye",
			       head="Jhakri Coronal +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
                   body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Stikini Ring",ring2="Stikini Ring",
			       back="Cornflower Cape",waist="Olseni Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
				   
	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun

	-- Other Specific Spells --
	
	sets.midcast['Blue Magic']['White Wind'] = {ammo="Mavi Tathlum",
					head="Carmine Mask +1",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Loquac. Earring",
			        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Asklepian Ring",ring2="Lebeche Ring",
			        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Gyve Trousers",feet="Medium's Sabots"}

	sets.midcast['Blue Magic'].Healing = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Staunch Tathlum",
					head="Carmine Mask +1",neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Mendi. Earring",
			        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
			        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Medium's Sabots"}
					
	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Tempered Cape +1",waist="Luminary Sash"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {main="Iris",sub="Iris",ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Assim. Jubbah +3",hands="Rawhide Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}

	sets.midcast['Blue Magic'].Buff = {main="Vampirism",sub="Vampirism",ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Assim. Jubbah +3",hands="Hashi. Bazu. +1",ring1="Kishar Ring",ring2="Dark Ring",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Carmine Greaves +1"}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif",back="Grapevine Cape",waist="Gishdubar Sash"})
	
	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Protectra = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Shellra = {ring2="Sheltered Ring"}
	

	
	
	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {feet="Serpentes Sabots"}
	sets.NightIdle = {}
	
	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +3"}

	-- Resting sets
	sets.resting = {main="Bolelabunga",sub="Genmei Shield",ammo="Falcon Eye",
			      head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
			      body="Jhakri Robe +2",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Sheltered Ring",
			      back="Bleating Mantle",waist="Flume Belt",legs="Lengo Pants",feet="Serpentes Sabots"}

	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
			      head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
			      body="Jhakri Robe +2",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Karieyh Ring",
			      back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet="Hippo. Socks +1"}
	
	sets.idle.Sphere = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
			      head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
			      body="Mekosu. Harness",hands=gear.herculean_refresh_hands,ring1="Defending Ring",ring2="Karieyh Ring",
			      back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet=gear.herculean_dt_feet}

	sets.idle.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
				head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
				
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {legs="Carmine Cuisses +1",feet="Hippo. Socks +1"})
				  
	-- Defense sets
	sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Brutal Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Moonbeam Cape",waist="Windbuffet Belt +1",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}

	sets.defense.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Sanare Earring",
		        body="Ayanmo Corazza +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Flax Sash",legs="Hagondes Pants +1",feet=gear.herculean_dt_feet}
				
    sets.defense.MEVA = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
        head="Amalric Coif",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Hashishin Mintan +1",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back=gear.mab_jse_back,waist="Luminary Sash",legs="Telchine Braconi",feet="Hippo. Socks +1"}
				
	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt",ear1="Suppanomimi", ear2="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",waist="Shetal Stone"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Assault = {ring1="Balrahn's Ring"}
	sets.Weapons = {main="Tizona", sub="Almace"}
	sets.Almace = {main="Almace", sub="Colada"}
	sets.MagicWeapons = {main="Nibiru Cudgel", sub="Nibiru Cudgel"}
	sets.MaccWeapons = {main="Iris", sub="Iris"}
	sets.HybridWeapons = {main="Vampirism", sub="Vampirism"}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Caps with Magic Haste Cap, +5DW = Change Earrings, 10DW
	
	sets.engaged = {main="Tizona", sub="Almace",ammo="Ginsen",
			    head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				
	sets.engaged.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}
				
	sets.engaged.MinAcc = {ammo="Ginsen",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				
	sets.engaged.MinAcc.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}
				
	sets.engaged.SomeAcc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}

	sets.engaged.SomeAcc.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Rajas Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}
				
	sets.engaged.Acc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
				body="Ayanmo Corazza +1",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Reiki Yotai",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
				
	sets.engaged.Acc.AM = {ammo="Falcon Eye",
			    head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Ilabrat Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
				body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
				back=gear.da_jse_back,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc.AM = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
			    body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
				body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc.AM = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Combatant's Torque",ear1="Regal Earring",ear2="Telos Earring",
			    body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
			    back=gear.stp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}

	sets.engaged.Fodder = {ammo="Ginsen",
			    head="Dampening Tam",neck="Ainia Collar",ear1="Dedition Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				
	sets.engaged.Fodder.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Ainia Collar",ear1="Dedition Earring",ear2="Telos Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}
	
	sets.engaged.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.DTLite.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.PDT = {ammo="Staunch Tathlum",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}

	sets.engaged.MinAcc.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}

	sets.engaged.MinAcc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}
				
	sets.engaged.SomeAcc.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.SomeAcc.PDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}

	sets.engaged.Acc.DTLite = {ammo="Falcon Eye",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.Acc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
				body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt",legs="Aya. Cosciales +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc.DTLite = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc.PDT = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
				body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc.DTLite = {ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Regal Earring",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.FullAcc.PDT = {ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Regal Earring",ear2="Telos Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.Fodder.DTLite = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.Fodder.DTLite.AM = {ammo="Ginsen",
			    head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
			    body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
		        body="Ayanmo Corazza +1",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Patricius Ring",
				back="Moonbeam Cape",waist="Windbuffet Belt +1",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}
				
	sets.engaged.MDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}

	sets.engaged.MinAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.SomeAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
			
	sets.engaged.Acc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.Fodder.MDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi", ear2="Telos Earring",
		        body="Adhemar Jacket",hands="Assim. Bazu. +3",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Aya. Cosciales +1",feet=gear.herculean_ta_feet}

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",legs="Gyve Trousers",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",ring1="Mujin Band",ring2="Locus Ring"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 2)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 2)
	else
		set_macro_page(6, 2)
	end
end

--Dynamis Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = 1100
					return true
				else
					return false
				end
			end
		end
	end
	return false
end