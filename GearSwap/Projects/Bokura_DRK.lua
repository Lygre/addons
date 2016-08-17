-- *** Credit goes to Flippant for helping me with Gearswap *** --
-- ** I Use Some of Motenten's Functions ** --

function get_sets()
    AccIndex = 1
    AccArray = {"LowACC","MidACC","HighACC"} -- 3 Levels Of Accuracy Sets For TP/WS/Hybrid/Stun. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. Most of These Sets Are Empty So You Need To Edit Them On Your Own. Remember To Check What The Combined Set Is For Each Sets. --
    WeaponIndex = 1
    WeaponArray = {"Liberator","Ragnarok","Apocalypse"} -- Default Main Weapon Is Liberator. Can Delete Any Weapons/Sets That You Don't Need Or Replace/Add The New Weapons That You Want To Use. --
    IdleIndex = 1
    IdleArray = {"Movement","Regen","Refresh"} -- Default Idle Set Is Movement --
    Armor = 'None'
    Twilight = 'None'
    Attack = 'OFF' -- Set Default WS Attack Set ON or OFF Here --
    Rancor = 'ON' -- Set Default Rancor ON or OFF Here --
    Samurai_Roll = 'ON' -- Set Default SAM Roll ON or OFF Here --
    target_distance = 5 -- Set Default Distance Here --
    select_default_macro_book() -- Change Default Macro Book At The End --

    -- Gavialis Helm --
    elements = {}
    elements.equip = {head="Gavialis Helm"}
    elements.Resolution = S{"Lightning","Wind","Earth"}
    elements.Entropy = S{"Dark","Water","Earth"}
    elements.Catastrophe = S{"Dark","Earth"}
    elements.Insurgency = S{"Light","Dark","Fire"}

    sc_map = {SC1="Entropy", SC2="Insurgency", SC3="LastResort"} -- 3 Additional Binds. Can Change Whatever JA/WS/Spells You Like Here. Remember Not To Use Spaces. --

    sets.Idle = {}
    -- Regen Set --
    sets.Idle.Regen = {}
    sets.Idle.Regen.Liberator = set_combine(sets.Idle.Regen,{
            main="Liberator",
            sub="Bloodrain Strap"})
    sets.Idle.Regen.Liberator.SAM = set_combine(sets.Idle.Regen,{
            main="Liberator",
            sub="Bloodrain Strap"})
    sets.Idle.Regen.Ragnarok = set_combine(sets.Idle.Regen,{
            main="Ragnarok",
            sub="Duplus Grip"})
    sets.Idle.Regen.Ragnarok.SAM = set_combine(sets.Idle.Regen,{
            main="Ragnarok",
            sub="Bloodrain Strap"})
    sets.Idle.Regen.Apocalypse = set_combine(sets.Idle.Regen,{
            main="Apocalypse",
            sub="Duplus Grip"})
    sets.Idle.Regen.Apocalypse.SAM = set_combine(sets.Idle.Regen,{
            main="Apocalypse",
            sub="Bloodrain Strap"})

    -- Movement Sets --
    sets.Idle.Movement = set_combine(sets.Idle.Regen,{
            legs="Blood Cuisses"})
    sets.Idle.Movement.Liberator = set_combine(sets.Idle.Movement,{
            main="Liberator",
            sub="Bloodrain Strap"})
    sets.Idle.Movement.Liberator.SAM = set_combine(sets.Idle.Movement,{
            main="Liberator",
            sub="Bloodrain Strap"})
    sets.Idle.Movement.Ragnarok = set_combine(sets.Idle.Movement,{
            main="Ragnarok",
            sub="Duplus Grip"})
    sets.Idle.Movement.Ragnarok.SAM = set_combine(sets.Idle.Movement,{
            main="Ragnarok",
            sub="Bloodrain Strap"})
    sets.Idle.Movement.Apocalypse = set_combine(sets.Idle.Movement,{
            main="Apocalypse",
            sub="Duplus Grip"})
    sets.Idle.Movement.Apocalypse.SAM = set_combine(sets.Idle.Movement,{
            main="Apocalypse",
            sub="Bloodrain Strap"})

    -- Refresh Sets --
    sets.Idle.Refresh = set_combine(sets.Idle.Regen,{
            head="Wivre Hairpin",
            body="Twilight Mail",
            hands="Ogier's Gauntlets",
            feet="Ogier's Leggings"})
    sets.Idle.Refresh.Liberator = set_combine(sets.Idle.Refresh,{
            main="Liberator",
            sub="Bloodrain Strap"})
    sets.Idle.Refresh.Liberator.SAM = set_combine(sets.Idle.Refresh,{
            main="Liberator",
            sub="Bloodrain Strap"})
    sets.Idle.Refresh.Ragnarok = set_combine(sets.Idle.Refresh,{
            main="Ragnarok",
            sub="Duplus Grip"})
    sets.Idle.Refresh.Ragnarok.SAM = set_combine(sets.Idle.Refresh,{
            main="Ragnarok",
            sub="Bloodrain Strap"})
    sets.Idle.Refresh.Apocalypse = set_combine(sets.Idle.Refresh,{
            main="Apocalypse",
            sub="Duplus Grip"})
    sets.Idle.Refresh.Apocalypse.SAM = set_combine(sets.Idle.Refresh,{
            main="Apocalypse",
            sub="Bloodrain Strap"})

    sets.Twilight = {head="Twilight Helm",body="Twilight Mail"}

    -- TP Base Set --
    sets.TP = {}

    -- Liberator(AM3 Down) TP Sets --
    sets.TP.Liberator = {
            main="Liberator",
            sub="Bloodrain Strap"}
    sets.TP.Liberator.MidACC = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.HighACC = set_combine(sets.TP.Liberator.MidACC,{})

    -- Liberator(AM3 Up) TP Sets --
    sets.TP.Liberator.AM3 = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.AM3 = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.HighACC.AM3 = set_combine(sets.TP.Liberator.MidACC.AM3,{})

    -- Liberator(AM3 Down: High Haste) TP Sets --
    sets.TP.Liberator.HighHaste = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.HighHaste = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.HighACC.HighHaste = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})

    -- Liberator(AM3 Up: High Haste) TP Sets --
    sets.TP.Liberator.AM3.HighHaste = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.MidACC.AM3.HighHaste = set_combine(sets.TP.Liberator.AM3.HighHaste,{})
    sets.TP.Liberator.HighACC.AM3.HighHaste = set_combine(sets.TP.Liberator.MidACC.AM3.HighHaste,{})

    -- Liberator(AM3 Down: Ionis) TP Sets --
    sets.TP.Liberator.Ionis = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.Ionis = set_combine(sets.TP.Liberator.Ionis,{})
    sets.TP.Liberator.HighACC.Ionis = set_combine(sets.TP.Liberator.MidACC.Ionis,{})

    -- Liberator(AM3 Up: Ionis) TP Sets --
    sets.TP.Liberator.AM3.Ionis = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.MidACC.AM3.Ionis = set_combine(sets.TP.Liberator.AM3.Ionis,{})
    sets.TP.Liberator.HighACC.AM3.Ionis = set_combine(sets.TP.Liberator.MidACC.AM3.Ionis,{})

    -- Liberator(AM3 Down: High Haste + Ionis) TP Sets --
    sets.TP.Liberator.HighHaste.Ionis = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.HighHaste.Ionis = set_combine(sets.TP.Liberator.HighHaste.Ionis,{})
    sets.TP.Liberator.HighACC.HighHaste.Ionis = set_combine(sets.TP.Liberator.MidACC.HighHaste.Ionis,{})

    -- Liberator(AM3 Up: High Haste + Ionis) TP Sets --
    sets.TP.Liberator.AM3.HighHaste.Ionis = set_combine(sets.TP.Liberator.AM3.HighHaste,{})
    sets.TP.Liberator.MidACC.AM3.HighHaste.Ionis = set_combine(sets.TP.Liberator.AM3.HighHaste.Ionis,{})
    sets.TP.Liberator.HighACC.AM3.HighHaste.Ionis = set_combine(sets.TP.Liberator.MidACC.AM3.HighHaste.Ionis,{})

    -- Liberator(AM3 Down: SAM Roll) TP Sets --
    sets.TP.Liberator.STP = set_combine(sets.TP.Liberator,{})
    sets.TP.Liberator.MidACC.STP = set_combine(sets.TP.Liberator.MidACC,{})
    sets.TP.Liberator.HighACC.STP = set_combine(sets.TP.Liberator.HighACC,{})

    -- Liberator(AM3 Up: SAM Roll) TP Sets --
    sets.TP.Liberator.AM3.STP = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.MidACC.AM3.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{})
    sets.TP.Liberator.HighACC.AM3.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})

    -- Liberator(AM3 Down: High Haste + SAM Roll) TP Sets --
    sets.TP.Liberator.HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
    sets.TP.Liberator.HighACC.HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})

    -- Liberator(AM3 Up: High Haste + SAM Roll) TP Sets --
    sets.TP.Liberator.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
    sets.TP.Liberator.HighACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})

    -- Liberator(AM3 Down: Ionis + SAM Roll) TP Sets --
    sets.TP.Liberator.Ionis.STP = set_combine(sets.TP.Liberator.Ionis,{})
    sets.TP.Liberator.MidACC.Ionis.STP = set_combine(sets.TP.Liberator.MidACC.Ionis,{})
    sets.TP.Liberator.HighACC.Ionis.STP = set_combine(sets.TP.Liberator.HighACC.Ionis,{})

    -- Liberator(AM3 Up: Ionis + SAM Roll) TP Sets --
    sets.TP.Liberator.AM3.Ionis.STP = set_combine(sets.TP.Liberator.AM3,{})
    sets.TP.Liberator.MidACC.AM3.Ionis.STP = set_combine(sets.TP.Liberator.MidACC.AM3,{})
    sets.TP.Liberator.HighACC.AM3.Ionis.STP = set_combine(sets.TP.Liberator.HighACC.AM3,{})

    -- Liberator(AM3 Down: High Haste + Ionis + SAM Roll) TP Sets --
    sets.TP.Liberator.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
    sets.TP.Liberator.HighACC.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})

    -- Liberator(AM3 Up: High Haste + Ionis + SAM Roll) TP Sets --
    sets.TP.Liberator.AM3.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.HighHaste,{})
    sets.TP.Liberator.MidACC.AM3.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.MidACC.HighHaste,{})
    sets.TP.Liberator.HighACC.AM3.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.HighACC.HighHaste,{})

    -- Ragnarok TP Sets --
    sets.TP.Ragnarok = {
            main="Ragnarok",
            sub="Duplus Grip"}
    sets.TP.Ragnarok.MidACC = set_combine(sets.TP.Ragnarok,{})
    sets.TP.Ragnarok.HighACC = set_combine(sets.TP.Ragnarok.MidACC,{})

    -- Ragnarok(High Haste) TP Sets --
    sets.TP.Ragnarok.HighHaste = set_combine(sets.TP.Ragnarok,{})
    sets.TP.Ragnarok.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.HighHaste,{})
    sets.TP.Ragnarok.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.MidACC.HighHaste,{})

    -- Ragnarok(Ionis) TP Sets --
    sets.TP.Ragnarok.Ionis = set_combine(sets.TP.Ragnarok,{})
    sets.TP.Ragnarok.MidACC.Ionis = set_combine(sets.TP.Ragnarok.Ionis,{})
    sets.TP.Ragnarok.HighACC.Ionis = set_combine(sets.TP.Ragnarok.MidACC.Ionis,{})

    -- Ragnarok(High Haste + Ionis) TP Sets --
    sets.TP.Ragnarok.HighHaste.Ionis = set_combine(sets.TP.Ragnarok.HighHaste,{})
    sets.TP.Ragnarok.MidACC.HighHaste.Ionis = set_combine(sets.TP.Ragnarok.HighHaste.Ionis,{})
    sets.TP.Ragnarok.HighACC.HighHaste.Ionis = set_combine(sets.TP.Ragnarok.MidACC.HighHaste.Ionis,{})

    -- Ragnarok(SAM Roll) TP Sets --
    sets.TP.Ragnarok.STP = set_combine(sets.TP.Ragnarok,{})
    sets.TP.Ragnarok.MidACC.STP = set_combine(sets.TP.Ragnarok.MidACC,{})
    sets.TP.Ragnarok.HighACC.STP = set_combine(sets.TP.Ragnarok.HighACC,{})

    -- Ragnarok(High Haste + SAM Roll) TP Sets --
    sets.TP.Ragnarok.HighHaste.STP = set_combine(sets.TP.Ragnarok.HighHaste,{})
    sets.TP.Ragnarok.MidACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.MidACC.HighHaste,{})
    sets.TP.Ragnarok.HighACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.HighACC.HighHaste,{})

    -- Ragnarok(Ionis + SAM Roll) TP Sets --
    sets.TP.Ragnarok.Ionis.STP = set_combine(sets.TP.Ragnarok.Ionis,{})
    sets.TP.Ragnarok.MidACC.Ionis.STP = set_combine(sets.TP.Ragnarok.MidACC.Ionis,{})
    sets.TP.Ragnarok.HighACC.Ionis.STP = set_combine(sets.TP.Ragnarok.HighACC.Ionis,{})

    -- Ragnarok(High Haste + Ionis + SAM Roll) TP Sets --
    sets.TP.Ragnarok.HighHaste.Ionis.STP = set_combine(sets.TP.Ragnarok.HighHaste,{})
    sets.TP.Ragnarok.MidACC.HighHaste.Ionis.STP = set_combine(sets.TP.Ragnarok.MidACC.HighHaste,{})
    sets.TP.Ragnarok.HighACC.HighHaste.Ionis.STP = set_combine(sets.TP.Ragnarok.HighACC.HighHaste,{})

    -- Apocalypse(AM Down) TP Sets --
    sets.TP.Apocalypse = {
            main="Apocalypse",
            sub="Duplus Grip"}
    sets.TP.Apocalypse.MidACC = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.HighACC = set_combine(sets.TP.Apocalypse.MidACC,{})

    -- Apocalypse(AM Up) TP Sets --
    sets.TP.Apocalypse.AM = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.AM = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.HighACC.AM = set_combine(sets.TP.Apocalypse.MidACC.AM,{})

    -- Apocalypse(AM Down: High Haste) TP Sets --
    sets.TP.Apocalypse.HighHaste = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.HighHaste,{})
    sets.TP.Apocalypse.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.MidACC.HighHaste,{})

    -- Apocalypse(AM Up: High Haste) TP Sets --
    sets.TP.Apocalypse.AM.HighHaste = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.MidACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.AM.HighHaste,{})
    sets.TP.Apocalypse.HighACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.MidACC.AM.HighHaste,{})

    -- Apocalypse(AM Down: Ionis) TP Sets --
    sets.TP.Apocalypse.Ionis = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.Ionis = set_combine(sets.TP.Apocalypse.Ionis,{})
    sets.TP.Apocalypse.HighACC.Ionis = set_combine(sets.TP.Apocalypse.MidACC.Ionis,{})

    -- Apocalypse(AM Up: Ionis) TP Sets --
    sets.TP.Apocalypse.AM.Ionis = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.MidACC.AM.Ionis = set_combine(sets.TP.Apocalypse.AM.Ionis,{})
    sets.TP.Apocalypse.HighACC.AM.Ionis= set_combine(sets.TP.Apocalypse.MidACC.AM.Ionis,{})

    -- Apocalypse(AM Down: High Haste + Ionis) TP Sets --
    sets.TP.Apocalypse.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.HighHaste,{})
    sets.TP.Apocalypse.MidACC.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.HighHaste.Ionis,{})
    sets.TP.Apocalypse.HighACC.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.MidACC.HighHaste.Ionis,{})

    -- Apocalypse(AM Up: High Haste + Ionis) TP Sets --
    sets.TP.Apocalypse.AM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.AM.HighHaste,{})
    sets.TP.Apocalypse.MidACC.AM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.AM.HighHaste.Ionis,{})
    sets.TP.Apocalypse.HighACC.AM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.MidACC.AM.HighHaste.Ionis,{})

    -- Apocalypse(AM Down: SAM Roll) TP Sets --
    sets.TP.Apocalypse.STP = set_combine(sets.TP.Apocalypse,{})
    sets.TP.Apocalypse.MidACC.STP = set_combine(sets.TP.Apocalypse.MidACC,{})
    sets.TP.Apocalypse.HighACC.STP = set_combine(sets.TP.Apocalypse.HighACC,{})

    -- Apocalypse(AM Up: SAM Roll) TP Sets --
    sets.TP.Apocalypse.AM.STP = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.MidACC.AM.STP = set_combine(sets.TP.Apocalypse.MidACC.AM,{})
    sets.TP.Apocalypse.HighACC.AM.STP = set_combine(sets.TP.Apocalypse.HighACC.AM,{})

    -- Apocalypse(AM Down: High Haste + SAM Roll) TP Sets --
    sets.TP.Apocalypse.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighHaste,{})
    sets.TP.Apocalypse.MidACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.MidACC.HighHaste,{})
    sets.TP.Apocalypse.HighACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighACC.HighHaste,{})

    -- Apocalypse(AM Up: High Haste + SAM Roll) TP Sets --
    sets.TP.Apocalypse.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighHaste,{})
    sets.TP.Apocalypse.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.MidACC.HighHaste,{})
    sets.TP.Apocalypse.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.HighACC.HighHaste,{})

    -- Apocalypse(AM Down: Ionis + SAM Roll) TP Sets --
    sets.TP.Apocalypse.Ionis.STP = set_combine(sets.TP.Apocalypse.Ionis,{})
    sets.TP.Apocalypse.MidACC.Ionis.STP = set_combine(sets.TP.Apocalypse.MidACC.Ionis,{})
    sets.TP.Apocalypse.HighACC.Ionis.STP = set_combine(sets.TP.Apocalypse.HighACC.Ionis,{})

    -- Apocalypse(AM Up: Ionis + SAM Roll) TP Sets --
    sets.TP.Apocalypse.AM.Ionis.STP = set_combine(sets.TP.Apocalypse.AM,{})
    sets.TP.Apocalypse.MidACC.AM.Ionis.STP = set_combine(sets.TP.Apocalypse.MidACC.AM,{})
    sets.TP.Apocalypse.HighACC.AM.Ionis.STP = set_combine(sets.TP.Apocalypse.HighACC.AM,{})

    -- Apocalypse(AM Down: High Haste + Ionis + SAM Roll) TP Sets --
    sets.TP.Apocalypse.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.HighHaste,{})
    sets.TP.Apocalypse.MidACC.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.MidACC.HighHaste,{})
    sets.TP.Apocalypse.HighACC.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.HighACC.HighHaste,{})

    -- Apocalypse(AM Up: High Haste + Ionis + SAM Roll) TP Sets --
    sets.TP.Apocalypse.AM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.HighHaste,{})
    sets.TP.Apocalypse.MidACC.AM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.MidACC.HighHaste,{})
    sets.TP.Apocalypse.HighACC.AM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.HighACC.HighHaste,{})

    -- Liberator(AM3 Down) /SAM TP Sets --
    sets.TP.Liberator.SAM = {
            main="Liberator",
            sub="Bloodrain Strap"}
    sets.TP.Liberator.SAM.MidACC = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.HighACC = set_combine(sets.TP.Liberator.SAM.MidACC,{})

    -- Liberator(AM3 Up) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3 = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.MidACC.AM3 = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.HighACC.AM3 = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})

    -- Liberator(AM3 Down: High Haste) /SAM TP Sets --
    sets.TP.Liberator.SAM.HighHaste = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.MidACC.HighHaste = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})

    -- Liberator(AM3 Up: High Haste) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.HighHaste = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.MidACC.AM3.HighHaste = set_combine(sets.TP.Liberator.SAM.AM3.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.AM3.HighHaste = set_combine(sets.TP.Liberator.SAM.MidACC.AM3.HighHaste,{})

    -- Liberator(AM3 Down: Ionis) /SAM TP Sets --
    sets.TP.Liberator.SAM.Ionis = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.MidACC.Ionis = set_combine(sets.TP.Liberator.SAM.Ionis,{})
    sets.TP.Liberator.SAM.HighACC.Ionis = set_combine(sets.TP.Liberator.SAM.MidACC.Ionis,{})

    -- Liberator(AM3 Up: Ionis) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.Ionis = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.MidACC.AM3.Ionis = set_combine(sets.TP.Liberator.SAM.AM3.Ionis,{})
    sets.TP.Liberator.SAM.HighACC.AM3.Ionis = set_combine(sets.TP.Liberator.SAM.MidACC.AM3.Ionis,{})

    -- Liberator(AM3 Down: High Haste + Ionis) /SAM TP Sets --
    sets.TP.Liberator.SAM.HighHaste.Ionis = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.HighHaste.Ionis = set_combine(sets.TP.Liberator.SAM.HighHaste.Ionis,{})
    sets.TP.Liberator.SAM.HighACC.HighHaste.Ionis = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste.Ionis,{})

    -- Liberator(AM3 Up: High Haste + Ionis) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.HighHaste.Ionis = set_combine(sets.TP.Liberator.SAM.AM3.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.AM3.HighHaste.Ionis = set_combine(sets.TP.Liberator.SAM.AM3.HighHaste.Ionis,{})
    sets.TP.Liberator.SAM.HighACC.AM3.HighHaste.Ionis = set_combine(sets.TP.Liberator.SAM.MidACC.AM3.HighHaste.Ionis,{})

    -- Liberator(AM3 Down: SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.STP = set_combine(sets.TP.Liberator.SAM,{})
    sets.TP.Liberator.SAM.MidACC.STP = set_combine(sets.TP.Liberator.SAM.MidACC,{})
    sets.TP.Liberator.SAM.HighACC.STP = set_combine(sets.TP.Liberator.SAM.HighACC,{})

    -- Liberator(AM3 Up: SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.STP = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.MidACC.AM3.STP = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})
    sets.TP.Liberator.SAM.HighACC.AM3.STP = set_combine(sets.TP.Liberator.SAM.HighACC.AM3,{})

    -- Liberator(AM3 Down: High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighACC.HighHaste,{})

    -- Liberator(AM3 Up: High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.AM3.HighHaste.STP = set_combine(sets.TP.Liberator.SAM.HighACC.HighHaste,{})

    -- Liberator(AM3 Down: Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.Ionis.STP = set_combine(sets.TP.Liberator.SAM.Ionis,{})
    sets.TP.Liberator.SAM.MidACC.Ionis.STP = set_combine(sets.TP.Liberator.SAM.MidACC.Ionis,{})
    sets.TP.Liberator.SAM.HighACC.Ionis.STP = set_combine(sets.TP.Liberator.SAM.HighACC.Ionis,{})

    -- Liberator(AM3 Up: Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.Ionis.STP = set_combine(sets.TP.Liberator.SAM.AM3,{})
    sets.TP.Liberator.SAM.MidACC.AM3.Ionis.STP = set_combine(sets.TP.Liberator.SAM.MidACC.AM3,{})
    sets.TP.Liberator.SAM.HighACC.AM3.Ionis.STP = set_combine(sets.TP.Liberator.SAM.HighACC.AM3,{})

    -- Liberator(AM3 Down: High Haste + Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.SAM.HighACC.HighHaste,{})

    -- Liberator(AM3 Up: High Haste + Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Liberator.SAM.AM3.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.SAM.HighHaste,{})
    sets.TP.Liberator.SAM.MidACC.AM3.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.SAM.MidACC.HighHaste,{})
    sets.TP.Liberator.SAM.HighACC.AM3.HighHaste.Ionis.STP = set_combine(sets.TP.Liberator.SAM.HighACC.HighHaste,{})

    -- Ragnarok /SAM TP Sets --
    sets.TP.Ragnarok.SAM = {
            main="Ragnarok",
            sub="Duplus Grip"}
    sets.TP.Ragnarok.SAM.MidACC = set_combine(sets.TP.Ragnarok.SAM,{})
    sets.TP.Ragnarok.SAM.HighACC = set_combine(sets.TP.Ragnarok.SAM.MidACC,{})

    -- Ragnarok(High Haste) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.HighHaste = set_combine(sets.TP.Ragnarok.SAM,{})
    sets.TP.Ragnarok.SAM.MidACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.HighHaste,{})
    sets.TP.Ragnarok.SAM.HighACC.HighHaste = set_combine(sets.TP.Ragnarok.SAM.MidACC.HighHaste,{})

    -- Ragnarok(Ionis) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.Ionis = set_combine(sets.TP.Ragnarok.SAM,{})
    sets.TP.Ragnarok.SAM.MidACC.Ionis = set_combine(sets.TP.Ragnarok.SAM.Ionis,{})
    sets.TP.Ragnarok.SAM.HighACC.Ionis = set_combine(sets.TP.Ragnarok.SAM.MidACC.Ionis,{})

    -- Ragnarok(High Haste + Ionis) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.HighHaste.Ionis = set_combine(sets.TP.Ragnarok.SAM.HighHaste,{})
    sets.TP.Ragnarok.SAM.MidACC.HighHaste.Ionis = set_combine(sets.TP.Ragnarok.SAM.HighHaste.Ionis,{})
    sets.TP.Ragnarok.SAM.HighACC.HighHaste.Ionis = set_combine(sets.TP.Ragnarok.SAM.MidACC.HighHaste.Ionis,{})

    -- Ragnarok(SAM Roll) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.STP = set_combine(sets.TP.Ragnarok.SAM,{})
    sets.TP.Ragnarok.SAM.MidACC.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC,{})
    sets.TP.Ragnarok.SAM.HighACC.STP = set_combine(sets.TP.Ragnarok.SAM.HighACC,{})

    -- Ragnarok(High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.HighHaste,{})
    sets.TP.Ragnarok.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC.HighHaste,{})
    sets.TP.Ragnarok.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Ragnarok.SAM.HighACC.HighHaste,{})

    -- Ragnarok(Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.Ionis.STP = set_combine(sets.TP.Ragnarok.SAM.Ionis,{})
    sets.TP.Ragnarok.SAM.MidACC.Ionis.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC.Ionis,{})
    sets.TP.Ragnarok.SAM.HighACC.Ionis.STP = set_combine(sets.TP.Ragnarok.SAM.HighACC.Ionis,{})

    -- Ragnarok(High Haste + Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Ragnarok.SAM.HighHaste.Ionis.STP = set_combine(sets.TP.Ragnarok.SAM.HighHaste,{})
    sets.TP.Ragnarok.SAM.MidACC.HighHaste.Ionis.STP = set_combine(sets.TP.Ragnarok.SAM.MidACC.HighHaste,{})
    sets.TP.Ragnarok.SAM.HighACC.HighHaste.Ionis.STP = set_combine(sets.TP.Ragnarok.SAM.HighACC.HighHaste,{})

    -- Apocalypse(AM Down) /SAM TP Sets --
    sets.TP.Apocalypse.SAM = {
            main="Apocalypse",
            sub="Duplus Grip"}
    sets.TP.Apocalypse.SAM.MidACC = set_combine(sets.TP.Apocalypse.SAM,{})
    sets.TP.Apocalypse.SAM.HighACC = set_combine(sets.TP.Apocalypse.SAM.MidACC,{})

    -- Apocalypse(AM Up) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM = set_combine(sets.TP.Apocalypse.SAM,{})
    sets.TP.Apocalypse.SAM.MidACC.AM = set_combine(sets.TP.Apocalypse.SAM.AM,{})
    sets.TP.Apocalypse.SAM.HighACC.AM = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM,{})

    -- Apocalypse(AM Down: High Haste) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.HighHaste = set_combine(sets.TP.Apocalypse.SAM,{})
    sets.TP.Apocalypse.SAM.MidACC.HighHaste = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{})
    sets.TP.Apocalypse.SAM.HighACC.HighHaste = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste,{})

    -- Apocalypse(AM Up: High Haste) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.HighHaste = set_combine(sets.TP.Apocalypse.SAM.AM,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.SAM.AM.HighHaste,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.HighHaste = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste,{})

    -- Apocalypse(AM Down: Ionis) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.Ionis = set_combine(sets.TP.Apocalypse.SAM,{})
    sets.TP.Apocalypse.SAM.MidACC.Ionis = set_combine(sets.TP.Apocalypse.SAM.Ionis,{})
    sets.TP.Apocalypse.SAM.HighACC.Ionis = set_combine(sets.TP.Apocalypse.SAM.MidACC.Ionis,{})

    -- Apocalypse(AM Up: Ionis) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.Ionis = set_combine(sets.TP.Apocalypse.SAM.AM,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.Ionis = set_combine(sets.TP.Apocalypse.SAM.AM.Ionis,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.Ionis = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM.Ionis,{})

    -- Apocalypse(AM Down: High Haste + Ionis) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{})
    sets.TP.Apocalypse.SAM.MidACC.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.SAM.HighHaste.Ionis,{})
    sets.TP.Apocalypse.SAM.HighACC.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste.Ionis,{})

    -- Apocalypse(AM Up: High Haste + Ionis) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.SAM.AM.HighHaste,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.SAM.AM.HighHaste.Ionis,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.HighHaste.Ionis = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste.Ionis,{})

    -- Apocalypse(AM Down: SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.STP = set_combine(sets.TP.Apocalypse.SAM,{})
    sets.TP.Apocalypse.SAM.MidACC.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC,{})
    sets.TP.Apocalypse.SAM.HighACC.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC,{})

    -- Apocalypse(AM Up: SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.STP = set_combine(sets.TP.Apocalypse.SAM.AM,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.AM,{})

    -- Apocalypse(AM Down: High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{})
    sets.TP.Apocalypse.SAM.MidACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste,{})
    sets.TP.Apocalypse.SAM.HighACC.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.HighHaste,{})

    -- Apocalypse(AM Up: High Haste + SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.HighHaste.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.HighHaste,{})

    -- Apocalypse(AM Down: Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.Ionis,{})
    sets.TP.Apocalypse.SAM.MidACC.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.Ionis,{})
    sets.TP.Apocalypse.SAM.HighACC.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.Ionis,{})

    -- Apocalypse(AM Up: Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.AM,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.AM,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.AM,{})

    -- Apocalypse(AM Down: High Haste + Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{})
    sets.TP.Apocalypse.SAM.MidACC.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste,{})
    sets.TP.Apocalypse.SAM.HighACC.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.HighHaste,{})

    -- Apocalypse(AM Up: High Haste + Ionis + SAM Roll) /SAM TP Sets --
    sets.TP.Apocalypse.SAM.AM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.HighHaste,{})
    sets.TP.Apocalypse.SAM.MidACC.AM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.MidACC.HighHaste,{})
    sets.TP.Apocalypse.SAM.HighACC.AM.HighHaste.Ionis.STP = set_combine(sets.TP.Apocalypse.SAM.HighACC.HighHaste,{})

    -- AM3 Rancor ON Mantle --
    sets.TP.Rancor = {back="Rancorous Mantle"}

    -- PDT/MDT Sets --
    sets.PDT = {}

    sets.MDT = set_combine(sets.PDT,{})

    -- Hybrid Set --
    sets.TP.Hybrid = set_combine(sets.PDT,{})
    sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
    sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

    -- WS Base Set --
    sets.WS = {}

    -- Resolution Sets --
    sets.WS.Resolution = {}
    sets.WS.Resolution.MidACC = set_combine(sets.WS.Resolution,{})
    sets.WS.Resolution.HighACC = set_combine(sets.WS.Resolution.MidACC,{})

    -- Resolution(Attack) Set --
    sets.WS.Resolution.ATT = set_combine(sets.WS.Resolution,{})

    -- Catastrophe Sets --
    sets.WS.Catastrophe = {}
    sets.WS.Catastrophe.MidACC = set_combine(sets.WS.Catastrophe,{})
    sets.WS.Catastrophe.HighACC = set_combine(sets.WS.Catastrophe.MidACC,{})

    -- Catastrophe(Attack) Set --
    sets.WS.Catastrophe.ATT = set_combine(sets.WS.Catastrophe,{})

    -- Entropy Sets --
    sets.WS.Entropy = {}
    sets.WS.Entropy.MidACC = set_combine(sets.WS.Entropy,{})
    sets.WS.Entropy.HighACC = set_combine(sets.WS.Entropy.MidACC,{})

    -- Entropy(Attack) Set --
    sets.WS.Entropy.ATT = set_combine(sets.WS.Entropy,{})

    -- Insurgency Sets --
    sets.WS.Insurgency = {}
    sets.WS.Insurgency.MidACC = set_combine(sets.WS.Insurgency,{})
    sets.WS.Insurgency.HighACC = set_combine(sets.WS.Insurgency.MidACC,{})

    -- JA Sets --
    sets.JA = {}
    sets.JA["Blood Weapon"] = {body="Fallen's Cuirass"}
    sets.JA["Diabolic Eye"] = {hands="Fall. Fin. Gaunt. +1"}
    sets.JA["Nether Void"] = {legs="Heath. Flanchard +1"}
    sets.JA["Arcane Circle"] = {feet="Igno. Sollerets +1"}
    sets.JA["Last Resort"] = {feet="Fall. Sollerets +1"}

    -- Waltz Set --
    sets.Waltz = {}

    sets.Precast = {}
    -- Fastcast Set --
    sets.Precast.FastCast = {}

    -- Precast Dark Magic --
    sets.Precast['Dark Magic'] = set_combine(sets.Precast.FastCast,{head="Fall. Burgeonet +1"})

    -- Midcast Base Set --
    sets.Midcast = {}

    -- Magic Haste Set --
    sets.Midcast.Haste = set_combine(sets.PDT,{})

    -- Dark Magic Set --
    sets.Midcast['Dark Magic'] = {}

    -- Stun Sets --
    sets.Midcast.Stun = set_combine(sets.Midcast['Dark Magic'],{})
    sets.Midcast.Stun.MidACC = set_combine(sets.Midcast.Stun,{})
    sets.Midcast.Stun.HighACC = set_combine(sets.Midcast.Stun.MidACC,{})

    -- Endark Set --
    sets.Midcast.Endark = set_combine(sets.Midcast['Dark Magic'],{})

    -- Enfeebling Magic Set --
    sets.Midcast['Enfeebling Magic'] = {body="Igno. Cuirass +1"}

    -- Elemental Magic Set --
    sets.Midcast['Elemental Magic'] = {}

    -- Dread Spikes Set --
    sets.Midcast['Dread Spikes'] = {}
