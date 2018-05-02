function user_setup()
	state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'Refresh', 'Reraise')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PetPDT', 'PDT', 'Reraise', 'PKiller')
	state.MagicalDefenseMode:options('PetMDT','MDT', 'MKiller')
	state.ResistDefenseMode:options('PetMEVA', 'MEVA')
	
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Knockback', 'Suppa', 'DWEarrings'}
		
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	
	gear.PHYKumbha1 = {name="Kumbhakarna", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: TP Bonus+180',}}
	gear.PHYKumbha2 = {name="Kumbhakarna", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: TP Bonus+160',}}
	gear.PDTMABKumbha = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+20','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+200',}}
	gear.MABKumbha = {name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+19','Pet: TP Bonus+160',}}
 
    -- Set up Jug Pet cycling and keybind Ctrl+F7
    -- INPUT PREFERRED JUG PETS HERE
    state.JugMode = M{['description']='Jug Mode', 'ScissorlegXerin','BlackbeardRandy','AttentiveIbuki','DroopyDortwin','WarlikePatrick','AcuexFamiliar'}
	send_command('bind ^f7 gs c cycle JugMode')
 
    -- Set up Monster Correlation Modes and keybind Alt+F7
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
    send_command('bind !f7 gs c cycle CorrelationMode')
 
    -- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F7
    state.PetMode = M{['description']='Pet Mode', 'PetOnly', 'PetTank', 'PetStance',  'Normal'}
    send_command('bind @f7 gs c cycle PetMode')
  
    -- Set up Reward Modes and keybind Ctrl+Backspace
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
    send_command('bind ^backspace gs c cycle RewardMode')
	
	send_command('bind @f8 gs c toggle AutoReadyMode')
	send_command('bind !` gs c StandardReady')
	
	select_default_macro_book()
end

-- BST gearsets
function init_gear_sets()
    -- PRECAST SETS
    sets.precast.JA['Killer Instinct'] = {} --head="Ankusa Helm +1"
    sets.precast.JA['Bestial Loyalty'] = {body="Mirke Wardecors",hands="Ankusa Gloves +1"}
    sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
    sets.precast.JA.Familiar = {legs="Ankusa Trousers +1"}
    sets.precast.JA.Tame = {head="Totemic Helm +1"}
    sets.precast.JA.Spur = {back="Artio's Mantle",feet="Nukumi Ocreae +1"}
	sets.SpurAxe = {main="Skullrender"}
	sets.SpurAxesDW = {main="Skullrender",sub="Skullrender"}
 
	sets.precast.JA['Feral Howl'] = {}
 
	sets.precast.JA.Reward = {
                neck="Phalaina Locket",ear1="Etiolation Earring",ear2="Domesticator's Earring", --head="Stout Bonnet"
                body="Tot. Jackcoat +1",hands="Regimen Mittens",ring1="Stikini Ring",ring2="Sirona's Ring",
                back="Pastoralist's Mantle",waist="Hurch'lan Sash",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}
 
	sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Theta"})
	sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
	sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})
 
	sets.precast.JA.Charm = {}
 
	-- CURING WALTZ
	sets.precast.Waltz = {
                head=gear.valorous_pet_head,neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
                body="Tot. Jackcoat +1",hands="Regimen Mittens",ring1="Valseur's Ring",ring2="Asklepian Ring",
                back="Moonbeam Cape",waist="Chaac Belt",legs="Dashing Subligar",feet="Valorous Greaves"}
               
    -- HEALING WALTZ
	sets.precast.Waltz['Healing Waltz'] = {}
 
    -- STEPS
	sets.precast.Step = {ammo="Hasty Pinion +1",
                head="Gavialis Helm",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Heartseeker Earring",
                body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
                back="Ground. Mantle +1",waist="Olseni Belt",legs="Acro Breeches",feet="Valorous Greaves"}
 
    -- VIOLENT FLOURISH
	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = {ammo="Hasty Pinion +1",
                head="Gavialis Helm",neck="Combatant's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
                body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
                back="Ground. Mantle +1",waist="Olseni Belt",legs="Acro Breeches",feet="Valorous Greaves"}
 
	sets.precast.FC = {ammo="Impatiens",
	neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Jumalik Mail",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring"}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
 
    -- MIDCAST SETS
    sets.midcast.FastRecast = {
                head="Gavialis Helm",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
                body="Taeon Tabard",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
                back="Moonbeam Cape",waist="Hurch'lan Sash",legs="Tali'ah Sera. +1",feet="Tot. Gaiters +1"}
 
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
 
	sets.midcast.Cure = {
                head="Gavialis Helm",neck="Phalaina Locket",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
                body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Lebeche Ring",ring2="Sirona's Ring",
                back="Pastoralist's Mantle",waist="Hurch'lan Sash",legs="Tali'ah Sera. +1",feet="Tot. Gaiters +1"}
 
	sets.midcast.Curaga = sets.midcast.Cure

	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	sets.midcast.Stoneskin = sets.midcast.FastRecast
 
	sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {neck="Debilis Medallion",ring1="Haoma's Ring",ring2="Haoma's Ring"})
 
	sets.midcast.Protect = set_combine(sets.midcast.FastRecast, {ring2="Sheltered Ring"})
	sets.midcast.Protectra = sets.midcast.Protect
 
	sets.midcast.Shell = set_combine(sets.midcast.FastRecast, {ring2="Sheltered Ring"})
	sets.midcast.Shellra = sets.midcast.Shell
 
	sets.midcast['Enfeebling Magic'] = sets.midcast.FastRecast
 
	sets.midcast['Elemental Magic'] = sets.midcast.FastRecast
		
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic']
 
    -- WEAPONSKILLS
    -- Default weaponskill sets.
	sets.precast.WS = {ammo="Hasty Pinion +1",
                head="Gavialis Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
                body="Mes. Haubergeon",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
                back="Buquwik Cape",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Amm Greaves"}
 
	sets.precast.WS.SomeAcc = {ammo="Hasty Pinion +1",
                head=gear.valorous_pet_head,neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
                body="Mes. Haubergeon",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
                back="Letalis Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Amm Greaves"}
 
	sets.precast.WS.Acc = {ammo="Hasty Pinion +1",
                head=gear.valorous_pet_head,neck="Combatant's Torque",ear1="Brutal Earring",ear2="Sherida Earring",
                body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Ramuh Ring +1",
                back="Letalis Mantle",waist="Olseni Belt",legs="Meg. Chausses +1",feet="Nukumi Ocreae +1"}
				
	sets.precast.WS.FullAcc = {ammo="Hasty Pinion +1",
                head=gear.valorous_pet_head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
                body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
                back="Ground. Mantle +1",waist="Olseni Belt",legs="Acro Breeches",feet="Nukumi Ocreae +1"}
				
	sets.precast.WS.Fodder = {ammo="Paeapua",
                head="Gavialis Helm",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Sherida Earring",
                body="Mes. Haubergeon",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
                back="Buquwik Cape",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Nukumi Ocreae +1"}
 
    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Ruinator'].Mekira = set_combine(sets.precast.WS['Ruinator'], {head="Gavialis Helm"})
    sets.precast.WS['Ruinator'].WSMedAcc = set_combine(sets.precast.WS.WSMedAcc, {})
    sets.precast.WS['Ruinator'].WSHighAcc = set_combine(sets.precast.WS.WSHighAcc, {})
 
    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Onslaught'].WSMedAcc = set_combine(sets.precast.WSMedAcc, {})
    sets.precast.WS['Onslaught'].WSHighAcc = set_combine(sets.precast.WSHighAcc, {})
 
    sets.precast.WS['Primal Rend'] = {ammo="Dosis Tathlum",
                head="Jumalik Helm",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
                body="Jumalik Mail",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Stikini Ring",
                back="Toro Cape",waist="Fotia Belt",legs="Tali'ah Sera. +1",feet="Tot. Jackcoat +1"}
 
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {})
		
		-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Brutal Earring",ear2="Sherida Earring",}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
 
        -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {ammo="Demonry Core",
		head="Totemic Helm +1",neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body="Taeon Tabard",hands="Nukumi Manoplas +1",ring1="Varar Ring",ring2="Varar Ring",
        back="Pastoralist's Mantle",waist="Incarnation Sash",legs=gear.valorous_physical_pet_legs,feet="Totemic Gaiters +1"}
		
    sets.midcast.Pet.MagicReady = {ammo="Demonry Core",
		head=gear.valorous_pet_head,neck="Adad Amulet",ear1="Enmerkar Earring",ear2="Domesticator's Earring",
        body=gear.valorous_pet_body,hands="Nukumi Manoplas +1",ring1="Varar Ring",ring2="Varar Ring",
        back="Pastoralist's Mantle",waist="Incarnation Sash",legs=gear.valorous_magical_pet_legs,feet=gear.valorous_magical_pet_feet}
 
	sets.midcast.Pet.Acc = set_combine(sets.midcast.Pet.WS, {head="Totemic Helm +1",hands="Regimen Mittens"}) --legs="Wisent Kecks"
	sets.midcast.Pet.FullAcc = set_combine(sets.midcast.Pet.WS, {head="Totemic Helm +1",hands="Regimen Mittens"}) --legs="Wisent Kecks"

	sets.midcast.Pet.ReadyRecast = {legs="Desultor Tassets"}
	sets.midcast.Pet.Neutral = {head="Totemic Helm +1"}
	sets.midcast.Pet.Favorable = {head="Nukumi Cabasset"}
	sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1"}

	-- PET-ONLY SETS THAT SWAP WEAPONS FOR READY AND IDLE
	sets.midcast.Pet.ReadyRecastNE = {sub="Charmer's Merlin",legs="Desultor Tassets"}
	sets.midcast.Pet.ReadyNE = set_combine(sets.midcast.Pet.WS, {main=gear.PHYKumbha1,sub=gear.PHYKumbha2})
	sets.midcast.Pet.ReadyNE.MedAcc = set_combine(sets.midcast.Pet.WS, {main="Kerehcatl",sub=gear.PHYKumbha2})
	sets.midcast.Pet.ReadyNE.FullAcc = set_combine(sets.midcast.Pet.WS, {main="Kerehcatl",sub="Hunahpu"})

	sets.midcast.Pet.MagicReadyNE = set_combine(sets.midcast.Pet.MagicReady, {main=gear.MABKumbha,sub=gear.PDTMABKumbha})

	sets.IdleAxesNE = {main ="Izizoeksi",sub=gear.PDTMABKumbha}
	sets.RewardAxe = {}
	sets.RewardAxesDW = {}

	-- RESTING
	sets.resting = {}

	sets.idle = {ammo="Staunch Tathlum",
			head="Jumalik Helm",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Handler's Earring +1",
			body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Sheltered Ring",
			back="Solemnity Cape",waist="Flume Belt",legs="Tali'ah Sera. +1",feet="Skd. Jambeaux +1"}

	sets.idle.Refresh = set_combine(sets.idle, {})
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

	sets.idle.Pet = {ammo="Demonry Core",
			head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
			body="Taeon Tabard",hands="Ankusa Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
			back="Pastoralist's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Ankusa Gaiters +1"}

	sets.idle.Pet.Engaged = {ammo="Demonry Core",
			head="Anwig Salade",neck="Shulmanu Collar",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
			body="Taeon Tabard",hands="Regimen Mittens",ring1="Defending Ring",ring2="Dark Ring",
			back="Pastoralist's Mantle",waist="Hurch'lan Sash",legs="Tali'ah Sera. +1",feet="Tot. Gaiters +1"}
			
	-- DEFENSE SETS
	sets.defense.PDT = {ammo="Staunch Tathlum",
			head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Handler's Earring +1",
			body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Dark Ring",
			back="Moonbeam Cape",waist="Flume Belt",legs="Tali'ah Sera. +1",feet="Nukumi Ocreae +1"}

	sets.defense.PetPDT = {ammo="Demonry Core",
			head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
			body="Taeon Tabard",hands="Ankusa Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
			back="Pastoralist's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Ankusa Gaiters +1"}
			
	sets.defense.PetMDT = {ammo="Demonry Core",
			head="Anwig Salade",neck="Loricate Torque +1",ear1="Enmerkar Earring",ear2="Handler's Earring +1",
			body="Taeon Tabard",hands="Ankusa Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
			back="Pastoralist's Mantle",waist="Isa Belt",legs="Tali'ah Sera. +1",feet="Ankusa Gaiters +1"}
		
	sets.defense.PetMEVA = sets.defense.PetMDT
	
	sets.defense.PKiller = set_combine(sets.defense.PDT, {body="Nukumi Gausape +1"})
	sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {ammo="Staunch Tathlum",
			head="Genmei Kabuto",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
			body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Shadow Ring",
			back="Engulfer Cape +1",waist="Engraved Belt",legs="Tali'ah Sera. +1",feet="Nukumi Ocreae +1"}
	
	sets.defense.MEVA = {
		head="Gavialis Helm",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Jumalik Mail",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
		back="Toro Cape",waist="Engraved Belt",legs="Acro Breeches",feet="Valorous Greaves"}

	sets.defense.MKiller = set_combine(sets.defense.MDT, {body="Nukumi Gausape +1"})

	sets.Kiting = {feet="Skd. Jambeaux +1"}
	sets.DayIdle = {}
	sets.NightIdle = {}
 
        -- MELEE (SINGLE-WIELD) SETS
    sets.engaged = {ammo="Ginsen",
        head=gear.valorous_wsd_head,neck="Asperity Necklace",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Mes. Haubergeon",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		
    sets.engaged.SomeAcc = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Defiant Collar",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet="Valorous Greaves"}
    
	sets.engaged.Acc = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Brutal Earring",
        body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Acro Breeches",feet="Valorous Greaves"}
		
    sets.engaged.FullAcc = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Acro Breeches",feet="Valorous Greaves"}
		        
    sets.engaged.Fodder = {ammo="Ginsen",
        head=gear.valorous_wsd_head,neck="Asperity Necklace",ear1="Trux Earring",ear2="Brutal Earring",
        body="Mes. Haubergeon",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		
        -- MELEE (SINGLE-WIELD) HYBRID SETS
    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Jumalik Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		
    sets.engaged.SomeAcc.PDT = {ammo="Falcon Eye",
        head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Jumalik Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Valorous Greaves"}
    
	sets.engaged.Acc.PDT = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Jumalik Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		
    sets.engaged.FullAcc.PDT = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Jumalik Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		        
    sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
        head=gear.valorous_wsd_head,neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Sherida Earring",
        body="Jumalik Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		
        -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
    sets.engaged.DW = {ammo="Ginsen",
        head=gear.valorous_wsd_head,neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mes. Haubergeon",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet="Valorous Greaves"}
		
    sets.engaged.DW.SomeAcc = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Defiant Collar",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet="Valorous Greaves"}
    
	sets.engaged.DW.Acc = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Brutal Earring",
        body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Grunfeld Rope",legs="Acro Breeches",feet="Valorous Greaves"}
		
    sets.engaged.DW.FullAcc = {ammo="Falcon Eye",
        head=gear.valorous_wsd_head,neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Mes. Haubergeon",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Acro Breeches",feet="Valorous Greaves"}
		        
    sets.engaged.DW.Fodder = {ammo="Ginsen",
        head=gear.valorous_wsd_head,neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mes. Haubergeon",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Shetal Stone",legs="Meg. Chausses +1",feet="Valorous Greaves"}

        -- MELEE (DUAL-WIELD) HYBRID SETS
        sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {ear1="Dudgeon Earring",ear2="Heartseeker Earring",})
		sets.engaged.DW.SomeAcc.PDT = set_combine(sets.engaged.SomeAcc.PDT, {ear1="Dudgeon Earring",ear2="Heartseeker Earring",})
		sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.Acc.PDT, {ear1="Dudgeon Earring",ear2="Heartseeker Earring",})
		sets.engaged.DW.FullAcc.PDT = set_combine(sets.engaged.FullAcc.PDT, {})
 
        -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET ENGAGED
        sets.engaged.PetStance = set_combine(sets.engaged,{})
        sets.engaged.PetStance.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
        sets.engaged.PetStance.Acc = set_combine(sets.engaged.Acc, {})
        sets.engaged.PetStance.FullAcc = set_combine(sets.engaged.FullAcc, {})
		sets.engaged.PetStance.Fodder = set_combine(sets.engaged.Fodder, {})
 
        -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
        sets.engaged.PetTank = set_combine(sets.engaged,{})
        sets.engaged.PetTank.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
        sets.engaged.PetTank.Acc = set_combine(sets.engaged.Acc, {})
        sets.engaged.PetTank.FullAcc = set_combine(sets.engaged.FullAcc, {})
		sets.engaged.PetTank.Fodder = set_combine(sets.engaged.Fodder, {})
 
        -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET ENGAGED
        sets.engaged.DW.PetStance = set_combine(sets.engaged,{})
        sets.engaged.DW.PetStance.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
        sets.engaged.DW.PetStance.Acc = set_combine(sets.engaged.Acc, {})
        sets.engaged.DW.PetStance.FullAcc = set_combine(sets.engaged.FullAcc, {})
		sets.engaged.DW.PetStance.Fodder = set_combine(sets.engaged.Fodder, {})
 
        -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
        sets.engaged.DW.PetTank = set_combine(sets.engaged,{})
        sets.engaged.DW.PetTank.SomeAcc = set_combine(sets.engaged.SomeAcc, {})
        sets.engaged.DW.PetTank.Acc = set_combine(sets.engaged.Acc, {})
        sets.engaged.DW.PetTank.FullAcc = set_combine(sets.engaged.FullAcc, {})
		sets.engaged.DW.PetTank.Fodder = set_combine(sets.engaged.Fodder, {})
		
        sets.buff['Killer Instinct'] = {body="Nukumi Gausape +1"}
        sets.buff.Doom = set_combine(sets.buff.Doom, {})
		sets.buff.Sleep = {head="Frenzy Sallet"}
		sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
		sets.Weapons = {main ="Izizoeksi",sub=gear.PDTKumbha}
		sets.Knockback = {}
		sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Sherida Earring"}
		sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}		
		
-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------
 
        sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Seedbed Soil"})
        sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fish Oil Broth"})
        sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sun Water"})
        sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="D. Herbal Broth"})
        sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cng. Brain Broth"})
        sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Grass. Broth"})
        sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Mlw. Bird Broth"})
        sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gob. Bug Broth"})
        sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
        sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Auroral Broth"})
        sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="L. Carrot Broth"})
        sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wool Grease"})
        sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vermihumus"})
        sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Briny Broth"})
        sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepbed Soil"})
        sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Plasma Broth"})
        sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lucky Broth"})
        sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Svg. Mole Broth"})
        sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rzr. Brain Broth"})
        sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
        sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cl. Wheat Broth"})
        sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shadowy Broth"})
 
