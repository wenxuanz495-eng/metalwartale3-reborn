package gameAll.level
{
   import data.ClassProperty;
   import data.TextWay;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import gameAll.data.level.NewLevelData;
   import gameAll.level.extra.ExtraLevel;
   import gameAll.level.extra.JuneExtraLevel;
   import gameAll.level.extra.SpecialExtraLevel_1;
   import gameAll.level.extra.SpecialExtraLevel_10;
   import gameAll.level.extra.SpecialExtraLevel_11;
   import gameAll.level.extra.SpecialExtraLevel_2;
   import gameAll.level.extra.SpecialExtraLevel_3;
   import gameAll.level.extra.SpecialExtraLevel_4;
   import gameAll.level.extra.SpecialExtraLevel_5;
   import gameAll.level.extra.SpecialExtraLevel_6;
   import gameAll.level.extra.SpecialExtraLevel_7;
   import gameAll.level.extra.SpecialExtraLevel_8;
   import gameAll.level.extra.SpecialExtraLevel_9;
   import gameAll.level.extra.VipExtraLevel;
   import gameAll.level.extra.WeekExtraLevel;
   import gameAll.order.EventOrderDefineGroup;
   import gameAll.order.EventOrderUnit;
   
   public class LevelGroup
   {
      
      public var filter:LevelDataFilter = new LevelDataFilter();
      
      public var xml_arr:Array = [];
      
      public var level_arr:Array = [];
      
      public var normalLevelObj:Object = {};
      
      public var normalEnemyLevelObj:Object = {};
      
      public var extraLevelObj:Object = {};
      
      public var index:int = -1;
      
      public var level:*;
      
      public var rebirthNum:int = 0;
      
      public var normalNameArr:Array = [[],[],[],[],[]];
      
      public var nameArr:Array = [];
      
      public var knowingNameArr:Array = [];
      
      public var ghostNameArr:Array = [];
      
      public var extraArr:Array = [];
      
      public var weekExtraArr:Array = [];
      
      public var specialExtraNameArr:Array = [];
      
      private var normal_num:int = 0;
      
      private var normal_knowing_num:int = 0;
      
      public var state:String = "normal";
      
      public var lv001:Level_0;
      
      public var lv002:Level_3;
      
      public var lv003:Level_6;
      
      public var lv005:Level_2_4;
      
      public var lv006:Level_2_5;
      
      public var lv_2_9:Level_2_9;
      
      public var lv_2_10:Level_2_10;
      
      public var lv_2_11:Level_2_11;
      
      public var lv_2_12:Level_2_12;
      
      public var lv_2_13:Level_2_13;
      
      public var lv_3_00:GhostLevel;
      
      public var lv_3_1:Level_3_1;
      
      public var lv_3_3:Level_3_3;
      
      public var lv_3_13:Level_3_13;
      
      public var lv_3_15:Level_3_15;
      
      public var lv_3_16:Level_3_16;
      
      public var lv004:ExtraLevel;
      
      public var lv008:WeekExtraLevel;
      
      public var sl_1:SpecialExtraLevel_1;
      
      public var sl_2:SpecialExtraLevel_2;
      
      public var sl_3:SpecialExtraLevel_3;
      
      public var sl_4:SpecialExtraLevel_4;
      
      public var sl_5:SpecialExtraLevel_5;
      
      public var sl_6:SpecialExtraLevel_6;
      
      public var sl_7:SpecialExtraLevel_7;
      
      public var sl_8:SpecialExtraLevel_8;
      
      public var sl_9:SpecialExtraLevel_9;
      
      public var sl_10:SpecialExtraLevel_10;
      
      public var sl_11:SpecialExtraLevel_11;
      
      public var al_0:ArenaLevel;
      
      public var vipl_0:VipExtraLevel;
      
      public var june_0:JuneExtraLevel;
      
      public function LevelGroup()
      {
         super();
         EventOrderUnit.pro_arr = ClassProperty.getProArr(new EventOrderUnit());
         this.filter.LG = this;
      }
      
      public function inAllXML(xml0:XML) : *
      {
         var n:* = undefined;
         var xx0:int = 0;
         var levelAddArr0:Array = null;
         var packName0:String = null;
         var packId0:String = null;
         var l_xml0:* = undefined;
         var name0:String = null;
         var class0:Class = null;
         var id0:String = null;
         var className0:String = null;
         var arr0:Array = null;
         var firstID:String = null;
         var secondID:String = null;
         var threeID:String = null;
         var level00:* = undefined;
         this.filter.diffArr = TextWay.xmlToNumberArr(xml0.levelData[0].diff[0]);
         var fatherxml:* = xml0.father;
         var levelxml:* = fatherxml.level;
         var p1_levelsMax0:int = 0;
         var p2_levelsMax0:int = 0;
         this.normalLevelObj["p1"] = [];
         this.normalLevelObj["p2"] = [];
         for(n in levelxml)
         {
            levelAddArr0 = null;
            packName0 = "";
            packId0 = "";
            l_xml0 = levelxml[n];
            this.xml_arr.push(l_xml0);
            name0 = String(l_xml0.child("name"));
            id0 = l_xml0.@id;
            className0 = String(l_xml0.specialClass);
            arr0 = id0.split("-");
            firstID = arr0[0];
            secondID = arr0[1];
            threeID = arr0[2];
            if(firstID == "1")
            {
               if(secondID == "3")
               {
                  class0 = getDefinitionByName("gameAll.level.GhostLevel") as Class;
               }
               else
               {
                  class0 = getDefinitionByName("gameAll.level.Levels") as Class;
               }
               if(secondID == "1" || secondID == "2" || secondID == "3")
               {
                  if(int(threeID) < 999)
                  {
                     if(secondID == "1")
                     {
                        ++this.normal_num;
                     }
                     else if(secondID == "2")
                     {
                        ++this.normal_knowing_num;
                     }
                     p1_levelsMax0++;
                     this.normalNameArr[0].push(name0);
                     levelAddArr0 = this.normalLevelObj["p1"];
                     packName0 = NewLevelData.packName[0];
                     packId0 = "p1";
                  }
               }
               else
               {
                  p2_levelsMax0++;
                  this.normalNameArr[1].push(name0);
                  levelAddArr0 = this.normalLevelObj["p2"];
                  packName0 = NewLevelData.packName[1];
                  packId0 = "p2";
               }
            }
            else if(firstID == "2")
            {
               class0 = getDefinitionByName("gameAll.level.extra.ExtraLevel") as Class;
               this.extraArr.push(name0);
            }
            else if(firstID == "3")
            {
               class0 = getDefinitionByName("gameAll.level.extra.WeekExtraLevel") as Class;
               this.weekExtraArr.push(name0);
            }
            else if(firstID == "4")
            {
               class0 = getDefinitionByName("gameAll.level.Levels") as Class;
               this.specialExtraNameArr.push(name0);
            }
            else if(firstID == "5")
            {
               class0 = getDefinitionByName("gameAll.level.ArenaLevel") as Class;
            }
            if(className0 != "")
            {
               class0 = getDefinitionByName(className0) as Class;
            }
            if(id0.substr(0,3) == "1-2")
            {
               this.knowingNameArr.push(name0);
            }
            else if(id0.substr(0,3) == "1-3")
            {
               this.ghostNameArr.push(name0);
            }
            level00 = new class0();
            this.level_arr.push(level00);
            if(Boolean(levelAddArr0))
            {
               levelAddArr0.push(level00);
            }
            level00.packName = packName0;
            level00.packId = packId0;
            level00.inData_byXML(l_xml0);
            Game.gameDefine.level.setLevel(id0,level00.levelsLevel);
         }
         Game.gameData.newLevelData.p1.levelsMax = p1_levelsMax0;
         Game.gameData.newLevelData.p2.levelsMax = p2_levelsMax0;
         this.filter.init();
         xx0 = 0;
         trace("LevelGroup:p1最大关卡数量：" + p1_levelsMax0);
         trace("LevelGroup:p2最大关卡数量：" + p2_levelsMax0);
      }
      
      public function chosenLevel(index0:int) : *
      {
         var id0:String = "";
         if(this.state == "normal")
         {
            if(index0 < this.normal_num || index0 >= 999)
            {
               id0 = "1-1-" + index0;
            }
            else if(index0 < this.normal_num + this.normal_knowing_num)
            {
               id0 = "1-2-" + (index0 - this.normal_num);
            }
            else if(index0 < 100)
            {
               id0 = "1-3-" + (index0 - this.normal_num - this.normal_knowing_num);
            }
            else
            {
               id0 = "1-4-" + index0 % 100;
            }
         }
         else if(this.state == "extra")
         {
            id0 = "2-1-" + index0;
         }
         else if(this.state == "weekExtra")
         {
            id0 = "3-1-" + index0;
         }
         else if(this.state == "specialExtra")
         {
            id0 = "4-1-" + index0;
         }
         else if(this.state == "arena")
         {
            id0 = "5-1-" + index0;
         }
         else if(this.state == "union")
         {
            id0 = "6-1-" + index0;
         }
         var lv0:Levels = this.getLevel_byID(id0);
         if(lv0 is Levels)
         {
            this.index = index0;
            Game.gameData.nowGameLevel = this.index;
            this.level = lv0;
            this.level.reloadXML();
            trace("LevelGroup 选择关卡：" + this.level.name);
         }
         else
         {
            trace("在数组中没找到指定关卡：" + id0);
         }
      }
      
      public function getLevel_byID(id0:String) : Levels
      {
         var n:* = undefined;
         var lv0:Levels = null;
         for(n in this.level_arr)
         {
            lv0 = this.level_arr[n];
            if(lv0.id == id0)
            {
               return lv0;
            }
         }
         return null;
      }
      
      public function startLevel() : *
      {
         if(this.level is VipExtraLevel)
         {
            Game.gameData.isVipLevelB = true;
         }
         else
         {
            Game.gameData.isVipLevelB = false;
         }
         Game.gameData.aideEnabled = false;
         this.rebirthNum = 0;
         Game.gameData.challengeTaskData.challengeFail = "no";
         this.level.startLevel();
      }
      
      public function closeLevel() : *
      {
         Game.gameData.challengeTaskData.challengeFail = "no";
         this.level.closeLevel();
      }
      
      public function getRebirthCrystal() : int
      {
         if(this.rebirthNum == 0)
         {
            return 1;
         }
         return 2;
      }
      
      public function toExit() : *
      {
      }
      
      public function doAllOrder_byID(label0:String) : *
      {
         var edo:EventOrderDefineGroup = null;
         if(this.level != null)
         {
            edo = this.level.getEODG(label0);
            if(edo is EventOrderDefineGroup)
            {
               edo.doAllOrder();
            }
         }
      }
      
      public function doOrder_byID(label0:String, middlePoint:Point = null, lockB:Boolean = false) : *
      {
         var edo:EventOrderDefineGroup = null;
         var p0:Point = null;
         var rect0:Rectangle = null;
         if(this.level != null)
         {
            edo = this.level.getEODG(label0);
            p0 = new Point();
            rect0 = Game.oneScene.viewRangeRect2;
            p0.x = rect0.x + rect0.width / 2;
            if(Boolean(middlePoint))
            {
               p0 = middlePoint;
            }
            this.level.openEventOrderDefineGroup(edo,p0.x,0,"tip");
            if(lockB)
            {
               Game.oneScene.lockView(p0.x);
            }
         }
      }
      
      public function randomSuper() : String
      {
         var arr0:Array = null;
         var n:* = undefined;
         var cn0:String = null;
         var isSuperB:Boolean = false;
         var onlyChampionB:Boolean = false;
         var arr2:Array = [];
         if(this.level != null)
         {
            arr0 = this.level.enemyCnNameArr;
            for(n in arr0)
            {
               cn0 = arr0[n];
               isSuperB = Game.gameDefine.checkSuper(cn0);
               onlyChampionB = Game.gameDefine.checkOnlyChampion(cn0);
               trace(cn0 + "   是否可能是精英怪：" + isSuperB + "   是否只是冠军怪：" + onlyChampionB);
               if(isSuperB && !onlyChampionB)
               {
                  arr2.push(cn0);
               }
            }
         }
         if(arr2.length == 0)
         {
            return "";
         }
         return arr2[int(arr2.length * Math.random())];
      }
      
      public function LevelGroupTimer() : *
      {
         if(this.level is Levels)
         {
            this.level.levelTimer();
         }
      }
      
      public function getNormalNameArr(lp0:String) : *
      {
         return this.normalNameArr[int(lp0.substr(1)) - 1];
      }
   }
}