end

function pretarget(spell,action)
    if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    elseif spell.english == "Berserk" and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
        cancel_spell()
        send_command('Aggressor')
    elseif spell.english == "Seigan" and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
        cancel_spell()
        send_command('ThirdEye')
    elseif spell.english == "Meditate" and player.tp > 2900 then -- Cancel Meditate If TP Is Above 2900 --
        cancel_spell()
        add_to_chat(123, spell.name .. ' Canceled: ['..player.tp..' TP]')
    elseif spell.type == "WeaponSkill" and spell.target.distance > target_distance and player.status == 'Engaged' then -- Cancel WS If You Are Out Of Range --
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        return
    elseif buffactive['Light Arts'] or buffactive['Addendum: White'] then
        if spell.english == "Light Arts" and not buffactive['Addendum: White'] then
            cancel_spell()
            send_command('input /ja Addendum: White <me>')
        elseif spell.english == "Manifestation" then
            cancel_spell()
            send_command('input /ja Accession <me>')
        elseif spell.english == "Alacrity" then
            cancel_spell()
            send_command('input /ja Celerity <me>')
        elseif spell.english == "Parsimony" then
            cancel_spell()
            send_command('input /ja Penury <me>')
        end
    elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
        if spell.english == "Dark Arts" and not buffactive['Addendum: Black'] then
            cancel_spell()
            send_command('input /ja Addendum: Black <me>')
        elseif spell.english == "Accession" then
            cancel_spell()
            send_command('input /ja Manifestation <me>')
        elseif spell.english == "Celerity" then
            cancel_spell()
            send_command('input /ja Alacrity <me>')
        elseif spell.english == "Penury" then
            cancel_spell()
            send_command('input /ja Parsimony <me>')
        end
    end
