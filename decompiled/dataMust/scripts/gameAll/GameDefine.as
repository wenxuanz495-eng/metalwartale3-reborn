package gameAll
{
   import data.StringToDefine;
   import data.TextWay;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import gameAll.define.AdditionalDefine;
   import gameAll.define.ArenaFlipCardDefine;
   import gameAll.define.DialogueDefine;
   import gameAll.define.ExploreDefine;
   import gameAll.define.ExtraDefine;
   import gameAll.define.FlipCardDefine;
   import gameAll.define.GameLevelDefine;
   import gameAll.define.GiftDefine;
   import gameAll.define.SpecialExtraDefine;
   import gameAll.define.TaskDefine;
   import gameAll.define.TipsDefine;
   import gameAll.define.WeekExtraDefine;
   import gameAll.define.helper.HelperDefine;
   import gameAll.define.liveness.LivenessDefine;
   import gameAll.define.other.ArmsUpgradeDefine;
   import gameAll.define.other.DailySignDefine;
   import gameAll.define.other.DropBoxDefine;
   import gameAll.define.other.HighDefine;
   import gameAll.define.other.PurpleChipDefine;
   import gameAll.define.other.RankGiftDefine;
   import gameAll.honor.HonorDefine;
   import gameAll.test.AccountLimitDefine;
   import gameAll.vip.VipDefine;
   
   public class GameDefine
   {
      
      public var dialogue:DialogueDefine = new DialogueDefine();
      
      public var taskDefine:TaskDefine = new TaskDefine();
      
      public var itemsDropLevel:Array = [0,-3,-6];
      
      public var itemsDropPro:Array = [0.2,0.3,0.5];
      
      public var itemsDropType:Array = ["chip","crystal","material","lifePer","money",""];
      
      public var soldierIDTP:Array = [0.005,0.005,0.09,0.05,0.35,1];
      
      public var superIDTP:Array = [0.2,0.2,0.2,0,0.2,1];
      
      public var championIDTP:Array = [0.2,0.2,0.2,0,0.2,1];
      
      public var bossIDTP:Array = [0.3,0.3,0.2,0,0.2,0];
      
      public var chipDropType:Array = ["green_chip","orange_chip","yellow_chip","blue_chip","white_chip"];
      
      public var material_level:Array = [0,1,18,36,51,61];
      
      public var crystal_level:Array = [0,1,26,41,9999];
      
      public var soldierChip:Array = [0.0001,0,0.0001,0.0098,0.99];
      
      public var superChip:Array = [0.0001,0.0001,0.0098,0.99,0];
      
      public var championChip:Array = [0.01,0.09,0.2,0.7,0];
      
      public var bossChip:Array = [0.01,0.09,0.6,0.3,0];
      
      public var rankNameArr:Array = ["新兵","下士","中士","上士","少尉","中尉","上尉","少校","中校","上校","少将","中将","上将","五星上将","元帅","大元帅"];
      
      public var armsMust:NormalMustDefine = new NormalMustDefine();
      
      public var subMust:NormalMustDefine = new NormalMustDefine();
      
      public var holeMust:NormalMustDefine = new NormalMustDefine();
      
      public var supplyMust:NormalMustDefine = new NormalMustDefine();
      
      public var headMust:NormalMustDefine = new NormalMustDefine();
      
      public var difficult_ra_arr:Array = [1,1,1,1];
      
      public var difficult_ra0:Array = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.612,0.648,0.72,0.792,0.792,0.792,0.9,0.9,0.9,0.9,1.08,1.08,1.08,1.08,1.08,1.08,1.08,1.08,1.08,1.08];
      
      public var difficult_ra1:Array = [1.44,1.152,1.152,1.224,1.224,1.296,1.296,1.296,1.296,1.368,1.368,1.44,1.44,1.44,1.512,1.512,1.512,1.584,1.584,1.584,1.656,1.656,1.728,1.728,1.728,1.8,1.8,1.8,1.872,1.872,1.872];
      
      public var difficult_ra2:Array = [2.8,2.24,2.24,2.24,2.4,2.4,2.4,2.56,2.56,2.56,2.56,2.64,2.64,2.64,2.72,2.72,2.72,2.72,2.8,2.8,2.8,2.8,2.88,2.88,2.88,2.88,3.04,3.04,3.04,3.04,3.04];
      
      public var difficult_ra3:Array = [4,3.2,3.2,3.2,3.2,3.2,3.2,4,4,4,4,4,4,4,4.8,4.8,4.8,4.8,4.8,4.8,4.8,4.8,6.4,6.4,6.4,6.4,6.4,6.4,6.4,6.4,6.4];
      
      public var enemyExp2:Array = [14,26,46,74,110,154,206,266,334,410,494,586,686,794,910,1034,1166,1306,1454,1610,1650,1700,1750,1800,1850,1900,1950,2000,2050,2100,2150,2200,2250,2300,2350,2400,2450,2500,2550,2600,2650,2700,2750,2800,2850,2900,2950,3000,3050,3100,3150,3200,3250,3300,3350,3400,3450,3500,3550,3600,3650,3700,3750,3800,3850,3900,3950,4000,4050,4100];
      
      public var enemyAttack_diff:Array = [16,12,8,4];
      
      public var addDefine:AdditionalDefine = new AdditionalDefine();
      
      public var enemyLoaderList:Array = [];
      
      public var explore:ExploreDefine = new ExploreDefine();
      
      public var gift:GiftDefine = new GiftDefine();
      
      public var extra:ExtraDefine = new ExtraDefine();
      
      public var weekExtra:WeekExtraDefine = new WeekExtraDefine();
      
      public var specialExtra:SpecialExtraDefine = new SpecialExtraDefine();
      
      public var liveness:LivenessDefine = new LivenessDefine();
      
      public var flipCard:FlipCardDefine = new FlipCardDefine();
      
      public var arenaFlipCard:ArenaFlipCardDefine = new ArenaFlipCardDefine();
      
      public var dropBox:DropBoxDefine = new DropBoxDefine();
      
      public var accountLimit:AccountLimitDefine = new AccountLimitDefine();
      
      public var high:HighDefine = new HighDefine();
      
      public var honor:HonorDefine = new HonorDefine();
      
      public var purpleChip:PurpleChipDefine = new PurpleChipDefine();
      
      public var vip:VipDefine = new VipDefine();
      
      public var dailySign:DailySignDefine = new DailySignDefine();
      
      public var helper:HelperDefine = new HelperDefine();
      
      public var armsUpgrade:ArmsUpgradeDefine = new ArmsUpgradeDefine();
      
      public var level:GameLevelDefine = new GameLevelDefine();
      
      public var rankGiftDefine:RankGiftDefine = new RankGiftDefine();
      
      public var crystalMax:int = 8;
      
      public var crystalUpgradeNum:int = 4;
      
      public var materialUpgradeNum:int = 2;
      
      public var motionMustItems:Array = ["thorn"];
      
      public var boomMustItems:Array = ["boom"];
      
      public var energyMustItems:Array = ["buncher"];
      
      public var mixedMustItems:Array = ["thorn","buncher","boom"];
      
      public var armsMustItemsNum:Array = [5,10,20,30,60,120,50,100,200,100,200,400];
      
      public var superalloy_Z_Must:Array = [1,5,10,10,50,100,15,75,150,20,100,200];
      
      public var jumpSkillCoinNum:Array = [0,100,1000,10000,20000,50000,100000,200000,500000,1000000,2000000,4000000,5000000,8000000];
      
      public var rocketSkillCoinNum:Array = [0,100,1000,10000,20000,50000,100000,200000,500000,1000000,2000000,4000000,5000000,8000000];
      
      public var plasmaSkillCoinNum:Array = [0,100,1000,10000,20000,50000,100000,200000,500000,1000000,2000000,4000000,6000000,10000000];
      
      public var jumpSkillLevelNum:Array = [-1,4,9,14,19,24,29,34,39,44,55,59,61,64];
      
      public var rocketSkillLevelNum:Array = [-1,4,9,14,19,24,29,34,39,44,55,60,61,64];
      
      public var plasmaSkillLevelNum:Array = [-1,4,9,14,19,24,29,34,39,44,55,60,63,68];
      
      public var pointArr:Array = [];
      
      internal var CarUpgradeLife_G:Array = [1000,1600,3000,5000,7000,9000,24000,32000,40000,80000,120000,200000,300000,320000,350000,400000,450000,500000,550000];
      
      internal var CarUpgradeLife_M:Array = [1800,3600,6000,12000,15000,20000,50000,60000,96000,200000,350000,600000,800000,850000,900000,950000,1000000,1100000,1200000];
      
      internal var CarUpgradeLife_XYZ:Array = [0,0,0,24000,36000,48000,60000,80000,120000,240000,350000,800000,1000000,1100000,1200000,1300000,1400000,1500000,1600000];
      
      internal var CarUpgradeDefence_G:Array = [480,680,880,1080,1280,1480,1680,1880,2000,2200,2400,5200,5600,5800,6000,6200,6400,6600,6800];
      
      internal var CarUpgradeDefence_M:Array = [720,1020,1320,1620,1920,2220,2520,2820,3000,3300,3600,7800,8400,8800,9200,9600,10000,10500,11000];
      
      internal var CarUpgradeDefence_XYZ:Array = [0,0,0,1200,1600,2000,3000,3600,4200,5000,5500,8000,8800,9600,10400,11200,12000,12800,13600];
      
      internal var CarUpgradeMust_G:Array = [10000,30000,50000,100000,300000,500000,1000000,1500000,1500000,2000000,3000000,5000000,10000000,15000000,20000000,20000000,20000000,20000000,20000000];
      
      internal var CarUpgradeMust_M:Array = [10,10,20,20,30,30,50,70,100,100,100,100,100,200,200,200,200,200,200];
      
      internal var CarUpgradeMust_X:Array = [0,0,0,0,60,60,60,80,80,100,100,200,200,300,300,400,400,500,500];
      
      internal var CarUpgradeMust_Y:Array = [0,0,0,0,0,0,0,0,0,12,12,16,16,24,24,40,40,64,64];
      
      public var superEnemyColor:ColorTransform = new ColorTransform(1,1,1,1,0,20,200,0);
      
      public var championEnemyColor:ColorTransform = new ColorTransform(1,1,1,1,180,80,0,0);
      
      public var weEnemyColor:ColorTransform = new ColorTransform(0.9,1,0.9,1,0,139,0,0);
      
      public var superAllRa:Array = [7,5,2,1];
      
      public var championAllRa:Array = [15,8,3,1];
      
      public var bossAllRa:Array = [30,30,4,1];
      
      public var noSuperList:Array = ["判决者","剑装审判者","炮装审判者","自爆蜘蛛机","原子塔","原子反应堆","警报塔","地面自动炮台","防御激光炮","巨型压路机","飞轮机器人","闪电球",""];
      
      public var nolyChampionList:Array = ["强袭者","碾压者","攻城坦克","仲裁者","杀戮者","突击者","女妖战机"];
      
      public var unlockBagMustMCoin:int = 50;
      
      public var rankAdd:Array = [];
      
      public var rankGift:Array = [];
      
      public var levelsMax:int = 31;
      
      public var gameLevelTest:int = 0;
      
      public var nowLevel:int = 2;
      
      public var lockFirstB:Boolean = false;
      
      public var recommendLevelArr:Array = [];
      
      public var noticeContext:String = "   <font color=\'#FFFF00\'>亲爱的玩家，超合金战记2 1.007补丁正式更新！</font>\n\n   如之前有充值方面的问题，请前往论坛联系客服解决问题！更多精彩活动，更多新关卡，我们将在后续版本中陆续推出！";
      
      public var tips:TipsDefine = new TipsDefine();
      
      public function GameDefine()
      {
         super();
         this.armsMust.GCoin_arr = [0,0,1000,10000,1000000,0];
         this.armsMust.level_arr = [0,2,4,4,24,39];
         this.armsMust.MCoin_arr = [0,0,0,0,0,99];
         this.armsMust.rankLevel_arr = [0,0,0,0,2,4];
         this.subMust.level_arr = [2,9,19,24,24,39,39,49];
         this.subMust.GCoin_arr = [0,100000,1000000,1500000,0,0,0,0];
         this.subMust.MCoin_arr = [0,0,0,0,100,200,400,800];
         this.subMust.rankLevel_arr = [0,0,0,2,4,6,11,14];
         this.holeMust.GCoin_arr = [1000,250000,0,0,0];
         this.holeMust.level_arr = [6,6,6,6];
         this.holeMust.MCoin_arr = [0,0,25,50];
         this.headMust.GCoin = 50000;
         this.headMust.MCoin = 0;
         this.supplyMust.GCoin_arr = [500];
         this.supplyMust.index = 0;
         this.supplyMust.fleshByIndex(0);
         this.pointArr.push(new Point(-100 - 40,-20));
         this.pointArr.push(new Point(-153 - 40,-50));
         this.pointArr.push(new Point(-60 - 40,-134));
         this.pointArr.push(new Point(-98 + 10 - 40,-154 + 10));
         this.pointArr.push(new Point(-98 + 10 - 40,-111 - 10));
         this.pointArr.push(new Point(-161 + 50 - 40,-170 + 13));
         this.pointArr.push(new Point(-161 + 50 - 40,-106 - 13));
         this.pointArr.push(new Point(-161 + 50 - 40,-137));
         this.rankAdd.push([5,0,-1,0,0]);
         this.rankAdd.push([5,0.05,-1,0.1,0.1]);
         this.rankAdd.push([5,0.05,-1,0.2,0.15]);
         this.rankAdd.push([5,0.05,-1,0.3,0.2]);
         this.rankAdd.push([5,0.1,-1,0.4,0.3]);
         this.rankAdd.push([5,0.1,-1,0.5,0.35]);
         this.rankAdd.push([5,0.1,-1,0.6,0.4]);
         this.rankAdd.push([5,0.2,-1,0.7,0.6]);
         this.rankAdd.push([5,0.2,-1,0.8,0.7]);
         this.rankAdd.push([5,0.2,-1,0.9,0.8]);
         this.rankAdd.push([5,0.3,-1,1,1]);
         this.rankAdd.push([5,0.3,-1,1.1,1.25]);
         this.rankAdd.push([5,0.3,-1,1.2,1.5]);
         this.rankAdd.push([5,0.5,-1,1.3,1.8]);
         this.rankAdd.push([5,0.5,-1,1.4,2]);
         this.rankAdd.push([5,0.5,-1,1.5,2.5]);
         this.rankGift.push(["100000","random_20","z_3","crystal_2_2","yellow_chip_1"]);
         this.rankGift.push(["150000","random_30","z_6","crystal_2_3","yellow_chip_1"]);
         this.rankGift.push(["200000","random_40","z_9","crystal_2_4","yellow_chip_1"]);
         this.rankGift.push(["300000","random_50","z_12","crystal_3_2","orange_chip_1"]);
         this.rankGift.push(["400000","random_60","z_15","crystal_3_3","orange_chip_1"]);
         this.rankGift.push(["500000","random_70","z_18","crystal_3_4","orange_chip_1"]);
         this.rankGift.push(["600000","random_80","z_21","crystal_4_2","green_chip_1"]);
         this.rankGift.push(["700000","random_90","z_24","crystal_4_3","green_chip_1"]);
         this.rankGift.push(["800000","random_100","z_27","crystal_4_4","green_chip_1"]);
         this.rankGift.push(["1000000","random_110","z_30","crystal_5_2","green_chip_1"]);
         this.rankGift.push(["2000000","random_120","z_40","crystal_6_2","green_chip_1"]);
         this.rankGift.push(["2000000","random_120","z_40","crystal_6_2","green_chip_1"]);
         this.recommendLevelArr[0] = ["1","1-2","1-3","2-4","3-5","4-6","5-7","6-8","7-9","8-10","9-11","10-12","11-13","11-13","12-14","13-15","14-16","15-17","16-18","17-19","18-20","19-21","20-22","20-22","21-23","21-23","22-24","22-24","23-25","23-25","24-25"];
         this.recommendLevelArr[1] = ["1","26-28","26-28","27-29","27-29","28-30","28-30","29-31","29-31","30-32","30-32","31-33","31-33","32-34","33-35","33-35","34-36","34-36","35-37","35-37","36-38","36-38","37-39","37-39","38-40","38-40","39-40","39-40","39-40","39-40","39-40"];
         this.recommendLevelArr[2] = ["1","41-44","41-44","41-44","42-45","42-45","42-45","43-46","43-46","43-46","44-47","44-47","44-47","45-48","46-49","46-49","46-49","47-50","47-50","47-50","48-50","48-50","49-50","49-50","49-50","49-50","50","50","50","50","50"];
         this.recommendLevelArr[3] = ["1","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50","50"];
         ExtraDefine.swapToCode2([this.CarUpgradeDefence_G,this.CarUpgradeDefence_M,this.CarUpgradeDefence_XYZ,this.CarUpgradeLife_G,this.CarUpgradeLife_M,this.CarUpgradeLife_XYZ,this.CarUpgradeMust_G,this.CarUpgradeMust_M,this.CarUpgradeMust_X,this.CarUpgradeMust_Y]);
      }
      
      public function fleshSubPosition(param1:Sprite) : *
      {
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         this.pointArr.length = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 8)
         {
            _loc3_ = "a" + (_loc2_ + 1);
            _loc4_ = param1.getChildByName(_loc3_);
            this.pointArr.push(new Point(_loc4_.x,_loc4_.y));
            _loc2_++;
         }
      }
      
      public function checkSuper(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.noSuperList)
         {
            if(param1 == this.noSuperList[_loc2_])
            {
               return false;
            }
         }
         return true;
      }
      
      public function checkOnlyChampion(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         for(_loc2_ in this.nolyChampionList)
         {
            if(param1 == this.nolyChampionList[_loc2_])
            {
               return true;
            }
         }
         return false;
      }
      
      public function getDpsByLevel(param1:int) : *
      {
         return 10 * Math.pow(param1,1.5) + 2;
      }
      
      public function getArmsMustItems(param1:String, param2:Array) : Array
      {
         var _loc9_:* = undefined;
         var _loc10_:Array = null;
         var _loc11_:* = undefined;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:String = null;
         if(int(param2[0]) == 0)
         {
            _loc10_ = [];
            for(_loc11_ in param2)
            {
               _loc12_ = param2[_loc11_];
               _loc13_ = _loc12_.split("_num");
               _loc12_ = _loc13_[0] + "_num" + Math.ceil(Number(_loc13_[1]) * 0.8);
               _loc10_.push(_loc12_);
            }
            return _loc10_;
         }
         var _loc3_:int = int(param2[0]);
         var _loc4_:int = int(param2[1]) * 0.8;
         var _loc5_:int = int(param2[2]) * 0.8 * 0.8;
         if(_loc5_ < 1)
         {
            _loc5_ = 1;
         }
         var _loc6_:Array = [];
         var _loc7_:Array = this[param1 + "MustItems"];
         var _loc8_:String = "_" + _loc3_;
         if(_loc3_ == 5)
         {
            _loc7_ = this.mixedMustItems;
         }
         for(_loc9_ in _loc7_)
         {
            _loc14_ = _loc7_[_loc9_] + _loc8_ + "_num" + _loc4_;
            _loc6_.push(_loc14_);
         }
         _loc6_.push("superalloy_num" + _loc4_);
         _loc6_.push("superalloy_Z_num" + _loc5_);
         return _loc6_;
      }
      
      public function getArmsEnergyMax(param1:Number) : int
      {
         return 1.2 * 20 / ((param1 + 0.1) * (1 + 20 * this.getArmsEnergyRa(param1))) / 2;
      }
      
      public function getArmsEnergyRa(param1:Number) : Number
      {
         return 0.033;
      }
      
      public function getTrainItemsNum(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 < 5000)
         {
            _loc2_ = 0;
         }
         else if(param1 < 21)
         {
            _loc2_ = 1;
         }
         else if(param1 < 31)
         {
            _loc2_ = 2;
         }
         else if(param1 < 41)
         {
            _loc2_ = 3;
         }
         else
         {
            _loc2_ = 4;
         }
         return _loc2_;
      }
      
      public function getTrainCoinNum(param1:int) : int
      {
         param1 += 1;
         return param1 * param1 * 300;
      }
      
      public function getTrainCoinNum_M(param1:int, param2:String) : int
      {
         param1 += 1;
         if(param1 > 500)
         {
            param1 = 500;
         }
         if(param2 == "all")
         {
            return (int((param1 - 1) / 5) + 1) * 10;
         }
         return 0;
      }
      
      public function getAllTrainCoinNum_M(param1:int) : Number
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += this.getTrainCoinNum_M(param1,"all");
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTrainLevelNum(param1:int, param2:String) : int
      {
         var _loc3_:int = 1;
         if(param2 == "all")
         {
            if(param1 >= 300)
            {
               _loc3_ = 81;
            }
            else if(param1 >= 200)
            {
               _loc3_ = 61;
            }
            else
            {
               _loc3_ = 1;
            }
         }
         else
         {
            _loc3_ = param1 + 1;
         }
         return _loc3_;
      }
      
      public function getSkillCoinNum(param1:int, param2:String) : int
      {
         return this[param2 + "SkillCoinNum"][param1];
      }
      
      public function getSkillLevelNum(param1:int, param2:String) : int
      {
         return this[param2 + "SkillLevelNum"][param1];
      }
      
      public function getAchieve(param1:int) : int
      {
         var _loc2_:int = param1 + 1;
         if(param1 >= 14)
         {
            return _loc2_ * _loc2_ * 500 + 380000;
         }
         return _loc2_ * _loc2_ * 500;
      }
      
      public function getAllAchieve(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1 + 1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ += this.getAchieve(_loc4_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getRankName(param1:int) : String
      {
         return this.rankNameArr[param1];
      }
      
      public function getExp(param1:int) : Number
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1 + 1;
         if(param1 < 25)
         {
            _loc3_ = 80 * _loc2_ * (_loc2_ * _loc2_ + 1) + 50;
            if(param1 >= 6)
            {
               _loc3_ *= 1;
            }
            return _loc3_;
         }
         if(param1 < 40)
         {
            return 120 * _loc2_ * (_loc2_ * _loc2_ + 1) + 50;
         }
         if(param1 < 50)
         {
            return 200 * _loc2_ * (_loc2_ * _loc2_ + 1) + 50;
         }
         if(param1 < 59)
         {
            return 300 * _loc2_ * (_loc2_ * _loc2_ + 1) + 50;
         }
         return 500 * _loc2_ * (_loc2_ * _loc2_ + 1) + 50;
      }
      
      public function getAllExp(param1:int) : Number
      {
         var _loc2_:Number = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ += this.getExp(_loc3_);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getLife(param1:int) : int
      {
         var _loc2_:int = param1 + 1;
         if(_loc2_ <= 60)
         {
            return 5 * _loc2_ * _loc2_ + 100;
         }
         return 20 * _loc2_ * _loc2_ + 1000;
      }
      
      public function getDefence(param1:int) : int
      {
         var _loc2_:int = param1 + 1;
         return _loc2_ * _loc2_ + 20;
      }
      
      public function getDefence_ra(param1:int) : Number
      {
         var _loc2_:int = param1 + 1;
         var _loc3_:Number = 12;
         if(_loc2_ <= 60)
         {
            _loc3_ = 40;
         }
         else
         {
            _loc3_ = 80;
         }
         return _loc3_;
      }
      
      public function getCarLife(param1:int) : Point
      {
         var _loc2_:int = param1 + 1;
         var _loc3_:Point = new Point();
         if(_loc2_ <= 4)
         {
            _loc3_.x = 120;
            _loc3_.y = 60;
         }
         else if(_loc2_ < 10)
         {
            _loc3_.x = 300;
            _loc3_.y = 200;
         }
         else if(_loc2_ < 15)
         {
            _loc3_.x = 800;
            _loc3_.y = 200;
         }
         else if(_loc2_ < 20)
         {
            _loc3_.x = 1600;
            _loc3_.y = 200;
         }
         else if(_loc2_ < 25)
         {
            _loc3_.x = 3000;
            _loc3_.y = 500;
         }
         else if(_loc2_ < 30)
         {
            _loc3_.x = 5000;
            _loc3_.y = 800;
         }
         else if(_loc2_ < 35)
         {
            _loc3_.x = 7000;
            _loc3_.y = 1000;
         }
         else if(_loc2_ < 40)
         {
            _loc3_.x = 9000;
            _loc3_.y = 1400;
         }
         else if(_loc2_ < 45)
         {
            _loc3_.x = 24000;
            _loc3_.y = 1800;
         }
         else if(_loc2_ < 50)
         {
            _loc3_.x = 32000;
            _loc3_.y = 2200;
         }
         else if(_loc2_ < 55)
         {
            _loc3_.x = 40000;
            _loc3_.y = 4000;
         }
         else if(_loc2_ < 60)
         {
            _loc3_.x = 80000;
            _loc3_.y = 4000;
         }
         else if(_loc2_ < 65)
         {
            _loc3_.x = 120000;
            _loc3_.y = 4000;
         }
         else if(_loc2_ < 70)
         {
            _loc3_.x = 200000;
            _loc3_.y = 4000;
         }
         else
         {
            _loc3_.x = 300000;
            _loc3_.y = 4000;
         }
         return new Point(_loc3_.x,_loc3_.y);
      }
      
      public function getEnemyLevel(param1:int, param2:Array, param3:Array, param4:Array, param5:int = 31, param6:int = 13, param7:int = 10) : Array
      {
         var _loc8_:Array = [];
         var _loc9_:Array = this.getOneEnemyLevel(param5,"",param2);
         var _loc10_:Array = this.getOneEnemyLevel(param6,"knowing",param3);
         var _loc11_:Array = this.getOneEnemyLevel(param7,"ghost",param4);
         _loc8_ = _loc9_.concat(_loc10_);
         _loc8_ = _loc8_.concat(_loc11_);
         return this.find5Level(param1,_loc8_);
      }
      
      public function getOneEnemyLevel(param1:int, param2:String, param3:Array) : Array
      {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:Array = [[],[],[],[]];
         for(_loc5_ in _loc4_)
         {
            _loc6_ = param1;
            _loc7_ = int(param3[_loc5_]);
            if(_loc7_ < param1)
            {
               _loc6_ = _loc7_;
            }
            if(_loc5_ == 0 && param2 == "" && _loc6_ <= 1)
            {
               _loc6_ = 2;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc4_[_loc5_][_loc8_] = this.getEnemyLevel_byLevel(_loc8_,_loc5_,param2);
               _loc8_++;
            }
         }
         return _loc4_;
      }
      
      public function find5Level(param1:int, param2:Array) : Array
      {
         var _loc4_:* = undefined;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:* = 0;
         var _loc15_:int = 0;
         var _loc16_:Object = null;
         var _loc17_:Object = null;
         var _loc18_:Object = null;
         var _loc3_:int = 0;
         for(_loc4_ in param2)
         {
            _loc12_ = param2[_loc4_];
            if(_loc12_.length > 0)
            {
               _loc3_ = int(_loc12_[_loc12_.length - 1]);
            }
         }
         if(param1 > _loc3_)
         {
            param1 = _loc3_;
         }
         var _loc5_:int = param1;
         if(param1 < 25)
         {
            _loc5_ = param1 - 5;
         }
         else
         {
            _loc5_ = param1 - 3;
         }
         var _loc6_:Boolean = false;
         var _loc7_:Array = [];
         var _loc8_:Array = [];
         var _loc9_:* = int(param2.length - 1);
         while(_loc9_ >= 0)
         {
            _loc13_ = param2[_loc9_];
            _loc14_ = int(_loc13_.length - 1);
            while(_loc14_ >= 0)
            {
               _loc15_ = int(_loc13_[_loc14_]);
               if(_loc15_ <= param1 && _loc15_ > _loc5_)
               {
                  if(_loc9_ > 3 || _loc14_ != 0)
                  {
                     _loc16_ = new Object();
                     _loc16_.diff = _loc9_;
                     _loc16_.level = _loc14_;
                     _loc16_.taskLevel = _loc15_;
                     _loc7_.push(_loc16_);
                  }
               }
               if((_loc15_ <= param1 || _loc6_) && _loc8_.length < 5)
               {
                  _loc6_ = true;
                  if(_loc9_ > 3 || _loc14_ != 0)
                  {
                     _loc17_ = new Object();
                     _loc17_.diff = _loc9_;
                     _loc17_.level = _loc14_;
                     _loc17_.taskLevel = _loc15_;
                     _loc8_.push(_loc17_);
                  }
               }
               _loc14_--;
            }
            _loc9_--;
         }
         var _loc10_:Array = _loc7_;
         if(_loc7_.length == 0)
         {
            if(_loc8_.length > 0)
            {
               _loc10_ = _loc8_;
            }
            else
            {
               _loc18_ = new Object();
               _loc18_.diff = 0;
               _loc18_.level = 1;
               _loc18_.taskLevel = 1;
               _loc10_ = [_loc18_];
            }
         }
         var _loc11_:int = 0;
         while(_loc11_ < Math.abs(5 - _loc10_.length))
         {
            if(_loc10_.length < 5)
            {
               _loc10_.push(_loc10_[int(_loc10_.length * Math.random())]);
            }
            else
            {
               _loc10_.splice(int(_loc10_.length * Math.random()),1);
            }
            _loc14_++;
         }
         return _loc10_;
      }
      
      public function getEnemyLevel_byLevel(param1:int, param2:int, param3:String = "") : int
      {
         return this.level.getEnemyLevel_byLevel(param1,param2,param3);
      }
      
      public function getEnemyLife_byLevel(param1:int) : Number
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param1 < 54)
         {
            return this.getEnemyLife_byLevel2(param1);
         }
         _loc2_ = param1 + 1;
         if(_loc2_ < 3)
         {
            _loc2_ = 3;
         }
         _loc3_ = 0;
         _loc4_ = 1;
         if(_loc2_ <= 10)
         {
            _loc3_ = 1;
            _loc4_ = 1;
         }
         else if(_loc2_ < 26)
         {
            _loc3_ = 1.2;
            _loc4_ = 2;
         }
         else if(_loc2_ < 41)
         {
            _loc3_ = 1.4;
            _loc4_ = 3;
         }
         else if(_loc2_ < 51)
         {
            _loc3_ = 1.6;
            _loc4_ = 4;
         }
         else if(_loc2_ < 65)
         {
            _loc3_ = 2;
            _loc4_ = 6;
         }
         else
         {
            _loc3_ = 2.8;
            _loc4_ = 6;
         }
         _loc5_ = 10;
         if(_loc2_ > 60)
         {
            _loc5_ = 20;
         }
         _loc6_ = _loc5_ * Math.sqrt(_loc2_ * _loc2_ * _loc2_) * (1 + _loc2_ * 0.02) * _loc3_ * 0.7 + 10 * Math.sqrt(_loc2_ * _loc2_ * _loc2_) * (1 + _loc2_ * 0.02) * _loc3_ * _loc4_ * 0.8;
         return Math.ceil(_loc6_);
      }
      
      public function getEnemyLife_byLevel2(param1:int) : Number
      {
         var _loc2_:int = param1 + 1;
         if(_loc2_ < 3)
         {
            _loc2_ = 3;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 1;
         if(_loc2_ <= 10)
         {
            _loc3_ = 1;
            _loc4_ = 1;
         }
         else if(_loc2_ < 26)
         {
            _loc3_ = 1.2;
            _loc4_ = 2;
         }
         else if(_loc2_ < 41)
         {
            _loc3_ = 1.4;
            _loc4_ = 3;
         }
         else if(_loc2_ < 51)
         {
            _loc3_ = 1.6;
            _loc4_ = 4;
         }
         else
         {
            _loc3_ = 2;
            _loc4_ = 6;
         }
         var _loc5_:Number = 10 * Math.sqrt(_loc2_ * _loc2_ * _loc2_) * (1 + _loc2_ * 0.02) * _loc3_ * 0.7 + 5 * Math.sqrt(_loc2_ * _loc2_ * _loc2_) * (1 + _loc2_ * 0.02) * _loc3_ * _loc4_ * 0.8;
         return Math.ceil(_loc5_);
      }
      
      public function getChipSubRa(param1:int) : Array
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = 1;
         if(param1 <= 10)
         {
            _loc2_ = 1;
            _loc3_ = 1;
         }
         else if(param1 < 26)
         {
            _loc2_ = 1.2;
            _loc3_ = 2;
         }
         else if(param1 < 41)
         {
            _loc2_ = 1.4;
            _loc3_ = 3;
         }
         else if(param1 < 51)
         {
            _loc2_ = 1.6;
            _loc3_ = 4;
         }
         else if(param1 < 65)
         {
            _loc2_ = 2;
            _loc3_ = 6;
         }
         else
         {
            _loc2_ = 2.8;
            _loc3_ = 6;
         }
         return [_loc2_,_loc3_];
      }
      
      public function getEnemyHurt_byLevel(param1:int) : Number
      {
         var _loc2_:int = param1 + 1;
         var _loc3_:Point = this.getCarLife(param1);
         var _loc4_:Number = 1;
         if(_loc2_ <= 10)
         {
            _loc4_ = 1.2;
         }
         else if(_loc2_ < 26)
         {
            _loc4_ = 1.6;
         }
         else if(_loc2_ < 41)
         {
            _loc4_ = 1.8;
         }
         else if(_loc2_ < 51)
         {
            _loc4_ = 2.5;
         }
         else if(_loc2_ < 65)
         {
            _loc4_ = 3;
         }
         else if(_loc2_ < 71)
         {
            _loc4_ = 4;
         }
         else
         {
            _loc4_ = 5;
         }
         var _loc5_:Number = 5;
         var _loc6_:Number = 100;
         if(_loc2_ > 60)
         {
            _loc5_ = 10;
            _loc6_ = 1000;
         }
         return Math.ceil(2.5 * (_loc5_ * _loc2_ * _loc2_ + _loc6_ + _loc3_.x) * (1 + _loc2_ * 0.02) * _loc4_ / 50);
      }
      
      public function getEnemyExp_byLevel(param1:int) : int
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         else if(param1 > 70 - 1)
         {
            return this.enemyExp2[69] + (param1 - 69) * 50;
         }
         return this.enemyExp2[param1];
      }
      
      public function getEnemyCoin_byLevel(param1:int) : int
      {
         return (param1 + 1) * 8 + 10;
      }
      
      public function getNowDifficult_ra(param1:int, param2:int, param3:String = "") : Number
      {
         var _loc4_:Number = 1;
         return param2 + 1;
      }
      
      public function getEnemyAchieve_byLevel(param1:int, param2:int) : int
      {
         var _loc3_:int = param1 - param2;
         var _loc4_:int = 2;
         if(_loc3_ > 0)
         {
            _loc4_ = 2;
         }
         else
         {
            _loc4_ = 2 * (1 / (Math.abs(param2 - param1) + 1)) + 0.5;
         }
         if(_loc4_ > 2)
         {
            _loc4_ = 2;
         }
         return _loc4_;
      }
      
      public function getRecommendLevel(param1:int, param2:int) : String
      {
         return this.recommendLevelArr[param2][param1];
      }
      
      public function getKnowingMustLevel(param1:int) : int
      {
         if(param1 == 0)
         {
            return 25;
         }
         if(param1 == 1)
         {
            return 50;
         }
         return 50;
      }
      
      public function getKnowingMustLv(param1:int) : int
      {
         var _loc2_:Array = [25,28,30,32,35,40,45,50,50,50,60,60,60,60];
         if(param1 > _loc2_.length - 1)
         {
            param1 = _loc2_.length - 1;
         }
         return _loc2_[param1];
      }
      
      public function getKnowingUnlockLevel(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            _loc4_ = this.getKnowingMustLv(_loc3_);
            if(param1 + 1 < _loc4_)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return _loc3_;
      }
      
      public function getGhostMustLevel(param1:int) : int
      {
         if(param1 == 0)
         {
            return 60;
         }
         if(param1 == 1)
         {
            return 60;
         }
         return 60;
      }
      
      public function getGhostMustLv(param1:int) : int
      {
         var _loc2_:Array = [60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60];
         if(param1 > _loc2_.length - 1)
         {
            param1 = _loc2_.length - 1;
         }
         return _loc2_[param1];
      }
      
      public function getEnemyHeroHurt(param1:int) : Number
      {
         return 5;
      }
      
      public function getDropSuperalloy_Z(param1:int, param2:int) : Number
      {
         var _loc3_:int = Math.abs(param1 - param2);
         var _loc4_:Number = 0.5 - _loc3_ * 0.1;
         if(_loc3_ >= 5)
         {
            _loc4_ = 0;
         }
         return _loc4_;
      }
      
      public function getItemsLevel(param1:int, param2:String = "") : int
      {
         var _loc3_:int = param1 - 4;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         var _loc4_:int = _loc3_ + (param1 - _loc3_ + 1) * Math.random();
         if(_loc4_ <= 0)
         {
            _loc4_ = 0;
         }
         return _loc4_;
      }
      
      public function getMinLevel(param1:String, param2:int) : int
      {
         var _loc4_:Array = null;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         param2++;
         var _loc3_:int = 0;
         if(param1 == "material" || param1 == "crystal")
         {
            _loc4_ = this[param1 + "_level"];
            for(_loc5_ in _loc4_)
            {
               _loc6_ = int(_loc4_[_loc5_]);
               if(param2 < _loc6_)
               {
                  _loc3_ = int(_loc4_[_loc5_ - 1]);
                  break;
               }
               if(_loc5_ == _loc4_.length - 1)
               {
                  _loc3_ = int(_loc4_[_loc5_]);
               }
            }
            return _loc3_ - 1;
         }
         return 0;
      }
      
      public function getItemsType(param1:String, param2:int = 1) : String
      {
         var _loc3_:String = "";
         return this.itemsDropType[StringToDefine.getPro_byArr(this[param1 + "IDTP"])];
      }
      
      public function getChipType(param1:String) : String
      {
         return this.chipDropType[StringToDefine.getPro_byArr(this[param1 + "Chip"])];
      }
      
      public function dropString_byLevel(param1:int) : String
      {
         var _loc2_:int = ++param1;
         var _loc3_:int = param1 - 3;
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         var _loc4_:Array = [1,18,36,51,61];
         var _loc5_:Array = ["初级","中级","高级","大师级","专家级"];
         var _loc6_:Array = [1,26,41];
         var _loc7_:Array = ["一级","二级","三级"];
         var _loc8_:String = "材料（";
         var _loc9_:int = this._getMaxIndex(_loc2_,_loc4_);
         var _loc10_:int = this._getMaxIndex(_loc3_,_loc4_);
         if(_loc9_ != _loc10_)
         {
            _loc8_ += _loc5_[_loc10_] + "~" + _loc5_[_loc9_];
         }
         else
         {
            _loc8_ += _loc5_[_loc9_];
         }
         _loc8_ += "）";
         var _loc11_:String = "晶体（";
         var _loc12_:int = this._getMaxIndex(_loc2_,_loc6_);
         var _loc13_:int = this._getMaxIndex(_loc3_,_loc6_);
         if(_loc12_ != _loc13_)
         {
            _loc11_ += _loc7_[_loc13_] + "~" + _loc7_[_loc12_];
         }
         else
         {
            _loc11_ += _loc7_[_loc12_];
         }
         _loc11_ += "）";
         var _loc14_:String = "芯片（" + _loc3_ + "级~" + _loc2_ + "级）";
         return _loc8_ + "\n" + _loc11_ + "\n" + _loc14_ + "\n" + "超合金\n超合金Z";
      }
      
      private function _getMaxIndex(param1:int, param2:Array) : int
      {
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         for(_loc4_ in param2)
         {
            _loc5_ = int(param2[_loc4_]);
            if(param1 < _loc5_)
            {
               if(_loc4_ == 0)
               {
                  return 0;
               }
               return _loc4_ - 1;
            }
         }
         return param2.length - 1;
      }
      
      public function getCrystalUpgradeCoin(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:Array = [0,4000,8000,40000,80000,160000,320000,640000];
         var _loc4_:Array = [0,500,500,500,500,500];
         if(param2)
         {
            return _loc3_[param1 - 1];
         }
         return _loc4_[param1 - 1];
      }
      
      public function getCrystalUpgradeLevel(param1:int, param2:Boolean = true) : int
      {
         var _loc3_:Array = [0,1,10,20,30,40,50,60];
         var _loc4_:Array = [0,1,15,25,61];
         if(param2)
         {
            return _loc3_[param1 - 1];
         }
         return _loc4_[param1 - 1];
      }
      
      public function addSuperalloy(param1:int) : Object
      {
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc11_:* = undefined;
         var _loc12_:* = undefined;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc2_:Array = ["s","x","y","z"];
         var _loc3_:Array = ["超合金","超合金X","超合金Y","超合金Z"];
         var _loc4_:Array = ["#FFFFFF","#00FF00","#FF9900","#FF33FF"];
         var _loc5_:Array = [6,3,2.5,2];
         var _loc6_:Array = [0,0.8,0.2,0];
         var _loc7_:Object = new Object();
         for(_loc8_ in _loc2_)
         {
            _loc7_[_loc2_[_loc8_]] = 0;
         }
         _loc9_ = 0;
         while(_loc9_ < param1)
         {
            _loc13_ = StringToDefine.getPro_byArr(_loc6_);
            _loc7_[_loc2_[_loc13_]] += _loc5_[_loc13_] * 2;
            _loc9_++;
         }
         var _loc10_:Array = [];
         for(_loc11_ in _loc2_)
         {
            _loc14_ = int(_loc7_[_loc2_[_loc11_]]);
            if(_loc14_ > 0)
            {
               _loc10_.push(StringToDefine.getFontColor(_loc3_[_loc11_],_loc4_[_loc11_]) + StringToDefine.getFontColor(" " + _loc14_,"#FFFF00") + "个");
            }
         }
         _loc7_.text = "";
         for(_loc12_ in _loc10_)
         {
            _loc7_.text += _loc10_[_loc12_];
            if(_loc12_ < _loc10_.length - 1)
            {
               _loc7_.text += "，";
            }
         }
         return _loc7_;
      }
      
      public function getChipPrice(param1:String, param2:int) : int
      {
         param2++;
         var _loc3_:Number = 2;
         if(param1 == "white_chip")
         {
            _loc3_ = 1;
         }
         else if(param1 == "blue_chip")
         {
            _loc3_ = 1.25;
         }
         else if(param1 == "yellow_chip")
         {
            _loc3_ = 1.5;
         }
         else if(param1 == "orange_chip")
         {
            _loc3_ = 1.75;
         }
         else if(param1 == "green_chip")
         {
            _loc3_ = 2;
         }
         return (10 * param2 + 20) * _loc3_;
      }
      
      public function getTestB() : Boolean
      {
         if(this.nowLevel > 1)
         {
            return true;
         }
         return false;
      }
      
      public function getTaskExp(param1:int) : int
      {
         return this.taskDefine.getTaskExp(param1);
      }
      
      public function getTaskGCoin(param1:int) : int
      {
         return this.taskDefine.getGCoin(param1);
      }
      
      public function getTaskCrystalLevel(param1:int) : int
      {
         var _loc2_:* = undefined;
         param1++;
         for(_loc2_ in this.crystal_level)
         {
            if(param1 < this.crystal_level[_loc2_])
            {
               return _loc2_ - 1;
            }
         }
         return 1;
      }
      
      public function getTaskGiftArr(param1:int, param2:int, param3:* = "soldier", param4:String = "") : Array
      {
         var _loc5_:Array = [];
         var _loc6_:Number = 1;
         if(param3 == "super")
         {
            _loc6_ = 1.1;
         }
         var _loc7_:int = this.getTaskExp(param1) * 1.2;
         var _loc8_:int = _loc7_ * (param2 + 1) * _loc6_;
         var _loc9_:int = this.getTaskGCoin(param1) * _loc6_ * 1.2;
         var _loc10_:int = _loc9_ * (param2 / 2 + 1);
         var _loc11_:int = this.getTaskCrystalLevel(param1);
         var _loc12_:int = param2 + 1;
         if(param1 > 69)
         {
            _loc11_++;
         }
         else
         {
            _loc5_.push("exp," + _loc8_ + ",1");
         }
         _loc5_.push("GCoin," + _loc10_ + ",1");
         if(param2 == 1)
         {
            _loc5_.push("materials,\tyellow_chip,\t1");
         }
         else if(param2 == 2)
         {
            _loc5_.push("materials,\torange_chip,\t1");
         }
         else if(param2 == 3 || param2 == 4)
         {
            _loc5_.push("materials,\tgreen_chip,\t1");
         }
         _loc5_.push("materials,\tsuperalloy_X,\t2");
         return _loc5_;
      }
      
      public function getTaskUpStar_M(param1:int) : NormalMustDefine
      {
         var _loc2_:NormalMustDefine = new NormalMustDefine();
         _loc2_.MCoin = (param1 + 1) * 2;
         return _loc2_;
      }
      
      public function getTaskFleshList_M() : NormalMustDefine
      {
         var _loc1_:NormalMustDefine = new NormalMustDefine();
         _loc1_.MCoin = 1;
         return _loc1_;
      }
      
      public function getTaskUpUseNum_M(param1:int) : NormalMustDefine
      {
         var _loc2_:NormalMustDefine = new NormalMustDefine();
         _loc2_.MCoin = (int((param1 - 10) / 5) + 1) * 10;
         if(_loc2_.MCoin < 1)
         {
            _loc2_.MCoin = 1;
         }
         return _loc2_;
      }
      
      public function getChipCubeMustCoin(param1:String) : int
      {
         var _loc2_:Array = ["white_chip","blue_chip","yellow_chip","orange_chip"];
         var _loc3_:Array = [1000,2000,3000,4000,5000];
         var _loc4_:int = _loc2_.indexOf(param1);
         return _loc3_[_loc4_];
      }
      
      public function getGroupScore(param1:int, param2:int) : Number
      {
         var _loc3_:Array = [0.1,0.15,0.3,0.4,0.6,0.8,1,2,4,4,5,6,6,6];
         var _loc4_:int = 0;
         if(param1 < 20)
         {
            _loc4_ = 100;
         }
         else if(param1 < 60)
         {
            _loc4_ = 70;
         }
         else if(param1 < 120)
         {
            _loc4_ = 50;
         }
         else if(param1 < 180)
         {
            _loc4_ = 30;
         }
         else if(param1 < 600)
         {
            _loc4_ = 10;
         }
         else
         {
            _loc4_ = 0;
         }
         return int(_loc4_ * _loc3_[param2]);
      }
      
      public function getStatistics(param1:Number, param2:Number, param3:Number) : Array
      {
         var _loc4_:int = 50 - Math.ceil((param1 - 4 * 60) / 10);
         if(_loc4_ > 50)
         {
            _loc4_ = 50;
         }
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         var _loc5_:int = 20 - Math.ceil((0.8 - param2) / 0.02);
         if(_loc5_ > 20)
         {
            _loc5_ = 20;
         }
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc6_:int = 50 - Math.ceil((param3 - 20) / 1);
         if(_loc6_ > 50)
         {
            _loc6_ = 50;
         }
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         var _loc7_:int = _loc4_ + _loc6_;
         var _loc8_:String = this.getPassGrade(_loc7_);
         return [_loc4_,_loc5_,_loc6_,_loc7_,_loc8_];
      }
      
      public function getPassGrade(param1:int) : String
      {
         var _loc2_:Array = [" 无"," D 级"," C 级"," B 级"," A 级"," S 级"," SS 级"," SSS 级"];
         return _loc2_[this.getPassGradeIndex(param1)];
      }
      
      public function getPassGradeIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         if(param1 >= 100)
         {
            _loc2_ = 7;
         }
         else if(param1 >= 96)
         {
            _loc2_ = 6;
         }
         else if(param1 >= 91)
         {
            _loc2_ = 5;
         }
         else if(param1 >= 81)
         {
            _loc2_ = 4;
         }
         else if(param1 >= 71)
         {
            _loc2_ = 3;
         }
         else if(param1 >= 61)
         {
            _loc2_ = 2;
         }
         else if(param1 >= 0)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function getCarUpgradeLife(param1:int, param2:String) : Number
      {
         var _loc5_:int = 0;
         var _loc3_:Array = this["CarUpgradeLife_" + param2];
         var _loc4_:Number = 0;
         if(param1 >= 10)
         {
            _loc5_ = param1 / 5 - 2;
            _loc4_ = int(TextWay.getText(_loc3_[_loc5_]));
         }
         return _loc4_;
      }
      
      public function getCarUpgradeDefence(param1:int, param2:String) : Number
      {
         var _loc5_:int = 0;
         var _loc3_:Array = this["CarUpgradeDefence_" + param2];
         var _loc4_:Number = 0;
         if(param1 >= 10)
         {
            _loc5_ = param1 / 5 - 2;
            _loc4_ = int(TextWay.getText(_loc3_[_loc5_]));
         }
         return _loc4_;
      }
      
      public function getCarUpgradeMust(param1:int, param2:String) : Number
      {
         var _loc5_:int = 0;
         var _loc3_:Array = this["CarUpgradeMust_" + param2];
         var _loc4_:Number = 0;
         if(param1 >= 5)
         {
            _loc5_ = param1 / 5 - 1;
            _loc4_ = int(TextWay.getText(_loc3_[_loc5_]));
         }
         return _loc4_;
      }
   }
}

