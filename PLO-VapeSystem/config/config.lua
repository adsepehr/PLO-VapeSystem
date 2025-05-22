-- Written by Negative | @ngtive
Config = {}

-- Main Config
Config.Command = { CommandName = "vape", Start = "start", Stop = "stop" }
Config.SharedObject = 'esx:getSharedObject'

-- Vape Config
Config.TakeAHitButton = 51 -- Dokme Kam Gereftan Ba Vape
Config.StopVapeButton = 182 -- Dokme Stop Kardan Vape
Config.SmokeSize = 0.5 -- Size Dood Ijad Shode Az Vape
Config.FailureOdds = 10594 -- Shans Sokhtan Va Terekidan Vape (10594 = 0.0001%)
Config.VapeCoolDownTime = 4000 -- Cooldown Baraye Estefade Az Vape
Config.VapeHangTime = 2800 -- Modate Baghi Mondane Dood Haye Ijad Shode Az Vape

-- Item Config
Config.UseWithItem = false -- Baraye Keshidan Vape Item Lazem Bashe? Note : Agar In Option Ro true Kardid VapePermission Ro false Konid
Config.ItemName = 'vape' -- Esme Item e Morede Nazar

-- Permission Config
Config.VapePermission = true -- Estefade Az Vape Premission Bekhad? Note : Agar In Option Ro true Kardid UseWithItem Ro false Konid
Config.PermissionsGroup = "vip" -- Group E Mojaz Baraye Estefade Az Vape
Config.ErrorPermissionMissing = "Shoma VIP Nistid" -- Error Baraye Nadashtan Dastresi

-- Vape Texts Config
Config.HitVape = "~g~E~w~ Baraye Kam Gereftan" -- Payam Bala Sare Player Baraye Kam Gereftan
Config.CancelVape = "~r~L~wc~ Baraye Cancel Kardan" -- Payam Bala Sare Player Baraye Cancel Kardan
Config.VapeDrawTextScaleAboveHead = 0.32 --  Size Payam Bala Sare Player

-- Notifications Config
Config.StartVape = "~w~Shoma Vape Khod Ra ~g~Estefade ~w~Kardid"
Config.StopVape = "~w~Shoma Vape Khod Ra ~r~Motevaghef ~w~Kardid"
Config.AlreadyUsing = "~r~Darhale Hazer Vape Dar Dast Shomast"
Config.ErrorVehicle = "~r~Vape Dar Mashin Ghabele Estefade Nist"
Config.ErrorDead = "~r~Shoma Hengame Marg Az Vape Nemitonid Estefade Konid"

-- Vape Sounds Config
Config.Sound = "TIMER_STOP"
Config.DictionaryForTheSound = "HUD_MINI_GAME_SOUNDSET"

-- Vape Particle & Objects Config
Config.SmokeParticle = "exp_grd_bzgas_smoke" -- Item E Vape
Config.SmokeLocationBone = {20279} -- Makan Gharar Gereftan Item Vape Dar Badane Player (Ro Dast Set Shode)
-- Written by Negative | @ngtive