end

function precast(spell,action)
    if spell.type == "WeaponSkill" then
        if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
            cancel_spell()
            add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
            return
        else
            equipSet = sets.WS
            if equipSet[spell.english] then
                equipSet = equipSet[spell.english]
            end
            if Attack == 'ON' then
                equipSet = equipSet["ATT"]
            end
            if equipSet[AccArray[AccIndex]] then
                equipSet = equipSet[AccArray[AccIndex]]
            end
            if elements[spell.name] and elements[spell.name]:contains(world.day_element) then
                equipSet = set_combine(equipSet,elements.equip)
            end
            if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
                equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
            end
            if (spell.english == "Entropy" or spell.english == "Resolution" or spell.english == "Insurgency") and (player.tp > 2990 or buffactive.Sekkanoki) then
                if world.time <= (7*60) or world.time >= (17*60) then -- 3000 TP or Sekkanoki: Equip Lugra Earring +1 From Dusk To Dawn --
                    equipSet = set_combine(equipSet,{ear1="Lugra Earring +1"})
                else
                    equipSet = set_combine(equipSet,{ear1="Bale Earring"}) -- 3000 TP or Sekkanoki: Equip Kokou's Earring --
                end
            end
            equip(equipSet)
        end
    elseif spell.type == "JobAbility" then
        if sets.JA[spell.english] then
            equip(sets.JA[spell.english])
        end
        if spell.english == "Scarlet Delirium" then
            send_command('cancel Stoneskin')
            cast_delay(0.2)
        end
    elseif spell.action_type == 'Magic' then
        if buffactive.silence or spell.target.distance > 16+target_distance then -- Cancel Magic or Ninjutsu If You Are Silenced or Out of Range --
            cancel_spell()
            add_to_chat(123, spell.name..' Canceled: [Silenced or Out of Casting Range]')
            return
        else
            if spell.english == "Stun" then
                if buffactive.Hasso or buffactive.Seigan then -- Cancel Hasso or Seigan When You Use Stun --
                    cast_delay(0.2)
                    send_command('cancel Hasso,Seigan')
                end
                equip(sets.Precast.FastCast)
            elseif spell.english == 'Utsusemi: Ni' then
                if buffactive['Copy Image (3)'] then
                    cancel_spell()
                    add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
                    return
                else
                    equip(sets.Precast.FastCast)
                end
            elseif sets.Precast[spell.skill] then
                equip(sets.Precast[spell.skill])
            else
                equip(sets.Precast.FastCast)
            end
        end
    elseif spell.type == "Waltz" then
        refine_waltz(spell,action)
        equip(sets.Waltz)
    elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
        cast_delay(0.2)
        send_command('cancel Sneak')
    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end

