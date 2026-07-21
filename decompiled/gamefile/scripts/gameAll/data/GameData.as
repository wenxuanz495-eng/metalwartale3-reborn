package gameAll.data
{
   import body.hero.CarDefine;
   import data.TextWay;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import gameAll.data.challenge.ChallengeTaskData;
   import gameAll.data.collect.CollectTaskData;
   import gameAll.data.collect.WeekTaskData;
   import gameAll.data.level.NewLevelData;
   import gameAll.data.level.OnePackData;
   import gameAll.data.weekExtra.WeekExtraData;
   import gameAll.high.HighArena_ExtraData;
   import gameAll.high.HighArms_ExtraData;
   import gameAll.high.HighDps_ExtraData;
   import gameAll.high.HighLife_ExtraData;
   import gameAll.honor.HonorData;
   import gameAll.vip.VipData;
   import goods.GoodsDefine;
   import unit4399.PreventCF;
   
   public class GameData
   {
      
      public static var diffName:Array = ["普通","噩梦","地狱","炼狱"];
      
      public static var packName:Array = ["p1","p2"];
      
      public static var packCnName:Array = ["自由之心","月球危机"];
      
      public static var MAX_LEVEL:int = 149;
      
      public var username:String = "";
      
      public var uid:int = 0;
      
      public var nowSaveIndex:int = 2;
      
      public var pcf:PreventCF = PreventCF.getInstance();
      
      public var baseLifeVar:* = 0.2;
      
      public var vv:Number = 3.123;
      
      private var _baseLife:Number = 200;
      
      private var _carLife:Number = 0;
      
      private var _foreverLife:Number = 0;
      
      private var _nowLife:String = "200";
      
      public var baseDefence:Number = 200;
      
      private var _carDefence:Number = 0;
      
      public var carDefenceType:String = "mixed";
      
      private var _foreverDefence:Number = 0;
      
      private var _level:String = "0";
      
      private var _level2:int = 0;
      
      public var _maxExp:Number = 0;
      
      public var nowGetExp:Number = 0;
      
      public var nowGCoin:Number = 0;
      
      public var nowScore:int = 0;
      
      public var gameTime:Number = 0;
      
      public var nowAchieve:int = 0;
      
      public var nowKillNum:int = 0;
      
      public var nowHurtNum:int = 0;
      
      public var nowArmsIndex:int = 0;
      
      public var nowArmsData:ArmsItemsData;
      
      public var nowCarLabel:String = "beetle";
      
      public var subCarLabel:String = "subCar_blue";
      
      private var _nowExp:String = "0";
      
      public var _achieve:String = "100";
      
      public var _maxAchieve:int = 0;
      
      public var allAchieve:int = 0;
      
      private var _GCoin:String = "";
      
      private var _GCoin2:Number = 0;
      
      private var _MCoin:String = "";
      
      private var _MCoin2:Number = 0;
      
      public var _score:String = "";
      
      public var bulletNum:int = 1;
      
      public var hitBulletNum:int = 0;
      
      public var playerRank:String = "新兵";
      
      public var _rankLevel:int = 0;
      
      public var maxRankLevel:int = 29;
      
      public var playerName:String = "4399小战士";
      
      public var headLabel:String = "s1";
      
      public var unlockedHeads:Array = ["s1","s2","s3"];
      
      public var tutorial:int = 0;
      
      public var skillLevel:Array = [0,0,0];
      
      public var nowSkillNum:Array = [0,0,0];
      
      public var levelsLock:Array = [1,0,0,0,0];
      
      public var levelsMax:int = 30;
      
      public var nowDifficult:int = 0;
      
      public var nowGameLevel:int = 0;
      
      public var nowGameEnemyLevel:int = 0;
      
      public var playerData:PlayerData = new PlayerData();
      
      public var rankAdd:randAddData = new randAddData();
      
      public var armsItems:ArmsItemsDataGroup = new ArmsItemsDataGroup();
      
      public var subItems:ArmsItemsDataGroup = new ArmsItemsDataGroup();
      
      public var carItems:CarItemsDataGroup = new CarItemsDataGroup();
      
      public var materialsItems:GoodsItemsDataGroup = new GoodsItemsDataGroup();
      
      public var propsItems:GoodsItemsDataGroup = new GoodsItemsDataGroup();
      
      public var taskData:TaskData = new TaskData();
      
      public var challengeTaskData:ChallengeTaskData = new ChallengeTaskData();
      
      public var collectTaskData:CollectTaskData = new CollectTaskData();
      
      public var weekTaskData:WeekTaskData = new WeekTaskData();
      
      public var giftData:GiftData = new GiftData();
      
      public var extraData:ExtraData = new ExtraData();
      
      public var weekExtraData:WeekExtraData = new WeekExtraData();
      
      public var specialExtraData:SpecialExtraData = new SpecialExtraData();
      
      public var honorData:HonorData = new HonorData();
      
      public var vipData:VipData = new VipData();
      
      public var growVip:Boolean = false;
      
      public var dailySignData:DailySignData = new DailySignData();
      
      public var isZuobi:Boolean = false;
      
      public var zuobiStr:String = "";
      
      public var testRankZuobiB:Boolean = true;
      
      public var backstageMCoin:int = 0;
      
      public var totalEarnedMCoin:Number = 0;
      
      public var modInfiniteEnergy:Boolean = false;
      
      public var modGod:Boolean = false;
      
      public var modOneHit:Boolean = false;
      
      public var modUnlockAll:Boolean = false;
      
      public var modCraftFree:Boolean = false;
      
      public var modNoExtraCooldown:Boolean = false;
      
      public var modNoTaskCooldown:Boolean = false;
      
      public var modAllLevelsPassed:Boolean = false;
      
      public var autoCollectLifePer:Boolean = true;
      
      public var knowingData:KnowingData = new KnowingData();
      
      public var ghostData:GhostData = new GhostData();
      
      public var groupData:GroupData = new GroupData();
      
      public var livenessData:LivenessData = new LivenessData();
      
      public var arenaData:ArenaData = new ArenaData();
      
      public var passData:PassScore = new PassScore();
      
      public var newLevelData:NewLevelData = new NewLevelData();
      
      public var offlineUnion:Object = null;
      
      public var saveDataVersion:String = "1.003";
      
      public var lifeRateB:Boolean = true;
      
      public var lifeRateB2:Boolean = true;
      
      public var itemsAdd:AllAdditionalData = new AllAdditionalData();
      
      public var newGiftNumber:Number = 1.3;
      
      public var NOW_GIFT_NUMBER:Number = 1.6;
      
      public var isVipLevelB:Boolean = false;
      
      public var aideEnabled:Boolean = false;
      
      public var isNationalDay:Boolean = true;
      
      public var lastExchangeData:String = "0_0|0,0|0,0|0,0|0,0|0,0|0";
      
      public function GameData()
      {
         super();
         this.maxAchieve = 0;
         this.maxExp = 0;
         this.subItems.equMaxNum = 8;
         this.materialsItems.bagMaxNum = 126;
         this.propsItems.bagMaxNum = 144;
      }
      
      public static function getDiffName(diff0:int) : String
      {
         return diffName[diff0];
      }
      
      public static function getPackName(name0:String) : String
      {
         var index0:int = packName.indexOf(name0);
         return packCnName[index0];
      }
      
      public function gamingInit() : *
      {
         this.nowGetExp = 0;
         this.nowGCoin = 0;
         this.nowScore = 0;
         this.gameTime = 0;
         this.nowAchieve = 0;
         this.nowKillNum = 0;
         this.bulletNum = 0;
         this.hitBulletNum = 0;
         this.nowHurtNum = 0;
      }
      
      public function getNowGoodsDefine() : GoodsDefine
      {
         var gd0:GoodsDefine = new GoodsDefine();
         gd0.price = this.GCoin;
         gd0.Mprice = this.MCoin;
         gd0.Xprice = this.materialsItems.getNumByBase("superalloy_X");
         gd0.Yprice = this.materialsItems.getNumByBase("superalloy_Y");
         gd0.Zprice = this.materialsItems.getNumByBase("superalloy_Z");
         gd0.Jprice = this.propsItems.getNumByBase("justice_badge");
         return gd0;
      }
      
      public function delNowGoodsDefine(d0:GoodsDefine) : *
      {
         this.addCoin(-d0.price);
         this.materialsItems.useItemsNum("superalloy_X",d0.Xprice);
         this.materialsItems.useItemsNum("superalloy_Y",d0.Yprice);
         this.materialsItems.useItemsNum("superalloy_Z",d0.Zprice);
         this.propsItems.useItemsNum("justice_badge",d0.Jprice);
         if(d0.isZuobi())
         {
            Game.uiGroup.zuobile("价格修改了！");
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      public function use_GCoin_card() : *
      {
         var name0:String = null;
         var gd0:GoodsItemsData = null;
         var i:int = 0;
         while(i < 4)
         {
            name0 = "GCoin_card_" + (i + 1);
            gd0 = this.propsItems.getItemsByName(name0);
            if(gd0 is GoodsItemsData)
            {
               Game.IC.useItems(gd0,this.propsItems,true);
            }
            i++;
         }
      }
      
      public function inData_byObj(obj:Object, fleshB:Boolean = false) : *
      {
         var n:* = undefined;
         var v00:Number = Number(NaN);
         var v01:Number = Number(NaN);
         var m:* = undefined;
         var pro0:String = null;
         var name2:String = null;
         var tt:int = 0;
         var pro_arr:Array = ["tutorial","levelsLock","nowSkillNum","foreverLife","nowLife","baseDefence","foreverDefence","level","nowArmsIndex","nowExp","achieve","allAchieve","GCoin","MCoin","score","playerRank","playerName","rankLevel","headLabel","unlockedHeads","lastExchangeData","growVip"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.nowDifficult = 0;
         this.nowGameLevel = 0;
         v00 = Number(this.saveDataVersion.split(" ")[0]);
         v01 = Number(Game.versionNumber.split(" ")[0]);
         if(v00 > v01)
         {
            Game.uiGroup.checkTip.showCheck2("当前存档版本和游戏版本不符，\n有可能会导致无法读取存档的问题。",2);
         }
         this.GCoin2 = obj.hasOwnProperty("GCoin2") ? obj.GCoin2 : this.GCoin;
         this.MCoin2 = obj.hasOwnProperty("MCoin2") ? obj.MCoin2 : this.MCoin;
         this.level2 = obj.hasOwnProperty("level2") ? obj.level2 : this.level;
         this.modInfiniteEnergy = obj.hasOwnProperty("modInfiniteEnergy") ? Boolean(obj.modInfiniteEnergy) : false;
         this.modGod = obj.hasOwnProperty("modGod") ? Boolean(obj.modGod) : false;
         this.modOneHit = obj.hasOwnProperty("modOneHit") ? Boolean(obj.modOneHit) : false;
         this.modUnlockAll = obj.hasOwnProperty("modUnlockAll") ? Boolean(obj.modUnlockAll) : false;
         this.modCraftFree = obj.hasOwnProperty("modCraftFree") ? Boolean(obj.modCraftFree) : false;
         this.modNoExtraCooldown = obj.hasOwnProperty("modNoExtraCooldown") ? Boolean(obj.modNoExtraCooldown) : false;
         this.modNoTaskCooldown = obj.hasOwnProperty("modNoTaskCooldown") ? Boolean(obj.modNoTaskCooldown) : false;
         this.autoCollectLifePer = obj.hasOwnProperty("autoCollectLifePer") ? Boolean(obj.autoCollectLifePer) : true;
         this.modAllLevelsPassed = obj.hasOwnProperty("modAllLevelsPassed") ? Boolean(obj.modAllLevelsPassed) : false;
         this.isZuobi = false;
         this.zuobiStr = "";
         if(obj.hasOwnProperty("offlineUnion") && obj.offlineUnion != null)
         {
            this.offlineUnion = obj.offlineUnion;
         }
         else
         {
            this.offlineUnion = null;
         }
         if(!obj.hasOwnProperty("testRankZuobiB"))
         {
            this.testRankZuobiB = true;
         }
         else
         {
            this.testRankZuobiB = obj.testRankZuobiB;
         }
         if(!obj.hasOwnProperty("subCarLabel"))
         {
            this.subCarLabel = "subCar_blue";
         }
         else
         {
            this.subCarLabel = obj.subCarLabel;
            if(this.subCarLabel.indexOf("subCar_") == -1)
            {
               this.subCarLabel = "subCar_blue";
            }
         }
         if(!obj.hasOwnProperty("saveDataVersion"))
         {
            this.saveDataVersion = "1.003";
         }
         else
         {
            this.saveDataVersion = obj.saveDataVersion;
         }
         if(!obj.hasOwnProperty("newGiftNumber"))
         {
            this.newGiftNumber = 1.3;
         }
         else
         {
            this.newGiftNumber = obj.newGiftNumber;
         }
         var newData_arr0:Array = ["passData","dailySignData","vipData","honorData","weekTaskData","collectTaskData","arenaData","livenessData","specialExtraData","weekExtraData","groupData","ghostData","knowingData","challengeTaskData","extraData","giftData","taskData"];
         newData_arr0 = newData_arr0.reverse();
         newData_arr0 = newData_arr0.concat([]);
         for(m in newData_arr0)
         {
            name2 = newData_arr0[m];
            if(obj.hasOwnProperty(name2))
            {
               this[name2].inData_byObj(obj[name2]);
            }
            else
            {
               this[name2].init();
            }
         }
         if(!obj.hasOwnProperty("backstageMCoin"))
         {
            this.backstageMCoin = 0;
         }
         else
         {
            this.backstageMCoin = obj.backstageMCoin;
         }
         if(obj.hasOwnProperty("totalEarnedMCoin"))
         {
            this.totalEarnedMCoin = Number(obj.totalEarnedMCoin);
         }
         else
         {
            this.totalEarnedMCoin = this.MCoin;
         }
         if(isNaN(this.totalEarnedMCoin) || this.totalEarnedMCoin < 0)
         {
            this.totalEarnedMCoin = 0;
         }
         this.challengeTaskData.fleshByTaskDefine();
         this.collectTaskData.fleshByTaskDefine();
         this.weekTaskData.fleshByTaskDefine();
         if(obj.hasOwnProperty("newLevelData"))
         {
            this.newLevelData.inData_byObj(obj.newLevelData);
         }
         else
         {
            this.newLevelData.init();
            this.newLevelData.switchData(this.levelsLock,this.knowingData.levelsLock,this.ghostData.levelsLock,this.passData.OBJ);
         }
         this.armsItems.inData_byObj(obj.armsItems);
         this.subItems.inData_byObj(obj.subItems);
         this.carItems.inData_byObj(obj.carItems);
         this.materialsItems.inData_byObj(obj.materialsItems);
         if(this.materialsItems.bagMaxNum < 126)
         {
            this.materialsItems.bagMaxNum = 126;
         }
         this.propsItems.inData_byObj(obj.propsItems);
         if(this.propsItems.bagMaxNum < 144)
         {
            this.propsItems.bagMaxNum = 144;
         }
         this.migrateClaimedLevelGiftWeapons();
         this.playerData.inData_byObj(obj.playerData);
         this.rankAdd.inData_byObj(obj.rankAdd);
         if(fleshB)
         {
            tt = getTimer();
            this.armsItems.fleshData();
            this.subItems.fleshData();
         }
         this.fleshExp_Achieve();
         this.nowArmsData = this.armsItems.equArr[this.nowArmsIndex];
         this.fleshAdd_byItems();
         if(Boolean(this.armsItems.getItemsByBase("cutter_gold",false)))
         {
            this.armsItems.delItemByBaseLabel("cutter_gold",false);
            if(this.checkArms_byIDArr(["cutter_gold_lv1"]) != "")
            {
               return;
            }
            this.subItems.addItems("cutter_gold_lv1",true);
         }
      }

      private function migrateClaimedLevelGiftWeapons() : *
      {
         var need2013:Boolean = this.giftData.getLevelUnlock(0) == 1 && !(this.armsItems.getItemsByBase("snow",false) is ArmsItemsData);
         var needSparta:Boolean = this.giftData.getLevelUnlock(1) == 1 && !(this.armsItems.getItemsByBase("arc",false) is ArmsItemsData);
         var needed:int = int(need2013) + int(needSparta);
         if(needed <= 0)
         {
            return;
         }
         if(this.armsItems.getSurplus() < needed)
         {
            this.armsItems.bagMaxNum = this.armsItems.arr.length + needed;
         }
         if(need2013)
         {
            this.armsItems.addItems("snow_lv1",true);
         }
         if(needSparta)
         {
            this.armsItems.addItems("arc_lv1",true);
         }
      }
      
      public function testAddArmsItems() : *
      {
         this.level = 0;
         this.GCoin = 500000;
         this.GCoin2 = 500000;
         this.nowExp = 0;
         this.achieve = 0;
         this.score = 0;
         this.baseLife = 200;
         this.carLife = 0;
         this.foreverLife = 0;
         this.nowLife = 0;
         this.carDefence = 0;
         this.rankLevel = 0;
         this.arenaData.nowRank = 9999;
         this.subCarLabel = "subCar_blue";
         this.nowDifficult = 0;
         this.lastExchangeData = "0_0|0,0|0,0|0,0|0,0|0,0|0";
         this.itemsAdd.clearData();
         var n:int = 0;
         while(n < 1)
         {
            this.armsItems.addItems("soya_lv1");
            n++;
         }
         this.armsItems.loadEquip(this.armsItems.arr[0].id,0);
         this.nowArmsData = this.armsItems.equArr[0];
         var m:int = 0;
         while(m < 1)
         {
            m++;
         }
         this.subItems.armsState = ["","lock","lock","lock","lock","lock","lock","lock"];
         var m2:int = 0;
         while(m2 < 1)
         {
            this.carItems.addItems(this.nowCarLabel);
            m2++;
         }
         this.carItems.loadFirstEquip();
         var chip0:GoodsItemsData = this.materialsItems.addItems("white_chip");
         chip0.addArr = ["life_rate:5"];
         this.materialsItems.addItems("superalloy_Z");
         this.propsItems.addItems("rebirth_crystal",5);
         this.extraData.init();
         this.taskData.fleshTaskStr();
         this.knowingData.init();
         this.ghostData.init();
         this.weekExtraData.init();
         this.specialExtraData.init();
         this.livenessData.init();
         this.arenaData.init();
         this.honorData.init();
         this.vipData.init();
         this.passData.init();
         this.collectTaskData.init();
         this.challengeTaskData.init();
         this.weekTaskData.init();
         this.playerData.init();
         this.newLevelData.init();
         this.fleshExp_Achieve();
         this.setValue_byLevel();
      }
      
      public function OverduePan() : *
      {
         this.carItems.OverduePan();
      }
      
      public function newDayCtrl() : *
      {
         this.rankAdd.newDayCtrl();
         this.taskData.newDayCtrl();
         this.giftData.newDayCtrl();
         this.extraData.newDayCtrl();
         this.challengeTaskData.newDayCtrl();
         this.collectTaskData.newDayCtrl();
         this.specialExtraData.newDayCtrl();
         this.livenessData.newDayCtrl();
         this.arenaData.newDayCtrl();
         this.vipData.newDayCtrl();
         this.weekTaskData.newDayCtrl();
         this.weekExtraData.newDayCtrl();
      }
      
      public function getKnowingLevelUnLock() : int
      {
         if(this.modUnlockAll || this.modAllLevelsPassed)
         {
            return 9999;
         }
         return this.knowingData.levelsLock[this.nowDifficult];
      }
      
      public function getGhostLevelUnLock() : int
      {
         if(this.modUnlockAll || this.modAllLevelsPassed)
         {
            return 9999;
         }
         return this.ghostData.levelsLock[this.nowDifficult];
      }
      
      public function fleshExp_Achieve() : *
      {
         this.maxExp = this.getMustExp();
         this.maxAchieve = Game.gameDefine.getAchieve(this.rankLevel);
         this.rankAdd.inData_byLevel(this.rankLevel);
         this.playerRank = Game.gameDefine.getRankName(this.rankLevel);
      }
      
      public function getAllDps() : Number
      {
         return this.armsItems.getOneDps() + this.subItems.getAllDps();
      }
      
      public function copy() : GameData
      {
         var gd0:GameData = new GameData();
         gd0.inData_byObj(this);
         return gd0;
      }
      
      public function copyObj() : Object
      {
         var bty0:ByteArray = new ByteArray();
         bty0.writeObject(this.copy());
         bty0.position = 0;
         return bty0.readObject();
      }
      
      public function getFirstGameB() : Boolean
      {
         if(this.levelsLock[0] == 1)
         {
            return true;
         }
         return false;
      }
      
      public function checkArms_byIDArr(arr0:Array) : String
      {
         var n:* = undefined;
         var id0:String = null;
         var aid0:ArmsItemsData = null;
         for(n in arr0)
         {
            id0 = arr0[n];
            aid0 = this.armsItems.getItemsByBase(id0,false);
            if(aid0 is ArmsItemsData)
            {
               return aid0.cnName;
            }
            aid0 = this.subItems.getItemsByBase(id0,false);
            if(aid0 is ArmsItemsData)
            {
               return aid0.cnName;
            }
         }
         return "";
      }
      
      public function getLifePer() : Number
      {
         return this.baseLifeVar + this.itemsAdd.lifeBall;
      }
      
      public function fleshAdd_byItems(panGamingB:Boolean = false) : *
      {
         var card0:CarDefine = null;
         var carda0:CarItemsData = null;
         this.itemsAdd = new AllAdditionalData();
         this.itemsAdd.addData(this.armsItems.getAdd());
         this.itemsAdd.addData(this.subItems.getAdd());
         this.honorData.fleshAdd();
         this.itemsAdd.addData(this.honorData.add);
         this.itemsAdd.addData(this.vipData.buffAdd);
         this.itemsAdd.addData(this.giftData.GetStarAdd());
         this.itemsAdd.addCarData(this.carItems.getAdd());
         if(!(panGamingB || Game.gameState == "gaming"))
         {
            this.setLife(0);
         }
         if(Boolean(this.carItems.getNow()))
         {
            carda0 = this.carItems.getNow();
            card0 = carda0.getArmsDefine();
            this.carLife = carda0.getNowLife();
            this.carDefence = carda0.getNowDefence();
            this.carDefenceType = carda0.getDefenceType();
         }
         else
         {
            card0 = Game.defineGroup.getCarDefine("beetle");
            this.carLife = card0.baseLife;
            this.carDefence = card0.defenceValue;
            this.carDefenceType = card0.defenceType;
         }
         this.baseLife = Game.gameDefine.getLife(this.level);
         this.baseDefence = Game.gameDefine.getDefence(this.level);
      }
      
      public function get maxLife() : Number
      {
         return (this.baseLife + this.foreverLife + this.carLife + this.itemsAdd.life_value) * (1 + this.playerData.lifeAdd.value + this.itemsAdd.life_max + this.itemsAdd.lifeAdd + this.itemsAdd.allAdd + this.playerData.allAdd.value + this.rankAdd.attackAdd + Game.uiGroup.unionUI.GetBuildAddByType(1));
      }
      
      public function get maxDefence() : Number
      {
         return (this.carDefence + this.foreverDefence + this.itemsAdd.defence_max) * (1 + this.playerData.defenceAdd.value + this.itemsAdd.defenceAdd + this.itemsAdd.defence_mul + this.itemsAdd.allAdd + this.playerData.allAdd.value + Game.uiGroup.unionUI.GetBuildAddByType(2));
      }
      
      public function getAllArmsAdd() : Number
      {
         return 1 + this.playerData.attackAdd.value + this.playerData.allAdd.value + this.itemsAdd.attackAdd + this.itemsAdd.allAdd + this.rankAdd.attackAdd + Game.uiGroup.unionUI.GetBuildAddByType(0);
      }
      
      public function getAllSubAdd() : Number
      {
         return 1 + this.playerData.subAdd.value + this.playerData.allAdd.value + this.itemsAdd.subAdd + this.itemsAdd.allAdd + Game.uiGroup.unionUI.GetBuildAddByType(3);
      }
      
      public function setLife(value:Number, way0:String = "add") : *
      {
         if(this.modGod && value < 0)
         {
            return;
         }
         var ml0:Number = this.maxLife;
         if(way0 == "add")
         {
            this.nowLife += value;
         }
         else if(way0 == "value")
         {
            this.nowLife = value;
         }
         else if(way0 == "mul")
         {
            this.nowLife += value * ml0;
         }
         if(this.nowLife < 0)
         {
            this.nowLife = 0;
         }
         if(this.nowLife > ml0)
         {
            this.nowLife = ml0;
         }
      }
      
      public function addExp(value:Number) : *
      {
         this.maxExp = this.getMustExp();
         this.addScore(value / 10);
         var level0:int = this.level;
         if(level0 >= MAX_LEVEL)
         {
            this.nowExp = 0;
         }
         else
         {
            this.nowExp += value;
            this.nowGetExp += value;
            while(this.nowExp >= this.maxExp)
            {
               this.nowExp -= this.maxExp;
               ++this.level;
               if(this.level >= MAX_LEVEL)
               {
                  break;
               }
               this.maxExp = this.getMustExp();
            }
            if(level0 < this.level)
            {
               this.setValue_byLevel();
               Game.uiGroup.upLevel();
            }
         }
      }
      
      
      public function isHeadUnlocked(headId:String) : Boolean
      {
         var n:* = undefined;
         if(headId == null || headId == "")
         {
            return false;
         }
         if(this.unlockedHeads == null)
         {
            this.unlockedHeads = ["s1","s2","s3"];
         }
         for(n in this.unlockedHeads)
         {
            if(this.unlockedHeads[n] == headId)
            {
               return true;
            }
         }
         // default free heads
         if(headId == "s1" || headId == "s2" || headId == "s3")
         {
            return true;
         }
         return false;
      }

      public function unlockHead(headId:String) : *
      {
         if(this.isHeadUnlocked(headId))
         {
            return;
         }
         if(this.unlockedHeads == null)
         {
            this.unlockedHeads = ["s1","s2","s3"];
         }
         this.unlockedHeads.push(headId);
      }
      public function addCoin(value:int) : *
      {
         var g1:* = this.GCoin;
         var g2:* = this.GCoin2;
         var zuobi0:Boolean = g1 != g2;
         this.GCoin += value;
         if(value > 0)
         {
            this.nowGCoin += value;
         }
         if(this.GCoin < 0)
         {
            this.GCoin = 0;
         }
         else if(this.GCoin >= 2000000000)
         {
            this.GCoin = 2000000000;
         }
         this.GCoin2 = this.GCoin;
      }
      
      public function addMCoin(value:int) : *
      {
         var g1:* = this.MCoin;
         var g2:* = this.MCoin2;
         var zuobi0:Boolean = g1 != g2;
         this.MCoin += value;
         if(value > 0)
         {
            this.totalEarnedMCoin += value;
         }
         if(this.MCoin < 0)
         {
            this.MCoin = 0;
         }
         this.MCoin2 = this.MCoin;
      }
      
      public function addScore(value:int) : *
      {
         if(this.score < 100000000)
         {
            this.score += value;
            this.nowScore += value;
            if(this.score < 0)
            {
               this.score = 0;
            }
         }
      }
      
      public function addKillNum(value:int) : *
      {
         this.nowKillNum += value;
         this.weekTaskData.addKillNum(value);
      }
      
      public function addAchieve(value:int) : *
      {
         var level0:int = 0;
         this.maxAchieve = Game.gameDefine.getAchieve(this.rankLevel);
         if(this.rankLevel < this.maxRankLevel)
         {
            this.achieve += value;
            this.allAchieve += value;
            this.nowAchieve += value;
            level0 = this.rankLevel;
            while(this.achieve >= this.maxAchieve)
            {
               if(this.rankLevel >= this.maxRankLevel)
               {
                  this.gotoMaxAchieve();
                  break;
               }
               this.achieve -= this.maxAchieve;
               ++this.rankLevel;
               this.fleshExp_Achieve();
               this.materialsItems.bagMaxNum += this.rankAdd.bag;
            }
            if(level0 < this.rankLevel)
            {
               this.rankAdd.upDataInitAll();
               Game.uiGroup.changeUI.materialsUI.fleshAll();
            }
         }
         else
         {
            this.gotoMaxAchieve();
         }
      }
      
      public function gotoMaxAchieve() : *
      {
         this.rankLevel = this.maxRankLevel;
         this.achieve = this.maxAchieve;
         this.allAchieve = Game.gameDefine.getAllAchieve(this.rankLevel);
      }
      
      public function setValue_byLevel() : *
      {
         this.maxExp = this.getMustExp();
         this.fleshAdd_byItems();
         this.nowLife = this.maxLife;
      }
      
      public function getMustExp() : Number
      {
         return Game.gameDefine.getExp(this.level);
      }
      
      public function getNowLevelUnlock() : int
      {
         if(this.modUnlockAll || this.modAllLevelsPassed)
         {
            return 9999;
         }
         return this.levelsLock[this.nowDifficult];
      }
      
      public function getLevelUnlockB(diff0:int, level0:int, levelPack0:String = "") : Boolean
      {
         if(this.modUnlockAll || this.modAllLevelsPassed)
         {
            return true;
         }
         var bb0:Boolean = false;
         var unlock_level0:int = 0;
         var mustLevel:int = 0;
         if(levelPack0 == "")
         {
            unlock_level0 = int(this.levelsLock[diff0]);
            if(level0 <= unlock_level0)
            {
               bb0 = true;
            }
         }
         else if(levelPack0 == "knowing")
         {
            if(diff0 == 0)
            {
               mustLevel = Game.gameDefine.getKnowingMustLevel(level0);
               if(this.level + 1 >= mustLevel)
               {
                  bb0 = true;
               }
            }
            else
            {
               unlock_level0 = int(this.knowingData.levelsLock[diff0]);
               if(level0 <= unlock_level0)
               {
                  bb0 = true;
               }
            }
         }
         else if(levelPack0 == "ghost")
         {
            unlock_level0 = int(this.ghostData.levelsLock[diff0]);
            if(level0 <= unlock_level0)
            {
               bb0 = true;
            }
         }
         return bb0;
      }
      
      public function get defenceHurtRedu() : Number
      {
         return this.getDefenceHurtRedu(this.maxDefence,this.level);
      }
      
      public function getDefenceHurtRedu(def0:Number, level0:int) : Number
      {
         var d_ra2:Number = def0 / (def0 + (level0 + 1) * Game.gameDefine.getDefence_ra(level0));
         if(d_ra2 > 0.9)
         {
            d_ra2 = 0.9;
         }
         return d_ra2;
      }
      
      public function fleshBagFillShow() : *
      {
         if(this.materialsItems.arr.length >= this.materialsItems.bagMaxNum)
         {
            Game.uiGroup.showBagFill();
         }
         else
         {
            Game.uiGroup.hideBagFill();
         }
      }
      
      public function dataTimer() : *
      {
         var n:* = undefined;
         var id0:ArmsItemsData = null;
         var arr0:Array = this.armsItems.equArr;
         for(n in arr0)
         {
            id0 = arr0[n];
            id0.addEnergy(id0.maxEnergyRate / 6);
         }
         if(this.lifeRateB && this.lifeRateB2)
         {
            this.setLife(this.itemsAdd.life_rate / 6);
         }
         this.fleshBagFillShow();
      }
      
      public function getHighDps_ExtraData() : *
      {
         var d0:HighDps_ExtraData = new HighDps_ExtraData();
         d0.armsLabel = this.armsItems.getEquipList()[0];
         d0.subArr = this.subItems.getEquipSiteList();
         d0.carLabel = this.carItems.equArr[0].baseLabel;
         d0.skillNum = this.skillLevel;
         d0.group = this.groupData.name;
         d0.playerName = this.playerName;
         return d0;
      }
      
      public function getHighArena_ExtraData() : HighArena_ExtraData
      {
         var d0:HighArena_ExtraData = new HighArena_ExtraData();
         d0.arms = this.armsItems.getEquipList();
         d0.sub = this.subItems.getEquipList();
         d0.car = this.carItems.equArr[0].baseLabel;
         d0.skill = this.skillLevel;
         d0.group = this.groupData.name;
         d0.name = this.playerName;
         d0.dps = Math.ceil(this.getAllDps());
         d0.life = Math.ceil(this.maxLife);
         d0.defence = Math.ceil(this.maxDefence);
         d0.head = this.headLabel;
         d0.lv = this.level;
         return d0;
      }
      
      public function getHighLife_ExtraData() : *
      {
         var d0:HighLife_ExtraData = new HighLife_ExtraData();
         d0.group = this.groupData.name;
         d0.playerName = this.playerName;
         return d0;
      }
      
      public function getNiubiArms(type0:String) : *
      {
         var gd:ArmsItemsDataGroup = this.armsItems;
         if(type0 == "top_sub")
         {
            gd = this.subItems;
         }
         var aid0:ArmsItemsData = gd.getMaxDpsArms();
         var d0:HighArms_ExtraData = new HighArms_ExtraData();
         d0.playerName = this.playerName;
         if(Boolean(aid0))
         {
            d0.label = aid0.baseLabel;
            d0.name = aid0.cnName;
            d0.type = aid0.define.type;
            d0.dps = Math.ceil(aid0.define.getAllDps());
         }
         else
         {
            d0 = null;
         }
         return d0;
      }
      
      public function isLevelUnlock(diff0:int, level0:int) : Boolean
      {
         if(this.modUnlockAll || this.modAllLevelsPassed)
         {
            return true;
         }
         var page0:int = diff0 / 4;
         var bb0:Boolean = false;
         var p0:OnePackData = this.newLevelData[packName[page0]];
         if(level0 < p0.lockNum)
         {
            return true;
         }
         return false;
      }
      
      public function changeToNewLevel(diff0:int, level0:int) : Array
      {
         var max0:int = Game.gameData.levelsMax;
         var max1:int = Game.gameData.knowingData.levelsMax;
         var p0:int = int(diff0 / 4);
         var p_name0:String = "p1";
         var n_diff0:int = 0;
         if(p0 == 0)
         {
            level0 = level0;
         }
         else if(p0 == 1)
         {
            level0 += max0;
         }
         else if(p0 == 2)
         {
            level0 += max0 + max1;
         }
         else
         {
            p_name0 = "p2";
            n_diff0 = 1;
         }
         return [p_name0,level0,n_diff0 * 4 + diff0 % 4];
      }
      
      public function isBeforeLevelUnlock(diff0:int, level0:int) : Boolean
      {
         if(this.modUnlockAll || this.modAllLevelsPassed)
         {
            return true;
         }
         var arr0:Array = this.changeToNewLevel(diff0,level0);
         var page0:String = arr0[0];
         level0 = int(arr0[1]);
         var p0:OnePackData = this.newLevelData[page0];
         if(level0 < p0.lockNum)
         {
            return true;
         }
         return false;
      }
      
      public function getOneData_byType(type0:String) : *
      {
         var arr0:Array = null;
         if(type0 == "lv")
         {
            return String(this.level + 1);
         }
         if(type0 == "dps")
         {
            return String(this.getAllDps());
         }
         if(type0 == "enemy")
         {
            return String(this.honorData.ac.killEnemyNum);
         }
         if(type0 == "level")
         {
            arr0 = this.levelsLock.concat([]);
            if(arr0.length > 4)
            {
               arr0.pop();
            }
            return arr0.concat(this.knowingData.levelsLock).concat(this.ghostData.levelsLock);
         }
         return "";
      }
      
      public function get level() : int
      {
         return this.pcf.getAttribute("level");
      }
      
      public function set level(value:int) : *
      {
         this.pcf.setAttribute("level",value);
      }
      
      public function get level2() : int
      {
         return this._level2 - 8875256;
      }
      
      public function set level2(value:int) : *
      {
         this._level2 = value + 8875256;
      }
      
      public function get rankLevel() : int
      {
         return this.pcf.getAttribute("rankLevel");
      }
      
      public function set rankLevel(value:int) : *
      {
         this.pcf.setAttribute("rankLevel",value);
      }
      
      public function get nowExp() : Number
      {
         return this.pcf.getAttribute("nowExp");
      }
      
      public function set nowExp(value:Number) : *
      {
         this.pcf.setAttribute("nowExp",value);
      }
      
      public function get maxExp() : Number
      {
         return this.pcf.getAttribute("maxExp") - 737;
      }
      
      public function set maxExp(value:Number) : *
      {
         this.pcf.setAttribute("maxExp",value + 737);
      }
      
      public function get maxAchieve() : Number
      {
         return this.pcf.getAttribute("maxAchieve") - 737;
      }
      
      public function set maxAchieve(value:Number) : *
      {
         this.pcf.setAttribute("maxAchieve",value + 737);
      }
      
      public function get baseLife() : Number
      {
         return this.pcf.getAttribute("baseLife");
      }
      
      public function set baseLife(value:Number) : *
      {
         this.pcf.setAttribute("baseLife",value);
      }
      
      public function get carLife() : Number
      {
         return this.pcf.getAttribute("carLife");
      }
      
      public function set carLife(value:Number) : *
      {
         this.pcf.setAttribute("carLife",value);
      }
      
      public function get foreverLife() : Number
      {
         return this._foreverLife / this.vv;
      }
      
      public function set foreverLife(value:Number) : *
      {
         this._foreverLife = value * this.vv;
      }
      
      public function get nowLife() : Number
      {
         return this.pcf.getAttribute("nowLife");
      }
      
      public function set nowLife(value:Number) : *
      {
         this.pcf.setAttribute("nowLife",value);
      }
      
      public function get carDefence() : Number
      {
         return this.pcf.getAttribute("carDefence");
      }
      
      public function set carDefence(value:Number) : *
      {
         this.pcf.setAttribute("carDefence",value);
      }
      
      public function get foreverDefence() : Number
      {
         return this._foreverDefence / this.vv;
      }
      
      public function set foreverDefence(value:Number) : *
      {
         this._foreverDefence = value * this.vv;
      }
      
      public function get GCoin() : Number
      {
         return this.pcf.getAttribute("GCoin") - 737;
      }
      
      public function set GCoin(value:Number) : *
      {
         this.pcf.setAttribute("GCoin",value + 737);
      }
      
      public function get GCoin2() : Number
      {
         return this.pcf.getAttribute("GCoin2");
      }
      
      public function set GCoin2(value:Number) : *
      {
         this.pcf.setAttribute("GCoin2",value);
      }
      
      public function get MCoin() : Number
      {
         var value:Number = this.pcf.getAttribute("MCoin");
         if(isNaN(value))
         {
            this.pcf.setAttribute("MCoin",0);
            this.pcf.setAttribute("MCoin2",0);
            return 0;
         }
         return value;
      }
      
      public function set MCoin(value:Number) : *
      {
         if(isNaN(value))
         {
            value = 0;
            this.pcf.setAttribute("MCoin2",0);
         }
         this.pcf.setAttribute("MCoin",value);
      }
      
      public function get MCoin2() : Number
      {
         return this.pcf.getAttribute("MCoin2");
      }
      
      public function set MCoin2(value:Number) : *
      {
         if(isNaN(value))
         {
            value = 0;
         }
         this.pcf.setAttribute("MCoin2",value);
      }
      
      public function get score() : int
      {
         return Math.floor(int(TextWay.getText(this._score)));
      }
      
      public function set score(value:int) : *
      {
         this._score = TextWay.toCode(String(Math.floor(value)));
      }
      
      public function get achieve() : int
      {
         return this.pcf.getAttribute("achieve");
      }
      
      public function set achieve(value:int) : *
      {
         this.pcf.setAttribute("achieve",value);
      }
   }
}


