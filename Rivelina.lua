if myHero.charName~="Riven"then return end local a=.52 local t=true local e="Rivelina"local l="https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua"local n=LIB_PATH.."SourceLib.lua"if FileExist(n)then require("SourceLib")else DOWNLOADING_SOURCELIB=true DownloadFile(l,n,function()print("Required libraries downloaded successfully, please reload")end)end if DOWNLOADING_SOURCELIB then print("Downloading required libraries, please wait...")return end if t then SourceUpdater(e,a,"raw.github.com","/gmlyra/BolScripts/master/"..e..".lua",SCRIPT_PATH..GetCurrentEnv().FILE_NAME,"/gmlyra/VersionFiles/master/"..e..".version"):CheckUpdate()end local e=Require("SourceLib")e:Add("vPrediction","https://raw.github.com/Hellsing/BoL/master/common/VPrediction.lua")e:Add("SOW","https://raw.github.com/Hellsing/BoL/master/common/SOW.lua")e:Check()if e.downloadNeeded==true then return end require'VPrediction'require'SOW'local e,e,e,e=false,false,false,false local r,g=nil,nil local t local n=nil local v,E,b,T=0,0,0,0 local R={1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}local e={Q=260+100,W=250,E=325,R=880,AA=250}local M={[1]=function()myHero:MoveTo(mousePos.x,mousePos.z)end,[2]=function()SendChat('/l')end,[3]=function()SendChat('/d')end,[4]=function()SendChat('/t')end,[5]=function()SendChat('/j')end,[6]=function()end,}local a,l,d,i=false,false,false,false local m,S,o,s,C,u,c,f=nil,nil,nil,nil,nil,nil,nil,nil local h,y,I,P,_,f,A,H=false,false,false,false,false,false,false,false function OnLoad()initComponents()end function initComponents()n=VPrediction()Orbwalker=SOW(n)t=TargetSelector(TARGET_NEAR_MOUSE,900)Menu=scriptConfig("Rivelina by Lillgoalie & Mr Articuno","RivenBLMA")Menu:addSubMenu("["..myHero.charName.." - Orbwalker]","SOWorb")Orbwalker:LoadToMenu(Menu.SOWorb)Menu:addSubMenu("["..myHero.charName.." - Combo]","RivenCombo")Menu.RivenCombo:addParam("combo","Combo mode",SCRIPT_PARAM_ONKEYDOWN,false,32)Menu.RivenCombo:addSubMenu("Q Settings","qSet")Menu.RivenCombo.qSet:addParam("useQ","Use Q in combo",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo:addSubMenu("W Settings","wSet")Menu.RivenCombo.wSet:addParam("useW","Use W in combo",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo:addSubMenu("E Settings","eSet")Menu.RivenCombo.eSet:addParam("useE","Use E in combo",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo:addSubMenu("R Settings","rSet")Menu.RivenCombo.rSet:addParam("useWeaving","Use R on Q>AA",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo.rSet:addParam("useR","Use R in Combo",SCRIPT_PARAM_LIST,1,{"ALWAYS","KILLABLE","NEVER"})Menu.RivenCombo.rSet:addParam("rRange","Maximum range to cast R",SCRIPT_PARAM_SLICE,850,400,900,0)Menu:addSubMenu("["..myHero.charName.." - Harass]","Harass")Menu.Harass:addParam("harass","Harass",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("G"))Menu.Harass:addParam("useQ","Use Q in Harass",SCRIPT_PARAM_ONOFF,true)Menu.Harass:addParam("useW","Use W in Harass",SCRIPT_PARAM_ONOFF,true)Menu.Harass:addParam("useE","Use E in Harass",SCRIPT_PARAM_ONOFF,true)Menu:addSubMenu("["..myHero.charName.." - Laneclear]","Laneclear")Menu.Laneclear:addParam("lclr","Laneclear Key",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("V"))Menu.Laneclear:addParam("useClearQ","Use Q in Laneclear",SCRIPT_PARAM_ONOFF,true)Menu.Laneclear:addParam("useClearW","Use W in Laneclear",SCRIPT_PARAM_ONOFF,true)Menu.Laneclear:addParam("useClearE","Use E in Laneclear",SCRIPT_PARAM_ONOFF,true)Menu:addSubMenu("["..myHero.charName.." - Jungleclear]","Jungleclear")Menu.Jungleclear:addParam("jclr","Jungleclear Key",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("V"))Menu.Jungleclear:addParam("useClearQ","Use Q in Jungleclear",SCRIPT_PARAM_ONOFF,true)Menu.Jungleclear:addParam("useClearW","Use W in Jungleclear",SCRIPT_PARAM_ONOFF,true)Menu.Jungleclear:addParam("useClearE","Use E in Jungleclear",SCRIPT_PARAM_ONOFF,true)Menu:addSubMenu("["..myHero.charName.." - Additionals]","Ads")Menu.Ads:addParam("cancel","Animation Cancel",SCRIPT_PARAM_LIST,1,{"Move","Laugh","Dance","Taunt","joke","Nothing"})AddProcessSpellCallback(function(e,n)animationCancel(e,n)end)Menu.Ads:addParam("autoLevel","Auto-Level Spells",SCRIPT_PARAM_ONOFF,false)Menu.Ads:addSubMenu("Escape","escapeMenu")Menu.Ads.escapeMenu:addParam("escapeKey","Escape Key",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("C"))Menu.Ads:addParam("weaving","Q>AA",SCRIPT_PARAM_ONOFF,true)Menu.Ads:addParam("hitOnly","Only Q if hits",SCRIPT_PARAM_ONOFF,true)Menu.Ads:addSubMenu("Killsteal","KS")Menu.Ads.KS:addParam("useR","Use Ultimate",SCRIPT_PARAM_ONOFF,true)Menu.Ads.KS:addParam("ignite","Use Ignite",SCRIPT_PARAM_ONOFF,false)Menu.Ads.KS:addParam("igniteRange","Minimum range to cast Ignite",SCRIPT_PARAM_SLICE,470,0,600,0)Menu.Ads:addSubMenu("VIP","VIP")Menu.Ads.VIP:addParam("skin","Use custom skin (Requires Reload)",SCRIPT_PARAM_ONOFF,false)Menu.Ads.VIP:addParam("skin1","Skin changer",SCRIPT_PARAM_SLICE,1,1,7)Menu.Ads.VIP:addParam("pCast","Use packets (VIP Only)",SCRIPT_PARAM_ONOFF,false)Menu:addSubMenu("["..myHero.charName.." - Target Selector]","targetSelector")Menu.targetSelector:addTS(t)t.name="Focus"Menu:addSubMenu("["..myHero.charName.." - Drawings]","drawings")local n=DrawManager()n:CreateCircle(myHero,e.AA,1,{255,0,255,0}):AddToMenu(Menu.drawings,"AA range",true,true,true)n:CreateCircle(myHero,e.Q,1,{255,0,255,0}):AddToMenu(Menu.drawings,"Q range",true,true,true)n:CreateCircle(myHero,e.W,1,{255,0,255,0}):AddToMenu(Menu.drawings,"W range",true,true,true)n:CreateCircle(myHero,e.E,1,{255,0,255,0}):AddToMenu(Menu.drawings,"E range",true,true,true)n:CreateCircle(myHero,e.R,1,{255,0,255,0}):AddToMenu(Menu.drawings,"R range",true,true,true)enemyMinions=minionManager(MINION_ENEMY,360,myHero,MINION_SORT_MAXHEALTH_DEC)allyMinions=minionManager(MINION_ALLY,360,myHero,MINION_SORT_MAXHEALTH_DEC)jungleMinions=minionManager(MINION_JUNGLE,360,myHero,MINION_SORT_MAXHEALTH_DEC)if Menu.Ads.VIP.skin and VIP_USER then GenModelPacket("Riven",Menu.Ads.VIP.skin1)end PrintChat('<font color = "#33CCCC">Rivelina by</font> <font color = "#fff8e7">Lillgoalie</font> <font color = "#33CCCC">&</font> <font color = "#fff8e7">Mr Articuno</font>')end function OnTick()t:update()enemyMinions:update()allyMinions:update()jungleMinions:update()CDHandler()KillSteal()S,o,s,SheenSlot,TrinitySlot,LichBaneSlot,m,C,u,c,STDSlot=GetInventorySlotItem(3128),GetInventorySlotItem(3146),GetInventorySlotItem(3144),GetInventorySlotItem(3057),GetInventorySlotItem(3078),GetInventorySlotItem(3100),GetInventorySlotItem(3153),GetInventorySlotItem(3077),GetInventorySlotItem(3074),GetInventorySlotItem(3143),GetInventorySlotItem(3131)a=(myHero:CanUseSpell(_Q)==READY)l=(myHero:CanUseSpell(_W)==READY)d=(myHero:CanUseSpell(_E)==READY)i=(myHero:CanUseSpell(_R)==READY)y=(S~=nil and myHero:CanUseSpell(S)==READY)I=(o~=nil and myHero:CanUseSpell(o)==READY)P=(s~=nil and myHero:CanUseSpell(s)==READY)h=(m~=nil and myHero:CanUseSpell(m)==READY)_=(C~=nil and myHero:CanUseSpell(C)==READY)f=(u~=nil and myHero:CanUseSpell(u)==READY)A=(c~=nil and myHero:CanUseSpell(c)==READY)STDREADY=(STDSlot~=nil and myHero:CanUseSpell(STDSlot)==READY)IREADY=(r~=nil and myHero:CanUseSpell(r)==READY)if Menu.Ads.autoLevel then AutoLevel()end if Menu.Ads.escapeMenu.escapeKey then EscapeMode()end if Menu.RivenCombo.combo then Combo()end if Menu.Harass.harass then Harass()end if Menu.Laneclear.lclr then LaneClear()end if Menu.Jungleclear.jclr then JungleClear()end end function CDHandler()a=(myHero:CanUseSpell(_Q)==READY)l=(myHero:CanUseSpell(_W)==READY)d=(myHero:CanUseSpell(_E)==READY)i=(myHero:CanUseSpell(_R)==READY)tiamatSlot=GetInventorySlotItem(3077)hydraSlot=GetInventorySlotItem(3074)youmuuSlot=GetInventorySlotItem(3142)bilgeSlot=GetInventorySlotItem(3144)bladeSlot=GetInventorySlotItem(3153)tiamatReady=(tiamatSlot~=nil and myHero:CanUseSpell(tiamatSlot)==READY)hydraReady=(hydraSlot~=nil and myHero:CanUseSpell(hydraSlot)==READY)youmuuReady=(youmuuSlot~=nil and myHero:CanUseSpell(youmuuSlot)==READY)bilgeReady=(bilgeSlot~=nil and myHero:CanUseSpell(bilgeSlot)==READY)bladeReady=(bladeSlot~=nil and myHero:CanUseSpell(bladeSlot)==READY)if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot")then r=SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot")then r=SUMMONER_2 end g=(r~=nil and myHero:CanUseSpell(r)==READY)end function Harass()local n=t.target if n~=nil and ValidTarget(n)then if Menu.Harass.useE and d then SpellCast(_E,n.x,n.z)end if Menu.Harass.useW and ValidTarget(n,e.W)and l then SpellCast(_W)ItemUsage()end if Menu.Harass.useQ and ValidTarget(n,e.Q)and a then if Menu.Ads.weaving then qWeaving(n)end if not Menu.Ads.weaving then SpellCast(_Q,n.x,n.z)end end end end function Combo()local e=0 if t.target~=nil then AllInCombo(t.target,0)end end function AllInCombo(n,t)if n~=nil and t==0 then if ValidTarget(n,e.W-20)and l then CastSpell(_W)end if ValidTarget(n,900)and Menu.RivenCombo.eSet.useE and d and l then SpellCast(_E,n.x,n.z)DelayAction(function()end,1500-GetLatency())ItemUsage()end if i and myHero:GetSpellData(_R).name=='RivenFengShuiEngine'and ValidTarget(n,360)then if Menu.RivenCombo.rSet.useR==1 then SpellCast(_R)DelayAction(function()end,800-GetLatency())end if Menu.RivenCombo.rSet.useR==2 then SpellCast(_R)DelayAction(function()end,800-GetLatency())end end if ValidTarget(n,e.W)and l and Menu.RivenCombo.wSet.useW then SpellCast(_W)elseif ValidTarget(n,e.Q+e.W)and l and a and Menu.RivenCombo.qSet.useQ then SpellCast(_Q,n.x,n.z)elseif ValidTarget(n,e.E+e.W)and d and Menu.RivenCombo.eSet.useE then SpellCast(_E,n.x,n.z)SpellCast(_W)end if ValidTarget(n,Menu.RivenCombo.rSet.rRange)and i and myHero:GetSpellData(_R).name=='rivenizunablade'then if Menu.RivenCombo.rSet.useR==1 and n~=nil and ValidTarget(n,Menu.RivenCombo.rSet.rRange)then SpellCast(_R,n.x,n.z)end if Menu.RivenCombo.rSet.useR==2 then for n,e in ipairs(GetEnemyHeroes())do rDmg=getDmg("R",e,myHero)if e~=nil and ValidTarget(e,Menu.RivenCombo.rSet.rRange)and e.health<rDmg then SpellCast(_R,e.x,e.z)end end end DelayAction(function()end,1e3-GetLatency())end if ValidTarget(n,e.Q)and a and Menu.RivenCombo.qSet.useQ then SpellCast(_Q,n.x,n.z)end if ValidTarget(n,700)and GetDistance(n)>500 then if Menu.RivenCombo.qSet.useQ and a then SpellCast(_Q,n.x,n.z)end end if ValidTarget(n,900)and GetDistance(n)>700 then if Menu.RivenCombo.qSet.useQ and a then SpellCast(_Q,n.x,n.z)end end end end function SmartCombo(n)if n~=nil and ValidTarget(n)then if i and Menu.RivenCombo.rSet.useR and ValidTarget(n,e.R)then rDmg=getDmg("R",n,myHero)if i and n~=nil and ValidTarget(n,Menu.RivenCombo.rSet.rRange)and n.health<=rDmg then if myHero:GetSpellData(_R).name=='RivenFengShuiEngine'then CastSpell(_R)end if myHero:GetSpellData(_R).name=='rivenizunablade'then SpellCast(_R,n.x,n.z)end end end if Menu.Ads.weaving and a and Menu.RivenCombo.qSet.useQ then qWeaving(n)else SpellCast(_Q,n.x,n.z)end if Menu.RivenCombo.wSet.useW and ValidTarget(n,e.W)and l then CastSpell(_W)end if d and Menu.RivenCombo.eSet.useE and ValidTarget(n,e.E)then SpellCast(_E,n.x,n.z)end end end function LaneClear()for t,n in pairs(enemyMinions.objects)do for d,t in pairs(allyMinions.objects)do if t~=nil and n~=nil then if n~=nil and ValidTarget(n)and Menu.Laneclear.useClearQ and a then if Menu.Ads.weaving then qWeaving(n)else if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end end end end if Menu.Laneclear.useClearW and l and ValidTarget(n,e.W)then CastSpell(_W)end end if allyminion==nil and n~=nil then if Menu.Laneclear.useClearQ and a then if Menu.Ads.weaving then qWeaving(n)else if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else SpellCast(_Q,n.x,n.z)end end end if Menu.Laneclear.useClearW and l and ValidTarget(n,e.W)then CastSpell(_W)end end end end end function JungleClear()for t,n in pairs(jungleMinions.objects)do if n~=nil then if Menu.Jungleclear.useClearE and d then SpellCast(_E,n.x,n.z)end if Menu.Jungleclear.useClearQ and a then if Menu.Ads.weaving then qWeaving(n)else if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else SpellCast(_Q,n.x,n.z)end end end if Menu.Jungleclear.useClearW and l and ValidTarget(n,e.W)then CastSpell(_W)end end end end function AutoLevel()local d,l,a,t=player:GetSpellData(_Q).level+v,player:GetSpellData(_W).level+E,player:GetSpellData(_E).level+b,player:GetSpellData(_R).level+T if d+l+a+t<player.level then local i={SPELL_1,SPELL_2,SPELL_3,SPELL_4,}local e={0,0,0,0}for n=1,player.level,1 do e[R[n]]=e[R[n]]+1 end for n,a in ipairs({d,l,a,t})do if a<e[n]then LevelSpell(i[n])end end end end function KillSteal()if Menu.Ads.KS.useR then KSR()end if Menu.Ads.KS.ignite then IgniteKS()end end function KSR()for n,e in ipairs(GetEnemyHeroes())do rDmg=getDmg("R",e,myHero)if i and e~=nil and ValidTarget(e,Menu.RivenCombo.rSet.rRange)and e.health<rDmg then if myHero:GetSpellData(_R).name=='RivenFengShuiEngine'then SpellCast(_R)end if myHero:GetSpellData(_R).name=='rivenizunablade'then SpellCast(_R,e.x,e.z)end end end end function IgniteKS()if g then local e=GetEnemyHeroes()for n,e in ipairs(e)do if ValidTarget(e,600)then if getDmg("IGNITE",e,myHero)>e.health and RReady~=true and GetDistance(e)>=Menu.Ads.KS.igniteRange then CastSpell(r,e)end end end end end function EscapeMode()myHero:MoveTo(mousePos.x,mousePos.z)for a,n in ipairs(GetEnemyHeroes())do if n~=nil and ValidTarget(n,e.W)and l then CastSpell(_W)end end if d then SpellCast(_E,mousePos.x,mousePos.z)end if a and not d then if a and not d then DelayAction(function()end,1500-GetLatency())SpellCast(_Q,mousePos.x,mousePos.z)end end end function HealthCheck(e,n)if e.health>(e.maxHealth*(n/100))then return true else return false end end function qWeaving(n)Orbwalker:RegisterAfterAttackCallback(function(n,t)if n.type~='obj_AI_Hero'and Menu.Jungleclear.jclr then if a then if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else SpellCast(_Q,n.x,n.z)end end end if n.type~='obj_AI_Hero'and Menu.Laneclear.lclr then if a then if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else SpellCast(_Q,n.x,n.z)end end end if n.type=='obj_AI_Hero'and Menu.Harass.harass then if a then if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else SpellCast(_Q,n.x,n.z)end end end if n.type=='obj_AI_Hero'and Menu.RivenCombo.combo then if a then if i and Menu.RivenCombo.rSet.useWeaving and myHero:GetSpellData(_R).name=='RivenFengShuiEngine'then CastSpell(_R)end if Menu.Ads.hitOnly then if ValidTarget(n,e.Q)then SpellCast(_Q,n.x,n.z)end else SpellCast(_Q,n.x,n.z)end end end end)end function animationCancel(n,e)if not n.isMe then return end if e.name=='RivenTriCleave'then DelayAction(function()SOW:resetAA()end,nil)M[Menu.Ads.cancel]()else if e.name=='RivenMartyr'then M[Menu.Ads.cancel]()else if e.name=='RivenFeint'then M[Menu.Ads.cancel]()else if e.name=='RivenFengShuiEngine'then else if e.name=='rivenizunablade'then end end end end end end function SpellCast(n,a,e)if Menu.Ads.VIP.pCast and VIP_USER then Packet('S_CAST',{spellId=n,fromX=a,fromY=e}):send()else if a==nil or e==nil then CastSpell(n)else CastSpell(n,a,e)end end end function ItemUsage(e)if y then CastSpell(S,t.target)end if I then CastSpell(o,t.target)end if P then CastSpell(s,t.target)end if h then CastSpell(m,t.target)end if _ and GetDistance(t.target)<275 then CastSpell(C)end if f and GetDistance(t.target)<275 then CastSpell(u)end if A and GetDistance(t.target)<275 then CastSpell(c)end end function GenModelPacket(e,n)p=CLoLPacket(150)p:EncodeF(myHero.networkID)p.pos=1 t1=p:Decode1()t2=p:Decode1()t3=p:Decode1()t4=p:Decode1()p:Encode1(t1)p:Encode1(t2)p:Encode1(t3)p:Encode1(bit32.band(t4,11))p:Encode1(1)p:Encode4(n)for n=1,#e do p:Encode1(string.byte(e:sub(n,n)))end for e=#e+1,64 do p:Encode1(0)end p:Hide()RecvPacket(p)end function OnDraw()end