function midcast(spell,action)
    equipSet = {}
    if spell.action_type == 'Magic' then
        equipSet = sets.Midcast
        if spell.english:startswith('Absorb') then
            if buffactive["Dark Seal"] then -- Equip Aug'd Fall. Burgeonet +1 When You Have Dark Seal Up --
                equipSet = set_combine(equipSet,{head="Fall. Burgeonet +1"})
            end
        elseif spell.english:startswith('Drain') or spell.english:startswith('Aspir') or spell.english:startswith('Bio') then
            if world.day == "Darksday" or world.weather_element == "Dark" then -- Equip Hachirin-no-Obi On Darksday or Dark Weather --
                equipSet = set_combine(equipSet,{waist="Hachirin-no-Obi"})
            end
        elseif spell.english == "Stoneskin" then
            if buffactive.Stoneskin then
                send_command('@wait 1.7;cancel stoneskin')
            end
            equipSet = equipSet.Stoneskin
        elseif spell.english == "Sneak" then
            if spell.target.name == player.name and buffactive['Sneak'] then
                send_command('cancel sneak')
            end
            equipSet = equipSet.Haste
        elseif spell.english:startswith('Utsusemi') then
            if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
                send_command('@wait 1.7;cancel Copy Image*')
            end
            equipSet = equipSet.Haste
        elseif spell.english == 'Monomi: Ichi' then
            if buffactive['Sneak'] then
                send_command('@wait 1.7;cancel sneak')
            end
            equipSet = equipSet.Haste
        else
            if equipSet[spell.english] then
                equipSet = equipSet[spell.english]
            end
            if equipSet[AccArray[AccIndex]] then
                equipSet = equipSet[AccArray[AccIndex]]
            end
            if equipSet[spell.skill] then
                equipSet = equipSet[spell.skill]
            end
            if equipSet[spell.type] then
                equipSet = equipSet[spell.type]
            end
        end
    elseif equipSet[spell.english] then
        equipSet = equipSet[spell.english]
    end
    equip(equipSet)
