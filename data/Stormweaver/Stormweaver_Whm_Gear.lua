-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TPEat', 'Regain')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Twilight Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	sets.Weapons = {main="Queller Rod",sub="Genmei Shield"}
	
    -- Precast Sets
	
	
    -- Fast cast sets for spells
    sets.precast.FC = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head="Chironic Hat",
		body="Inyanga Jubbah +2",
		hands="Repartie Gloves",
		legs="Artsieq Hose",
		feet="Regal Pumps",
		neck="Orison Locket",
		waist="Luminary Sash",
		left_ear="Loquac. Earring",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back="Perimede Cape",
	}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +1"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']
	
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		head="Piety Cap", 
		hands="Chironic Gloves", 
		legs="Ebers Pantaloons +1",
		feet="Hygieia Clogs +1", 
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.precast.FC.CureSolace = sets.precast.FC.Cure

	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +3"}
	sets.precast.JA.Devotion = {head="Piety Cap"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Nahtirah Hat",ear1="Roundel Earring",
		body="Piety Briault +3",hands="Theophany Mitts +3",
		waist="Chaac Belt",back="Aurist's Cape +1"}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Hasty Pinion +1",
		head="Befouled Crown",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Kaykaus Bliaut",hands="Theophany Mitts +3",ring1="Rajas Ring",ring2="Stikini Ring",
		back="Rancorous Mantle",waist="Fotia Belt",legs="Assid. Pants +1",feet="Gende. Galosh. +1"}

    --sets.precast.WS['Flash Nova'] = {}

    --sets.precast.WS['Mystic Boon'] = {}

    -- Midcast Sets

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})
	
	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}

	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Seidr Cotehardie"}

	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring"}
	
    sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Enki Strap",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +2",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}
		
	-- sets.midcast.Teleport = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
		-- head="Telchine Cap",neck="Incanter's Torque",ear1="Etiolation Earring",ear2="Gifted Earring",
		-- body="Kaykaus Bliaut",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Dark Ring",
		-- back="Aurist's Cape +1",waist="Austerity Belt +1",legs="Lengo Pants",feet="Hygieia Clogs +1"}

    -- Cure sets

	sets.midcast.Cure = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Locket",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.CureSolace = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.LightWeatherCureSolace = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.LightWeatherCure = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.LightDayCureSolace = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.LightDayCure = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.Curaga = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}
		
	sets.midcast.LightWeatherCuraga = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}
		
	sets.midcast.LightDayCuraga = {
		main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
		}

	sets.midcast.CureMelee = {
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Phalaina Lockett",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Twilight Cape",
	}

	sets.midcast.Cursna = {
		main="Yagrush",
		sub="Sors Shield",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Ebers Bliaud",
		hands="Fanatic Gloves",
		legs="Theophany Pantaloons +2",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Malison Medallion",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Ephedra Ring",
		right_ring="Ephedra Ring",
		back="Alaunus's Cape",
	}

	sets.midcast.StatusRemoval = {main="Yagrush",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Ebers Cap",neck="Incanter's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +2",hands="Fanatic Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Ebers Pantaloons +1",feet="Regal Pumps +1"}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
	sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Theophany Duckbills +3"}
		
	sets.midcast['Erase'] = {main="Yagrush",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Cleric's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Theophany Duckbills +3"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {feet="Ebers Duckbills +1"})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Sors Shield",waist="Emphatikos Rope",legs="Shedir Seraweels"})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",sub="Genmei Shield",head="Inyanga Tiara +2", body="Piety Briault +3",hands="Ebers Mitts",legs="Theophany Pantaloons +2"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",feet="Piety Duckbills +1",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaloons",ear1="Gifted Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",legs="Piety Pantaloons",ear1="Gifted Earring",waist="Sekhmet Corset"})
	
	sets.midcast.BarElement = {main="Gada",sub="Ammurapi Shield",ammo="Hasty Pinion +1",
		head="Ebers Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Ebers Bliaud",hands="Ebers Mitts",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Piety Pantaloons",feet="Theophany Duckbills +3"}

	sets.midcast.Impact = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head=empty,neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Twilight Cloak",hands=gear.chironic_enfeeble_hands,ring1="Stikini Ring",ring2="Stikini Ring",
		back="Toro Cape",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Witching Robe",hands=gear.chironic_enfeeble_hands,ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist=gear.ElementalObi,legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Niobid Strap",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Vanir Cotehardie",hands=gear.chironic_enfeeble_hands,ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Divine Magic'] = {main=-"Oranyan", sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Theophany Pantaloons +2",feet="Chironic Slippers"}

	sets.midcast['Dark Magic'] = {main="Oranyan", sub="Niobid Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Yamabuki-no-Obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

    sets.midcast.Drain = {main="Rubicundity",sub="Sors Shield",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Evanescence Ring",ring2="Archon Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

    sets.midcast.Drain.Resistant = {main="Rubicundity",sub="Sors Shield",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Erra Pendant",ear1="Regal Earring",ear2="Digni. Earring",
        body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

    sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {main="Oranyan",sub="Enki Strap",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Incanter's Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Lengo Pants",feet="Regal Pumps +1"}

	sets.midcast.Stun.Resistant = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Nahtirah Hat",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Chironic Hose",feet=gear.chironic_nuke_feet}

	sets.midcast['Enfeebling Magic'] = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Kishar Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}

	sets.midcast['Enfeebling Magic'].Resistant = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Incanter's Torque",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyanga Dastanas +1",ring1="Stikini Ring",ring2="Stikini Ring",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Chironic Hose",feet="Medium's Sabots"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {back="Alaunus's Cape"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {back="Alaunus's Cape",ring1="Stikini Ring"})

    -- Sets to return to when not performing an action.

    -- Resting sets
	sets.resting = {main="Contemplator",sub="Buggard Strap +1",ammo="Homiliary",
		head="Befouled Crown",neck="Chrys. Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Ebers Bliaud",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Yagrush",
		--main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
		sub="Ammurapi Shield",
		ammo="Incantor Stone",
		head="Befouled Crown",
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pantaloons +1",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Orison Locket",
		waist="Luminary Sash",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Alaunus's Cape",
		}

	sets.idle.PDT = {main="Terra's Staff", sub="Oneiros Grip",ammo="Staunch Tathlum",
		head="Inyanga Tiara +2",neck="Loricate Torque +1",ear1="Odnowa Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Gende. Spats +1",feet=gear.chironic_refresh_feet}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {ring2="Karieyh Ring"})

	sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Homiliary",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Witching Robe",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Witful Belt",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}

    -- Defense sets

	sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
		head="Gende. Caubeen +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Vrikodara Jupon",hands="Gende. Gages +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Gende. Spats +1",feet="Gende. Galosh. +1"}

	sets.defense.MDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
		head="Telchine Cap",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Inyanga Jubbah +2",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Gende. Spats +1",feet="Gende. Galosh. +1"}

    sets.defense.MEVA = {ammo="Staunch Tathlum",
        head="Telchine Cap",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Inyanga Jubbah +2",hands="Theophany Mitts +3",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Telchine Braconi",feet="Theophany Duckbills +3"}
		
	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}
	sets.IceNuke = {main="Ngqoqwanb"}

		-- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Theophany Briault +3",
		hands="Theophany Mitts +3",
		legs="Theophany Pantaloons +2",
		feet="Theophany Duckbills +3",
		neck="Incanter's Torque",
		waist="Eschan Stone",
		left_ear="Nourishing Earring +1",
		right_ear="Mendicant's Earring",
		left_ring="Lebeche Ring",
		right_ring="Persis Ring",
		back="Alaunus's Cape",
		}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts",back="Mending Cape"}
	
	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Flax Sash",legs="Shedir Seraweels",feet=""}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 1)
end

-- Lockstyle
function set_lockstyle()
	send_command('wait 6;input /lockstyleset 1')
end