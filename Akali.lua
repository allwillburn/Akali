local ver = "0.01"


if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end


if GetObjectName(GetMyHero()) ~= "Akali" then return end


require("DamageLib")
require("OpenPredict")

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat('<font color = "#00FFFF">New version found! ' .. data)
        PrintChat('<font color = "#00FFFF">Downloading update, please wait...')
        DownloadFileAsync('https://raw.githubusercontent.com/allwillburn/Akali/master/Akali.lua', SCRIPT_PATH .. 'Akali.lua', function() PrintChat('<font color = "#00FFFF">Update Complete, please 2x F6!') return end)
    else
        PrintChat('<font color = "#00FFFF">No updates found!')
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/allwillburn/Akali/master/Akali.version", AutoUpdate)


GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local AkaliMenu = Menu("Akali", "Akali")

AkaliMenu:SubMenu("Combo", "Combo")
AkaliMenu.Combo:Boolean("Q", "Use Q in combo", true)
AkaliMenu.Combo:Boolean("W", "Use W in combo", true)
AkaliMenu.Combo:Boolean("E", "Use E in combo", true)
AkaliMenu.Combo:Boolean("R", "Use R in combo", true)
AkaliMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
AkaliMenu.Combo:Boolean("Cutlass", "Use Cutlass", true)
AkaliMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
AkaliMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)
AkaliMenu.Combo:Boolean("RHydra", "Use RHydra", true)
AkaliMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
AkaliMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)
AkaliMenu.Combo:Boolean("Randuins", "Use Randuins", true)


AkaliMenu:SubMenu("AutoMode", "AutoMode")
AkaliMenu.AutoMode:Boolean("Level", "Auto level spells", false)
AkaliMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
AkaliMenu.AutoMode:Boolean("Q", "Auto Q", false)
AkaliMenu.AutoMode:Boolean("W", "Auto W", false)
AkaliMenu.AutoMode:Boolean("E", "Auto E", false)
AkaliMenu.AutoMode:Boolean("R", "Auto R", false)

AkaliMenu:SubMenu("AutoFarm", "AutoFarm")
AkaliMenu.AutoFarm:Boolean("Q", "Auto Q", false)
AkaliMenu.AutoFarm:Boolean("E", "Auto E", false)



AkaliMenu:SubMenu("LaneClear", "LaneClear")
AkaliMenu.LaneClear:Boolean("Q", "Use Q", true)
AkaliMenu.LaneClear:Boolean("E", "Use E", true)
AkaliMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
AkaliMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)


AkaliMenu:SubMenu("Harass", "Harass")
AkaliMenu.Harass:Boolean("Q", "Use Q", true)
AkaliMenu.Harass:Boolean("W", "Use W", true)


AkaliMenu:SubMenu("KillSteal", "KillSteal")
AkaliMenu.KillSteal:Boolean("Q", "KS w Q", true)
AkaliMenu.KillSteal:Boolean("E", "KS w E", true)
AkaliMenu.KillSteal:Boolean("R", "KS w R", true)



AkaliMenu:SubMenu("AutoIgnite", "AutoIgnite")
AkaliMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)


AkaliMenu:SubMenu("Drawings", "Drawings")
AkaliMenu.Drawings:Boolean("DQ", "Draw Q Range", true)


AkaliMenu:SubMenu("SkinChanger", "SkinChanger")
AkaliMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
AkaliMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)
	
        
		
		

	--AUTO LEVEL UP
	if AkaliMenu.AutoMode.Level:Value() then

			spellorder = {_E, _W, _Q, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
          if Mix:Mode() == "Harass" then
            if AkaliMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
				if target ~= nil then 
                                      CastTargetSpell(target, _Q)
                                end
            end

            if AkaliMenu.Harass.W:Value() and Ready(_W) and ValidTarget(target, 600) then
				CastSkillShot(_W, target.pos) 
            end     
          end

	--COMBO
	  if Mix:Mode() == "Combo" then
            if AkaliMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
            end

            if AkaliMenu.Combo.Randuins:Value() and Randuins > 0 and Ready(Randuins) and ValidTarget(target, 500) then
			CastSpell(Randuins)
            end

            if AkaliMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 550) then
			 CastTargetSpell(target, BOTRK)
            end

            if AkaliMenu.Combo.Cutlass:Value() and Cutlass > 0 and Ready(Cutlass) and ValidTarget(target, 700) then
			 CastTargetSpell(target, Cutlass)
            end

            if AkaliMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 300) then
			 CastSpell(_E)
	    end

            if AkaliMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
                                            CastTargetSpell(target, _Q)
                 
            end	

            if AkaliMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if AkaliMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 700) then
			CastTargetSpell(target, Gunblade)
            end

            if AkaliMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if AkaliMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 270) then
			CastSkillShot(_W, target.pos) 
	    end
	    
	    
            if AkaliMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 700) then             
                CastTargetSpell(target, _R)
            end	

          end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if AkaliMenu.KillSteal.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
                                            CastTargetSpell(target, _Q)
                    
                end	


                if IsReady(_E) and ValidTarget(enemy, 300) and AkaliMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSpell(_E)
                end
			
		if AkaliMenu.KillSteal.R:Value() and Ready(_R) and ValidTarget(target, 700) then                
                           CastTargetSpell(target, _R)
                  
                end	
      end




      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if AkaliMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 900) then
	        	CastTargetSpell(closeminion, _Q)
                end

                
                if AkaliMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 300) then
	        	CastSpell(_E)
	        end

                if AkaliMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if AkaliMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          end
      end





       --Auto on minions
          for _, minion in pairs(minionManager.objects) do
      			
      			   	
              if AkaliMenu.AutoFarm.Q:Value() and Ready(_Q) and ValidTarget(minion, 600) and GetCurrentHP(minion) < CalcDamage(myHero,minion,QDmg,Q) then
                  CastTargetSpell(minion, _Q)
              end

              
              if AkaliMenu.AutoFarm.E:Value() and Ready(_E) and ValidTarget(minion, 300) and GetCurrentHP(minion) < CalcDamage(myHero,minion,EDmg,E) then
                  CastSpell(_E)
              end
		
	      
			
          end



        --AutoMode
        if AkaliMenu.AutoMode.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
                                            CastTargetSpell(target, _Q)
                 
        end	

        if AkaliMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, 270) then
	  	      CastSkillShot(_W, target.pos) 
          end
        end
        if AkaliMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget(target, 300) then
		      CastSpell(_E)
	  end
        end
        if AkaliMenu.AutoMode.R:Value() and Ready(_R) and ValidTarget(target, 700) then                
                 CastTargetSpell(target, _R)
            end	
                
	--AUTO GHOST
	if AkaliMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnDraw(function (myHero)
        
         if AkaliMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), 600, 0, 200, GoS.Red)
	end

end)


OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()        
       
        if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		Mix:ResetAA()
	end	
               
        if unit.isMe and spell.name:lower():find("itemravenoushydracrescent") then
		Mix:ResetAA()
	end

end) 


local function SkinChanger()
	if AkaliMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Akali</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')