end

function aftercast(spell,action)
    if not spell.interrupted then
        if spell.type == "WeaponSkill" then
            send_command('wait 0.2;gs c TP')
        elseif spell.english == "Arcane Circle" then -- Arcane Circle Countdown --
            send_command('wait 260;input /echo '..spell.name..': [WEARING OFF IN 10 SEC.];wait 10;input /echo '..spell.name..': [OFF]')
        elseif spell.english == "Sleep II" then -- Sleep II Countdown --
            send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Sleep" then -- Sleep Countdown --
            send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        end
    end
    status_change(player.status)
end

function status_change(new,old)
    check_equip_lock()
    if Armor == 'PDT' then
        equip(sets.PDT)
    elseif Armor == 'MDT' then
        equip(sets.MDT)
    elseif new == 'Engaged' then
        equipSet = sets.TP
        if Armor == 'Hybrid' and equipSet["Hybrid"] then
            equipSet = equipSet["Hybrid"]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[player.sub_job] then
            equipSet = equipSet[player.sub_job]
        end
        if equipSet[AccArray[AccIndex]] then
            equipSet = equipSet[AccArray[AccIndex]]
        end
        if buffactive["Aftermath: Lv.3"] and equipSet["AM3"] then
            if Rancor == 'ON' then -- Default Rancor Toggle Is Rancorous Mantle --
                equipSet = set_combine(equipSet["AM3"],sets.TP.Rancor)
            else -- Use Rancor Toggle For Atheling Mantle --
                equipSet = equipSet["AM3"]
            end
        end
        if buffactive.Aftermath and equipSet["AM"] then
            equipSet = equipSet["AM"]
        end
        if buffactive["Last Resort"] and ((buffactive.Haste and buffactive.March == 2) or (buffactive.Embrava and (buffactive.March == 2 or (buffactive.March and buffactive.Haste))) or (buffactive[580] and (buffactive.March or buffactive.Haste or buffactive.Embrava))) and equipSet["HighHaste"] then
            equipSet = equipSet["HighHaste"]
        end
        if buffactive.Ionis and equipSet["Ionis"] then
            equipSet = equipSet["Ionis"]
        end
        if buffactive["Samurai Roll"] and equipSet["STP"] and Samurai_Roll == 'ON' then
            equipSet = equipSet["STP"]
        end
        equip(equipSet)
    else
        equipSet = sets.Idle
        if equipSet[IdleArray[IdleIndex]] then
            equipSet = equipSet[IdleArray[IdleIndex]]
        end
        if equipSet[WeaponArray[WeaponIndex]] then
            equipSet = equipSet[WeaponArray[WeaponIndex]]
        end
        if equipSet[player.sub_job] then
            equipSet = equipSet[player.sub_job]
        end
        if buffactive['Reive Mark'] then -- Equip Ygnas's Resolve +1 During Reive --
            equipSet = set_combine(equipSet,{neck="Ygnas's Resolve +1"})
        end
        if world.area:endswith('Adoulin') then
            equipSet = set_combine(equipSet,{body="Councilor's Garb"})
        end
        equip(equipSet)
    end
    if Twilight == 'Twilight' then
        equip(sets.Twilight)
    end
