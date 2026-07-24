package items
{
   import UI.main.InfoUI;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import gameAll.data.ItemsData;
   import goods.GoodsDefine;
   
   public class ItemsController
   {
      
      public var GD:GameData;
      
      public var infoUI:InfoUI;

      private var batchItem:GoodsItemsData;

      private var batchFather:GoodsItemsDataGroup;

      private var upgradePackItem:GoodsItemsData;

      private var upgradePackFather:GoodsItemsDataGroup;

      private var coreRewardPages:Array = [];

      private var coreRewardPageIndex:int = 0;

      private var coreRewardFooter:String = "";
      
      public function ItemsController()
      {
         super();
      }
      
      public function init() : *
      {
         this.GD = Game.gameData;
         this.infoUI = Game.uiGroup.infoUI;
      }
      
      public function requestCoreBatch(it0:GoodsItemsData, father0:GoodsItemsDataGroup) : *
      {
         var d0:ItemsDefine = it0.getDefine();
         var toolLabel0:String = this.getCoreToolLabel(d0.cardType);
         if(toolLabel0 == "")
         {
            return;
         }
         var max0:int = Math.min(999,it0.nowNum,this.GD.propsItems.getNumByBase(toolLabel0));
         if(max0 < 1)
         {
            Game.uiGroup.checkTip.showCheck2("没有足够的对应拆解器。",2);
            return;
         }
         this.batchItem = it0;
         this.batchFather = father0;
         Game.uiGroup.checkTip.showNumberInput("输入要开启的数量：\n最多可以开启 " + max0 + " 个。",String(Math.min(10,max0)),this.confirmCoreBatch,null,3);
      }

      private function confirmCoreBatch() : *
      {
         if(this.batchItem == null || this.batchFather == null)
         {
            return;
         }
         var d0:ItemsDefine = this.batchItem.getDefine();
         var toolLabel0:String = this.getCoreToolLabel(d0.cardType);
         var max0:int = Math.min(999,this.batchItem.nowNum,this.GD.propsItems.getNumByBase(toolLabel0));
         var num0:int = int(Game.uiGroup.checkTip.input_txt.text);
         if(num0 < 1)
         {
            Game.uiGroup.checkTip.showCheck2("请输入大于0的数量。",2);
            return;
         }
         if(num0 > max0)
         {
            num0 = max0;
         }
         this.useItems(this.batchItem,this.batchFather,false,num0);
         this.batchItem = null;
         this.batchFather = null;
      }

      public function requestChipBagBatch(it0:GoodsItemsData, father0:GoodsItemsDataGroup) : *
      {
         if(it0 == null || father0 == null || it0.nowNum < 1)
         {
            return;
         }
         this.batchItem = it0;
         this.batchFather = father0;
         Game.uiGroup.checkTip.showNumberInput("输入要开启的芯片袋数量：\n最多可以开启 " + it0.nowNum + " 个。",String(Math.min(10,it0.nowNum)),this.confirmChipBagBatch,null,4);
      }

      private function confirmChipBagBatch() : *
      {
         if(this.batchItem == null || this.batchFather == null)
         {
            return;
         }
         var num0:int = int(Game.uiGroup.checkTip.input_txt.text);
         if(num0 < 1)
         {
            Game.uiGroup.checkTip.showCheck2("请输入大于0的数量。",2);
            return;
         }
         num0 = Math.min(num0,this.batchItem.nowNum);
         this.openChipBagBatch(this.batchItem,this.batchFather,num0);
         this.batchItem = null;
         this.batchFather = null;
      }

      private function openChipBagBatch(it0:GoodsItemsData, father0:GoodsItemsDataGroup, requestedNum0:int) : *
      {
         var opened0:int = 0;
         var won0:int = 0;
         var chip0:GoodsItemsData = null;
         var stopReason0:String = "";
         if(this.GD.materialsItems.getSurplus() < 1)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包至少需要一个空位，才能批量开启芯片袋。",2);
            return;
         }
         while(opened0 < requestedNum0 && it0.nowNum > 0)
         {
            if(Math.random() < 0.49)
            {
               if(this.GD.materialsItems.getSurplus() < 1)
               {
                  stopReason0 = "材料背包已满，剩余芯片袋未消耗。";
                  break;
               }
               chip0 = this.addPurpleChip_byLevel(Game.gameData.level);
               if(chip0 == null)
               {
                  stopReason0 = "紫色芯片未能放入材料背包，剩余芯片袋未消耗。";
                  break;
               }
               won0++;
            }
            father0.useItemsData(it0,1);
            opened0++;
         }
         if(opened0 > 0)
         {
            Game.uiGroup.changeUI.materialsUI.fleshAll();
            Game.uiGroup.changeUI.propsUI.fleshAll();
            if(Game.uiGroup._changeUI != null && Game.uiGroup._changeUI.bag != null)
            {
               Game.uiGroup._changeUI.bag.fleshData();
            }
            Game.uiGroup.saveDataNoUI("批量开启紫色芯片袋");
         }
         var result0:String = "批量开启完成。\n已开启芯片袋：" + opened0 + " 个\n获得紫色芯片：" + won0 + " 个";
         if(stopReason0 != "")
         {
            result0 += "\n" + stopReason0;
         }
         Game.uiGroup.checkTip.showCheck2(result0,2);
      }

      public function useItems(it0:GoodsItemsData, father0:GoodsItemsDataGroup, allUseB:Boolean = false, requestedNum:int = 0) : *
      {
         var str0:String = null;
         var d3:GoodsDefine = null;
         var bb3:Boolean = false;
         var aid0:ItemsData = null;
         var num0:int = 1;
         var openNum0:int = 0;
         var opened0:int = 0;
         var toolNum0:int = 0;
         var stopReason0:String = null;
         if(allUseB)
         {
            num0 = it0.nowNum;
         }
         if(requestedNum > 0)
         {
            num0 = Math.min(requestedNum,it0.nowNum);
         }
         var d0:ItemsDefine = it0.getDefine();
         if(d0.type == "card")
         {
            if(d0.cardType == "offlineUpgradePack")
            {
               this.upgradePackItem = it0;
               this.upgradePackFather = father0;
               Game.uiGroup.checkTip.showCheck2("请选择礼包类型：\n确定：随机材料\n取消：随机晶体",1,this.openUpgradeMaterial,this.openUpgradeCrystal);
               return;
            }
            if(d0.cardType == "research_upgrade")
            {
               Game.uiGroup.checkTip.showCheck2("研发升级卡会在武器研发材料不足时自动提示使用，不能在背包中直接使用。",2);
               return;
            }
            if(d0.cardType == "drop_box" || d0.cardType == "drop_box2" || d0.cardType == "drop_box3")
            {
               this.openCoreBatch(it0,father0,d0.cardType,num0);
               return;
            }
            if(d0.cardType == "exp")
            {
               this.GD.addExp(d0.cardValue * num0);
            }
            else if(d0.cardType == "expTime")
            {
               this.GD.rankAdd.addDoubleExpTime(d0.cardValue * num0);
            }
            else if(d0.cardType == "achieve")
            {
               this.GD.addAchieve(d0.cardValue * num0);
            }
            else if(d0.cardType == "lifeMax")
            {
               this.GD.foreverLife += d0.cardValue * num0;
            }
            else if(d0.cardType == "defence")
            {
               this.GD.foreverDefence += d0.cardValue * num0;
            }
            else if(d0.cardType == "GCoin")
            {
               this.GD.addCoin(d0.cardValue * num0);
            }
            else if(d0.cardType.indexOf("vipCard") >= 0)
            {
               this.GD.vipData.setVip(d0.cardType);
            }
            else
            {
               if(d0.cardType == "chipBag")
               {
                  if(this.GD.materialsItems.getSurplus() > 0)
                  {
                     father0.useItemsData(it0,num0);
                     if(Math.random() < 0.49)
                     {
                        this.addPurpleChip_byLevel(Game.gameData.level);
                        Game.uiGroup.changeUI.materialsUI.fleshAll();
                        Game.uiGroup.checkTip.showCheck2("你获得了一个紫色芯片。",2);
                     }
                     else
                     {
                        Game.uiGroup.checkTip.showCheck2("你没有获得紫色芯片。",2);
                     }
                     Game.uiGroup.saveDataNoUI("解开芯片袋子");
                  }
                  else
                  {
                     Game.uiGroup.checkTip.showCheck2("材料背包至少需要一个空位，才能使用该道具。",2);
                  }
                  return;
               }
               if(d0.cardType == "superalloy")
               {
                  if(this.GD.materialsItems.getSurplus() < 4)
                  {
                     Game.uiGroup.checkTip.showCheck2("您的材料背包空位必须大于" + 4 + "个，才能使用超合金原石。",3);
                  }
                  else
                  {
                     Game.uiGroup.shopUI.shopBox.superalloyStoneDismantle(num0);
                     father0.useItemsData(it0,num0);
                     Game.uiGroup.changeUI.materialsUI.fleshAll();
                     Game.uiGroup.changeUI.propsUI.fleshAll();
                  }
                  Game.uiGroup.saveDataNoUI();
                  return;
               }
               if(d0.cardType == "drop_box")
               {
                  if(this.GD.propsItems.getNumByBase("disassemble") > 0)
                  {
                     str0 = Game.gameDefine.dropBox.getGift(Game.severTime.than8());
                     d3 = Game.goodsDefineGroup.getDefine_byStr3(str0,-1,true);
                     bb3 = true;
                     if(d3.type == "materials")
                     {
                        if(this.GD.materialsItems.getSurplus() <= 0)
                        {
                           aid0 = this.GD.materialsItems.getItemsByBase(d3.id);
                           if(aid0 == null)
                           {
                              bb3 = false;
                           }
                        }
                        if(bb3)
                        {
                           Game.uiGroup.checkTip.showCheck2("你获得了" + d3.num + "个" + d3.name + "。",2);
                        }
                        else
                        {
                           Game.uiGroup.checkTip.showCheck2("材料背包至少需要一个空位，才能拆解战斗核心。",2);
                        }
                     }
                     else if(d3.type == "sub" || d3.type == "arms")
                     {
                        if(this.GD.checkArms_byIDArr([d3.define.id]) != "")
                        {
                           bb3 = false;
                           Game.uiGroup.checkTip.showCheck2("你已经拥有了 " + d3.name + " ，不能拆解战斗核心。",2);
                        }
                        else if(d3.type == "sub")
                        {
                           Game.uiGroup.checkTip.showCheck2("你获得了副武器" + d3.name + "。",2);
                        }
                        else
                        {
                           Game.uiGroup.checkTip.showCheck2("你获得了主武器" + d3.name + "。",2);
                        }
                     }
                     else if(d3.id == "GCoin_card_4")
                     {
                        Game.uiGroup.checkTip.showCheck2("你获得了 " + d3.price + " G币。",2);
                     }
                     else
                     {
                        Game.uiGroup.checkTip.showCheck2("你获得了" + d3.num + "个" + d3.name + "。",2);
                     }
                     if(bb3)
                     {
                        Game.uiGroup.addGift_byArr([d3],true,this.GD.level,false);
                        Game.SG.playSound("upgradeArms");
                        father0.useItemsData(it0,num0);
                        this.GD.propsItems.useItemsNum("disassemble");
                        Game.uiGroup.changeUI.materialsUI.fleshAll();
                        Game.uiGroup.infoUI.fleshData();
                        Game.uiGroup.saveDataNoUI("拆解战斗核心");
                     }
                  }
                  else
                  {
                     Game.uiGroup.checkTip.showCheck2("你没有拆解器，不能拆解战斗核心。",2);
                  }
                  return;
               }
               if(d0.cardType == "drop_box2")
               {
                  if(this.GD.propsItems.getNumByBase("disassemble_2") > 0)
                  {
                     str0 = Game.gameDefine.dropBox2.getGift(Game.severTime.than8());
                     d3 = Game.goodsDefineGroup.getDefine_byStr3(str0,-1,true);
                     bb3 = true;
                     if(d3.type == "materials")
                     {
                        if(this.GD.materialsItems.getSurplus() <= 0)
                        {
                           aid0 = this.GD.materialsItems.getItemsByBase(d3.id);
                           if(aid0 == null)
                           {
                              bb3 = false;
                           }
                        }
                        if(bb3)
                        {
                           Game.uiGroup.checkTip.showCheck2("你获得了" + d3.num + "个" + d3.name + "。",2);
                        }
                        else
                        {
                           Game.uiGroup.checkTip.showCheck2("材料背包至少需要一个空位，才能拆解战斗核心。",2);
                        }
                     }
                     else if(d3.type == "sub" || d3.type == "arms")
                     {
                        if(this.GD.checkArms_byIDArr([d3.define.id]) != "")
                        {
                           bb3 = false;
                           Game.uiGroup.checkTip.showCheck2("你已经拥有了 " + d3.name + " ，不能拆解战斗核心。",2);
                        }
                        else if(d3.type == "sub")
                        {
                           Game.uiGroup.checkTip.showCheck2("你获得了副武器" + d3.name + "。",2);
                        }
                        else
                        {
                           Game.uiGroup.checkTip.showCheck2("你获得了主武器" + d3.name + "。",2);
                        }
                     }
                     else if(d3.id == "GCoin_card_4")
                     {
                        Game.uiGroup.checkTip.showCheck2("你获得了 " + d3.price + " G币。",2);
                     }
                     else
                     {
                        Game.uiGroup.checkTip.showCheck2("你获得了" + d3.num + "个" + d3.name + "。",2);
                     }
                     if(bb3)
                     {
                        Game.uiGroup.addGift_byArr([d3],true,this.GD.level,false);
                        Game.SG.playSound("upgradeArms");
                        father0.useItemsData(it0,num0);
                        this.GD.propsItems.useItemsNum("disassemble_2");
                        Game.uiGroup.changeUI.materialsUI.fleshAll();
                        Game.uiGroup.infoUI.fleshData();
                        Game.uiGroup.saveDataNoUI("拆解战斗核心");
                     }
                  }
                  else
                  {
                     Game.uiGroup.checkTip.showCheck2("你没有优质拆解器，不能拆解战斗核心。",2);
                  }
                  return;
               }
               if(d0.cardType == "drop_box3")
               {
                  toolNum0 = this.GD.propsItems.getNumByBase("disassemble_3");
                  if(toolNum0 > 0)
                  {
                     openNum0 = num0;
                     if(openNum0 > toolNum0)
                     {
                        openNum0 = toolNum0;
                     }
                     opened0 = 0;
                     stopReason0 = "";
                     while(opened0 < openNum0)
                     {
                        str0 = Game.gameDefine.dropBox3.getGift(Game.severTime.than8());
                        d3 = Game.goodsDefineGroup.getDefine_byStr3(str0,-1,true);
                        bb3 = true;
                        if(d3.type == "materials")
                        {
                           if(this.GD.materialsItems.getSurplus() <= 0)
                           {
                              aid0 = this.GD.materialsItems.getItemsByBase(d3.id);
                              if(aid0 == null)
                              {
                                 bb3 = false;
                                 stopReason0 = "材料背包至少需要一个空位，才能继续拆解。";
                              }
                           }
                        }
                        else if(d3.type == "props" && !d3.getFastUseB())
                        {
                           if(this.GD.propsItems.getSurplus() <= 0 && this.GD.propsItems.getItemsByBase(d3.id) == null)
                           {
                              bb3 = false;
                              stopReason0 = "道具背包没有空位，剩余核心未消耗。";
                           }
                        }
                        else if(d3.type == "sub" || d3.type == "arms")
                        {
                           if(this.GD.checkArms_byIDArr([d3.define.id]) != "")
                           {
                              bb3 = false;
                              stopReason0 = "随机到了已拥有的 " + d3.name + "，剩余核心未消耗。";
                           }
                           else if(this.GD[d3.type + "Items"].getSurplus() <= 0)
                           {
                              bb3 = false;
                              stopReason0 = "武器库没有空位，剩余核心未消耗。";
                           }
                        }
                        if(!bb3)
                        {
                           break;
                        }
                        Game.uiGroup.addGift_byArr([d3],true,this.GD.level,false);
                        father0.useItemsData(it0,1);
                        this.GD.propsItems.useItemsNum("disassemble_3",1);
                        opened0++;
                     }
                     if(opened0 > 0)
                     {
                        Game.SG.playSound("upgradeArms");
                        Game.uiGroup.changeUI.materialsUI.fleshAll();
                        Game.uiGroup.infoUI.fleshData();
                        Game.uiGroup.saveDataNoUI("批量拆解稀有战斗核心");
                        if(stopReason0 != "")
                        {
                           Game.uiGroup.checkTip.showCheck2("已拆解 " + opened0 + " 个稀有战斗核心。\n" + stopReason0,2);
                        }
                        else if(opened0 < num0)
                        {
                           Game.uiGroup.checkTip.showCheck2("已拆解 " + opened0 + " 个稀有战斗核心。\n稀有拆解器不足，剩余核心未消耗。",2);
                        }
                        else
                        {
                           Game.uiGroup.checkTip.showCheck2("批量拆解完成，共拆解 " + opened0 + " 个稀有战斗核心。",2);
                        }
                     }
                     else if(stopReason0 != "")
                     {
                        Game.uiGroup.checkTip.showCheck2(stopReason0,2);
                     }
                  }
                  else
                  {
                     Game.uiGroup.checkTip.showCheck2("你没有稀有拆解器，不能拆解战斗核心。",2);
                  }
                  return;
               }
            }
            this.infoUI.showAddEffect("+" + d0.cardValue * num0,d0.cardType);
            father0.useItemsData(it0,num0);
         }
         Game.uiGroup.allback.info.fleshData();
      }

      private function openUpgradeMaterial() : *
      {
         this.openUpgradePackByType("material","材料");
      }

      private function openUpgradeCrystal() : *
      {
         this.openUpgradePackByType("crystal","晶体");
      }

      private function openUpgradePackByType(type0:String, cn0:String) : *
      {
         if(this.upgradePackItem == null || this.upgradePackFather == null)
         {
            return;
         }
         var arr0:Array = Game.itemsDefineGroup.getArr_byOneLevel(type0,this.GD.level);
         if(arr0.length < 1)
         {
            Game.uiGroup.checkTip.showCheck2("当前等级没有可获取的" + cn0 + "。",2);
            return;
         }
         var reward0:ItemsDefine = arr0[int(Math.random() * arr0.length)].copyAll();
         if(this.GD.materialsItems.getSurplus() <= 0 && this.GD.materialsItems.getItemsByBase(reward0.name) == null)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包没有空位，礼包未消耗。",2);
            return;
         }
         reward0.nowNum = 1;
         this.GD.materialsItems.addItemsDefine(reward0,1);
         this.upgradePackFather.useItemsData(this.upgradePackItem,1);
         Game.uiGroup.changeUI.materialsUI.fleshAll();
         Game.uiGroup.changeUI.propsUI.fleshAll();
         Game.uiGroup.checkTip.showCheck2("你获得了1个" + reward0.cnName + "。",2);
         Game.uiGroup.saveDataNoUI("开启自选强化礼包");
         this.upgradePackItem = null;
         this.upgradePackFather = null;
      }

      private function getCoreToolLabel(cardType0:String) : String
      {
         if(cardType0 == "drop_box")
         {
            return "disassemble";
         }
         if(cardType0 == "drop_box2")
         {
            return "disassemble_2";
         }
         if(cardType0 == "drop_box3")
         {
            return "disassemble_3";
         }
         return "";
      }

      private function getCoreGift(cardType0:String) : String
      {
         if(cardType0 == "drop_box")
         {
            return Game.gameDefine.dropBox.getGift(Game.severTime.than8());
         }
         if(cardType0 == "drop_box2")
         {
            return Game.gameDefine.dropBox2.getGift(Game.severTime.than8());
         }
         return Game.gameDefine.dropBox3.getGift(Game.severTime.than8());
      }

      private function openCoreBatch(it0:GoodsItemsData, father0:GoodsItemsDataGroup, cardType0:String, requestedNum0:int) : *
      {
         var toolLabel0:String = this.getCoreToolLabel(cardType0);
         var openNum0:int = Math.min(requestedNum0,it0.nowNum,this.GD.propsItems.getNumByBase(toolLabel0));
         var opened0:int = 0;
         var stopReason0:String = "";
         var str0:String = null;
         var d3:GoodsDefine = null;
         var aid0:ItemsData = null;
         var canAdd0:Boolean = false;
         var fixedCoin0:int = this.getCoreFixedCoin(cardType0);
         var fixedArr0:Array = null;
         var fixed0:GoodsDefine = null;
          var rewardOrder0:Array = [];
          var rewardTotals0:Object = {};
          var fixedOrder0:Array = [];
          var fixedTotals0:Object = {};
          var easterOrder0:Array = [];
          var easterTotals0:Object = {};
          var easterArr0:Array = null;
          var easter0:GoodsDefine = null;
         var requiredMaterial0:Object = null;
         var requiredProps0:Object = null;
         var requiredMaterialNum0:int = 0;
         var requiredPropsNum0:int = 0;
         var n:* = undefined;
         while(opened0 < openNum0)
         {
            str0 = this.getCoreGift(cardType0);
            d3 = Game.goodsDefineGroup.getDefine_byStr3(str0,-1,true);
            fixedArr0 = this.getCoreFixedMaterials(cardType0);
            canAdd0 = true;
            requiredMaterial0 = {};
            requiredProps0 = {};
            requiredMaterialNum0 = 0;
            requiredPropsNum0 = 0;
            for(n in fixedArr0)
            {
               fixed0 = fixedArr0[n];
               if(this.GD.materialsItems.getItemsByBase(fixed0.id) == null && !requiredMaterial0.hasOwnProperty(fixed0.id))
               {
                  requiredMaterial0[fixed0.id] = true;
                  requiredMaterialNum0++;
               }
            }
            if(d3.type == "materials")
            {
               if(d3.define != null && d3.define.type == "chip")
               {
                  requiredMaterialNum0++;
               }
               else if(this.GD.materialsItems.getItemsByBase(d3.id) == null && !requiredMaterial0.hasOwnProperty(d3.id))
               {
                  requiredMaterial0[d3.id] = true;
                  requiredMaterialNum0++;
               }
            }
            else if(d3.type == "props" && !d3.getFastUseB())
            {
               if(this.GD.propsItems.getItemsByBase(d3.id) == null)
               {
                  requiredProps0[d3.id] = true;
                  requiredPropsNum0++;
               }
            }
            else if(d3.type == "sub" || d3.type == "arms")
            {
               if(this.GD.checkArms_byIDArr([d3.define.id]) != "")
               {
                  canAdd0 = false;
                  stopReason0 = "随机到了已拥有的 " + d3.name + "，剩余核心未消耗。";
               }
               else if(this.GD[d3.type + "Items"].getSurplus() <= 0)
               {
                  canAdd0 = false;
                  stopReason0 = "武器库没有空位，剩余核心未消耗。";
               }
            }
            if(requiredMaterialNum0 > this.GD.materialsItems.getSurplus())
            {
               canAdd0 = false;
               stopReason0 = "材料背包空位不足，剩余核心未消耗。";
            }
            else if(requiredPropsNum0 > this.GD.propsItems.getSurplus())
            {
               canAdd0 = false;
               stopReason0 = "道具背包没有空位，剩余核心未消耗。";
            }
            if(!canAdd0)
            {
               break;
            }
             this.GD.addCoin(fixedCoin0);
             this.addCoreRewardSummary(fixedOrder0,fixedTotals0,"G币",fixedCoin0);
            for(n in fixedArr0)
            {
               fixed0 = fixedArr0[n];
               Game.uiGroup.addGift_byArr([fixed0],true,this.GD.level,false);
                this.addCoreRewardSummary(fixedOrder0,fixedTotals0,fixed0.name,fixed0.num);
            }
            Game.uiGroup.addGift_byArr([d3],true,this.GD.level,false);
            if(d3.id == "GCoin_card_4")
            {
               this.addCoreRewardSummary(rewardOrder0,rewardTotals0,"G币",int(d3.price));
            }
             else
             {
                this.addCoreRewardSummary(rewardOrder0,rewardTotals0,d3.name,d3.num);
             }
             easterArr0 = this.getRareCoreEasterRewards(cardType0);
             for each(easter0 in easterArr0)
             {
                Game.uiGroup.addGift_byArr([easter0],true,this.GD.level,false);
                this.addCoreRewardSummary(easterOrder0,easterTotals0,easter0.name,easter0.num);
             }
            father0.useItemsData(it0,1);
            this.GD.propsItems.useItemsNum(toolLabel0,1);
            opened0++;
         }
         if(opened0 > 0)
         {
            Game.SG.playSound("upgradeArms");
            Game.uiGroup.changeUI.materialsUI.fleshAll();
            Game.uiGroup.changeUI.propsUI.fleshAll();
            if(Game.uiGroup._changeUI != null && Game.uiGroup._changeUI.bag != null)
            {
               Game.uiGroup._changeUI.bag.fleshData();
            }
            Game.uiGroup.infoUI.fleshData();
            Game.uiGroup.saveDataNoUI("批量开启战斗核心");
         }
         var result0:String = "";
         if(stopReason0 != "")
         {
            result0 = stopReason0;
         }
         else if(opened0 < requestedNum0)
         {
            result0 = "核心或拆解器数量不足。";
         }
         if(opened0 > 0)
         {
             this.showCoreRewardPages(fixedOrder0,fixedTotals0,rewardOrder0,rewardTotals0,easterOrder0,easterTotals0,result0);
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("没有拆解战斗核心。" + (result0 == "" ? "" : "\n" + result0),2);
         }
      }

      private function getCoreFixedCoin(cardType0:String) : int
      {
         if(cardType0 == "drop_box")
         {
            return 75000;
         }
         if(cardType0 == "drop_box2")
         {
            return 200000;
         }
         return 500000;
      }

      private function getCoreFixedMaterials(cardType0:String) : Array
      {
         var result0:Array = [];
         var names0:Array = ["thorn","buncher","boom"];
         var level0:int = 0;
         var n:* = undefined;
         if(cardType0 == "drop_box2")
         {
            result0.push(Game.goodsDefineGroup.getDefine_byStr3("materials,superalloy,50",-1,true));
            result0.push(Game.goodsDefineGroup.getDefine_byStr3("materials,superalloy_Z,35",-1,true));
            result0.push(Game.goodsDefineGroup.getDefine_byStr3("materials,superalloy_X,25",-1,true));
            return result0;
         }
         for(n in names0)
         {
            level0 = cardType0 == "drop_box" ? 2 + int(Math.random() * 3) : 5 + int(Math.random() * 3);
            result0.push(Game.goodsDefineGroup.getDefine_byStr3("materials," + names0[n] + "_" + level0 + ",25",-1,true));
         }
         return result0;
      }

      private function getRareCoreEasterRewards(cardType0:String) : Array
      {
         var result0:Array = [];
         var pool0:Array = null;
         var canGet0:Array = [];
         var one0:GoodsDefine = null;
         if(cardType0 != "drop_box3")
         {
            return result0;
         }
         if(Math.random() < 0.001 && this.GD.armsItems.getSurplus() + this.GD.subItems.getSurplus() > 0)
         {
            pool0 = Game.goodsDefineGroup.Marms.concat(Game.goodsDefineGroup.Msub);
            for each(one0 in pool0)
            {
               if(one0 != null && Game.gameData.checkArms_byIDArr([one0.define.id]) == "")
               {
                  canGet0.push(one0);
               }
            }
            if(canGet0.length > 0)
            {
               result0.push((canGet0[int(Math.random() * canGet0.length)] as GoodsDefine).copy());
            }
         }
         if(Math.random() < 0.01)
         {
            result0.push(Game.goodsDefineGroup.getDefine_byStr3("props,research_upgrade_card,1",-1,true));
         }
         return result0;
      }

      private function addCoreRewardSummary(order0:Array, totals0:Object, name0:String, num0:int) : *
      {
         if(!totals0.hasOwnProperty(name0))
         {
            totals0[name0] = 0;
            order0.push(name0);
         }
         totals0[name0] += num0;
      }

      private function addCoreRewardCategory(lines0:Array, title0:String, order0:Array, totals0:Object) : *
      {
         var name0:String = null;
         var row0:String = "";
         var count0:int = 0;
         lines0.push("【" + title0 + "】");
         if(order0.length == 0)
         {
            lines0.push("无");
            return;
         }
         for each(name0 in order0)
         {
            if(row0 != "")
            {
               row0 += "　　";
            }
            row0 += name0 + "×" + totals0[name0];
            count0++;
            if(count0 == 2)
            {
               lines0.push(row0);
               row0 = "";
               count0 = 0;
            }
         }
         if(row0 != "")
         {
            lines0.push(row0);
         }
      }

      private function showCoreRewardPages(fixedOrder0:Array, fixedTotals0:Object, randomOrder0:Array, randomTotals0:Object, easterOrder0:Array, easterTotals0:Object, footer0:String = "") : *
      {
         var page0:String = null;
         var lines0:Array = [];
         var i:int = 0;
         var pageCount0:int = 0;
         this.addCoreRewardCategory(lines0,"固定奖励",fixedOrder0,fixedTotals0);
         this.addCoreRewardCategory(lines0,"随机奖励",randomOrder0,randomTotals0);
         if(easterOrder0.length > 0)
         {
            this.addCoreRewardCategory(lines0,"彩蛋奖励",easterOrder0,easterTotals0);
         }
         this.coreRewardPages = [];
         while(i < lines0.length)
         {
            page0 = "";
            pageCount0 = 0;
            while(i < lines0.length && pageCount0 < 3)
            {
               if(page0 != "")
               {
                  page0 += "\n";
               }
               page0 += lines0[i];
               i++;
               pageCount0++;
            }
            this.coreRewardPages.push(page0);
         }
         if(this.coreRewardPages.length == 0)
         {
            this.coreRewardPages.push("无奖励");
         }
         this.coreRewardFooter = footer0;
         this.coreRewardPageIndex = 0;
         this.showCurrentCoreRewardPage();
      }

      private function showCurrentCoreRewardPage() : *
      {
         var text0:String = "拆解获得";
         if(this.coreRewardPages.length > 1)
         {
            text0 += "（" + (this.coreRewardPageIndex + 1) + "/" + this.coreRewardPages.length + "）";
         }
         text0 += "：\n" + this.coreRewardPages[this.coreRewardPageIndex];
         if(this.coreRewardPageIndex < this.coreRewardPages.length - 1)
         {
            Game.uiGroup.checkTip.showPagedCheck2(text0,this.showNextCoreRewardPage);
         }
         else
         {
            if(this.coreRewardFooter != "")
            {
               Game.uiGroup.checkTip.showFooterCheck2(text0,this.coreRewardFooter);
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2(text0,2);
            }
         }
      }

      private function showNextCoreRewardPage() : *
      {
         this.coreRewardPageIndex++;
         if(this.coreRewardPageIndex < this.coreRewardPages.length)
         {
            this.showCurrentCoreRewardPage();
         }
      }
      
      public function sellItems(it0:GoodsItemsData, father0:GoodsItemsDataGroup) : *
      {
         this.GD.addCoin(it0.getSellPrice());
         this.infoUI.showAddEffect("+" + it0.getSellPrice(),"GCoin",16776960,false);
         father0.delItemsData(it0);
         Game.SG.playSound("sellItems");
      }
      
      public function addPurpleChip_byLevel(level0:int) : *
      {
         var chipName0:String = null;
         var d0:GoodsItemsData = null;
         var chipArr0:Array = [];
         chipArr0 = ["ben","zhui","jing","zu","zhen","lie","nu","kuang","hong","ji"];
         if(chipArr0.length > 0)
         {
            chipName0 = chipArr0[int(chipArr0.length * Math.random())] + "_purple_chip";
            d0 = this.GD.materialsItems.addItems(chipName0,1,level0 - 1);
            d0.addArr = Game.gameDefine.purpleChip.getAddArr(chipName0,d0.affixLevel);
            return d0;
         }
         return null;
      }
   }
}

