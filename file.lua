if myHero.charName~="Riven"then return end local a=.59 local t=true local e="Rivelina"local l="https://raw.github.com/TheRealSource/public/master/common/SourceLib.lua"local n=LIB_PATH.."SourceLib.lua"if FileExist(n)then require("SourceLib")else DOWNLOADING_SOURCELIB=true DownloadFile(l,n,function()print("Required libraries downloaded successfully, please reload")end)end if DOWNLOADING_SOURCELIB then print("Downloading required libraries, please wait...")return end if t then SourceUpdater(e,a,"raw.github.com","/Lillgoalie/Rivelina/master/"..e..".lua",SCRIPT_PATH..GetCurrentEnv().FILE_NAME,"/Lillgoalie/Rivelina/master/"..e..".version"):CheckUpdate()end local e=Require("SourceLib")e:Add("vPrediction","https://raw.github.com/Hellsing/BoL/master/common/VPrediction.lua")e:Add("SOW","https://raw.github.com/Hellsing/BoL/master/common/SOW.lua")e:Check()if e.downloadNeeded==true then return end require'VPrediction'require'SOW'local e,e,e,e=false,false,false,false local o,y=nil,nil local i local e=nil local H,I,b,D=0,0,0,0 local R={1,2,3,1,1,4,1,3,1,3,4,3,3,2,2,4,2,2}local n={Q=260+100,W=250,E=325,R=880,AA=250}local T={Q1=.4,Q2=.4,Q3=.4,E=.25,R=.4}local r={[1]=function()myHero:MoveTo(mousePos.x,mousePos.z)end,[2]=function()SendChat('/l')end,[3]=function()SendChat('/d')end,[4]=function()SendChat('/t')end,[5]=function()SendChat('/j')end,[6]=function()end,}local a,t,l,d=false,false,false,false local u,M,C,m,c,S,s,f=nil,nil,nil,nil,nil,nil,nil,nil local P,E,g,_,h,A,f,v=false,false,false,false,false,false,false,false function OnLoad()initComponents()end function initComponents()e=VPrediction()Orbwalker=SOW(e)i=TargetSelector(TARGET_NEAR_MOUSE,900)Menu=scriptConfig("Rivelina by Lillgoalie & Mr Articuno","RivenBLMA")Menu:addSubMenu("["..myHero.charName.." - Orbwalker]","SOWorb")Orbwalker:LoadToMenu(Menu.SOWorb)Menu:addSubMenu("["..myHero.charName.." - Combo]","RivenCombo")Menu.RivenCombo:addParam("combo","Combo mode",SCRIPT_PARAM_ONKEYDOWN,false,32)Menu.RivenCombo:addSubMenu("Q Settings","qSet")Menu.RivenCombo.qSet:addParam("useQ","Use Q in combo",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo:addSubMenu("W Settings","wSet")Menu.RivenCombo.wSet:addParam("useW","Use W in combo",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo:addSubMenu("E Settings","eSet")Menu.RivenCombo.eSet:addParam("useE","Use E in combo",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo:addSubMenu("R Settings","rSet")Menu.RivenCombo.rSet:addParam("useWeaving","Use R on Q>AA",SCRIPT_PARAM_ONOFF,true)Menu.RivenCombo.rSet:addParam("useR","Use R in Combo",SCRIPT_PARAM_LIST,1,{"ALWAYS","KILLABLE","NEVER"})Menu.RivenCombo.rSet:addParam("rRange","Maximum range to cast R",SCRIPT_PARAM_SLICE,850,400,900,0)Menu:addSubMenu("["..myHero.charName.." - Harass]","Harass")Menu.Harass:addParam("harass","Harass",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("G"))Menu.Harass:addParam("useQ","Use Q in Harass",SCRIPT_PARAM_ONOFF,true)Menu.Harass:addParam("useW","Use W in Harass",SCRIPT_PARAM_ONOFF,true)Menu.Harass:addParam("useE","Use E in Harass",SCRIPT_PARAM_ONOFF,true)Menu:addSubMenu("["..myHero.charName.." - Laneclear]","Laneclear")Menu.Laneclear:addParam("lclr","Laneclear Key",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("V"))Menu.Laneclear:addParam("useClearQ","Use Q in Laneclear",SCRIPT_PARAM_ONOFF,true)Menu.Laneclear:addParam("useClearW","Use W in Laneclear",SCRIPT_PARAM_ONOFF,true)Menu.Laneclear:addParam("useClearE","Use E in Laneclear",SCRIPT_PARAM_ONOFF,true)Menu:addSubMenu("["..myHero.charName.." - Jungleclear]","Jungleclear")Menu.Jungleclear:addParam("jclr","Jungleclear Key",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("V"))Menu.Jungleclear:addParam("useClearQ","Use Q in Jungleclear",SCRIPT_PARAM_ONOFF,true)Menu.Jungleclear:addParam("useClearW","Use W in Jungleclear",SCRIPT_PARAM_ONOFF,true)Menu.Jungleclear:addParam("useClearE","Use E in Jungleclear",SCRIPT_PARAM_ONOFF,true)Menu:addSubMenu("["..myHero.charName.." - Additionals]","Ads")Menu.Ads:addParam("cancel","Animation Cancel",SCRIPT_PARAM_LIST,1,{"Move","Laugh","Dance","Taunt","joke","Nothing"})AddProcessSpellCallback(function(e,n)animationCancel(e,n)end)Menu.Ads:addParam("autoLevel","Auto-Level Spells",SCRIPT_PARAM_ONOFF,false)Menu.Ads:addSubMenu("Escape","escapeMenu")Menu.Ads.escapeMenu:addParam("escapeKey","Escape Key",SCRIPT_PARAM_ONKEYDOWN,false,string.byte("C"))Menu.Ads:addParam("weaving","Q>AA",SCRIPT_PARAM_ONOFF,true)Orbwalker:RegisterAfterAttackCallback(function(e,n)if a then if e.type==myHero.type and(Menu.Harass.harass or Menu.RivenCombo.combo)then CastSpell(_Q,e)elseif e.type=='obj_AI_Minion'and(Menu.Laneclear.lclr or Menu.Jungleclear.jclr)then CastSpell(_Q,mousePos.x,mousePos.z)end end end)Menu.Ads:addParam("hitOnly","Only Q if hits",SCRIPT_PARAM_ONOFF,true)Menu.Ads:addSubMenu("Killsteal","KS")Menu.Ads.KS:addParam("useR","Use Ultimate",SCRIPT_PARAM_ONOFF,true)Menu.Ads.KS:addParam("ignite","Use Ignite",SCRIPT_PARAM_ONOFF,false)Menu.Ads.KS:addParam("igniteRange","Minimum range to cast Ignite",SCRIPT_PARAM_SLICE,470,0,600,0)Menu.Ads:addSubMenu("VIP","VIP")Menu.Ads.VIP:addParam("skin","Use custom skin (Requires Reload)",SCRIPT_PARAM_ONOFF,false)Menu.Ads.VIP:addParam("skin1","Skin changer",SCRIPT_PARAM_SLICE,1,1,7)Menu:addSubMenu("["..myHero.charName.." - Target Selector]","targetSelector")Menu.targetSelector:addTS(i)i.name="Focus"Menu:addSubMenu("["..myHero.charName.." - Drawings]","drawings")local e=DrawManager()e:CreateCircle(myHero,n.AA,1,{255,0,255,0}):AddToMenu(Menu.drawings,"AA range",true,true,true)e:CreateCircle(myHero,n.Q,1,{255,0,255,0}):AddToMenu(Menu.drawings,"Q range",true,true,true)e:CreateCircle(myHero,n.W,1,{255,0,255,0}):AddToMenu(Menu.drawings,"W range",true,true,true)e:CreateCircle(myHero,n.E,1,{255,0,255,0}):AddToMenu(Menu.drawings,"E range",true,true,true)e:CreateCircle(myHero,n.R,1,{255,0,255,0}):AddToMenu(Menu.drawings,"R range",true,true,true)enemyMinions=minionManager(MINION_ENEMY,360,myHero,MINION_SORT_MAXHEALTH_DEC)allyMinions=minionManager(MINION_ALLY,360,myHero,MINION_SORT_MAXHEALTH_DEC)jungleMinions=minionManager(MINION_JUNGLE,360,myHero,MINION_SORT_MAXHEALTH_DEC)if Menu.Ads.VIP.skin and VIP_USER then GenModelPacket("Riven",Menu.Ads.VIP.skin1)end PrintChat('<font color = "#33CCCC">Rivelina by</font> <font color = "#fff8e7">Lillgoalie</font> <font color = "#33CCCC">&</font> <font color = "#fff8e7">Mr Articuno</font>')end function OnTick()i:update()enemyMinions:update()allyMinions:update()jungleMinions:update()CDHandler()KillSteal()M,C,m,SheenSlot,TrinitySlot,LichBaneSlot,u,c,S,s,STDSlot=GetInventorySlotItem(3128),GetInventorySlotItem(3146),GetInventorySlotItem(3144),GetInventorySlotItem(3057),GetInventorySlotItem(3078),GetInventorySlotItem(3100),GetInventorySlotItem(3153),GetInventorySlotItem(3077),GetInventorySlotItem(3074),GetInventorySlotItem(3143),GetInventorySlotItem(3131)a=(myHero:CanUseSpell(_Q)==READY)t=(myHero:CanUseSpell(_W)==READY)l=(myHero:CanUseSpell(_E)==READY)d=(myHero:CanUseSpell(_R)==READY)E=(M~=nil and myHero:CanUseSpell(M)==READY)g=(C~=nil and myHero:CanUseSpell(C)==READY)_=(m~=nil and myHero:CanUseSpell(m)==READY)P=(u~=nil and myHero:CanUseSpell(u)==READY)h=(c~=nil and myHero:CanUseSpell(c)==READY)A=(S~=nil and myHero:CanUseSpell(S)==READY)f=(s~=nil and myHero:CanUseSpell(s)==READY)STDREADY=(STDSlot~=nil and myHero:CanUseSpell(STDSlot)==READY)IREADY=(o~=nil and myHero:CanUseSpell(o)==READY)if Menu.Ads.autoLevel then AutoLevel()end if Menu.Ads.escapeMenu.escapeKey then EscapeMode()end if Menu.RivenCombo.combo then Combo()end if Menu.Harass.harass then Harass()end if Menu.Laneclear.lclr then LaneClear()end if Menu.Jungleclear.jclr then JungleClear()end end function CDHandler()a=(myHero:CanUseSpell(_Q)==READY)t=(myHero:CanUseSpell(_W)==READY)l=(myHero:CanUseSpell(_E)==READY)d=(myHero:CanUseSpell(_R)==READY)tiamatSlot=GetInventorySlotItem(3077)hydraSlot=GetInventorySlotItem(3074)youmuuSlot=GetInventorySlotItem(3142)bilgeSlot=GetInventorySlotItem(3144)bladeSlot=GetInventorySlotItem(3153)tiamatReady=(tiamatSlot~=nil and myHero:CanUseSpell(tiamatSlot)==READY)hydraReady=(hydraSlot~=nil and myHero:CanUseSpell(hydraSlot)==READY)youmuuReady=(youmuuSlot~=nil and myHero:CanUseSpell(youmuuSlot)==READY)bilgeReady=(bilgeSlot~=nil and myHero:CanUseSpell(bilgeSlot)==READY)bladeReady=(bladeSlot~=nil and myHero:CanUseSpell(bladeSlot)==READY)if myHero:GetSpellData(SUMMONER_1).name:find("SummonerDot")then o=SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("SummonerDot")then o=SUMMONER_2 end y=(o~=nil and myHero:CanUseSpell(o)==READY)end function Harass()local e=i.target if e~=nil and ValidTarget(e)then ItemUsage(e)if Menu.Harass.useE and l then CastSpell(_E,e.x,e.z)end if Menu.Harass.useW and ValidTarget(e,n.W)and t then CastSpell(_W)end if Menu.Harass.useQ and ValidTarget(e,n.Q)and a then CastSpell(_Q,e.x,e.z)end end end function Combo()local e=0 if i.target~=nil then AllInCombo(i.target,0)end end function AllInCombo(e,i)if e~=nil and i==0 then if ValidTarget(e,n.W-20)and t then ItemUsage(e)CastSpell(_W)end if ValidTarget(e,900)and Menu.RivenCombo.eSet.useE and l and t then CastSpell(_E,e.x,e.z)DelayAction(function()end,1500-GetLatency())end if d and myHero:GetSpellData(_R).name=='RivenFengShuiEngine'and ValidTarget(e,360)then if Menu.RivenCombo.rSet.useR==1 then CastSpell(_R)DelayAction(function()end,800-GetLatency())end if Menu.RivenCombo.rSet.useR==2 then CastSpell(_R)DelayAction(function()end,800-GetLatency())end end if ValidTarget(e,n.W)and t and Menu.RivenCombo.wSet.useW then CastSpell(_W)elseif ValidTarget(e,n.Q+n.W)and t and a and Menu.RivenCombo.qSet.useQ then CastSpell(_Q,e.x,e.z)elseif ValidTarget(e,n.E+n.W)and l and Menu.RivenCombo.eSet.useE then CastSpell(_E,e.x,e.z)CastSpell(_W)end if ValidTarget(e,Menu.RivenCombo.rSet.rRange)and d and myHero:GetSpellData(_R).name=='rivenizunablade'then if Menu.RivenCombo.rSet.useR==1 and e~=nil and ValidTarget(e,Menu.RivenCombo.rSet.rRange)then CastSpell(_R,e.x,e.z)end if Menu.RivenCombo.rSet.useR==2 then for n,e in ipairs(GetEnemyHeroes())do rDmg=getDmg("R",e,myHero)if e~=nil and ValidTarget(e,Menu.RivenCombo.rSet.rRange)and e.health<rDmg then CastSpell(_R,e.x,e.z)end end end DelayAction(function()end,1e3-GetLatency())end if ValidTarget(e,n.Q)and a and Menu.RivenCombo.qSet.useQ then CastSpell(_Q,e.x,e.z)end if ValidTarget(e,700)and GetDistance(e)>500 then if Menu.RivenCombo.qSet.useQ and a then CastSpell(_Q,e.x,e.z)end end if ValidTarget(e,900)and GetDistance(e)>700 then if Menu.RivenCombo.qSet.useQ and a then CastSpell(_Q,e.x,e.z)end end end end function SmartCombo(e)if e~=nil and ValidTarget(e)then if d and Menu.RivenCombo.rSet.useR and ValidTarget(e,n.R)then rDmg=getDmg("R",e,myHero)if d and e~=nil and ValidTarget(e,Menu.RivenCombo.rSet.rRange)and e.health<=rDmg then if myHero:GetSpellData(_R).name=='RivenFengShuiEngine'then CastSpell(_R)end if myHero:GetSpellData(_R).name=='rivenizunablade'then CastSpell(_R,e.x,e.z)end end end if Menu.RivenCombo.wSet.useW and ValidTarget(e,n.W)and t then CastSpell(_W)end if l and Menu.RivenCombo.eSet.useE and ValidTarget(e,n.E)then CastSpell(_E,e.x,e.z)end end end function LaneClear()for l,e in pairs(enemyMinions.objects)do for i,l in pairs(allyMinions.objects)do if l~=nil and e~=nil then ItemUsage(e)if e~=nil and ValidTarget(e)and Menu.Laneclear.useClearQ and a then if Menu.Ads.hitOnly then if ValidTarget(e,n.Q)then CastSpell(_Q,e.x,e.z)end else if ValidTarget(e,n.Q)then CastSpell(_Q,e.x,e.z)end end end if Menu.Laneclear.useClearW and t and ValidTarget(e,n.W)then CastSpell(_W)end end if allyminion==nil and e~=nil then if Menu.Laneclear.useClearQ and a then if Menu.Ads.hitOnly then if ValidTarget(e,n.Q)then CastSpell(_Q,e.x,e.z)end else CastSpell(_Q,e.x,e.z)end end if Menu.Laneclear.useClearW and t and ValidTarget(e,n.W)then CastSpell(_W)end end end end end function JungleClear()for i,e in pairs(jungleMinions.objects)do if e~=nil then ItemUsage(e)if Menu.Jungleclear.useClearE and l then CastSpell(_E,e.x,e.z)end if Menu.Jungleclear.useClearQ and a then if Menu.Ads.hitOnly then if ValidTarget(e,n.Q)then CastSpell(_Q,e.x,e.z)end else CastSpell(_Q,e.x,e.z)end end if Menu.Jungleclear.useClearW and t and ValidTarget(e,n.W)then CastSpell(_W)end end end end function AutoLevel()local t,l,i,a=player:GetSpellData(_Q).level+H,player:GetSpellData(_W).level+I,player:GetSpellData(_E).level+b,player:GetSpellData(_R).level+D if t+l+i+a<player.level then local d={SPELL_1,SPELL_2,SPELL_3,SPELL_4,}local e={0,0,0,0}for n=1,player.level,1 do e[R[n]]=e[R[n]]+1 end for n,a in ipairs({t,l,i,a})do if a<e[n]then LevelSpell(d[n])end end end end function KillSteal()if Menu.Ads.KS.useR then KSR()end if Menu.Ads.KS.ignite then IgniteKS()end end function KSR()for n,e in ipairs(GetEnemyHeroes())do rDmg=getDmg("R",e,myHero)if d and e~=nil and ValidTarget(e,Menu.RivenCombo.rSet.rRange)and e.health<rDmg then if myHero:GetSpellData(_R).name=='RivenFengShuiEngine'then CastSpell(_R)end if myHero:GetSpellData(_R).name=='rivenizunablade'then CastSpell(_R,e.x,e.z)end end end end function IgniteKS()if y then local e=GetEnemyHeroes()for n,e in ipairs(e)do if ValidTarget(e,600)then if getDmg("IGNITE",e,myHero)>e.health and RReady~=true and GetDistance(e)>=Menu.Ads.KS.igniteRange then CastSpell(o,e)end end end end end function EscapeMode()myHero:MoveTo(mousePos.x,mousePos.z)for a,e in ipairs(GetEnemyHeroes())do if e~=nil and ValidTarget(e,n.W)and t then CastSpell(_W)end end if l and a then DelayAction(function()CastSpell(_Q,mousePos.x,mousePos.z)end,8-GetLatency())elseif l and not a then DelayAction(function()CastSpell(_E,mousePos.x,mousePos.z)end,15-GetLatency())elseif not l and a then DelayAction(function()CastSpell(_Q,mousePos.x,mousePos.z)end,8-GetLatency())end end function HealthCheck(e,n)if e.health>(e.maxHealth*(n/100))then return true else return false end end function animationCancel(n,e)if not n.isMe then return end if e.name=='RivenTriCleave'then DelayAction(function()Orbwalker:resetAA()end,T.Q1)r[Menu.Ads.cancel]()else if e.name=='RivenMartyr'then r[Menu.Ads.cancel]()else if e.name=='RivenFeint'then r[Menu.Ads.cancel]()else if e.name=='RivenFengShuiEngine'then r[Menu.Ads.cancel]()else if e.name=='rivenizunablade'then r[Menu.Ads.cancel]()end end end end end end function ItemUsage(e)if E then CastSpell(M,e)end if g then CastSpell(C,e)end if _ then CastSpell(m,e)end if P then CastSpell(u,e)end if h and GetDistance(e)<275 then CastSpell(c)end if A and GetDistance(e)<275 then CastSpell(S)end if f and GetDistance(e)<275 then CastSpell(s)end end function GenModelPacket(e,n)p=CLoLPacket(150)p:EncodeF(myHero.networkID)p.pos=1 t1=p:Decode1()t2=p:Decode1()t3=p:Decode1()t4=p:Decode1()p:Encode1(t1)p:Encode1(t2)p:Encode1(t3)p:Encode1(bit32.band(t4,11))p:Encode1(1)p:Encode4(n)for n=1,#e do p:Encode1(string.byte(e:sub(n,n)))end for e=#e+1,64 do p:Encode1(0)end p:Hide()RecvPacket(p)end function OnDraw()end