-------------------------------------------------------------------------------------------------------------------
-- Complete iLvl Jug Pet Precast List
-------------------------------------------------------------------------------------------------------------------
 
        sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Swirling Broth"})
        sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vis. Broth"})
        sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shimmering Broth"})
        sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Ferm. Broth"})
        sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Livid Broth"})
        sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spicy Broth"})
        sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bubbly Broth"})
        sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lyrical Broth"})
        sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Salubrious Broth"})
        sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Windy Greens"})
        sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Airy Broth"})
        sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Trans. Broth"})
        sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crumbly Soil"})
        sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Blackwater Broth"})
		sets.precast.JA['Bestial Loyalty'].SuspiciousAlice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Furious Broth"})
		sets.precast.JA['Bestial Loyalty'].AnklebiterJedd = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crackling Broth"})
		sets.precast.JA['Bestial Loyalty'].FleetReinhard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rapid Broth"})
		sets.precast.JA['Bestial Loyalty'].CursedAnnabelle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Creepy Broth"})
		sets.precast.JA['Bestial Loyalty'].SurgingStorm = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Insipid Broth"})
		sets.precast.JA['Bestial Loyalty'].SubmergedIyo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepwater Broth"})
        sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Electrified Broth"})
        sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bug-Ridden Broth"})
        sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fizzy Broth"})
        sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Tant. Broth"})
        sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pale Sap"})
        sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Meaty Broth"})
        sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Dire Broth"})
        sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Muddy Broth"})
		sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wetlands Broth"})
		sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'] = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Heavenly Broth"})
        sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wispy Broth"})
        sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Saline Broth"})
        sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sugary Broth"})
        sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Glazed Broth"})
        sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sticky Webbing"})
        sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Slimy Webbing"})
        sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Poisonous Broth"})
        sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Venomous Broth"})
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(6, 16)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 16)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(6, 20)
	end
end

function user_job_tick()
	if state.AutoReadyMode.value and player.sub_job == 'NIN' and not moving and not (buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if spell_recasts[339] == 0 then
			send_command('input /ma "Utsusemi: Ni" <me>')
			tickdelay = 1100
			return true
		end
		
	end
	return false
end