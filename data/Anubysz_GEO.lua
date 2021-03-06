-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
 
    gear.default.weaponskill_waist = "Windbuffet Belt"
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs-
    sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +3"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1"}
    sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines +3"}
    sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
     
    -- Fast cast sets for spells
 
    sets.precast.FC = {
		main="Sucellus",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','CHR+9','Mag. Acc.+3','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic Damage +12','INT+12','Mag. Acc.+12','"Mag.Atk.Bns."+10',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Geo. Pants +3",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','CHR+15','"Mag.Atk.Bns."+5',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Pet: Damage taken -3%',}},
		}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",back="Pahtli Cape"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})
 
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Imbodla Necklace",
		waist="Olseni Belt",
		left_ear="Lifestorm Earring",
		right_ear="Telos Earfring",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Rajas Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Pet: "Regen"+10',}},
		}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
		ammo="Pemphredo Tathlum",
        head="Hagondes Hat",
		neck="Eddy Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
        body="Hagondes Coat",
		hands="Yaoyotl Gloves",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
        back="Toro Cape",
		waist="Snow Belt",
		legs="Hagondes Pants",
		feet="Hagondes Sabots"
		}
 
    sets.precast.WS['Starlight'] = {ear2="Etiolation Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Etiolation Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
		main="Bolelabunga",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','CHR+9','Mag. Acc.+3','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic Damage +12','INT+12','Mag. Acc.+12','"Mag.Atk.Bns."+10',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Geo. Pants +3",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','CHR+15','"Mag.Atk.Bns."+5',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Pet: Damage taken -3%',}},
		}
 
    sets.midcast.Geomancy = {
		main="Idris",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic +3", augments={'Enhances "Bolster" effect',}},
		hands="Geo. Mitaines +3",
		legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
		feet="Azimuth Gaiters +1",
		neck="Bagua Charm +2",
		waist="Austerity Belt +1",
		left_ear="Magnetic Earring",
		right_ear="Gifted Earring",
		left_ring="Renaye Ring",
		right_ring="Sangoma Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Pet: Damage taken -3%',}},
		}
     
    sets.midcast.Geomancy.Indi = {
		main="Idris",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic +3", augments={'Enhances "Bolster" effect',}},
		hands="Geo. Mitaines +3",
		legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
		feet="Azimuth Gaiters +1",
		neck="Bagua Charm +2",
		waist="Austerity Belt +1",
		left_ear="Magnetic Earring",
		right_ear="Gifted Earring",
		left_ring="Renaye Ring",
		right_ring="Sangoma Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Pet: Damage taken -3%',}},
		}
     
    sets.midcast.Cure = {
		main={ name="Tamaxchi", augments={'Occ. atk. twice+8','Attack+20',}},
		sub="Sors Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		hands={ name="Vanya Cuffs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		legs={ name="Vanya Slops", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		feet={ name="Vanya Clogs", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		neck="Incanter's Torque",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Healing Earring",
		left_ring="Sirona's Ring",
		right_ring="Ephedra Ring",
		back="Tempered Cape +1",
		}
     
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
     
        -- Elemental Magic sets
     
    sets.midcast['Elemental Magic'] = {
		main={ name="Grioavolr", augments={'Magic burst dmg.+2%','MND+20','Mag. Acc.+22','"Mag.Atk.Bns."+13','Magic Damage +6',}},
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','CHR+9','Mag. Acc.+3','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic Damage +12','INT+12','Mag. Acc.+12','"Mag.Atk.Bns."+10',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Enmity-4','MND+6','Mag. Acc.+13',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','CHR+15','"Mag.Atk.Bns."+5',}},
		neck="Sanctity Necklace",
		waist="Othila Sash",
		left_ear="Friomisi Earring",
		right_ear="Barkaro. Earring",
		left_ring="Shiva Ring +1",
		right_ring="Shiva Ring +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
		}
 
    sets.midcast['Elemental Magic'].Resistant = {
		main={ name="Grioavolr", augments={'Magic burst dmg.+2%','MND+20','Mag. Acc.+22','"Mag.Atk.Bns."+13','Magic Damage +6',}},
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +12','CHR+9','Mag. Acc.+3','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Magic Damage +12','INT+12','Mag. Acc.+12','"Mag.Atk.Bns."+10',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Enmity-4','MND+6','Mag. Acc.+13',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','CHR+15','"Mag.Atk.Bns."+5',}},
		neck="Sanctity Necklace",
		waist="Othila Sash",
		left_ear="Friomisi Earring",
		right_ear="Barkaro. Earring",
		left_ring="Shiva Ring +1",
		right_ring="Shiva Ring +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
		}
 
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
	
	sets.midcast['Enfeebling Magic'] = {
		main={ name="Grioavolr", augments={'Magic burst dmg.+2%','MND+20','Mag. Acc.+22','"Mag.Atk.Bns."+13','Magic Damage +6',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Geo. Galero +3",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		legs="Geomancy Pants +3",
		feet="Geo. Sandals +3 +3 +3",
		neck="Erra Pendant",
		waist="Rumination Sash",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		left_ring="Levia. Ring +1",
		right_ring="Kishar Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	}
     
    sets.midcast['Dark Magic'] = {
		main={ name="Rubicundity", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+9','Dark magic skill +8','"Conserve MP"+6',}},
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
		body="Shango Robe",
		hands={ name="Helios Gloves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Drain" and "Aspir" potency +4',}},
		legs="Azimuth Tights +1",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+8%','CHR+15','"Mag.Atk.Bns."+5',}},
		neck="Incanter's Torque",
		waist="Fucho-no-Obi",
		left_ear="Magnetic Earring",
		right_ear="Gwati Earring",
		left_ring="Perception Ring",
		right_ring="Prolix Ring",
		back="Refraction Cape",
		}
		
		sets.midcast['Enhancing Magic'] = {
			main="Gada",
			sub="Ammurapi Shield",
			ammo="Plumose Sachet",
			head="Befouled Crown",
			body={ name="Telchine Chas.", augments={'Accuracy+12 Attack+12','Pet: "Regen"+3','Pet: Damage taken -3%',}},
			hands="Geo. Mitaines +3",
			legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
			feet="Regal Pumps +1",
			neck="Colossus's Torque",
			waist="Olympus Sash",
			left_ear="Andoaa Earring",
			right_ear="Augment. Earring",
			left_ring="Perception Ring",
			right_ring="Sangoma Ring",
			back="Fi Follet Cape +1",
		}
     
 
 
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {
		head="Nefer Khat +1",
		neck="Wiglen Gorget",
        body="Heka's Kalasiris",
		hands="Serpentes Cuffs",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        waist="Austerity Belt",
		legs="Nares Trews",
		feet="Chelona Boots +1"
		}
 
 
    -- Idle sets
 
    sets.idle = {
		main="Bolelabunga",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Befouled Crown",
		body="Jhakri Robe +2",
		hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},
		legs="Assid. Pants +1",
		feet="Serpentes Sabots",
		neck="Wiglen Gorget",
		waist="Fucho-no-Obi",
		left_ear="Etiolation Earring", 
		right_ear="Magnetic Earring",
		left_ring="Sheltered Ring",
		right_ring="Renaye Ring",
		back="Kumbira Cape",
		}
 
    sets.idle.PDT = {
		main="Terra's Staff",
		sub="Volos Strap",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Hagondes Hat +1", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+14',}},
		body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%',}},
		hands={ name="Hagondes Cuffs +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -1%','Pet: Attack+10 Pet: Rng.Atk.+10',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -1%','Enmity-3',}},
		feet={ name="Hag. Sabots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Enmity-2',}},
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Defending Ring",
		back="Umbra Cape",
		}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
		main="Idris",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Telchine Chas.", augments={'Accuracy+12 Attack+12','Pet: "Regen"+3','Pet: Damage taken -3%',}},
		hands="Geo. Mitaines +3",
		legs={ name="Telchine Braconi", augments={'Accuracy+14 Attack+14','Pet: "Regen"+2','Pet: Damage taken -3%',}},
		feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
		neck="Bagua Charm +2",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Defending Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Pet: "Regen"+10',}},
		}
 
    sets.idle.PDT.Pet = {
		main="Idris",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +4%','"Cure" spellcasting time -6%','HP+25',}},
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Telchine Chas.", augments={'Accuracy+12 Attack+12','Pet: "Regen"+3','Pet: Damage taken -3%',}},
		hands="Geo. Mitaines +3", 
		legs={ name="Telchine Braconi", augments={'Accuracy+14 Attack+14','Pet: "Regen"+2','Pet: Damage taken -3%',}},
		feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
		neck="Bagua Charm +2",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Defending Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Pet: "Regen"+10',}},
		}
 
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {head="Azimuth Hood +1",legs="Bagua Pants +3",feet="Azimuth Gaiters +1"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {head="Azimuth Hood +1",back="Lifestream Cape",legs="Bagua Pants +3",feet="Azimuth Gaiters +1"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {head="Azimuth Hood +1",body="Azimuth Coat +1",back="Lifestream Cape",legs="Bagua Pants +3",feet="Azimuth Gaiters +1"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {head="Azimuth Hood +1",body="Azimuth Coat +1",back="Lifestream Cape",legs="Bagua Pants +3",feet="Azimuth Gaiters +1"})
 
    -- sets.idle.Town = {
		-- main="Tamaxchi",
		-- sub="Genbu's Shield",
		-- range="Dunna",
        -- head="",
		-- neck="Wiglen Gorget",
		-- ear1="Enchanter Earring +1",
		-- ear2="Loquacious Earring",
        -- body="Respite Cloak",
		-- hands="Geomancy Mitaines +3",
		-- ring1="Sheltered Ring",
		-- ring2="Paguroidea Ring",
        -- back="Umbra Cape",
		-- waist="Goading Belt",
		-- legs="Bagua Pants +3",
		-- feet="Geomancy Sandals +2"
		-- }
 
    sets.idle.Weak = {
		main="Terra's Staff",
		sub="Volos Strap",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Hagondes Hat +1", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+14',}},
		body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%',}},
		hands={ name="Hagondes Cuffs +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -1%','Pet: Attack+10 Pet: Rng.Atk.+10',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -1%','Enmity-3',}},
		feet={ name="Hag. Sabots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Enmity-2',}},
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Defending Ring",
		back="Umbra Cape",
		}
 
    -- Defense sets
 
    sets.defense.PDT = {
		main="Terra's Staff",
		sub="Volos Strap",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Hagondes Hat +1", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+14',}},
		body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%',}},
		hands={ name="Hagondes Cuffs +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -1%','Pet: Attack+10 Pet: Rng.Atk.+10',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -1%','Enmity-3',}},
		feet={ name="Hag. Sabots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Enmity-2',}},
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Defending Ring",
		back="Umbra Cape",
		}
 
    sets.defense.MDT = {
		main="Terra's Staff",
		sub="Volos Strap",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Hagondes Hat +1", augments={'Phys. dmg. taken -3%','"Mag.Atk.Bns."+14',}},
		body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -2%',}},
		hands={ name="Hagondes Cuffs +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -1%','Pet: Attack+10 Pet: Rng.Atk.+10',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -2%','Magic dmg. taken -1%','Enmity-3',}},
		feet={ name="Hag. Sabots +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Enmity-2',}},
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Magic dmg. taken -3%','Breath dmg. taken -4%',}},
		right_ring="Defending Ring",
		back="Umbra Cape",
		}
 
    sets.Kiting = {feet="Geomancy Sandals +2"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = {
		main="Tishtrya",
		sub="Genmei Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Lissome Necklace",
		waist="Cetl Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Chirich Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Pet: "Regen"+10',}},
		}
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end
 
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end
end
 
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end
 
-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(3, 1)
end
