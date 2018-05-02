function user_setup()

	state.OffenseMode:options('Normal', 'Acc', 'HighAcc', 'Fodder')
	state.HybridMode:options('Normal', 'Tank', 'NoShellTank', 'PDT', 'MDT')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.PhysicalDefenseMode:options('PDT', 'PDT_HP')
	state.MagicalDefenseMode:options('MDT','MDT_HP','BDT','BDT_HP')
	state.ResistDefenseMode:options('MEVA', 'Death','Charm')
	state.IdleMode:options('Normal', 'PDT', 'MDT', 'Refresh')
	
	state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP'}
	
	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^` gs c RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind ^\\\\ input /ma "Protect 4" <me>')
	send_command('bind @\\\\ input /ma "Shell V" <me>')
	send_command('bind !\\\\ input /ma "Crusade" <me>')
	send_command('bind ^= input /ja "Lunge" <me>')
	send_command('bind @= input /ja "Gambit" <me>')
	send_command('bind != input /ja "Rayke" <me>')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

function init_gear_sets()

    sets.enmity = {ammo="Aqreqaq Bomblet", hands="Futhark Gloves +1", back="Mubvumbamiri mantle", waist="Warwolf Belt"}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {head="Thaumas Hat", neck="Baetyl Pendant", ear1="Novio Earring", ear2="Friomisi Earring",
            body="Vanir Cotehardie", ring1="Shiva Ring +1", ring2=="Omega Ring",
            back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Iuitl Tights +1", feet="Taeon Boots"}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})

	-- Pulse sets, different stats for different rune modes, stat aligned.
    sets.precast.JA['Vivacious Pulse'] = {}
    sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
    sets.precast.Step = {}
		
	sets.precast.JA['Violent Flourish'] = {}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

	-- Fast cast sets for spells
    sets.precast.FC = {
            head="Runeist bandeau +1", ear1="Loquacious Earring",
            body="Dread Jupon", hands="Thaumas gloves", ring2=="Prolix Ring",
            legs="Orvail Pants +1"}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {ammo="Aqreqaq Bomblet",
            head="Whirlpool Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Manibozho Jerkin", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2=="Rajas Ring",
            back="Buquwik Cape", waist="Thunder Belt", legs="Quiahuiz Trousers", feet="Taeon Boots"}
	sets.precast.WS.Acc = {ammo="Aqreqaq Bomblet",
            head="Whirlpool Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Manibozho Jerkin", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2=="Rajas Ring",
            back="Buquwik Cape", waist="Thunder Belt", legs="Quiahuiz Trousers", feet="Taeon Boots"}			
    sets.precast.WS['Resolution'] = {ammo="Aqreqaq Bomblet",
            head="Whirlpool Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Manibozho Jerkin", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2=="Rajas Ring",
            back="Buquwik Cape", waist="Thunder Belt", legs="Quiahuiz Trousers", feet="Taeon Boots"}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, 
        {ammo="Falcon Eye", body="Dread Jupon", hands="Umuthi Gloves", back="Evasionist's Cape", legs="Manibozho Legs"})
    sets.precast.WS['Dimidiation'] = {ammo="Thew Bomblet",
            head="Felistris Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Dread Jupon", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2=="Rajas Ring",
            back="Atheling Mantle", waist="Windbuffet Belt", legs="Manibozho Brais", feet="Taeon Boots"}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, 
        {ammo="Falcon Eye", head="Whirlpool Mask", hands="Buremte Gloves", back="Evasionist's Cape", waist="Thunder Belt"})
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})
    sets.precast.WS['Ground Strike'] = {ammo="Thew Bomblet",
            head="Felistris Mask", neck="Thunder Gorget", ear1="Bladeborn Earring", ear2="Steelflash Earring",
            body="Dread Jupon", hands="Futhark Mitons +1", ring1="Epona's Ring", ring2=="Rajas Ring",
            back="Atheling Mantle", waist="Windbuffet Belt", legs="Manibozho Brais", feet="Taeon Boots"}
    sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS['Ground Strike'].Normal, {})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque", ear1="Andoaa Earring", hands="Runeist mitons +1", waist="Olympus Sash", legs="Futhark Trousers +1"}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {head="Runeist Bandeau +1", legs="Futhark Trousers +1"}
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash"})
	sets.midcast.Flash = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	
    sets.midcast.Cure = {neck="Incanter's Torque", hands="Buremte Gloves", ring1="Ephedra Ring", feet="Futhark Boots +1"}
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
    sets.midcast.Protect = {ring2=="Sheltered Ring"}
    sets.midcast.Shell = {ring2=="Sheltered Ring"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}
	
    sets.idle = {ammo='Inlamvuyeso',
            head="Ocelomeh Headpiece +1", neck="Wiglen Gorget", ear1="Ethereal earring", ear2="Moonshade earring",
            body="Futhark Coat +1", hands="Umuthi Gloves", ring1="Sheltered Ring", ring2=="Paguroidea ring",
            back="Evasionist's Cape", waist="Flume Belt", legs="Runeist Trousers +1", feet="Skadi's jambeaux +1"}
			
	sets.idle.PDT = {}
	
	sets.idle.MDT = {}
    
	sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1"})
           
	sets.idle.Weak = {}
		   
	sets.Kiting = {feet="Skadi's Jambeaux +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Weapons = {}
    sets.Knockback = {}
    sets.MP = {ear2="Ethereal Earring",waist="Flume Belt"}
    sets.MP_Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Defense Sets
	
	sets.defense.PDT = {}
	sets.defense.PDT_HP = {}

	sets.defense.MDT = {}
	sets.defense.MDT_HP = {}
	
	sets.defense.BDT = {}
	sets.defense.BDT_HP = {}
	
	sets.defense.MEVA = {}
		
	sets.defense.Death = {}
		
	sets.defense.Charm = {}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {}
    sets.engaged.Acc = {}
	sets.engaged.HighAcc = {}
	sets.engaged.Fodder = {}
	
    sets.engaged.Tank = {}
    sets.engaged.Acc.Tank = {}
	sets.engaged.HighAcc.Tank = {}
	sets.engaged.Fodder.Tank = {}
	
    sets.engaged.NoShellTank = {}
    sets.engaged.Acc.NoShellTank = {}
	sets.engaged.HighAcc.NoShellTank = {}
	sets.engaged.Fodder.NoShellTank = {}
	
    sets.engaged.PDT = {}
    sets.engaged.Acc.PDT = {}
	sets.engaged.HighAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}
	
    sets.engaged.MDT = {}
    sets.engaged.Acc.MDT = {}
	sets.engaged.HighAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end