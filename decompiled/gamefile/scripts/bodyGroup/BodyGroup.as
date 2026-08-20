package bodyGroup
{
   import UI.gaming.EnemyLifeBar;
   import UI.gaming.GamingUI;
   import body.attack.AttackEvent;
   import body.define.EnemyDefine;
   import body.enemy.EnemyHeroBody;
   import body.hero.HeroCarBody;
   import body.hero.SubBody;
   import body.image.SingleMovieclip;
   import body.lieutenant.LieutenantBody;
   import data.Maths;
   import enemy.SakerFighter.SakerFighter_AI;
   import enemy._normal.Normal_Animation;
   import enemy._normal.Normal_ChangeBody;
   import enemy._normal.Normal_FlyBody;
   import enemy._normal.Normal_Fly_AI;
   import enemy._normal.Normal_Fly_AI2;
   import enemy._normal.Normal_Land_AI;
   import enemy.airLaserFort.AirLaserFortBody;
   import enemy.alarmTower.AlarmTowerBody;
   import enemy.atomicTower.AtomicTowerBody;
   import enemy.bansheeFighter.BansheeFighterBody;
   import enemy.charger.ChargerBody;
   import enemy.cutter.CutterBody;
   import enemy.cutter.CutterBody2;
   import enemy.darkTemplar.DarkTemplarBody;
   import enemy.drilling.DrillingBody;
   import enemy.drilling.DrillingBody2;
   import enemy.electricSaw.ElectricSawAnimation;
   import enemy.electricSaw.ElectricSawBody;
   import enemy.falconFighter.FalconFighterBody;
   import enemy.gear.Gear2_AI;
   import enemy.gear.GearBody;
   import enemy.gundam.FunnelBody;
   import enemy.gundam.GundamBody;
   import enemy.gundam.GundamBody2;
   import enemy.havenFighter.HavenFighter_AI;
   import enemy.infiltrator.Infiltrator2_AI;
   import enemy.infiltrator.Infiltrator_AI;
   import enemy.intercessor.IntercessorBody;
   import enemy.knowing.KnowingBody;
   import enemy.knowing.KnowingX7Body;
   import enemy.landFort.LandFortBody;
   import enemy.landFort.LandFort_AI2;
   import enemy.landFort.LandFort_AI3;
   import enemy.lighingBall.LighingBallBody;
   import enemy.loadKing.LoadKing2_AI;
   import enemy.loadKing.LoadKing_AI;
   import enemy.mammoth.Mammoth_AI;
   import enemy.ostrich.OstrichBody;
   import enemy.ostrich.Ostrich_AI;
   import enemy.rolling.RollingBody;
   import enemy.satellite.Satellite_AI;
   import enemy.satellite.SmallSatelliteBody;
   import enemy.satellite.SmallSatellite_AI;
   import enemy.slayer.SlayerBody;
   import enemy.spider.SpiderBody;
   import enemy.spiderFort.SpiderFortBody;
   import enemy.striker.StrikerBody;
   import enemy.tank.TankBody;
   import enemy.tank.TankBody2;
   import enemy.tercelFighter.TercelFighterBody;
   import enemy.tiger.Tiger_AI;
   import enemy.tiger.Xiniu_AI;
   import enemy.tires.TiresBody;
   import enemy.tracker.TrackerBody;
   import enemy.twogun.Twogun_AI;
   import enemy.tyrant.Tyrant_AI;
   import enemy.warden.WardenBody;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import image.BmpMovieClipManager;
   import image.GameSprite;
   import net.SWFLoaderManager;
   import net.TextLoaderManager;
   import scene.things.ThingsBody;
   
   public class BodyGroup
   {
      
      public var skill:SkillEffectCtrl = new SkillEffectCtrl();
      
      private var textLoaderManager:TextLoaderManager;
      
      private var swfLoaderManager:SWFLoaderManager;
      
      private var bmpMovieClipManager:BmpMovieClipManager;
      
      public var gameSprite:GameSprite;
      
      public var gamingUI:GamingUI;
      
      public var hero:HeroCarBody = null;
      
      public var things_arr:Array = [];
      
      public var heroCar_arr:Array = [];
      
      public var sub_arr:Array = [];
      
      public var weBanshee_arr:Array = [];
      
      public var enemySub_arr:Array = [];
      
      public var enemyHero_arr:Array = [];
      
      public var AtomicTower_arr:Array = [];
      
      public var AirLaserFort_arr:Array = [];
      
      public var TercelFighter_arr:Array = [];
      
      public var FalconFighter_arr:Array = [];
      
      public var BansheeFighter_arr:Array = [];
      
      public var ElectricSaw_arr:Array = [];
      
      public var Charger_arr:Array = [];
      
      public var Gundam_arr:Array = [];
      
      public var GundamFunnel_arr:Array = [];
      
      public var Gundam2_arr:Array = [];
      
      public var Spider_arr:Array = [];
      
      public var SmallSatellite_arr:Array = [];
      
      public var Drilling_arr:Array = [];
      
      public var Ostrich_arr:Array = [];
      
      public var Tracker_arr:Array = [];
      
      public var Tank_arr:Array = [];
      
      public var Rolling_arr:Array = [];
      
      public var Striker_arr:Array = [];
      
      public var Intercessor_arr:Array = [];
      
      public var LandFort_arr:Array = [];
      
      public var Gear_arr:Array = [];
      
      public var supply_arr:Array = [];
      
      public var enemy_arr:Array = [];
      
      public var weAir_arr:Array = [];
      
      public var weLand_arr:Array = [];
      
      public var we_arr:Array = [this.heroCar_arr,this.sub_arr,this.weAir_arr,this.weLand_arr];
      
      public var weHit_arr:Array = [this.heroCar_arr];
      
      public var we_bullet:Array = [];
      
      public var enemy_bullet:Array = [];
      
      public var bullet_arr:Array = [this.we_bullet,this.enemy_bullet];
      
      public var lifeBar_arr:Array = [];
      
      public function BodyGroup()
      {
         super();
         this.enemy_arr.push(this.AirLaserFort_arr);
         this.enemy_arr.push(this.ElectricSaw_arr);
         this.enemy_arr.push(this.Charger_arr);
         this.enemy_arr.push(this.Gundam_arr);
         this.enemy_arr.push(this.Gundam2_arr);
         this.enemy_arr.push(this.Spider_arr);
         this.enemy_arr.push(this.SmallSatellite_arr);
         this.enemy_arr.push(this.Drilling_arr);
         this.enemy_arr.push(this.TercelFighter_arr);
         this.enemy_arr.push(this.FalconFighter_arr);
         this.enemy_arr.push(this.BansheeFighter_arr);
         this.enemy_arr.push(this.Ostrich_arr);
         this.enemy_arr.push(this.Tracker_arr);
         this.enemy_arr.push(this.Tank_arr);
         this.enemy_arr.push(this.Rolling_arr);
         this.enemy_arr.push(this.Striker_arr);
         this.enemy_arr.push(this.Intercessor_arr);
         this.enemy_arr.push(this.LandFort_arr);
         this.enemy_arr.push(this.AtomicTower_arr);
         this.enemy_arr.push(this.Gear_arr);
         this.enemy_arr.push(this.enemyHero_arr);
      }
      
      public function init() : *
      {
         this.textLoaderManager = Game.textLoaderManager;
         this.bmpMovieClipManager = Game.bmpMovieClipManager;
         this.swfLoaderManager = Game.swfLoaderManager;
         this.gameSprite = Game.gameSprite;
         this.gamingUI = Game.uiGroup.gamingUI;
      }
      
      private function inputMC_list(img0:*, father:String, arr0:Array, pointB:Boolean = false) : *
      {
         var n:* = undefined;
         var smc0:SingleMovieclip = null;
         for(n in arr0)
         {
            smc0 = this.swfLoaderManager.getSingleMovieclip(father,arr0[n],pointB);
            if(smc0 != null)
            {
               img0.addSingleMovieclip(smc0);
            }
            else
            {
               try{ Game.reportClientError("missing-image","missing MovieClip: " + father + "/" + arr0[n],"","enemy-image"); }catch(eLog:*){}
            }
         }
      }

      public function prewarmEnemyImages(enemyNames:Array) : Boolean
      {
         var enemyName0:String = null;
         var xml0:XML = null;
         var imageNames:Array = null;
         var imageName0:String = null;
         var smc0:SingleMovieclip = null;
         var ok0:Boolean = true;
         var names0:Array = enemyNames.concat(["Spider","SmallWarden","Satellite_small"]);
         for each(enemyName0 in names0)
         {
            xml0 = this.textLoaderManager.getEnemyXML(enemyName0);
            if(xml0 == null)
            {
               continue;
            }
            imageNames = String(xml0.imgList).split(",");
            for each(imageName0 in imageNames)
            {
               smc0 = this.swfLoaderManager.getSingleMovieclip(enemyName0,imageName0);
               if(smc0 == null)
               {
                  ok0 = false;
                  try{ Game.reportClientError("missing-image","prewarm failed: " + enemyName0 + "/" + imageName0,"","enemy-image"); }catch(eLog:*){}
               }
               else
               {
                  smc0.gotoAndStop(1);
               }
            }
         }
         return ok0;
      }
      
      public function getUnit(str:String) : *
      {
         var b0:* = undefined;
         var e_d0:EnemyDefine = null;
         var armsList0:Array = null;
         if(str == "悬浮自动激光炮台")
         {
            return this.addAirLaserFort();
         }
         if(str == "悬浮自动激光炮台2号")
         {
            return this.addAirLaserFort("AirLaserFort_2");
         }
         if(str == "蓝光飞碟")
         {
            return this.addAirLaserFort("ufo");
         }
         if(str == "游隼战机")
         {
            return this.addTercelFighter();
         }
         if(str == "天隼战机")
         {
            return this.addFalconFighter();
         }
         if(str == "女妖战机")
         {
            return this.addBansheeFighter();
         }
         if(str == "女妖战机2")
         {
            return this.addBansheeFighter("2");
         }
         if(str == "电锯机器人")
         {
            return this.addElectricSaw();
         }
         if(str == "突击者")
         {
            return this.addCharger();
         }
         if(str == "杀戮者")
         {
            return this.addSlayer();
         }
         if(str == "自爆蜘蛛机")
         {
            return this.addSpider();
         }
         if(str == "中年僵尸")
         {
            return this.addSpider("zombie1");
         }
         if(str == "橄榄球僵尸")
         {
            return this.addSpider("zombie2");
         }
         if(str == "自动钻机")
         {
            return this.addDrilling();
         }
         if(str == "超级自动钻机")
         {
            return this.addDrilling2();
         }
         if(str == "切割者")
         {
            return this.addCutter();
         }
         if(str == "切割者-S")
         {
            return this.addCutter_S();
         }
         if(str == "冲刺者")
         {
            return this.addCutter2();
         }
         if(str == "鸵鸟机器人")
         {
            return this.addOstrich();
         }
         if(str == "追踪者")
         {
            return this.addTracker();
         }
         if(str == "追猎者")
         {
            return this.addTracker2();
         }
         if(str == "攻城坦克")
         {
            return this.addTank();
         }
         if(str == "冲锋坦克")
         {
            return this.addTank2();
         }
         if(str == "飞轮机器人")
         {
            return this.addTires();
         }
         if(str == "蜘蛛炮台")
         {
            return this.addSpiderFort();
         }
         if(str == "碾压者")
         {
            return this.addRolling();
         }
         if(str == "强袭者")
         {
            return this.addStriker();
         }
         if(str == "仲裁者")
         {
            return this.addIntercessor();
         }
         if(str == "判决者")
         {
            b0 = this.addIntercessor();
            b0.define.name = "判决者";
            b0.changeB = true;
            return b0;
         }
         if(str == "炮装审判者")
         {
            return this.addGundam();
         }
         if(str == "剑装审判者")
         {
            return this.addGundam2();
         }
         if(str == "地面自动炮台")
         {
            return this.addLandFort();
         }
         if(str == "警报塔")
         {
            return this.addAlarmTower();
         }
         if(str == "原子塔")
         {
            return this.addAtomicTower();
         }
         if(str == "原子反应堆")
         {
            return this.addAtomicTower2();
         }
         if(str == "巨型压路机")
         {
            return this.addGear();
         }
         if(str == "叛军")
         {
            return this.addEnemyHeroBody();
         }
         if(str == "闪电球")
         {
            return this.addLightingBall();
         }
         if(str == "七彩球")
         {
            return this.addLightingBall("SevenBall");
         }
         if(str == "圣堂战机")
         {
            return this.addHavenFighter();
         }
         if(str == "猎隼战机")
         {
            return this.addSakerFighter();
         }
         if(str == "小型压路机")
         {
            return this.addGear2();
         }
         if(str == "狂热者")
         {
            return this.addZealot();
         }
         if(str == "先知")
         {
            return this.addKnowing();
         }
         if(str == "黑暗先知")
         {
            return this.addKnowing2();
         }
         if(str == "X7")
         {
            return this.addX7();
         }
         if(str == "黑暗之刃")
         {
            return this.addDarkTemplar();
         }
         if(str == "暴君")
         {
            return this.addTyrant();
         }
         if(str == "渗透者")
         {
            return this.addInfiltrator();
         }
         if(str == "SAX-15D攻击机器人")
         {
            return this.addNormal_Land("Saxrobot",2);
         }
         if(str == "虎鲨坦克")
         {
            return this.addNormal_Land("SharkTank",2);
         }
         if(str == "防卫卫星")
         {
            return this.addSatellite();
         }
         if(str == "旋翼攻击机")
         {
            return this.addNormal_Fly("Rotorcraft",2);
         }
         if(str == "入侵者飞艇")
         {
            return this.addNormal_Fly("Intruder",2,true,null);
         }
         if(str == "机械路霸")
         {
            return this.addLoadKing();
         }
         if(str == "防御激光炮")
         {
            return this.addNormal_Land("LandLaser",1,false,this.LandFort_arr,LandFort_AI2);
         }
         if(str == "月面陆基激光炮")
         {
            return this.addNormal_Land("Ground_laser",1,false,this.LandFort_arr,LandFort_AI3);
         }
         if(str == "掠食者")
         {
            return this.addNormal_Land("Predator",3,true);
         }
         if(str == "SAX-DJ机器人")
         {
            return this.addNormal_Land("ElectricSaw2",2,true);
         }
         if(str == "投掷者")
         {
            return this.addNormal_Land("Infiltrator2",1,false,null,Infiltrator2_AI);
         }
         if(str == "雷霆")
         {
            return this.addNormal_Land("LoadKing2",2,true,null,LoadKing2_AI);
         }
         if(str == "巡天者")
         {
            return this.addNormal_Fly("SkyPatrol",1);
         }
         if(str == "猛犸战神")
         {
            return this.addNormal_Land("Mammoth",3,true,null,Mammoth_AI);
         }
         if(str == "旋风战机")
         {
            return this.addNormal_Fly("TornadoFighter",2,false,Normal_Fly_AI2);
         }
         if(str == "闪电坦克")
         {
            return this.addNormal_Land("LightningTank",2);
         }
         if(str == "黑暗剑装审判者")
         {
            return this.addGundam3();
         }
         if(str == "风暴战神")
         {
            return this.addNormal_Land("Twogun",5,true,null,Twogun_AI);
         }
         if(str == "凯斯特推土机")
         {
            return this.addNormal_Land("Bulldozer",4,true);
         }
         if(str == "机械剑齿虎")
         {
            return this.addNormal_Land("Tiger",5,true,null,Tiger_AI);
         }
         if(str == "钢铁暴牛兽")
         {
            return this.addNormal_Land("xiniu",4,true,null,Xiniu_AI);
         }
         if(str == "领域守卫官")
         {
            return this.addWarden();
         }
         if(str == "小守卫")
         {
            return this.addNormal_Fly("SmallWarden");
         }
         if(str == "风暴战士")
         {
            b0 = this.addNormal_Change("StormTroopers",2);
            b0.ai.flyAttackIndex = [1];
            b0.ai.waiAttackOver();
            return b0;
         }
         if(str == "风暴勇士")
         {
            b0 = this.addNormal_Fly("StormWarriors",3);
            b0.ai.skill.setSkillArr(["BackPlasma"]);
            return b0;
         }
         if(str == "激光战神苏拉")
         {
            b0 = this.addNormal_Land("Sula",3,true);
            b0.ai.noHurtType = "energy";
            return b0;
         }
         e_d0 = Game.defineGroup.getEnemyDefine_byCnName(str);
         if(Boolean(e_d0))
         {
            armsList0 = Game.defineGroup.getArmsDefineArr(e_d0.id,"enemyArms");
            if(armsList0.length > 0)
            {
               if(e_d0.isAir())
               {
                  trace("添加空中怪物：" + e_d0.id);
                  return this.addNormal_Fly(e_d0.id,armsList0.length,e_d0.haveAttackRectB());
               }
               trace("添加地面怪物：" + e_d0.id);
               return this.addNormal_Land(e_d0.id,armsList0.length,e_d0.haveAttackRectB());
            }
            throw new Error("没找到单位：" + str + "的武器定义" + e_d0.id);
         }
         trace("没找到单位：" + str);
      }
      
      public function addLifeBar(b0:*, color0:int = 0) : *
      {
         var l0:EnemyLifeBar = null;
         var ed0:EnemyDefine = b0.define;
         if(ed0.lifeBar == null)
         {
            l0 = new EnemyLifeBar();
            l0.BB = b0;
            l0.cx = 0;
            l0.cy = ed0.hitRect.y;
            ed0.lifeBar = l0;
            Game.gameSprite.textL.addChild(l0);
            if(color0 == 1)
            {
               l0.transform.colorTransform = new ColorTransform(1,1,1,1,0,100,-50,0);
            }
            this.lifeBar_arr.push(l0);
         }
      }
      
      public function delLifeBar(b0:*) : *
      {
         var l0:EnemyLifeBar = b0.define.lifeBar;
         if(l0 is EnemyLifeBar)
         {
            Game.gameSprite.textL.removeChild(l0);
            this.lifeBar_arr.splice(this.lifeBar_arr.indexOf(l0),1);
            l0.BB = null;
            b0.define.lifeBar = null;
         }
      }
      
      public function delAllLifeBar() : *
      {
         var n:* = undefined;
         var l0:EnemyLifeBar = null;
         for(n in this.lifeBar_arr)
         {
            l0 = this.lifeBar_arr[n];
            Game.gameSprite.textL.removeChild(l0);
            l0.BB = null;
         }
         this.lifeBar_arr.length = 0;
      }
      
      public function addThingsBody(label0:String, x0:int) : ThingsBody
      {
         var th0:ThingsBody = new ThingsBody();
         var mc0:MovieClip = this.swfLoaderManager.getResource("things",label0);
         th0.setImg(mc0);
         this.gameSprite.effectL2.addChild(th0.img);
         var minY:int = Game.BGHit.getMinY(x0);
         th0.x = x0;
         th0.y = minY + 2;
         this.things_arr.push(th0);
         return th0;
      }
      
      public function addHeroCarBody() : HeroCarBody
      {
         var m:int = 0;
         var hero0:HeroCarBody = new HeroCarBody();
         hero0.carDefine.xml = XML(this.textLoaderManager.getResource("car").data);
         this.inputMC_list(hero0.img.car,"car",Game.defineGroup.carImgLabelArr,true);
         this.inputMC_list(hero0.img.arms,"arms",Game.defineGroup.armsImgLabelArr,true);
         this.inputMC_list(hero0.img.fly.img,"heroFly",["stop","toFly","toStand"]);
         hero0.img.fly.img.gotoAndPlayIndex(0);
         for(hero0.img.fly.setArmMc(this.swfLoaderManager.getResource("heroFly","arm")); m < 12; )
         {
            hero0.img.car.rocket.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","rocket_lv" + (m + 1)));
            hero0.img.car.plasma.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasma_lv" + (m + 1)));
            m++;
         }
         hero0.img.car.rocket.showMC("rocket_lv1");
         hero0.img.car.plasma.showMC("plasma_lv1");
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield_open"));
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield"));
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield_close"));
         hero0.changeCar("beetle");
         hero0.changeArms("soya");
         hero0.img.ArmsFollowCar();
         hero0.mot.x0 = 300;
         hero0.mot.y0 = 200;
         this.gameSprite.heroL.addChild(hero0.img);
         this.heroCar_arr.push(hero0);
         this.hero = hero0;
         return hero0;
      }
      
      public function addLieutenantBody() : LieutenantBody
      {
         var hero0:LieutenantBody = new LieutenantBody();
         hero0.carDefine.xml = XML(this.textLoaderManager.getResource("car").data);
         hero0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("car","razer",true));
         this.inputMC_list(hero0.img.arms,"arms",LieutenantBody.MAIN_WEAPON_IMAGES,true);
         hero0.img.car.rocket.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","rocket_lv6"));
         hero0.img.car.rocket.showMC("rocket_lv6");
         hero0.img.car.plasma.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasma_lv3"));
         hero0.img.car.plasma.showMC("plasma_lv3");
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield_open"));
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield"));
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield_close"));
         hero0.changeCar("razer");
         hero0.changeArms(LieutenantBody.INITIAL_MAIN_WEAPON);
         hero0.img.ArmsFollowCar();
         hero0.mot.x0 = 100;
         hero0.mot.y0 = 200;
         this.gameSprite.heroL.addChild(hero0.img);
         this.heroCar_arr.push(hero0);
         return hero0;
      }
      
      public function addSubBody() : SubBody
      {
         var sub0:SubBody = new SubBody();
         sub0.carDefine.xml = XML(this.textLoaderManager.getResource("subCar").data);
         sub0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("sub","subCar_blue",true));
         sub0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("sub","subCar_red",true));
         sub0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("sub","subCar_yellow",true));
         var tvcBlue0:* = this.swfLoaderManager.getSingleMovieclip("sub25","subCar_blue",true);
         if(tvcBlue0 != null)
         {
            tvcBlue0.label = "subCar_tvc_blue";
            sub0.img.car.addSingleMovieclip(tvcBlue0);
         }
         var tvcRed0:* = this.swfLoaderManager.getSingleMovieclip("sub25","subCar_red",true);
         if(tvcRed0 != null)
         {
            tvcRed0.label = "subCar_tvc_red";
            sub0.img.car.addSingleMovieclip(tvcRed0);
         }
         var tvcYellow0:* = this.swfLoaderManager.getSingleMovieclip("sub25","subCar_yellow",true);
         if(tvcYellow0 != null)
         {
            tvcYellow0.label = "subCar_tvc_yellow";
            sub0.img.car.addSingleMovieclip(tvcYellow0);
         }
         this.inputMC_list(sub0.img.arms,"sub",Game.defineGroup.subImgLabelArr,true);
         sub0.mot.vxmax *= 1.5;
         sub0.changeCar("subCar_blue");
         sub0.img.ArmsFollowCar();
         this.gameSprite.flyL.addChild(sub0.img);
         this.sub_arr.push(sub0);
         return sub0;
      }
      
      public function addEnemyHeroBody() : EnemyHeroBody
      {
         var m:int = 0;
         var hero0:EnemyHeroBody = new EnemyHeroBody();
         hero0.carDefine.xml = XML(this.textLoaderManager.getResource("car").data);
         this.inputMC_list(hero0.img.car,"car",Game.defineGroup.carImgLabelArr,true);
         for(this.inputMC_list(hero0.img.arms,"arms",Game.defineGroup.armsImgLabelArr,true); m < 12; )
         {
            hero0.img.car.rocket.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","rocket_lv" + (m + 1)));
            hero0.img.car.plasma.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasma_lv" + (m + 1)));
            m++;
         }
         hero0.img.car.rocket.showMC("rocket_lv1");
         hero0.img.car.plasma.showMC("plasma_lv1");
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield_open"));
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield"));
         hero0.img.plasmaShield.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("parts","plasmaShield_close"));
         hero0.changeCar("batman");
         hero0.changeArms("fireFairy",0);
         hero0.img.ArmsFollowCar();
         hero0.mot.x0 = 100;
         hero0.mot.y0 = 200;
         this.gameSprite.heroL.addChild(hero0.img);
         this.enemyHero_arr.push(hero0);
         return hero0;
      }
      
      public function addEnemySubBody() : SubBody
      {
         var sub0:SubBody = new SubBody();
         sub0.camp = "enemy";
         sub0.carDefine.xml = XML(this.textLoaderManager.getResource("subCar").data);
         sub0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("sub","subCar_blue",true));
         sub0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("sub","subCar_red",true));
         sub0.img.car.addSingleMovieclip(this.swfLoaderManager.getSingleMovieclip("sub","subCar_yellow",true));
         var tvcBlue0:* = this.swfLoaderManager.getSingleMovieclip("sub25","subCar_blue",true);
         if(tvcBlue0 != null)
         {
            tvcBlue0.label = "subCar_tvc_blue";
            sub0.img.car.addSingleMovieclip(tvcBlue0);
         }
         var tvcRed0:* = this.swfLoaderManager.getSingleMovieclip("sub25","subCar_red",true);
         if(tvcRed0 != null)
         {
            tvcRed0.label = "subCar_tvc_red";
            sub0.img.car.addSingleMovieclip(tvcRed0);
         }
         var tvcYellow0:* = this.swfLoaderManager.getSingleMovieclip("sub25","subCar_yellow",true);
         if(tvcYellow0 != null)
         {
            tvcYellow0.label = "subCar_tvc_yellow";
            sub0.img.car.addSingleMovieclip(tvcYellow0);
         }
         this.inputMC_list(sub0.img.arms,"sub",Game.defineGroup.subImgLabelArr,true);
         sub0.mot.vxmax *= 1.5;
         sub0.changeCar("subCar_blue");
         sub0.img.ArmsFollowCar();
         this.gameSprite.flyL.addChild(sub0.img);
         this.enemySub_arr.push(sub0);
         return sub0;
      }
      
      public function addGundam() : GundamBody
      {
         var b0:GundamBody = new GundamBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Gundam"));
         b0.armsDefine.inData("Gundam_land",0);
         this.inputMC_list(b0.img,"Gundam",b0.define.imgList);
         b0.img.goPlayLoop("fly");
         this.gameSprite.enemyL.addChild(b0.img);
         b0.x = 500;
         b0.y = 300;
         this.Gundam_arr.push(b0);
         return b0;
      }
      
      public function addGundamFunnel(father0:String = "bullet") : FunnelBody
      {
         var b0:FunnelBody = new FunnelBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("GundamFunnel"));
         this.inputMC_list(b0.img,father0,b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.attack();
         this.gameSprite.enemyL.addChild(b0.img);
         this.GundamFunnel_arr.push(b0);
         return b0;
      }
      
      public function addGundam2() : GundamBody2
      {
         var b0:GundamBody2 = new GundamBody2();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Gundam2"));
         this.inputMC_list(b0.img,"Gundam2",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         b0.img.addAttackData(b0.define.attackData);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Gundam2_arr.push(b0);
         return b0;
      }
      
      public function addGundam3() : GundamBody2
      {
         var b0:GundamBody2 = new GundamBody2();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Gundam3"));
         this.inputMC_list(b0.img,"Gundam3",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         b0.img.addAttackData(b0.define.attackData);
         this.gameSprite.enemyL.addChild(b0.img);
         b0.ai.openGundam3B = true;
         this.Gundam2_arr.push(b0);
         return b0;
      }
      
      public function addAirLaserFort(str0:String = "AirLaserFort", enemyB:Boolean = true) : AirLaserFortBody
      {
         var b0:AirLaserFortBody = new AirLaserFortBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(str0));
         b0.armsDefine.inData(str0,0);
         this.inputMC_list(b0.img,str0,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(enemyB)
         {
            this.AirLaserFort_arr.push(b0);
         }
         else
         {
            this.weAir_arr.push(b0);
         }
         return b0;
      }
      
      public function addTercelFighter() : TercelFighterBody
      {
         var b0:TercelFighterBody = new TercelFighterBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("TercelFighter"));
         b0.armsDefine.inData("TercelFighter",0);
         this.inputMC_list(b0.img,"TercelFighter",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.TercelFighter_arr.push(b0);
         return b0;
      }
      
      public function addFalconFighter(camp0:String = "enemy") : FalconFighterBody
      {
         var b0:FalconFighterBody = new FalconFighterBody();
         b0.camp = camp0;
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("FalconFighter"));
         b0.armsDefine.inData("FalconFighter",0);
         this.inputMC_list(b0.img,"FalconFighter",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(camp0 == "enemy")
         {
            this.FalconFighter_arr.push(b0);
         }
         else
         {
            this.weAir_arr.push(b0);
         }
         return b0;
      }
      
      public function addBansheeFighter(str0:String = "") : BansheeFighterBody
      {
         var b0:BansheeFighterBody = new BansheeFighterBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("BansheeFighter" + str0));
         b0.armsDefine.inData("BansheeFighter_2",0);
         this.inputMC_list(b0.img,"BansheeFighter" + str0,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(str0 == "")
         {
            this.BansheeFighter_arr.push(b0);
         }
         else
         {
            this.weBanshee_arr.push(b0);
         }
         return b0;
      }
      
      public function addElectricSaw() : ElectricSawBody
      {
         var b0:ElectricSawBody = new ElectricSawBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("ElectricSaw"));
         this.inputMC_list(b0.img,"ElectricSaw",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         b0.img.addAttackData(b0.define.attackData);
         this.ElectricSaw_arr.push(b0);
         return b0;
      }
      
      public function addCharger() : ChargerBody
      {
         var b0:ChargerBody = new ChargerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Charger"));
         b0.armsDefine.inData("Charger_1",0);
         this.inputMC_list(b0.img,"Charger",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         b0.x = 500;
         b0.y = 300;
         this.Charger_arr.push(b0);
         return b0;
      }
      
      public function addSpider(str:String = "Spider") : SpiderBody
      {
         var b0:SpiderBody = new SpiderBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(str));
         this.inputMC_list(b0.img,str,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Spider_arr.push(b0);
         return b0;
      }
      
      public function addDrilling() : DrillingBody
      {
         var b0:DrillingBody = new DrillingBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Drilling"));
         this.inputMC_list(b0.img,"Drilling",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         b0.img.addAttackData(b0.define.attackData);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addDrilling2() : DrillingBody2
      {
         var b0:DrillingBody2 = new DrillingBody2();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Drilling2"));
         this.inputMC_list(b0.img,"Drilling2",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         b0.img.addAttackData(b0.define.attackData);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addOstrich() : OstrichBody
      {
         var b0:OstrichBody = new OstrichBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Ostrich"));
         b0.armsDefine.inData("Ostrich",0);
         this.inputMC_list(b0.img,"Ostrich",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Ostrich_arr.push(b0);
         return b0;
      }
      
      public function addTracker() : TrackerBody
      {
         var b0:TrackerBody = new TrackerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Tracker"));
         b0.armsDefine.inData("Tracker",0);
         this.inputMC_list(b0.img,"Tracker",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Tracker_arr.push(b0);
         return b0;
      }
      
      public function addTracker2() : TrackerBody
      {
         var b0:TrackerBody = new TrackerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Tracker2"));
         b0.armsDefine.inData("Tracker2",0);
         this.inputMC_list(b0.img,"Tracker2",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Tracker_arr.push(b0);
         return b0;
      }
      
      public function addTank() : TankBody
      {
         var b0:TankBody = new TankBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Tank"));
         b0.armsDefine.inData("Tank_1",0);
         this.inputMC_list(b0.img,"Tank",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Tank_arr.push(b0);
         return b0;
      }
      
      public function addTank2(camp0:String = "enemy") : TankBody2
      {
         var b0:TankBody2 = new TankBody2();
         b0.camp = camp0;
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Tank2"));
         b0.armsDefine.inData("Tank2",0);
         this.inputMC_list(b0.img,"Tank2",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(camp0 == "enemy")
         {
            this.Tank_arr.push(b0);
         }
         else
         {
            this.weLand_arr.push(b0);
         }
         return b0;
      }
      
      public function addTires() : TiresBody
      {
         var b0:TiresBody = new TiresBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Tires"));
         b0.armsDefine.inData("Tires_1",0);
         this.inputMC_list(b0.img,"Tires",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Tank_arr.push(b0);
         return b0;
      }
      
      public function addSpiderFort() : SpiderFortBody
      {
         var b0:SpiderFortBody = new SpiderFortBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("SpiderFort"));
         b0.armsDefine.inData("SpiderFort_1",0);
         this.inputMC_list(b0.img,"SpiderFort",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Tank_arr.push(b0);
         return b0;
      }
      
      public function addRolling() : RollingBody
      {
         var b0:RollingBody = new RollingBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Rolling"));
         b0.armsDefine.inData("Rolling_1",0);
         this.inputMC_list(b0.img,"Rolling",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Rolling_arr.push(b0);
         return b0;
      }
      
      public function addKnowing() : KnowingBody
      {
         var b0:KnowingBody = new KnowingBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Knowing"));
         b0.armsDefine.inData("Knowing",0);
         this.inputMC_list(b0.img,"Knowing",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Rolling_arr.push(b0);
         return b0;
      }
      
      public function addX7() : KnowingX7Body
      {
         var b0:KnowingX7Body = new KnowingX7Body();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("X7"));
         b0.armsDefine.inData("X7",0);
         this.inputMC_list(b0.img,"X7",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Rolling_arr.push(b0);
         return b0;
      }
      
      public function addKnowing2() : KnowingBody
      {
         var b0:KnowingBody = new KnowingBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("heianxianzhi"));
         b0.armsDefine.inData("heianxianzhi",0);
         this.inputMC_list(b0.img,"heianxianzhi",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Rolling_arr.push(b0);
         return b0;
      }
      
      public function addStriker() : StrikerBody
      {
         var b0:StrikerBody = new StrikerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Striker"));
         this.inputMC_list(b0.img,"Striker",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Striker_arr.push(b0);
         return b0;
      }
      
      public function addIntercessor() : IntercessorBody
      {
         var b0:IntercessorBody = new IntercessorBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Intercessor"));
         b0.armsDefine.inData("Intercessor",0);
         this.inputMC_list(b0.img,"Intercessor",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Intercessor_arr.push(b0);
         return b0;
      }
      
      public function addSlayer() : SlayerBody
      {
         var b0:SlayerBody = new SlayerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Slayer"));
         b0.armsDefine.inData("Charger_1",0);
         this.inputMC_list(b0.img,"Slayer",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         b0.x = 500;
         b0.y = 300;
         this.Charger_arr.push(b0);
         return b0;
      }
      
      public function addCutter() : CutterBody
      {
         var b0:CutterBody = new CutterBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Cutter"));
         this.inputMC_list(b0.img,"Cutter",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addCutter_S() : CutterBody
      {
         var b0:CutterBody = new CutterBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Cutter_S"));
         this.inputMC_list(b0.img,"Cutter_S",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addLightingBall(nameLabel:String = "LightingBall") : LighingBallBody
      {
         var b0:LighingBallBody = new LighingBallBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(nameLabel));
         b0.ai.ballType = nameLabel;
         this.inputMC_list(b0.img,nameLabel,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addCutter2() : CutterBody2
      {
         var b0:CutterBody2 = new CutterBody2();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Cutter2"));
         this.inputMC_list(b0.img,"Cutter2",b0.define.imgList);
         b0.armsDefine.inData("Cutter2",0);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Ostrich_arr.push(b0);
         return b0;
      }
      
      public function addLandFort() : LandFortBody
      {
         var b0:LandFortBody = new LandFortBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("LandFort"));
         this.inputMC_list(b0.img,"LandFort",b0.define.imgList);
         b0.armsDefine.inData("LandFort",0);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.LandFort_arr.push(b0);
         return b0;
      }
      
      public function addAtomicTower() : AtomicTowerBody
      {
         var b0:AtomicTowerBody = new AtomicTowerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("AtomicTower"));
         this.inputMC_list(b0.img,"AtomicTower",b0.define.imgList);
         b0.armsDefine.inData("AtomicTower",0);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.AtomicTower_arr.push(b0);
         return b0;
      }
      
      public function addAtomicTower2() : AtomicTowerBody
      {
         var b0:AtomicTowerBody = new AtomicTowerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("AtomicTower2"));
         b0.ai.armsNum = 4;
         this.inputMC_list(b0.img,"AtomicTower2",b0.define.imgList);
         b0.armsDefine.inData("AtomicTower2",0);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.AtomicTower_arr.push(b0);
         return b0;
      }
      
      public function addGear() : GearBody
      {
         var b0:GearBody = new GearBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Gear"));
         this.inputMC_list(b0.img,"Gear",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Gear_arr.push(b0);
         return b0;
      }
      
      public function addAlarmTower() : AlarmTowerBody
      {
         var b0:AlarmTowerBody = new AlarmTowerBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("AlarmTower"));
         this.inputMC_list(b0.img,"AlarmTower",b0.define.imgList);
         b0.armsDefine.inData("AlarmTower",0);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.LandFort_arr.push(b0);
         return b0;
      }
      
      public function addHavenFighter() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(HavenFighter_AI,Normal_Animation,"fly","fly");
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("HavenFighter"));
         b0.armsDefine.inData("HavenFighter",0);
         this.inputMC_list(b0.img,"HavenFighter",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addSakerFighter() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(SakerFighter_AI,Normal_Animation,"fly","fly");
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("SakerFighter"));
         b0.armsDefine.inData("SakerFighter",0);
         this.inputMC_list(b0.img,"SakerFighter",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Drilling_arr.push(b0);
         return b0;
      }
      
      public function addZealot() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(Ostrich_AI,ElectricSawAnimation);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Zealot"));
         b0.armsDefine.inData("Zealot",0);
         this.inputMC_list(b0.img,"Zealot",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Tracker_arr.push(b0);
         return b0;
      }
      
      public function addGear2() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(Gear2_AI,ElectricSawAnimation);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Gear2"));
         this.inputMC_list(b0.img,"Gear2",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.ElectricSaw_arr.push(b0);
         return b0;
      }
      
      public function addEngineers() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.camp = "we";
         b0.setAiClass(Ostrich_AI,ElectricSawAnimation);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Engineers"));
         b0.armsDefine.inData("Ostrich",1);
         this.inputMC_list(b0.img,"Engineers",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.weLand_arr.push(b0);
         return b0;
      }
      
      public function addDarkTemplar() : DarkTemplarBody
      {
         var b0:DarkTemplarBody = new DarkTemplarBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("DarkTemplar"));
         this.inputMC_list(b0.img,"DarkTemplar",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Striker_arr.push(b0);
         return b0;
      }
      
      public function addTyrant() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(Tyrant_AI,ElectricSawAnimation);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Tyrant"));
         b0.armsDefine.inData("Tyrant",1);
         this.inputMC_list(b0.img,"Tyrant",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         b0.shakeRange = 12;
         this.gameSprite.enemyL.addChild(b0.img);
         this.Rolling_arr.push(b0);
         return b0;
      }
      
      public function addInfiltrator() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(Infiltrator_AI,ElectricSawAnimation);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Infiltrator"));
         this.inputMC_list(b0.img,"Infiltrator",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.ElectricSaw_arr.push(b0);
         return b0;
      }
      
      public function addNormal_Land(enemyName0:String, armsNum0:int = 1, hitHurt:Boolean = false, arr0:Array = null, class0:Class = null) : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         if(class0 is Class)
         {
            b0.setAiClass(class0,ElectricSawAnimation);
         }
         else
         {
            b0.setAiClass(Normal_Land_AI,ElectricSawAnimation);
         }
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(enemyName0));
         b0.armsDefine.inData(enemyName0,0);
         if(Boolean(b0.ai.hasOwnProperty("armsName")))
         {
            b0.ai.armsName = enemyName0;
            b0.ai.armsNum = armsNum0;
         }
         this.inputMC_list(b0.img,enemyName0,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(hitHurt)
         {
            b0.img.addAttackData(b0.define.attackData);
            if(arr0 is Array)
            {
               arr0.push(b0);
            }
            else
            {
               this.Rolling_arr.push(b0);
            }
         }
         else if(arr0 is Array)
         {
            arr0.push(b0);
         }
         else
         {
            this.Ostrich_arr.push(b0);
         }
         b0.ai.chooseAttack();
         return b0;
      }
      
      public function addNormal_Change(enemyName0:String, armsNum0:int = 1, hitHurt:Boolean = false, arr0:Array = null, class0:Class = null) : Normal_ChangeBody
      {
         var b0:Normal_ChangeBody = new Normal_ChangeBody();
         b0.setAiClass(class0);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(enemyName0));
         b0.armsDefine.inData(enemyName0,0);
         if(b0.ai.hasOwnProperty("armsName"))
         {
            b0.ai.armsName = enemyName0;
            b0.ai.armsNum = armsNum0;
         }
         this.inputMC_list(b0.img,enemyName0,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(hitHurt)
         {
            b0.img.addAttackData(b0.define.attackData);
         }
         this.Gundam_arr.push(b0);
         b0.ai.chooseAttack();
         return b0;
      }
      
      public function addWarden() : WardenBody
      {
         var enemyName0:String = "Warden";
         var b0:WardenBody = new WardenBody();
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(enemyName0));
         b0.armsDefine.inData(enemyName0,1);
         b0.define.rectLevel = 1;
         b0.ai.armsName = enemyName0;
         this.inputMC_list(b0.img,enemyName0,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         b0.img.addAttackData(b0.define.attackData);
         this.Gundam_arr.push(b0);
         return b0;
      }
      
      public function addNormal_Fly(enemyName0:String, armsNum0:int = 1, hitHurt:Boolean = false, _aiClass:Class = null, _skillClass:Class = null) : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         if(_aiClass == null)
         {
            _aiClass = Normal_Fly_AI;
         }
         b0.setAiClass(_aiClass,Normal_Animation,"fly","fly",_skillClass);
         b0.inData_byXML(this.textLoaderManager.getEnemyXML(enemyName0));
         b0.armsDefine.inData(enemyName0,0);
         b0.ai.armsName = enemyName0;
         b0.ai.armsNum = armsNum0;
         this.inputMC_list(b0.img,enemyName0,b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         if(hitHurt)
         {
            b0.img.addAttackData(b0.define.attackData);
            this.Drilling_arr.push(b0);
         }
         else
         {
            this.BansheeFighter_arr.push(b0);
         }
         return b0;
      }
      
      public function addSatellite() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(Satellite_AI,Normal_Animation,"fly","fly");
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Satellite"));
         this.inputMC_list(b0.img,"Satellite",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.AirLaserFort_arr.push(b0);
         return b0;
      }
      
      public function addSmallSatellite() : SmallSatelliteBody
      {
         var b0:SmallSatelliteBody = new SmallSatelliteBody();
         b0.setAiClass(SmallSatellite_AI,"fly","fly");
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("Satellite_small"));
         this.inputMC_list(b0.img,"Satellite_small",b0.define.imgList);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChildAt(b0.img,0);
         this.SmallSatellite_arr.push(b0);
         return b0;
      }
      
      public function addLoadKing() : Normal_FlyBody
      {
         var b0:Normal_FlyBody = new Normal_FlyBody();
         b0.setAiClass(LoadKing_AI,ElectricSawAnimation);
         b0.shakeRange = 6;
         b0.inData_byXML(this.textLoaderManager.getEnemyXML("LoadKing"));
         b0.armsDefine.inData("LoadKing",1);
         this.inputMC_list(b0.img,"LoadKing",b0.define.imgList);
         b0.img.addAttackData(b0.define.attackData);
         b0.img.gotoAndPlayIndex(0);
         this.gameSprite.enemyL.addChild(b0.img);
         this.Rolling_arr.push(b0);
         return b0;
      }
      
      public function addSupply() : MovieClip
      {
         var mc0:MovieClip = this.swfLoaderManager.getResource("parts","supply");
         mc0.stop();
         this.supply_arr.push(mc0);
         this.gameSprite.effectL2.addChild(mc0);
         return mc0;
      }
      
      public function addPortal() : MovieClip
      {
         var mc0:MovieClip = this.swfLoaderManager.getResource("parts","portal");
         mc0.stop();
         this.supply_arr.push(mc0);
         this.gameSprite.effectL2.addChild(mc0);
         return mc0;
      }
      
      public function getArr_byTrueName(str0:String) : Array
      {
         var n:* = undefined;
         var i:* = undefined;
         var b0:* = undefined;
         var arr0:Array = [];
         for(n in this.enemy_arr)
         {
            for(i in this.enemy_arr[n])
            {
               b0 = this.enemy_arr[n][i];
               if(b0.define.trueName == str0)
               {
                  arr0.push(b0);
               }
            }
         }
         return arr0;
      }
      
      public function shootEvent(event:AttackEvent) : *
      {
         var smc:SingleMovieclip = null;
         var bullet0:* = event.bullet;
         if(bullet0.specialType == "Sula_Laser")
         {
            event.x0 = this.hero.mot.x0;
            event.y0 = Game.BGHit.getMinY(event.x0) - 20;
         }
         var hero0:* = event.attackBody;
         var imgLabel0:String = bullet0.imgLabel;
         if(imgLabel0 != "")
         {
            smc = this.swfLoaderManager.getSingleMovieclip(bullet0.imgFather,imgLabel0);
            bullet0.init(smc,event.x0,event.y0,event.v0,event.ra,event.vmax,event.va);
            if(imgLabel0.indexOf("charged_bullet") >= 0 || imgLabel0.indexOf("dragonHead") >= 0)
            {
               this.gameSprite.effectL2.addChild(bullet0.img.mc);
            }
            else if(imgLabel0.indexOf("positron") >= 0)
            {
               this.gameSprite.enemyL.addChild(bullet0.img.mc);
            }
            else
            {
               this.gameSprite.bulletL.addChild(bullet0.img.mc);
            }
            if(bullet0.bulletType == "laser" || smc.totalFrames > 1)
            {
               bullet0.img.play();
            }
            else
            {
               bullet0.img.stop();
            }
         }
         else
         {
            bullet0.init(null,event.x0,event.y0,event.v0,event.ra,event.vmax,event.va);
         }
         if(event.attackBody.camp == "we")
         {
            this.we_bullet.push(bullet0);
         }
         else if(event.attackBody.camp == "enemy")
         {
            this.enemy_bullet.push(bullet0);
         }
      }
      
      public function allEnemyAttackHero(b0:* = null, panRebirthB:Boolean = false) : *
      {
         var n:* = undefined;
         var arr0:Array = null;
         for(n in this.enemy_arr)
         {
            arr0 = this.enemy_arr[n];
            this.attackBody_byArr(arr0,b0,panRebirthB);
         }
      }
      
      public function attackBody_byArr(arr0:Array, b0:* = null, panRebirthB:Boolean = false) : *
      {
         var m:* = undefined;
         for(m in arr0)
         {
            if(arr0[m].die == 0)
            {
               if(Boolean(arr0[m].hasOwnProperty("ai")))
               {
                  if(panRebirthB)
                  {
                     if(!arr0[m].ai.attackBodyAffterRebirthB)
                     {
                        continue;
                     }
                  }
                  if(b0 == null)
                  {
                     arr0[m].ai.attackBody(this.hero);
                  }
                  else
                  {
                     arr0[m].ai.attackBody(b0);
                  }
               }
            }
         }
      }
      
      public function unlockArr(arr0:Array) : *
      {
         var m:* = undefined;
         for(m in arr0)
         {
            arr0[m].mot.viewB = false;
         }
      }
      
      public function getLive(arr0:Array) : Array
      {
         var n:* = undefined;
         var b0:* = undefined;
         var newArr:Array = [];
         for(n in arr0)
         {
            b0 = arr0[n];
            if(b0.die == 0 && b0.camp == "enemy")
            {
               newArr[newArr.length] = b0;
            }
         }
         return newArr;
      }
      
      public function getLiveEnemy() : Array
      {
         var n:* = undefined;
         var newArr:Array = [];
         for(n in this.enemy_arr)
         {
            newArr = newArr.concat(this.getLive(this.enemy_arr[n]));
         }
         return newArr;
      }
      
      public function getLiveEnemyB() : Boolean
      {
         var n:* = undefined;
         for(n in this.enemy_arr)
         {
            if(this.enemy_arr[n].length > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getLiveEnemyB2() : Boolean
      {
         var n:* = undefined;
         var m:* = undefined;
         var i:* = undefined;
         var j:* = undefined;
         for(n in this.enemy_arr)
         {
            if(this.enemy_arr[n].length > 0)
            {
               if(this.enemy_arr[n] == this.LandFort_arr)
               {
                  for(m in this.enemy_arr[n])
                  {
                     if(this.enemy_arr[n][m].die == 0 && this.enemy_arr[n][m].hitHurtB == 0)
                     {
                        return true;
                     }
                  }
               }
               else if(this.enemy_arr[n] == this.Gear_arr)
               {
                  for(i in this.enemy_arr[n])
                  {
                     if(this.enemy_arr[n][i].die == 0 && this.enemy_arr[n][i].define.maxLife < 99999999)
                     {
                        return true;
                     }
                  }
               }
               else if(this.enemy_arr[n] != this.SmallSatellite_arr)
               {
                  for(j in this.enemy_arr[n])
                  {
                     if(this.enemy_arr[n][j].die == 0)
                     {
                        return true;
                     }
                  }
               }
            }
         }
         return false;
      }
      
      public function getHurt(arr0:Array) : Array
      {
         var n:* = undefined;
         var b0:* = undefined;
         var newArr:Array = [];
         for(n in arr0)
         {
            b0 = arr0[n];
            if(b0.hitHurtB == 0)
            {
               newArr[newArr.length] = b0;
            }
         }
         return newArr;
      }
      
      public function getHurt_Arr2(arr2:Array) : Array
      {
         var m:* = undefined;
         var arr0:Array = null;
         var n:* = undefined;
         var b0:* = undefined;
         var newArr:Array = [];
         for(m in arr2)
         {
            arr0 = arr2[m];
            for(n in arr0)
            {
               b0 = arr0[n];
               if(b0.hitHurtB == 0 && Boolean(b0.img.visible))
               {
                  newArr[newArr.length] = b0;
               }
            }
         }
         return newArr;
      }
      
      public function getHurt_RandomEnemy() : *
      {
         var arr0:Array = this.getHurt_Arr2(this.enemy_arr);
         return arr0[int(arr0.length * Math.random())];
      }
      
      public function getHurt_RandomWe() : *
      {
         var arr0:Array = this.getHurtWe();
         return arr0[int(arr0.length * Math.random())];
      }
      
      public function getHurt_Random(camp0:String) : *
      {
         if(camp0 == "enemy")
         {
            return this.getHurt_RandomWe();
         }
         if(camp0 == "we")
         {
            return this.getHurt_RandomEnemy();
         }
         return null;
      }
      
      public function getRandom_Gap(camp0:String, x0:int, y0:int, len0:int) : *
      {
         if(camp0 == "enemy")
         {
            return this.getRandom_GapInArr(this.weHit_arr,x0,y0,len0);
         }
         if(camp0 == "we")
         {
            return this.getRandom_GapInArr(this.enemy_arr,x0,y0,len0);
         }
         return null;
      }
      
      public function getRandom_GapInArr(arr0:Array, x0:int, y0:int, len0:int) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var b0:* = undefined;
         var arr2:Array = [];
         for(n in arr0)
         {
            for(m in arr0[n])
            {
               b0 = arr0[n][m];
               if(b0.die == 0 && b0.hitHurtB == 0 && Maths.Long(b0.MX - x0,b0.MY - y0) < len0)
               {
                  arr2.push(b0);
               }
            }
         }
         return arr2[int(arr2.length * Math.random())];
      }
      
      public function getHurtWe() : Array
      {
         var n:* = undefined;
         var m:* = undefined;
         var b0:* = undefined;
         var arr0:Array = [];
         for(n in this.weHit_arr)
         {
            for(m in this.weHit_arr[n])
            {
               b0 = this.weHit_arr[n][m];
               if(b0.die == 0 && b0.hitHurtB == 0)
               {
                  arr0.push(b0);
               }
            }
         }
         return arr0;
      }
      
      public function getLiveEnemy_byRect(rect0:Rectangle) : Array
      {
         var n:* = undefined;
         var m:* = undefined;
         var b0:* = undefined;
         var x0:int = 0;
         var y0:int = 0;
         var arr0:Array = [];
         for(n in this.enemy_arr)
         {
            for(m in this.enemy_arr[n])
            {
               b0 = this.enemy_arr[n][m];
               x0 = int(b0.mot.x0);
               y0 = int(b0.mot.y0);
               if(rect0.contains(x0,y0) && b0.die == 0)
               {
                  arr0.push(b0);
               }
            }
         }
         return arr0;
      }
      
      public function getHurtEnemy_byRect(rect0:Rectangle) : Array
      {
         var n:* = undefined;
         var m:* = undefined;
         var b0:* = undefined;
         var x0:int = 0;
         var y0:int = 0;
         var arr0:Array = [];
         for(n in this.enemy_arr)
         {
            for(m in this.enemy_arr[n])
            {
               b0 = this.enemy_arr[n][m];
               x0 = int(b0.mot.x0);
               y0 = int(b0.mot.y0);
               if(rect0.contains(x0,y0) && b0.die == 0 && b0.hitHurtB == 0)
               {
                  arr0.push(b0);
               }
            }
         }
         return arr0;
      }
      
      public function getEnemy_byName(type0:String, name0:String) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var b0:* = undefined;
         var type1:String = null;
         var name1:String = null;
         var arr0:Array = [];
         for(n in this.enemy_arr)
         {
            for(m in this.enemy_arr[n])
            {
               b0 = this.enemy_arr[n][m];
               type1 = b0.type;
               name1 = b0.define.name;
               if(type1 == type0 || name1 == name0)
               {
                  return b0;
               }
            }
         }
         return null;
      }
      
      public function getHurtEnemyNum() : int
      {
         var n:* = undefined;
         var m:* = undefined;
         var b0:* = undefined;
         var num0:int = 0;
         for(n in this.enemy_arr)
         {
            for(m in this.enemy_arr[n])
            {
               b0 = this.enemy_arr[n][m];
               if(b0.die == 0 && b0.hitHurtB == 0)
               {
                  num0++;
               }
            }
         }
         return num0;
      }
      
      public function getAllEnemyNum() : int
      {
         var n:* = undefined;
         var num0:int = 0;
         for(n in this.enemy_arr)
         {
            num0 += this.enemy_arr[n].length;
         }
         return num0;
      }
      
      public function delBody_inArr(arr0:Array, b0:*) : *
      {
         var f0:int = arr0.indexOf(b0);
         this.delBody_byIndex(arr0,f0);
      }
      
      public function delBody_byIndex(arr0:Array, index0:int) : *
      {
         var b0:* = undefined;
         if(index0 >= 0 && index0 < arr0.length)
         {
            b0 = arr0[index0];
            if(b0.img != null)
            {
               b0.img.clear();
               if(b0.img is SingleMovieclip)
               {
                  b0.img.mc.parent.removeChild(b0.img.mc);
               }
               else
               {
                  b0.img.parent.removeChild(b0.img);
               }
            }
            arr0.splice(index0,1);
         }
      }
      
      public function clearArr(arr0:Array) : *
      {
         var n:* = undefined;
         var b0:* = undefined;
         for(n in arr0)
         {
            b0 = arr0[n];
            if(b0.img != null)
            {
               if(!(b0.img is MovieClip))
               {
                  b0.img.clear();
               }
               else
               {
                  b0.img.stop();
               }
               if(b0.img is SingleMovieclip)
               {
                  b0.img.mc.parent.removeChild(b0.img.mc);
               }
               else
               {
                  b0.img.parent.removeChild(b0.img);
               }
            }
         }
         arr0.length = 0;
      }
      
      public function clearAllEnemy() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var mc0:* = undefined;
         for(n in this.enemy_arr)
         {
            this.clearArr(this.enemy_arr[n]);
         }
         this.clearArr(this.GundamFunnel_arr);
         this.clearArr(this.enemy_bullet);
         this.clearArr(this.we_bullet);
         this.heroCar_arr.shift();
         this.clearArr(this.heroCar_arr);
         this.heroCar_arr.push(this.hero);
         this.clearArr(this.enemyHero_arr);
         this.clearArr(this.enemySub_arr);
         this.clearArr(this.weBanshee_arr);
         this.clearArr(this.weLand_arr);
         this.clearArr(this.weAir_arr);
         for(m in this.supply_arr)
         {
            mc0 = this.supply_arr[m];
            mc0.parent.removeChild(mc0);
         }
         this.supply_arr.length = 0;
         this.clearArr(this.things_arr);
         this.delAllLifeBar();
      }
      
      public function clearAll() : *
      {
         var m:* = undefined;
         this.clearAllEnemy();
         for(m in this.we_arr)
         {
            this.clearArr(this.we_arr[m]);
         }
         this.hero = null;
      }
      
      public function pauseAllBody() : *
      {
         this.pauseAllArr2(this.enemy_arr);
         this.pauseAllArr2(this.we_arr);
         this.pauseAllArr2([this.enemySub_arr,this.GundamFunnel_arr]);
         this.pauseAllArr2([this.enemy_bullet,this.we_bullet]);
      }
      
      public function pauseAllArr2(arr0:*) : *
      {
         var n:* = undefined;
         var n1:* = undefined;
         var b0:* = undefined;
         for(n in arr0)
         {
            for(n1 in arr0[n])
            {
               b0 = arr0[n][n1];
               if(b0.img != null)
               {
                  b0.img.pause();
                  if(Boolean(b0.hasOwnProperty("SG")))
                  {
                     b0.SG.stopAllImage();
                  }
               }
            }
         }
      }
      
      public function resumeAllBody() : *
      {
         this.resumeAllArr2(this.enemy_arr);
         this.resumeAllArr2(this.we_arr);
         this.resumeAllArr2([this.enemySub_arr,this.GundamFunnel_arr]);
         this.resumeAllArr2([this.enemy_bullet,this.we_bullet]);
      }
      
      public function resumeAllArr2(arr0:*) : *
      {
         var n:* = undefined;
         var n1:* = undefined;
         var b0:* = undefined;
         for(n in arr0)
         {
            for(n1 in arr0[n])
            {
               b0 = arr0[n][n1];
               if(b0.img != null)
               {
                  b0.img.resume();
               }
            }
         }
      }
      
      public function BGTimer() : *
      {
      }
   }
}

