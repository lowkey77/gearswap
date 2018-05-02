-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
include('Obi_Check')
include('organizer-lib')
organizer_items = {
  echos="Echo Drops",
  shihei="Shihei",
  orb="Macrocosmic Orb"
 
}
--[[
        Custom commands:
 
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
 
                                        Light Arts              Dark Arts
 
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]
 
 
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
     
    state.MagicBurst = M(false, 'Magic Burst')
 
    info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
                       "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",}
    info.high_nukes = S{"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
 
    send_command('bind ^` input /ma Stun <t>')
 
    select_default_macro_book()
end
 
function user_unload()
    send_command('unbind ^`')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    -- Precast Sets
 
    -- Precast sets to enhance JAs
 
    sets.precast.JA['Tabula Rasa'] = {}
    sets.precast.JA['Dark Arts'] = {body="Acad. Gown +1"}
    sets.precast.JA['Light Arts'] = {legs="Acad. Pants +1"}
 
    -- Fast cast sets for spells
 
    sets.precast.FC ={
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Incantor Stone",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body={ name="Merlinic Jubbah", augments={'"Fast Cast"+6','CHR+6','Mag. Acc.+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','"Fast Cast"+6','MND+5','Mag. Acc.+5',}},
    neck="Orunmila's torque",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Rehab Ring",
    back="Perimede Cape",}
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
 
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})
 
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
    ear2="Mendicant's Earring",ear1="Loquacious Earring",back="Pahtli Cape",feet="Vanya Clogs"})
 
    sets.precast.FC.Curaga = sets.precast.FC.Cure
 
    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty,body=""})
 
   -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
     ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Fortified Ring",
    right_ring="Mephitas's Ring",
    back="Pahtli Cape",}
     
     
    -- Midcast Sets
 
    sets.midcast.FastRecast = {}
 
    sets.midcast.Cure = {
    main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
    sub="Niobid Strap",
    ammo="Kalboron Stone",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    hands={ name="Kaykaus Cuffs", augments={'MP+60','MND+10','Mag. Acc.+15',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Magnetic Earring",
    right_ear="Mendi. Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back="Pahtli Cape",}
 
    sets.midcast.CureWithLightWeather = {
    main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
    sub="Niobid Strap",
    ammo="Kalboron Stone",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    hands={ name="Kaykaus Cuffs", augments={'MP+60','MND+10','Mag. Acc.+15',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Incanter's Torque",
    waist="Hachirin-no-Obi",
    left_ear="Magnetic Earring",
    right_ear="Mendi. Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back="Pahtli Cape",}
 
    sets.midcast.Curaga = sets.midcast.Cure
 
    sets.midcast.Regen = {
    head="Arbatel Bonnet +1",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +5',}},
    hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +6',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},}
 
    sets.midcast.Cursna = {
    main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
    sub="Niobid Strap",
    ammo="Kalboron Stone",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    hands={ name="Kaykaus Cuffs", augments={'MP+60','MND+10','Mag. Acc.+15',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Magnetic Earring",
    right_ear="Mendi. Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back="Pahtli Cape",}
 
    sets.midcast['Enhancing Magic'] = { 
    main="Oranyan",
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +6',}},
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +5',}},
    hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +6',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    neck="Incanter's Torque",
    waist="Siegel Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Sheltered Ring",
    right_ring="Prolix Ring",
    back="Perimede Cape",}
 
 
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",waist="Siegel Sash",})
 
    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet={ name="Peda. Loafers +1", augments={'Enhances "Stormsurge" effect',}},})
     
    sets.midcast.Klimaform = set_combine(sets.midcast['Enhancing Magic'], {feet="Arbatel Loafers +1"})
     
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'],{left_ring="Sheltered ring"})
    sets.midcast.Protectra = sets.midcast.Protect
 
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {left_ring="Sheltered ring"})
    sets.midcast.Shellra = sets.midcast.Shell
     
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet="Inspirited Boots"})
 
    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {})
     
    sets.midcast.Storm = {
    main="Oranyan",
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +6',}},
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +5',}},
    hands={ name="Telchine Gloves", augments={'"Fast Cast"+5','Enh. Mag. eff. dur. +6',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Peda. Loafers +1", augments={'Enhances "Stormsurge" effect',}},
    neck="Incanter's Torque",
    waist="Siegel Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Sheltered Ring",
    right_ring="Prolix Ring",
    back="Perimede Cape",}
 
    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    hands="Lurid Mitts",
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Medium's Sabots", augments={'MP+30','MND+8','"Cure" potency +2%',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Barkaro. Earring",
    right_ear="Gwati Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back="Izdubar Mantle",}
 
    sets.midcast.IntEnfeebles = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
    hands="Lurid Mitts",
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Medium's Sabots", augments={'MP+30','MND+8','"Cure" potency +2%',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Barkaro. Earring",
    right_ear="Gwati Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back="Izdubar Mantle",}
 
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
     
    sets.midcast.Kaustra = {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','DEX+7','Mag. Acc.+7','"Mag.Atk.Bns."+13',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+29','Magic burst mdg.+9%','INT+6','Mag. Acc.+12',}},
    feet="Arbatel Loafers +1",
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Static Earring",
    left_ring="Mujin Band",
    right_ring="Archon Ring",
    back="Seshaw Cape",}
 
    sets.midcast['Dark Magic'] = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Chironic Hat", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +9','CHR+1','Mag. Acc.+12',}},
    body={ name="Psycloth Vest", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back={ name="Bookworm's Cape", augments={'INT+3','MND+1','Helix eff. dur. +20',}},}
     
 
    sets.midcast.Drain = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Chironic Hat", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +9','CHR+1','Mag. Acc.+12',}},
    body={ name="Psycloth Vest", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    right_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    right_ring="Archon Ring",
    right_ring="Perception Ring",
    back={ name="Bookworm's Cape", augments={'INT+3','MND+1','Helix eff. dur. +20',}},}
 
    sets.midcast.Aspir = sets.midcast.Drain
 
    sets.midcast.Stun = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Chironic Hat", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +9','CHR+1','Mag. Acc.+12',}},
    body={ name="Psycloth Vest", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Levia. Ring +1",
    right_ring="Perception Ring",
    back={ name="Bookworm's Cape", augments={'INT+3','MND+1','Helix eff. dur. +20',}},}
 
    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})
 
 
    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] ={
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+10%','INT+5','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','DEX+7','Mag. Acc.+7','"Mag.Atk.Bns."+13',}},
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+4','DEX+9','Mag. Acc.+13','"Mag.Atk.Bns."+10',}},
    feet="Arbatel Loafers +1",
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi",
    left_ear="Friomisi Earring",
    right_ear="Barkarole Earring",
    left_ring="Acumen Ring",
    right_ring="Shiva Ring +1",
    back="Toro Cape",}
 
    sets.midcast['Elemental Magic'].Resistant = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+10%','INT+5','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','DEX+7','Mag. Acc.+7','"Mag.Atk.Bns."+13',}},
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+4','DEX+9','Mag. Acc.+13','"Mag.Atk.Bns."+10',}},
    feet="Arbatel Loafers +1",
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi",
    left_ear="Friomisi Earring",
    right_ear="Barkarole Earring",
    left_ring="Acumen Ring",
    right_ring="Shiva Ring +1",
    back="Toro Cape",}
     
 
    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap"})
 
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {sub="Niobid Strap"})
 
    sets.midcast.Impact = {}
     
    sets.midcast.Helix ={
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+10%','INT+5','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','DEX+7','Mag. Acc.+7','"Mag.Atk.Bns."+13',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+4','DEX+9','Mag. Acc.+13','"Mag.Atk.Bns."+10',}},
    feet="Arbatel Loafers +1",
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Seshaw Cape",}
     
    sets.midcast.Noctohelix = {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','DEX+7','Mag. Acc.+7','"Mag.Atk.Bns."+13',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+29','Magic burst mdg.+9%','INT+6','Mag. Acc.+12',}},
    feet="Arbatel Loafers +1",
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Static Earring",
    left_ring="Mujin Band",
    right_ring="Archon Ring",
    back="Seshaw Cape",}
 
    -- Sets to return to when not performing an action.
 
    -- Resting sets
        sets.resting = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Magnetic Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
 
    sets.idle.Town ={
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
    sets.idle.Field = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
     
    sets.idle.Field.PDT = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Loricate torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
    sets.idle.Field.Stun = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
    sets.idle.Weak = {
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
     
    -- Defense sets
 
    sets.defense.PDT = {main=gear.Staff.PDT,
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Loricate torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
    sets.defense.MDT = {main=gear.Staff.PDT,
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -2%','"Cure" spellcasting time -3%',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Loricate torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
    sets.Kiting = {feet="Herald's Gaiters"}
 
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
 
    -- Normal melee group
    sets.engaged = { main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Chironic Hat", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +9','CHR+1','Mag. Acc.+12',}},
    body={ name="Witching Robe", augments={'MP+40','Mag. Acc.+12','"Mag.Atk.Bns."+8',}},
    hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+6','Mag. Acc.+10','"Mag.Atk.Bns."+14',}},
    legs="Assid. Pants +1",
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Magnetic Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered ring",
    right_ring="Shneddick Ring",
    back="Solemnity Cape",}
 
 
 
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet={ name="Peda. Loafers +1", augments={'Enhances "Stormsurge" effect',}},}
    sets.buff['Alacrity'] = {head="Nahtirah Hat",feet="Pedagogy Loafers +1"}
    sets.buff['Stormsurge'] = {feet={ name="Peda. Loafers +1", augments={'Enhances "Stormsurge" effect',}},}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
 
    sets.buff.FullSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring",body="Pedagogy Gown +1"}
    sets.buff.PDTSublimation = {head="Academic's Mortarboard +1",ear1="Savant's Earring"}
 
    sets.magic_burst ={ 
    main={ name="Grioavolr", augments={'Magic burst mdg.+9%','INT+13','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +4',}},
    sub="Niobid Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+10%','INT+5','Mag. Acc.+13','"Mag.Atk.Bns."+14',}},
    body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','DEX+7','Mag. Acc.+7','"Mag.Atk.Bns."+13',}},
    hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+4','DEX+9','Mag. Acc.+13','"Mag.Atk.Bns."+10',}},
    feet="Arbatel Loafers +1",
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Static Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Seshaw Cape",}
     
    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.element == world.day_element or spell.element == world.weather_element then
        if info.low_nukes:contains(spell.english) then 
        equip(sets.midcast['Elemental Magic'], {ring1="Zodiac Ring",back="Twilight Cape"})
            elseif info.high_nukes:contains(spell.english) then
            equip(sets.midcast['Elemental Magic'].HighTierNuke, {ring1="Zodiac Ring",back="Twilight Cape"})
        end
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
        equip(sets.magic_burst)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end
 
-- Handle notifications of general user state change.
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
 
-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end
 
function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end
 
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
 
    return idleSet
end
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end
 
    update_active_strategems()
    update_sublimation()
end
 
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false
 
    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end
 
function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end
 
-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end
 
    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end
 
 
function display_current_caster_state()
    local msg = ''
 
    if state.OffenseMode.value ~= 'None' then
        msg = msg .. 'Melee'
 
        if state.CombatForm.has_value then
            msg = msg .. ' (' .. state.CombatForm.value .. ')'
        end
         
        msg = msg .. ', '
    end
 
    msg = msg .. 'Idle ['..state.IdleMode.value..'], Casting ['..state.CastingMode.value..']'
 
    add_to_chat(122, msg)
    local currentStrats = get_current_strategem_count()
    local arts
    if buffactive['Light Arts'] or buffactive['Addendum: White'] then
        arts = 'Light Arts'
    elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
        arts = 'Dark Arts'
    else
        arts = 'No Arts Activated'
    end
    add_to_chat(122, 'Current Available Strategems: ['..currentStrats..'], '..arts..'')
end
 
-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use
    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
 
    local currentStrats = get_current_strategem_count()
    local newStratCount = currentStrats - 1
    local strategem = cmdParams[2]:lower()
     
    if currentStrats > 0 and strategem ~= 'light' and strategem ~= 'dark' then
        add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
    elseif currentStrats == 0 then
        add_to_chat(122, '***Out of strategems! Canceling...***')
        return
    end
 
    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
            add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        elseif buffactive['dark arts']  or buffactive['addendum: black'] then
            send_command('input /ja "Light Arts" <me>')
            add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
            add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        elseif buffactive['light arts'] or buffactive['addendum: white'] then
            send_command('input /ja "Dark Arts" <me>')
            add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('@input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('@input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('@input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('@input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('@input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('@input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('@input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('@input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('@input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('@input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('@input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('@input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('@input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('@input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('@input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('@input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end
 
function get_current_strategem_count()
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]
 
    local maxStrategems = math.floor(player.main_job_level + 10) / 20
 
    local fullRechargeTime = 5*33
 
    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
     
    return currentCharges
end
 
 
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 8)
end