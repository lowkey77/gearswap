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

	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
	gear.grioavolr_fc_staff = { name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}}
	
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
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +1"}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	-- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	--85% FC
	sets.precast.FC = {
		main={ name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}}, --4%
		sub="Clerisy Strap",--2%
		ammo="Impatiens",
		head="Atrophy Chapeau +1", --12%
		body="Zendik Robe",--13%
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Gyve Trousers",--4%
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},--5%
		neck="Voltsurge Torque",--4%
		waist="Witful Belt",--3%
		left_ear="Estq. Earring",--2%
		right_ear="Enchntr. Earring +1",--2%
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",--2%
		back="Perimede Cape",
		}
		
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Chant Du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",left_ear="Moonshade Earring",left_ring="Begrudging Ring",waist="Fotia Belt",feet="Thereoid Greaves"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {left_ear="Moonshade Earring"})
	
	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",neck="Baetyl Pendant",left_ear="Friomisi Earring",right_ear="Crematio Earring",
		body="Merlinic Jubbah",hands="Amalric Gages",left_ring="Shiva Ring +1",right_ring="Archon Ring",
		back="Sucellos's Cape",waist="Refoccilation Stone",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	
	-- Midcast Sets

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",left_ring="Mujin Band",right_ring="Locus Ring",feet="Jhakri Pigaches +1"}
	
	-- Gear for specific elemental nukes.
	sets.WindNuke = {}
	sets.IceNuke = {}

	sets.midcast.FastRecast = {
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap +1",
		ammo="Impatiens",
		head="Atrophy Chapeau +1", --10%
		body="Zendik Robe",--13%
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Gyve Trousers",--4%
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},--5%
		neck="Voltsurge Torque",--4%
		waist="Witful Belt",--3%
		left_ear="Estq. Earring",--2%
		right_ear="Enchntr. Earring +1",--2%
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",--2%
		back="Swith Cape +1",--4$
		}

    sets.midcast.Cure = {
		main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
		sub="Clerisy Strap",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Zendik Robe",
		hands="Atrophy Gloves +1",
		legs="Nares Trews",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Fucho-no-Obi",
		left_ear="Gwati Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Perimede Cape",
		}
		
    sets.midcast.LightWeatherCure = {
		main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
		sub="Clerisy Strap",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Zendik Robe",
		hands="Atrophy Gloves +1",
		legs="Nares Trews",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Hachirin-no-Obi",
		left_ear="Gwati Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Perimede Cape",
		}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {
		main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
		sub="Clerisy Strap",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Zendik Robe",
		hands="Atrophy Gloves +1",
		legs="Nares Trews",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Hachirin-no-Obi",
		left_ear="Gwati Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Perimede Cape",		
		}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		left_ring="Haoma's Ring",right_ring="Haoma's Ring",back="Tempered Cape +1",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})
		
	sets.midcast.Curaga = sets.midcast.Cure
	sets.Self_Healing = {neck="Phalaina Locket",left_ear="Etiolation Earring",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",right_ring="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}

	sets.midcast['Enhancing Magic'] = {
	main="Bolelabunga",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Leth. Chappel +1",
    body="Lethargy Sayon +1",
    hands="Atrophy Gloves +1",
    legs="Estqr. Fuseau +2",
    feet="Leth. Houseaux +1",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Gwati Earring",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Sucellos's Cape", augments={'Mag. Acc+20 /Mag. Dmg.+20',}}
	}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Almaric Coif", legs="Lethargy Fuseau +1"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {head="Umuthi Hat", neck="Nordens Gorget", waist="Siegel Sash" , legs="Doyen pants"})
	
	sets.midcast['Enfeebling Magic'] = {
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
		body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		hands="Leth. Gantherots +1",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet={ name="Medium's Sabots", augments={'MP+50','MND+8','"Conserve MP"+6','"Cure" potency +3%',}},
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Gwati Earring",
		right_ear="Hermetic Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
		}
		
	sets.midcast['Enfeebling Magic'].Resistant = {
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
		body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		hands="Leth. Gantherots +1",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet={ name="Medium's Sabots", augments={'MP+50','MND+8','"Conserve MP"+6','"Cure" potency +3%',}},
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Gwati Earring",
		right_ear="Hermetic Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
		}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1",waist="Chaac Belt"})
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1",waist="Chaac Belt",feet=gear.chironic_treasure_feet})

	sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Viti. Chapeau +1"})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Viti. Chapeau +1"})
	
    sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",left_ear="Crematio Earring",right_ear="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
        back="Sucellos's Cape",waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Sanctity Necklace",left_ear="Regal Earring",right_ear="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
        back="Sucellos's Cape",waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Elemental Magic'].Fodder = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",left_ear="Crematio Earring",right_ear="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",left_ring="Shiva Ring +1",right_ring="Shiva Ring +1",
        back="Sucellos's Cape",waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast['Elemental Magic'].Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Voltsurge Torque",left_ear="Enchntr. Earring +1",right_ear="Loquacious Earring",
        body="Helios Jacket",hands="Gende. Gages +1",left_ring="Kishar Ring",right_ring="Prolix Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap",ammo="Pemphredo Tathlum",left_ear="Regal Earring"})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {left_ear="Regal Earring"})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Alber Strap",ammo="Pemphredo Tathlum",left_ear="Regal Earring"})
		
	sets.midcast.Impact = {main="Oranyan",sub="Enki Strap",ammo="Regal Gem",
		head=empty,neck="Erra Pendant",left_ear="Regal Earring",right_ear="Digni. Earring",
		body="Twilight Cloak",hands="Leth. Gantherots +1",left_ring="Stikini Ring",right_ring="Stikini Ring",
		back="Sucellos's Cape",waist="Luminary Sash",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Dark Magic'] = {
	main={ name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Shango Robe",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs="Portent Pants",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Erra Pendant",
    waist="Casso Sash",
    right_ear="Hermetic Earring",
    left_ear="Gwati Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Perimede Cape",
		}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
    sub="Culminus", ring1="Excelsis Ring", waist="Fucho-no-Obi"})

	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
		
	sets.midcast.Stun.Resistant = {main="Serenity",sub="Enki Strap",ammo="Regal Gem",
		head="Amalric Coif",neck="Erra Pendant",left_ear="Regal Earring",right_ear="Digni. Earring",
		body="Zendik Robe",hands="Gende. Gages +1",left_ring="Stikini Ring",right_ring="Stikini Ring",
		back="Sucellos's Cape",waist="Acuity Belt +1",legs="Psycloth Lappas",feet=gear.merlinic_aspir_feet}

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {right_ring="Sheltered Ring"})

	-- Sets for special buff conditions on spells.
		
	sets.buff.ComposureOther = {
		head="Leth. Chappel +1",
		body="Lethargy Sayon +1",
		hands="Leth. Gantherots +1",
		legs="Leth. Fuseau +1",
		feet="Leth. Houseaux +1"
		}

	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	sets.HPDown = {head="Pixie Hairpin +1",left_ear="Mendicant's Earring",right_ear="Evans Earring",
		body="Jhakri Robe +2",hands="Jhakri Cuffs +2",left_ring="Mephitas's Ring +1",right_ring="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Jhakri Pigaches +1"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
	main="Bolelabunga",
    sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    ritht_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Altruistic Cape",
	}
	

	-- Idle sets
	sets.idle = {
		main="Bolelabunga",
		sub="Culminus",
		ammo="Homiliary",
		head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
		body="Atrophy Tabard +1",
		hands="Atrophy Gloves +1",
		legs="Nares Trews",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
		neck="Nodens Gorget",
		waist="Fucho-no-Obi",
		left_ear="Gwati Earring",
		right_ear="Hermetic Earring",
		left_ring="Meridian Ring",
		right_ring="Persis Ring",
		back="Perimede Cape",
		}
		
	sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",ammo="Impatiens",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Ethereal Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Dark Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}
		
	sets.idle.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Impatiens",
		head="Viti. Chapeau +1",neck="Warder's Charm +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Vrikodara Jupon",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Shadow Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}
		
	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Viti. Chapeau +1",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Jhakri Robe +2",hands=gear.merlinic_refresh_hands,left_ring="Defending Ring",right_ring="Dark Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet=gear.chironic_refresh_feet}
	
	sets.idle.DTHippo = set_combine(sets.idle.PDT, {back="Umbra Cape",legs="Carmine Cuisses +1",feet="Hippo. Socks +1"})
	
	-- Defense sets
	sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Impatiens",
		head="Hagondes Hat +1",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Ethereal Earring",
		body="Emet Harness +1",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Dark Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}

	sets.defense.NukeLock = sets.midcast['Elemental Magic']
		
	sets.defense.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Impatiens",
		head="Hagondes Hat +1",neck="Loricate Torque +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Vrikodara Jupon",hands="Hagondes Cuffs +1",left_ring="Defending Ring",right_ring="Dark Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Hagondes Pants +1",feet="Gende. Galosh. +1"}
		
    sets.defense.MEVA = {main="Terra's Staff",sub="Enki Strap",ammo="Pemphredo Tathlum",
        head=empty,neck="Warder's Charm +1",left_ear="Etiolation Earring",right_ear="Sanare Earring",
		body="Respite Cloak",hands="Telchine Gloves",left_ring="Vengeful Ring",right_ring="Purity Ring",
        back="Sucellos's Cape",waist="Luminary Sash",legs="Leth. Fuseau +1",feet="Telchine Pigaches"}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",right_ring="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {right_ring="Karieyh Ring"})

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.Weapons = {main="Almace", sub="Colada"}
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
--		head="Aya. Zucchetto +1",neck="Asperity Necklace",left_ear="Cessance Earring",right_ear="Brutal Earring",
--		body="Ayanmo Corazza +1",hands="Aya. Manopolas +1",left_ring="Petrov Ring",right_ring="Ilabrat Ring",
--		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.engaged = {
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}

	sets.engaged.DW = {
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}
		
	sets.engaged.PhysicalDef = {
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}
		
	sets.engaged.MagicalDef = {
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}

end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'DNC' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 7)
	else
		set_macro_page(1, 7)
	end
end