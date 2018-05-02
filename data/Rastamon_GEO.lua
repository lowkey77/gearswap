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
    sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +1"}
    sets.precast.JA['Full Circle'] = {head="Azimuth Hood"}
    sets.precast.JA['Curative Recantation'] = {hands="Bagua Mitaines +1"}
    sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +1"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}
     
    -- Fast cast sets for spells
 
    sets.precast.FC = {
		main="",
		sub="",
		ammo="I",
        head="Nahtirah Hat",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
        body="Helios jacket",
		ring1="Prolix Ring",
		ring2="Veneficium Ring",
        back="Swith Cape +1",
		waist="Witful Belt",
		legs="Geomancy Pants +1",
		feet="Chelona boots"
		}
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",back="Pahtli Cape"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"})
 
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nahtirah Hat",
		neck=gear.ElementalGorget,
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Helios jacket",
		hands="Yaoyotl Gloves",
		ring1="Rajas Ring",
		ring2="K'ayres Ring",
        back="Refraction Cape",
		waist=gear.ElementalBelt,
		legs="Hagondes Pants",
		feet="Hagondes Sabots"}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Flash Nova'] = {
		ammo="Dosis Tathlum",
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
 
    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}
 
    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    -- Base fast recast for spells
    sets.midcast.FastRecast = {
		main="Tamaxchi",
		sub="Genbu Shield",
        head="Nahtirah Hat",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
        body="Hagondes Coat +1",
		hands="Bokwus Gloves",
		ring1="Prolix Ring",
        back="Swith Cape +1",
		waist="Witful Belt",
		legs="Geomancy Pants +1",
		feet="Regal Pumps +1"
		}
 
    sets.midcast.Geomancy = {
		main="Tamaxchi",
		range="Dunna",
		head="Azimuth Hood",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
		body="Bagua Tunic +1",
		hands="Geomancy Mitaines +1",
        back="Lifestream Cape",
		legs="Bagua Pants +1",
		feet="Medium's Sabots"
		}
     
    sets.midcast.Geomancy.Indi = {
		main="Tamaxchi",
		range="Dunna",
        head="Azimuth Hood",
		body="Bagua Tunic +1",
		hands="Geomancy Mitaines +1",
        back="Lifestream Cape",
		legs="Bagua Pants +1",
		feet="Azimuth Gaiters"
		}
     
    sets.midcast.Cure = {
		main="Tamaxchi",
		sub="Genbu's Shield", 
		head="Vanya Hood",
        body="Heka's Kalasiris",
		hands="Bokwus Gloves",
		ring1="Haoma Ring",
		ring2="Sirona's Ring",
        back="Swith Cape +1",
		legs="Nares Trews",
		feet="Hagondes Sabots"
		}
     
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
 
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
     
        -- Elemental Magic sets
     
    sets.midcast['Elemental Magic'] = {
		main="Tamaxchi",
		sub="Genbu Shield",
		ammo="Dosis Tathlum",
        head="Helios Band",
		neck="Stoicheion Medal",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
        body="Azimuth Coat",
		hands="Psycloth Manillas",
		ring1="Icesoul Ring",
		ring2="Acumen Ring",
        back="Lifestream Cape",
		waist=gear.ElementalObi,
		legs="Azimuth Tights",
		feet="Amalric Nails"
		}
 
    sets.midcast['Elemental Magic'].Resistant = {
		main="Tamaxchi",
		sub="Genbu Shield",
		ammo="Dosis Tathlum",
        head="Helios Band",
		neck="Eddy Necklace",
		ear1="Hecate's Earring",
		ear2="Friomisi Earring",
        body="Azimuth Coat",
		hands="Lurid Mitts",
		ring1="Icesoul Ring",
		ring2="Acumen Ring",
        back="Lifestream Cape",
		waist=gear.ElementalObi,
		legs="Azimuth Tights",
		feet="Amalric Nails"
		}
 
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
     
    sets.midcast['Dark Magic'] = {
		main="Apamajas II",
		sub="mephitis grip",
        head="Artsieq hat",
		neck="Eddy Necklace",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
        body="Artsieq Jubbah",
		hands="Lurid mitts",
		ring1="sangoma ring",
		ring2="Perception ring",
        back="Ogapepo cape",
		waist="ovate robe",
		legs="Artsieq hose",
		feet="Artsieq boots"
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
		main="Tamaxchi",
		sub="Genbu's Shield",
		range="Dunna",
        head="Azimuth Hood",
		neck="Wiglen Gorget",
		ear1="Bloodgem Earring",
		ear2="Loquacious Earring",
        body="Azimuth Coat",
		hands="Bagua Mitaines +1",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Bagua Pants +1",
		feet="Geomancy sandals +1"
		}
 
    sets.idle.PDT = {
		main="Tamaxchi",
		sub="Genbu's Shield",
		range="Dunna",
        head="Hagondes Hat",
		neck="Twilight Torque",
		ear1="Bloodgem Earring",
		ear2="Loquacious Earring",
        body="Hagondes Coat +1",
		hands="Hagondes cuffs",
		ring1="Dark Ring",
		ring2="Shelter Ring",
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Hagondes pants +1",
		feet="Hagondes sabots"
		}
 
    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
		main="Tamaxchi",
		sub="Genbu's Shield",
		range="Dunna",
        head="Azimuth Hood1",
		neck="Twilight Torque",
		ear1="Handler's Earring +1",
		ear2="Ethereal Earring",
        body="Azimuth Coat",
		hands="Geomancy Mitaines +1",
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
        back="Lifestream Cape",
		waist="Goading Belt",
		legs="Hagondes pants +1",
		feet="Bagua Sandals +1"
		}
 
    sets.idle.PDT.Pet = {
		main="Tamaxchi",
		sub="Genbu's Shield",
		range="Dunna",
        head="Azimuth Hoot",
		neck="Twilight Torque",
		ear1="Handler's Earring +1",
		ear2="Ethereal Earring",
        body="Azimuth Coat",
		hands="Yaoyotl Gloves",
		ring1="Defending Ring",
		ring2="Paguroidea Ring",
        back="Lifestream Cape",
		waist="Goading Belt",
		legs="Hagondes pants +1",
		feet="Azimuth Gaiters"
		}
 
    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {head="Azimuth ",legs="Bagu",feet="Azimu"})
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {head="Azi",back="Lifese",legs="Ba",feet="Azim"})
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {head="Azimuth Hood +1",body="Azimuth Coat +1",back="Lifestream Cape",legs="Bagua Pants +1",feet="Azimuth Gaiters"})
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {head="Azimuth Hood +1",body="Azimuth Coat +1",back="Lifestream Cape",legs="Bagua Pants +1",feet="Azimuth Gaiters +1"})
 
    sets.idle.Town = {
		main="Tamaxchi",
		sub="Genbu's Shield",
		range="Dunna",
        head="",
		neck="Wiglen Gorget",
		ear1="Enchanter Earring +1",
		ear2="Loquacious Earring",
        body="Respite Cloak",
		hands="Geomancy Mitaines +1",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Bagua Pants +1",
		feet="Geomancy Sandals +1"
		}
 
    sets.idle.Weak = {
		main="Bolelabunga",
		sub="Genbu's Shield",
		range="Nepote Bell",
        head="Nefer Khat +1",
		neck="Wiglen Gorget",
		ear1="Bloodgem Earring",
		ear2="Loquacious Earring",
        body="Heka's Kalasiris",
		hands="Serpentes Cuffs",
		ring1="Sheltered Ring",
		ring2="Paguroidea Ring",
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Hagondes pants +1",
		feet="Geomancy Sandals +1"
		}
 
    -- Defense sets
 
    sets.defense.PDT = {
		range="Dunna",
        head="Hagondes Hat",
		neck="Wiglen Gorget",
		ear1="Bloodgem Earring",
		ear2="Loquacious Earring",
        body="Hagondes Coat +1",
		hands="Yaoyotl Gloves",
		ring1="Defending Ring",
		ring2=gear.DarkRing.physical,
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Hagondes Pants +1",
		feet="Hagondes Sabots"
		}
 
    sets.defense.MDT = {
		range="Dunna",
        head="Nahtirah Hat",
		neck="Wiglen Gorget",
		ear1="Bloodgem Earring",
		ear2="Loquacious Earring",
        body="Hagondes Coat +1",
		hands="Yaoyotl Gloves",
		ring1="Defending Ring",
		ring2="Shadow Ring",
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Hagondes Pants +1",
		feet="Hagondes Sabots"
		}
 
    sets.Kiting = {feet="Geomancy Sandals +1"}
 
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
		main="Tamaxchi",
		range="Dunna",
        head="Zelus Tiara",
		neck="Peacock Charm",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        body="Vanir Cotehardie",
		hands="Bokwus Gloves",
		ring1="Rajas Ring",
		ring2="Paguroidea Ring",
        back="Umbra Cape",
		waist="Goading Belt",
		legs="Hagondes Pants",
		feet="Hagondes Sabots"
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
    set_macro_page(1, 1)
end
