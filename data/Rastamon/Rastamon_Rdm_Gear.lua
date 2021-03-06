function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'MDT', 'TPEat', 'Regain', 'DTHippo')
    state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Toro Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
	gear.merlinic_nuke_head = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst dmg.+10%','INT+4',}}
	gear.merlinic_nuke_feet = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','Magic burst dmg.+11%','Mag. Acc.+10',}}
	
	gear.grioavolr_fc_staff = { name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}}
	gear.grioavolr_nuke_staff = { name="Grioavolr", augments={'Magic burst dmg.+8%','INT+2','Mag. Acc.+10','"Mag.Atk.Bns."+25','Magic Damage +3',}}
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	
	select_default_macro_book()
	set_lockstyle()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	-- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	-- 30% Job Trait, 6% Job Trait, 46% gear (only need 44%)
    -- No other FC sets necessary.
	--85% FC
	sets.precast.FC = {
		main="Crocea Mors", --20%
		sub="Ammurapi Shield",
		ammo="Impatiens",
		head="Atrophy chapeau +3", --16%
		body="Vitiation Tabard +3",--15%
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Ayanmo Cosciales +2",--6%
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},--5%
		neck="Loricate Torque +1",
		waist="Witful Belt",--3%
		left_ear="Malignance Earring",--1%
		right_ear="Enchanter Earring +1",
		left_ring="Veneficium Ring",
		right_ring="Weatherspoon Ring",
		back="Perimede Cape",
		}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Aya. Zucchetto +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Chirich Ring +1",
		right_ring="Karieyh Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}},
		}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	--sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	-- 50% MND / 30% STR
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, 
	{
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Ayanmo Corazza +2",
		hands="Atrophy Gloves +3",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Freke Ring",
		right_ring="Weatherspoon Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}},
		})
		
	-- 40% STR / 40% INT
	sets.precast.WS['Red Lotus Blade'] =  
	{
		ammo="Pemphredo Tathlum",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Vitiation Boots +3",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Regal Earring",
		left_ring="Weatherspoon Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Mag. Evasion+15',}},
		}
	
	-- 50% MND / 30% STR
	sets.precast.WS['Sanguine Blade'] =
	{
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		--head="Jhakri Coronal +2",
		body="Amalric Doublet +1",
		hands="Jhakri Cuffs +2",
		legs="Amalric Slops +1",
		feet="Vitiation Boots +3",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Mag. Evasion+15',}},
		}
		
	-- 50% MND / 30% STR
	sets.precast.WS['Seraph Blade'] =
	{
		ammo="Pemphredo Tathlum",
		head="Vitiation Chapeau +3",
		body="Amalric Doublet +1",
		hands="Jhakri Cuffs +2",
		legs="Amalric Slops +1",
		feet="Vitiation Boots +3",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Malignance Earring",
		right_ear="Moonshade Earring",
		left_ring="Weatherspoon Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
		}

	-- 50% MND / 30% STR
	sets.precast.WS['Aeolian Edge'] =
	{
		ammo="Pemphredo Tathlum",
		head="Vitiation Chapeau +3",
		body="Amalric Doublet +1",
		hands="Jhakri Cuffs +2",
		legs="Amalric Slops +1",
		feet="Vitiation Boots +3",
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Malignance Earring",
		right_ear="Moonshade Earring",
		left_ring="Freke Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}},
		}
		
	-- 73~85% MND
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
	{
		ammo="Regal Gem",
		head="Aya. Zucchetto +2",
		body="Vitiation Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Regal Earring",
		right_ear="Cessance Earring",
		left_ring="Rufescent Ring",
		right_ring="Persis Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}},
		})
	-- 80% DEX
	sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, 
	{
		ammo="Regal Gem",
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Atrophy Gloves +3",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Cessance Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','"Dual Wield"+10',}},
	})
	
	-- 50% STR / 50% MND
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, 
	{
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Malignance Tabard",
		--body="Vitiation Tabard +3",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Malignance Boots",
		--feet="Jhakri Pigaches +2",
		neck="Fotia Gorget",
		waist="Salifi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Regal Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}},
	})

	
	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands="Volte Bracers", feet=gear.chironic_treasure_feet, waist="Chaac Belt"})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {
		head="Ea Hat +1",
		neck="Mizu. Kubikazari",
		body="Ea Houppelande +1",
		left_ring="Mujin Band",
		right_ring="Locus Ring",
		feet="Jhakri Pigaches +2"
		}
	
	-- Gear for specific elemental nukes.
	sets.WindNuke = {}
	sets.IceNuke = {}

	sets.midcast.FastRecast = {
		-- main=gear.grioavolr_fc_staff,
		-- sub="Clerisy Strap +1",
		ammo="Impatiens",
		head="Atrophy chapeau +3", --14%
		body="Zendik Robe",--13%
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Gyve Trousers",--4%
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},--5%
		neck="Baetyl Pendant",--4%
		waist="Witful Belt",--3%
		left_ear="Estq. Earring",--2%
		right_ear="Enchntr. Earring +1",--2%
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",--2%
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10','Occ. inc. resist. to stat. ailments+10',}},
		}

    sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Chironic Doublet", augments={'Attack+10','"Cure" potency +8%','CHR+9','Mag. Acc.+8','"Mag.Atk.Bns."+12',}},
		hands="Atrophy Gloves +3",
		legs="Atrophy Tights +3",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Fucho-no-Obi",
		left_ear="Regal Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
		}
		
    sets.midcast.LightWeatherCure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Chironic Doublet", augments={'Attack+10','"Cure" potency +8%','CHR+9','Mag. Acc.+8','"Mag.Atk.Bns."+12',}},
		hands="Atrophy Gloves +3",
		legs="Atrophy Tights +3",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Hachirin-no-Obi",
		left_ear="Regal Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
		}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body={ name="Chironic Doublet", augments={'Attack+10','"Cure" potency +8%','CHR+9','Mag. Acc.+8','"Mag.Atk.Bns."+12',}},
		hands="Atrophy Gloves +3",
		legs="Atrophy Tights +3",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Hachirin-no-Obi",
		left_ear="Regal Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",		
		}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		left_ring="Haoma's Ring",right_ring="Haoma's Ring",back="Tempered Cape +1",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})
		
	sets.midcast.Curaga = sets.midcast.Cure
	
	sets.Self_Healing = {neck="Phalaina Locket",left_ear="Etiolation Earring",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	
	sets.Self_Refresh = {
		head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		neck="Duelist's Torque +2",
		body="Atrophy Tabard +3",
		legs="Lethargy Fuseau +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		waist="Gishdubar Sash"
		}

	sets.midcast['Enhancing Magic'] = {
		main="Murgleis",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Befouled Crown",
		body="Vitiation Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Atrophy Tights +3",
		feet="Lethargy Houseaux +1",
		neck="Duelist Torque +2",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
		
	sets.midcast['Temper II'] = {
		main="Murgleis",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Befouled Crown",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Viti. Gloves +3", augments={'Enhances "Phalanx II" effect',}},
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +1",
		neck="Incanter's Torque",
		waist="Fucho-no-Obi",
		left_ear="Regal Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Fi Follet Cape +1",
		}
		
	-- Sets for special buff conditions on spells.
		
	sets.buff.ComposureOther = {
		head="Lethargy Chappel +1",
		neck="Duelist Torque +2",
		--body="Lethargy Sayon +1",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		--hands="Lethargy Gantherots +1",
		hands="Atrophy Gloves +3",
		legs="Lethargy Fuseau +1",
		feet="Lethargy Houseaux +1"
		}
		
	sets.buff.RefreshOther = set_combine(sets.buff.ComposureOther,{
		head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Lethargy Fuseau +1",
		body="Atrophy Tabard +3",
		})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {body="Atrophy Tabard +3", head="Almaric Coif", legs="Lethargy Fuseau +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {head="Umuthi Hat", neck="Nodens Gorget", waist="Siegel Sash" , legs="Doyen pants"})
	
	sets.midcast['Shock Spikes'] = set_combine(sets.midcast['Enhancing Magic'], {legs="Vitiation Tights +3"})
	
	sets.midcast['Ice Spikes'] = set_combine(sets.midcast['Enhancing Magic'], {legs="Vitiation Tights +3"})
	
	sets.midcast.Enspell = set_combine(sets.midcast['Enhancing Magic'], {head="Umuthi Hat", hands="Ayanmo Manopolas +2", legs="Vitiation Tights +3", back="Ghostfyre Cape"})
	
	--Set for Gain spells
	sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {hands="Vitiation Gloves +3"})
	
	sets.midcast['Enfeebling Magic'] = {                         
		--main="Murgleis",
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		--sub="Ammurapi Shield",
		sub="Mephitis Grip",
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Regal Cuffs",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet="Vitiation Boots +3",
		neck="Duelist's Torque +2",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Vor Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
		
	sets.midcast['Enfeebling Magic'].Resistant = {
		--main="Murgleis",
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		--sub="Ammurapi Shield",
		sub="Mephitis Grip",
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Lethargy Gantherots +1",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet="Vitiation Boots +3",
		neck="Duelist's Torque +2",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Vor Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
		}
		
	sets.midcast['Silence'] = {                         
		--main="Murgleis",
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		--sub="Ammurapi Shield",
		sub="Mephitis Grip",
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Regal Cuffs",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet="Vitiation Boots +3",
		neck="Duelist's Torque +2",
		waist="Luminary Sash",
		left_ear="Regal Earring",
		right_ear="Vor Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
		
	sets.midcast['Dispel'] = {                         
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		sub="Mephitis Grip",
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Regal Cuffs",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet="Vitiation Boots +3",
		neck="Duelist's Torque +2",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Vor Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
		
	sets.midcast['Distract III'] = {                         
		main="Murgleis",
		--main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Regal Cuffs",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet="Vitiation Boots +3",
		neck="Duelist's Torque +2",
		waist="Rumination Sash",
		left_ear="Regal Earring",
		right_ear="Vor Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Atrophy chapeau +3",waist="Eschan Stone"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Atrophy chapeau +3",waist="Eschan Stone"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'])
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant)

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +3",waist="Chaac Belt"})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {waist="Chaac Belt",legs="Vitiation Tights +3",feet=gear.chironic_treasure_feet})

	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +3"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Vitiation Chapeau +3"})
	
	sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +3",legs="Vitiation Tights +3"})
	sets.midcast['Blind II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Vitiation Chapeau +3"})
	
    sets.midcast['Elemental Magic'] = {
		main=gear.grioavolr_nuke_staff,
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",
		neck="Sanctity Necklace",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
        --body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
		hands="Jhakri Cuffs +2",
		left_ring="Jhakri Ring",
		right_ring="Freke Ring",
        back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Mag. Evasion+15',}},
		waist=gear.obi_high_nuke_waist,
		legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
		feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		}
		
    sets.midcast['Elemental Magic'].Resistant = {
		main=gear.grioavolr_nuke_staff,
		sub="Enki Strap",
		ammo="Regal Gem",
        head="Jhakri Coronal +2",
		neck="Mizu. Kubikazari",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic Damage +10','INT+3','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
        --body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
		hands="Jhakri Cuffs +2",
		left_ring="Jhakri Ring",
		right_ring="Freke Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		waist=gear.ElementalObi,
		legs="Jhakri Slops +2",
		feet="Vitiation Boots +3"
		}
		
    sets.midcast['Elemental Magic'].Fodder = {
		main=gear.grioavolr_nuke_staff,
		sub="Enki Strap",
		ammo="Regal Gem",
        head=gear.merlinic_nuke_head,
		neck="Mizu. Kubikazari",
		left_ear="Malignance Earring",
		right_ear="Friomisi Earring",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic Damage +10','INT+3','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
        --body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		left_ring="Jhakri Ring",
		right_ring="Locus Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		waist=gear.ElementalObi,
		legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet=gear.merlinic_nuke_feet
		}

    sets.midcast['Elemental Magic'].Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Baetyl Pendant",left_ear="Enchntr. Earring +1",right_ear="Loquacious Earring",
        body="Helios Jacket",hands="Gende. Gages +1",left_ring="Kishar Ring",right_ring="Prolix Ring",
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10','Occ. inc. resist. to stat. ailments+10',}},waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap",ammo="Pemphredo Tathlum",left_ear="Regal Earring"})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {left_ear="Regal Earring"})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Alber Strap",ammo="Regal Gem",left_ear="Regal Earring"})
		
	sets.midcast.Impact = {main="Oranyan",sub="Enki Strap",ammo="Regal Gem",
		head=empty,neck="Erra Pendant",left_ear="Regal Earring",right_ear="Digni. Earring",
		body="Twilight Cloak",hands="Lethargy Gantherots +1",left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},waist="Hachirin-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Dark Magic'] = {
	--main={ name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}},
    --sub="Enki Strap",
    ammo="Regal Gem",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Atrophy Tabard +3",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs="Jhakri Slops +2",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Erra Pendant",
    waist="Casso Sash",
    right_ear="Dignitary's Earring",
    left_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Perimede Cape",
		}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
    sub="Ammurapi Shield", ring1="Excelsis Ring", waist="Fucho-no-Obi"})

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {body="Atrophy Tabard +3", hands="Jhakri Cuffs +2", feet="Vitiation boots +3"})
		
	sets.midcast.Stun.Resistant = {main="Serenity",sub="Enki Strap",ammo="Regal Gem",
		head="Amalric Coif",neck="Erra Pendant",left_ear="Regal Earring",right_ear="Digni. Earring",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},waist="Eschan Stone",legs="Jhakri Slops +2",feet=gear.merlinic_aspir_feet}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	
	sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
	
	sets.HPDown = {head="Pixie Hairpin +1",left_ear="Mendicant's Earring",right_ear="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",left_ring="Mephitas's Ring +1",right_ring="Mephitas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10','Occ. inc. resist. to stat. ailments+10',}},legs="Shedir Seraweels",feet="Jhakri Pigaches +2"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
		main="Murgleis",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
		ammo="Homiliary",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Volte Brais",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
		neck="Nodens Gorget",
		waist="Fucho-no-Obi",
		left_ear="Regal Earring",
		right_ear="Dignitary's Earring",
		left_ring="Meridian Ring",
		right_ring="Persis Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
	

	-- Idle sets
	sets.idle = {
		main="Murgleis",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Vitiation Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Volte Bracers",
		legs="Volte Brais",
		feet="Vitiation Boots +3",
		neck="Nodens Gorget",
		waist="Fucho-no-Obi",
		left_ear="Regal Earring",
		right_ear="Dignitary's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
		}
		
	sets.idle.PDT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		--waist="Windbuffet Belt +1",
		waist="Orpheus's Sash",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		}
		
	sets.idle.MDT = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		--waist="Windbuffet Belt +1",
		waist="Orpheus's Sash",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','"Dual Wield"+10',}},
		}
		
	sets.idle.Weak = {main="Murgleis",sub="Genmei Shield",ammo="Homiliary",
		head="Vitiation Chapeau +3",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,left_ring="Defending Ring",right_ring="Dark Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Volte Brais",feet=gear.chironic_refresh_feet}
	
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {back="Umbra Cape",legs="Carmine Cuisses +1",feet="Hippo. Socks +1"})
	
	-- Defense sets
	sets.defense.PDT = {main="Murgleis",sub="Genmei Shield",ammo="Impatiens",
		head="Vitiation Chapeau +3",neck="Warder's Charm +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Malignance Tabard",hands="Volte Bracers",left_ring="Defending Ring",right_ring="Shadow Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Volte Brais",feet="Malignance Boots"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = {main="Murgleis",sub="Genmei Shield",ammo="Impatiens",
		head="Vitiation Chapeau +3",neck="Warder's Charm +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Malignance Tabard",hands="Volte Bracers",left_ring="Defending Ring",right_ring="Shadow Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Volte Brais",feet="Malignance Boots"}
		
    sets.defense.MEVA = {main="Murgleis",sub="Genmei Shield",ammo="Impatiens",
		head="Vitiation Chapeau +3",neck="Warder's Charm +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Malignance Tabard",hands="Volte Bracers",left_ring="Defending Ring",right_ring="Shadow Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Volte Brais",feet="Malignance Boots"}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",right_ring="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {right_ring="Karieyh Ring"})

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.Weapons = {main="Crocea Mors", sub="Daybreak"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
--	sets.engaged = {ammo="Ginsen",
--		head="Aya. Zucchetto +2",neck="Asperity Necklace",left_ear="Cessance Earring",right_ear="Brutal Earring",
--		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",left_ring="Petrov Ring",right_ring="Ilabrat Ring",
--		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves"}

	sets.engaged = {
		ammo="Paeapua",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		waist="Salif Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		}
		
	sets.engaged.DW = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		--hands="Ayanmo Manopolas +2",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		waist="Orpheus's Sash",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Attack+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
		}
		
	sets.engaged.PhysicalDef = {
		ammo="Ginsen",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Chirich Ring +1",
		back="Agema Cape",
		}
		
	sets.engaged.MagicalDef = {
		ammo="Homiliary",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		legs="Aya. Cosciales +2",
		feet="Malignance Boots",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Chirich Ring +1",
		back="Agema Cape",
		}

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'SCH' then
		set_macro_page(2, 7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 7)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end

-- Lockstyle
function set_lockstyle()
	send_command('wait 6;input /lockstyleset 9')
end