end

function buff_change(buff,gain)
    buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
        if gain then
            send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123,'AM3: [OFF]')
        end
    elseif buff == 'weakness' then -- Weakness Timer --
        if gain then
            send_command('timers create "Weakness" 300 up')
        else
            send_command('timers delete "Weakness"')
        end
    end
    if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then -- Equip Berserker's Torque When You Are Asleep & Have 200+ HP --
        equip({neck="Berserker's Torque"})
    else
        if not midaction() then
            status_change(player.status)
        end
    end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
    if command == 'C1' then -- Accuracy Level Toggle --
        AccIndex = (AccIndex % #AccArray) + 1
        status_change(player.status)
        add_to_chat(158,'Accuracy Level: '..AccArray[AccIndex])
    elseif command == 'C17' then -- Main Weapon Toggle --
        WeaponIndex = (WeaponIndex % #WeaponArray) + 1
        add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
        status_change(player.status)
    elseif command == 'C5' then -- Auto Update Gear Toggle --
        status_change(player.status)
        add_to_chat(158,'Auto Update Gear')
    elseif command == 'C2' then -- Hybrid Toggle --
        if Armor == 'Hybrid' then
            Armor = 'None'
            add_to_chat(123,'Hybrid Set: [Unlocked]')
        else
            Armor = 'Hybrid'
            add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
        end
        status_change(player.status)
    elseif command == 'C7' then -- PDT Toggle --
        if Armor == 'PDT' then
            Armor = 'None'
            add_to_chat(123,'PDT Set: [Unlocked]')
        else
            Armor = 'PDT'
            add_to_chat(158,'PDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C15' then -- MDT Toggle --
        if Armor == 'MDT' then
            Armor = 'None'
            add_to_chat(123,'MDT Set: [Unlocked]')
        else
            Armor = 'MDT'
            add_to_chat(158,'MDT Set: [Locked]')
        end
        status_change(player.status)
    elseif command == 'C16' then -- Rancor Toggle --
        if Rancor == 'ON' then
            Rancor = 'OFF'
            add_to_chat(123,'Rancor: [OFF]')
        else
            Rancor = 'ON'
            add_to_chat(158,'Rancor: [ON]')
        end
        status_change(player.status)
    elseif command == 'C9' then -- Attack Toggle --
        if Attack == 'ON' then
            Attack = 'OFF'
            add_to_chat(123,'Attack: [OFF]')
        else
            Attack = 'ON'
            add_to_chat(158,'Attack: [ON]')
        end
        status_change(player.status)
    elseif command == 'C3' then -- Twilight Toggle --
        if Twilight == 'Twilight' then
            Twilight = 'None'
            add_to_chat(123,'Twilight Set: [Unlocked]')
        else
            Twilight = 'Twilight'
            add_to_chat(158,'Twilight Set: [locked]')
        end
        status_change(player.status)
    elseif command == 'C8' then -- Distance Toggle --
        if player.target.distance then
            target_distance = math.floor(player.target.distance*10)/10
            add_to_chat(158,'Distance: '..target_distance)
        else
            add_to_chat(123,'No Target Selected')
        end
    elseif command == 'C6' then -- Idle Toggle --
        IdleIndex = (IdleIndex % #IdleArray) + 1
        status_change(player.status)
        add_to_chat(158,'Idle Set: '..IdleArray[IdleIndex])
    elseif command == 'TP' then
        add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
    elseif command:match('^SC%d$') then
        send_command('//' .. sc_map[command])
    end
end

function check_equip_lock() -- Lock Equipment Here --
    if player.equipment.left_ring == "Warp Ring" or player.equipment.left_ring == "Capacity Ring" or player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Capacity Ring" then
        disable('ring1','ring2')
    elseif player.equipment.back == "Mecisto. Mantle" or player.equipment.back == "Aptitude Mantle +1" or player.equipment.back == "Aptitude Mantle" then
        disable('back')
    else
        enable('ring1','ring2','back')
    end
end

function refine_waltz(spell,action)
    if spell.type ~= 'Waltz' then
        return
    end

    if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" then
        return
    end

    local newWaltz = spell.english
    local waltzID

    local missingHP

    if spell.target.type == "SELF" then
        missingHP = player.max_hp - player.hp
    elseif spell.target.isallymember then
        local target = find_player_in_alliance(spell.target.name)
        local est_max_hp = target.hp / (target.hpp/100)
        missingHP = math.floor(est_max_hp - target.hp)
    end

    if missingHP ~= nil then
        if player.sub_job == 'DNC' then
            if missingHP < 40 and spell.target.name == player.name then
                add_to_chat(123,'Full HP!')
                cancel_spell()
                return
            elseif missingHP < 150 then
                newWaltz = 'Curing Waltz'
                waltzID = 190
            elseif missingHP < 300 then
                newWaltz = 'Curing Waltz II'
                waltzID = 191
            else
                newWaltz = 'Curing Waltz III'
                waltzID = 192
            end
        else
            return
        end
    end

    local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50}
    local tpCost = waltzTPCost[newWaltz]

    local downgrade

    if player.tp < tpCost then

        if player.tp < 20 then
            add_to_chat(123, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
            cancel_spell()
            return
        elseif player.tp < 35 then
            newWaltz = 'Curing Waltz'
        elseif player.tp < 50 then
            newWaltz = 'Curing Waltz II'
        end

        downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
    end

    if newWaltz ~= spell.english then
        send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
        if downgrade then
            add_to_chat(8, downgrade)
        end
        cancel_spell()
        return
    end

    if missingHP > 0 then
        add_to_chat(8,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
    end
end

function find_player_in_alliance(name)
    for i,v in ipairs(alliance) do
        for k,p in ipairs(v) do
            if p.name == name then
                return p
            end
        end
    end
end

function sub_job_change(newSubjob, oldSubjob)
    select_default_macro_book()
end

function set_macro_page(set,book)
    if not tonumber(set) then
        add_to_chat(123,'Error setting macro page: Set is not a valid number ('..tostring(set)..').')
        return
    end
    if set < 1 or set > 10 then
        add_to_chat(123,'Error setting macro page: Macro set ('..tostring(set)..') must be between 1 and 10.')
        return
    end

    if book then
        if not tonumber(book) then
            add_to_chat(123,'Error setting macro page: book is not a valid number ('..tostring(book)..').')
            return
        end
        if book < 1 or book > 20 then
            add_to_chat(123,'Error setting macro page: Macro book ('..tostring(book)..') must be between 1 and 20.')
            return
        end
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(set))
    else
        send_command('@input /macro set '..tostring(set))
    end
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 6)
    elseif player.sub_job == 'DNC' then
        set_macro_page(9, 6)
    elseif player.sub_job == 'SCH' then
        set_macro_page(8, 6)
    else
        set_macro_page(2, 6)
    end
end