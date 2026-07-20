package UI.helper
{
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
   import data.StringToDefine;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.CarItemsData;
   import gameAll.data.CarItemsDataGroup;
   import gameAll.data.GameData;
   import gameAll.data.TaskData;
   import gameAll.define.OneTaskDefine;
   import gameAll.level.LevelsDefine;
   import gameAll.vip.VipData;
   import goods.GoodsDefine;
   
   public class HelperBuilder
   {
      
      public function HelperBuilder()
      {
         super();
      }
      
      public function armsResearch(armsFather0:String) : Array
      {
         var data0:ArmsItemsDataGroup = null;
         var n:* = undefined;
         var arr1:Array = null;
         var d1:OneArmsDefine = null;
         var findStr0:String = null;
         var aid1:ArmsItemsData = null;
         var firstIndex0:int = 0;
         var i:int = 0;
         var d0:OneArmsDefine = null;
         var hd0:HelperContextBarDefine = null;
         var hd2:HelperContextBarDefine = null;
         trace("--------------------------------" + armsFather0);
         var darr:Array = [];
         var heroLevel0:int = Game.gameData.level + 1;
         if(armsFather0 == "arms")
         {
            data0 = Game.gameData.armsItems;
         }
         else
         {
            data0 = Game.gameData.subItems;
         }
         var arr0:Array = Game.defineGroup.getArr2(armsFather0);
         for(n in arr0)
         {
            arr1 = arr0[n];
            d1 = arr1[0];
            findStr0 = Game.goodsDefineGroup.getBuySite(d1.getLabel());
            aid1 = data0.getItemsByBase(d1.id,false);
            if(findStr0 == "")
            {
               firstIndex0 = 0;
               if(Boolean(aid1))
               {
                  firstIndex0 = aid1.getLevel() + 1;
               }
               for(i = firstIndex0; i < arr1.length; i++)
               {
                  d0 = arr1[i];
                  if(d0.mustLevel <= heroLevel0)
                  {
                     hd0 = new HelperContextBarDefine();
                     hd0.title = "研发";
                     if(i > 0)
                     {
                        hd0.title = "升级";
                     }
                     hd0.context = "可" + hd0.title + "新武器：" + StringToDefine.getFontColor(d0.name,"#FFFF00") + "（" + d0.mustLevel + "级）";
                     hd0.iconLabel = d0.father + "/" + d0.imgLabel;
                     hd0.gotoTarget = "arms/" + d0.father + "_upgrade/" + d0.id;
                     darr.push(hd0);
                     break;
                  }
               }
            }
            else if(aid1 == null && findStr0 != "pay")
            {
               hd2 = new HelperContextBarDefine();
               hd2.title = "购买";
               hd2.context = "可购买新武器：" + StringToDefine.getFontColor(d1.name,"#FFFF00") + "（" + d1.mustLevel + "级）";
               hd2.iconLabel = d1.father + "/" + d1.imgLabel;
               hd2.gotoTarget = "armsBuy/" + findStr0 + "/" + d1.father;
               darr.push(hd2);
            }
         }
         return darr;
      }
      
      public function carReserch() : Array
      {
         return this.carUpgrade().concat(this.carStrengthen());
      }
      
      private function carUpgrade() : Array
      {
         var n:* = undefined;
         var da0:CarItemsData = null;
         var d0:CarDefine = null;
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var heroLevel0:int = Game.gameData.level + 1;
         var carItems:CarItemsDataGroup = Game.gameData.carItems;
         var arr0:Array = carItems.equArr.concat(carItems.arr);
         var arr1:Array = [];
         for(n in arr0)
         {
            da0 = arr0[n];
            d0 = da0.getDefine();
            if(d0.getType() != "G")
            {
               if(!da0.getMaxUpgradeB() && heroLevel0 >= da0.getNextMustHeroLevel())
               {
                  hd0 = new HelperContextBarDefine();
                  hd0.title = "升级";
                  hd0.context = "车身 " + StringToDefine.getFontColor(d0.name,"#FFFF00") + " 可升级至" + da0.getNextLevel() + "级";
                  hd0.iconLabel = da0.imgLabel;
                  hd0.gotoTarget = "car/upgrade/" + da0.id;
                  darr.push(hd0);
               }
            }
         }
         return darr;
      }
      
      private function carStrengthen() : Array
      {
         var n:* = undefined;
         var da0:CarItemsData = null;
         var d0:CarDefine = null;
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var heroLevel0:int = Game.gameData.level + 1;
         var carItems:CarItemsDataGroup = Game.gameData.carItems;
         var arr0:Array = carItems.equArr.concat(carItems.arr);
         var arr1:Array = [];
         for(n in arr0)
         {
            da0 = arr0[n];
            d0 = da0.getDefine();
            if(!da0.getMaxStrengthenB())
            {
               hd0 = new HelperContextBarDefine();
               hd0.title = "强化";
               hd0.context = "车身 " + StringToDefine.getFontColor(d0.name,"#FFFF00") + " 可强化至" + (da0.strengthenNum + 1) + "级";
               hd0.iconLabel = da0.imgLabel;
               hd0.gotoTarget = "car/strengthen/" + da0.id;
               darr.push(hd0);
            }
         }
         return darr;
      }
      
      public function carBuy() : Array
      {
         return this._carBuy(Game.goodsDefineGroup.car).concat(this._carBuy(Game.goodsDefineGroup.Xcar,"兑换",4));
      }
      
      private function _carBuy(arr0:Array, str0:String = "购买", maxNum:int = 8) : Array
      {
         var gd0:GoodsDefine = null;
         var d0:CarDefine = null;
         var hd0:HelperContextBarDefine = null;
         var heroLevel0:int = Game.gameData.level + 1;
         var darr:Array = [];
         var num0:int = 0;
         for(var n:int = arr0.length - 1; n >= 0; n--)
         {
            gd0 = arr0[n];
            d0 = Game.defineGroup.getCarDefine(gd0.id);
            if(heroLevel0 >= d0.mustLevel)
            {
               if(Game.gameData.carItems.getItemsByBase(gd0.id) == null)
               {
                  hd0 = new HelperContextBarDefine();
                  hd0.title = str0;
                  hd0.context = "可" + hd0.title + "新车身：" + StringToDefine.getFontColor(d0.name,"#FFFF00") + "（" + d0.mustLevel + "级）";
                  hd0.iconLabel = gd0.imgLabel;
                  if(str0 != "购买")
                  {
                     hd0.gotoTarget = "car/exchange/" + n;
                  }
                  else
                  {
                     hd0.gotoTarget = "car/shop/" + n;
                  }
                  darr.push(hd0);
                  num0++;
                  if(num0 >= maxNum)
                  {
                     return darr;
                  }
               }
            }
         }
         return darr;
      }
      
      public function newLevel() : Array
      {
         return this._level();
      }
      
      private function _level() : Array
      {
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var level0:LevelsDefine = Game.LG.filter.getLastUnlockLevel();
         if(Boolean(level0))
         {
            hd0 = new HelperContextBarDefine();
            hd0.title = "可挑战新关卡";
            hd0.context = "" + StringToDefine.getFontColor(level0.packName + " > " + level0.name,"#FFFF00") + "（推荐" + (level0.enemyLv + 1) + "级）";
            hd0.iconLabel = "";
            hd0.gotoTarget = "level/" + level0.packId + "/" + 0 + "/" + level0.index;
            hd0.enemyLevel = level0.enemyLv;
            darr.push(hd0);
         }
         return darr;
      }
      
      public function scoreLevel() : Array
      {
         var lpStr:String = null;
         var lpName:String = null;
         var maxLv0:int = 0;
         var diff0:int = 0;
         var nowdiff0:String = null;
         var level0:int = 0;
         var l_d0:LevelsDefine = null;
         var nowName0:String = null;
         var score0:int = 0;
         var hd0:HelperContextBarDefine = null;
         var GD:GameData = Game.gameData;
         var darr:Array = [];
         var diffStr:Array = OneTaskDefine.diffStr;
         var pageStr:Array = OneTaskDefine.pageStr;
         var pageName:Array = OneTaskDefine.pageName;
         var maxArr:Array = [GD.levelsMax,GD.knowingData.levelsMax,GD.ghostData.levelsMax];
         var lockArr:Array = [GD.levelsLock,GD.knowingData.levelsLock,GD.ghostData.levelsLock];
         for(var n:int = pageName.length - 1; n >= 0; n--)
         {
            lpStr = pageStr[n];
            lpName = pageName[n];
            maxLv0 = int(maxArr[n]);
            for(diff0 = 3; diff0 >= 0; diff0--)
            {
               if(maxLv0 > lockArr[n][diff0])
               {
                  maxLv0 = int(lockArr[n][diff0]);
               }
               nowdiff0 = diffStr[diff0];
               for(level0 = maxLv0 - 1; level0 >= 0; level0--)
               {
                  l_d0 = Game.LG.filter.getLevelDefine(lpName,level0);
                  nowName0 = l_d0.name;
                  score0 = Game.gameData.passData.getScore(level0,diff0,lpName);
                  if(score0 <= 99 && !(lpName == "" && level0 <= 1))
                  {
                     hd0 = new HelperContextBarDefine();
                     hd0.title = "完美通关";
                     hd0.context = "没有完美通关：" + StringToDefine.getFontColor(lpStr + " > " + nowdiff0 + " > " + nowName0,"#FFFF00");
                     hd0.iconLabel = "";
                     hd0.gotoTarget = "level/" + lpName + "/" + diff0 + "/" + level0;
                     darr.push(hd0);
                     return darr;
                  }
               }
            }
         }
         return darr;
      }
      
      public function allTask() : Array
      {
         return this.newTask().concat(this.newChallengeTask()).concat(this.newCollectTask());
      }
      
      private function newTask() : Array
      {
         var hd0:HelperContextBarDefine = null;
         var data0:TaskData = Game.gameData.taskData;
         var num0:int = data0.maxNum - data0.nowNum;
         var darr:Array = [];
         if(num0 > 0)
         {
            hd0 = new HelperContextBarDefine();
            hd0.title = "每日任务";
            hd0.context = "今天还可以完成 " + StringToDefine.getFontColor(num0 + "次 ","#FFFF00") + hd0.title;
            hd0.iconLabel = "";
            hd0.gotoTarget = "task/normalTask";
            darr.push(hd0);
         }
         return darr;
      }
      
      private function newCollectTask() : Array
      {
         var num0:int = 0;
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         if(Game.gameData.level >= 60 - 1)
         {
            num0 = Game.gameData.collectTaskData.getEnabledNum();
            if(num0 > 0)
            {
               hd0 = new HelperContextBarDefine();
               hd0.title = "收集任务";
               hd0.context = "今天还可以完成 " + StringToDefine.getFontColor(num0 + "次 ","#FFFF00") + hd0.title;
               hd0.iconLabel = "";
               hd0.gotoTarget = "task/collectTask";
               darr.push(hd0);
            }
         }
         return darr;
      }
      
      private function newChallengeTask() : Array
      {
         var num0:int = 0;
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         if(Game.gameData.level >= 50 - 1)
         {
            num0 = Game.gameData.challengeTaskData.getEnabledNum();
            if(num0 > 0)
            {
               hd0 = new HelperContextBarDefine();
               hd0.title = "挑战任务";
               hd0.context = "今天还可以完成 " + StringToDefine.getFontColor(num0 + "次 ","#FFFF00") + hd0.title;
               hd0.iconLabel = "";
               hd0.gotoTarget = "task/challengeTask";
               darr.push(hd0);
            }
         }
         return darr;
      }
      
      public function newExtra(num1:int = 2) : Array
      {
         var num0:int = 0;
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var title_arr:Array = ["普通副本","特殊副本"];
         var num_arr:Array = [Game.gameData.extraData.getEnabledNum(),Game.gameData.specialExtraData.getEnabledNum()];
         var goto_arr:Array = ["extra","specialExtra"];
         for(var n:int = 0; n < num1; n++)
         {
            num0 = int(num_arr[n]);
            if(num0 > 0)
            {
               hd0 = new HelperContextBarDefine();
               hd0.title = title_arr[n];
               hd0.context = "今天还可以完成 " + StringToDefine.getFontColor(num0 + "次 ","#FFFF00") + hd0.title;
               hd0.iconLabel = "";
               hd0.gotoTarget = "extra/" + goto_arr[n];
               darr.push(hd0);
            }
         }
         return darr;
      }
      
      public function newGift() : Array
      {
         var n:* = undefined;
         var num0:int = 0;
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var title_arr:Array = ["活跃礼包","军衔礼包","VIP礼包"];
         var num_arr:Array = [Game.gameData.livenessData.getEnabledNum(),Game.gameData.rankAdd.rankGiftB ? 0 : 1,Game.gameData.vipData.giftGetB ? 0 : 1];
         var goto_arr:Array = ["live","rank","vip"];
         for(n in title_arr)
         {
            num0 = int(num_arr[n]);
            if(!(goto_arr[n] == "rank" && Game.gameData.rankLevel < 4))
            {
               if(num0 > 0)
               {
                  hd0 = new HelperContextBarDefine();
                  hd0.title = title_arr[n];
                  hd0.context = "今天还可以领取 " + StringToDefine.getFontColor(num0 + "次 ","#FFFF00") + hd0.title;
                  hd0.iconLabel = "";
                  hd0.gotoTarget = "gift/" + goto_arr[n];
                  darr.push(hd0);
               }
            }
         }
         return darr;
      }
      
      public function allOther() : *
      {
         return this.newVipMap().concat(this.newArea());
      }
      
      private function newVipMap() : Array
      {
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var data0:VipData = Game.gameData.vipData;
         var time0:int = data0.mapTime;
         if(time0 > 0)
         {
            hd0 = new HelperContextBarDefine();
            hd0.title = "VIP地图";
            hd0.context = "今天还可以进入VIP地图 " + StringToDefine.getFontColor(Math.ceil(time0 / 60) + "分钟","#FFFF00");
            hd0.iconLabel = "";
            hd0.gotoTarget = "other/vipMap";
            darr.push(hd0);
         }
         return darr;
      }
      
      private function newArea() : Array
      {
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var num0:int = Game.gameData.arenaData.useNum;
         if(num0 > 0 && Game.gameData.level >= 24)
         {
            hd0 = new HelperContextBarDefine();
            hd0.title = "天梯战斗";
            hd0.context = "今天还可以免费进行 " + StringToDefine.getFontColor(num0 + "次 ","#FFFF00") + "战斗";
            hd0.iconLabel = "";
            hd0.gotoTarget = "other/area";
            darr.push(hd0);
         }
         return darr;
      }
      
      public function helper_strategy_exp() : Array
      {
         var arr0:Array = [];
         arr0 = arr0.concat(this.expExtra(7,"经验副本"));
         arr0 = arr0.concat(this.newTask());
         arr0 = arr0.concat(this.newExtra(1));
         arr0 = arr0.concat(this._maxLevel());
         return arr0.concat(this.newVipMap());
      }
      
      private function expExtra(index0:int, title0:String) : Array
      {
         var hd0:HelperContextBarDefine = null;
         var darr:Array = [];
         var num0:int = Game.gameData.specialExtraData.getOneUseNum(index0);
         if(num0 > 0)
         {
            hd0 = new HelperContextBarDefine();
            hd0.title = title0;
            hd0.context = "今天还可以完成 " + StringToDefine.getFontColor("1次 ","#FFFF00") + hd0.title;
            hd0.iconLabel = "";
            hd0.gotoTarget = "extra/specialExtra/" + index0;
            darr.push(hd0);
         }
         return darr;
      }
      
      private function _maxLevel() : Array
      {
         var n:* = undefined;
         var hd0:HelperContextBarDefine = null;
         var arr0:Array = this.newLevel();
         if(arr0.length == 0)
         {
            return [];
         }
         var max0:HelperContextBarDefine = new HelperContextBarDefine();
         for(n in arr0)
         {
            hd0 = arr0[n];
            if(hd0.enemyLevel > max0.enemyLevel)
            {
               max0 = hd0;
               max0.title = "杀怪获得";
            }
         }
         if(max0.title == "")
         {
            return [];
         }
         return [max0];
      }
      
      public function helper_strategy_coin() : Array
      {
         var arr0:Array = [];
         arr0 = arr0.concat(this.expExtra(8,"金币副本"));
         arr0 = arr0.concat(this.newTask());
         arr0 = arr0.concat(this.newExtra(1));
         return arr0.concat(this._maxLevel());
      }
   }
}

