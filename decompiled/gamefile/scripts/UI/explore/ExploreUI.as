package UI.explore
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.button.PicButton;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.label.LabelBox;
   import data.StringToDefine;
   import fl.transitions.easing.Regular;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Timer;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import goods.GoodsDefine;
   import gs.TweenLite;
   
   public class ExploreUI extends Sprite
   {
      
      internal var itemsData:GoodsItemsDataGroup;
      
      internal var GD:GameData;
      
      public var switchLabel:LabelBox;
      
      public var labelArr:Array;
      
      public var mustCoinArr:Array;
      
      public var mustLevelArr:Array;
      
      public var cover_mc:Sprite;
      
      public var front_mc:Sprite;
      
      public var return_btn:PicButton;
      
      public var gotoChange_btn:SimpleButton;
      
      public var pay_btn:SimpleButton;
      
      public var allBox:ExploreIconBox;
      
      public var itemsBox:ItemsBox;
      
      public var sellArr:Array;
      
      public var sellBtnBox:*;
      
      public var coinTxt:TextField;
      
      public var McoinTxt:TextField;
      
      public var btn:SimpleButton;
      
      public var btn2:SimpleButton;
      
      public var no_mc:MovieClip;
      
      public var timer:Timer;
      
      public var nowLightIndex:int = 0;
      
      public var nowExploreIndex:int = 0;
      
      public var exploreCover_mc:Sprite;
      
      private var dragBmp:Bitmap;
      
      private var dragBmpSp:Sprite;
      
      public var getItemsEffect:MovieClip;
      
      public var nowItemsData:GoodsItemsData;
      
      public var nowGetGood:*;
      
      public var mustCoin:int = 0;
      
      public var mustLevel:int = 0;
      
      public var GorM:Boolean = true;
      
      public function ExploreUI()
      {
         var btn0:SimpleButton = null;
         this.switchLabel = new LabelBox();
         this.labelArr = ["g5000","g10000","g20000","g30000","g40000","m3","m5","m10","m15","m20"];
         this.allBox = new ExploreIconBox();
         this.itemsBox = new ItemsBox("bag",false);
         this.sellArr = [];
         this.timer = new Timer(30);
         this.dragBmp = new Bitmap(null,"auto",true);
         this.dragBmpSp = new Sprite();
         super();
         this.cover_mc.mouseChildren = false;
         this.cover_mc.mouseEnabled = false;
         this.front_mc.mouseChildren = false;
         this.front_mc.mouseEnabled = false;
         this.getItemsEffect.mouseChildren = false;
         this.getItemsEffect.mouseEnabled = false;
         this.switchLabel.setLabelClass(MoreStateButton);
         this.switchLabel.addLabel(this.labelArr,330,false,"explore");
         addChild(this.switchLabel);
         this.switchLabel.x = 124;
         this.switchLabel.y = 74;
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.addChild(this.exploreCover_mc);
         this.addChild(this.btn2);
         this.allBox.setLabelClass(ExploreIcon);
         this.allBox.setNum(3,3,579,217);
         this.allBox.setTotalNum(9);
         this.allBox.x = 284;
         this.allBox.y = 45 + 33;
         this.addChild(this.allBox);
         this.itemsBox.setLabelClass(ItemsIcon);
         this.itemsBox.setNum(10,1,582,61);
         this.itemsBox.x = 282;
         this.itemsBox.y = 361 + 16;
         addChild(this.itemsBox);
         for(var n:int = 0; n < 10; n++)
         {
            btn0 = this.sellBtnBox.getChildByName("b" + (n + 1));
            this.sellArr.push(btn0);
            btn0.addEventListener(MouseEvent.CLICK,this.sellClick);
         }
         this.btn.addEventListener(MouseEvent.CLICK,this.startExplore);
         this.btn2.addEventListener(MouseEvent.CLICK,this.completeExplore);
         this.no_mc.visible = false;
         this.no_mc.stop();
         this.exploreCover_mc.visible = false;
         this.timer.addEventListener(TimerEvent.TIMER,this.timerHandler);
         this.timer.stop();
         this.showBtn("start");
         this.dragBmpSp.addChild(this.dragBmp);
         this.dragBmpSp.mouseChildren = false;
         this.dragBmpSp.mouseEnabled = false;
         addChild(this.dragBmpSp);
         this.getItemsEffect.stop();
         addChild(this.getItemsEffect);
         this.gotoChange_btn.addEventListener(MouseEvent.CLICK,this.gotoChange);
         this.pay_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
      }
      
      public function init() : *
      {
         this.mustCoinArr = Game.gameDefine.explore.mustCoinArr;
         this.mustLevelArr = Game.gameDefine.explore.mustLevelArr;
         this.GD = Game.gameData;
         this.itemsData = this.GD.materialsItems;
         this.switchLabel.showState(0);
         this.fleshAllBox();
         this.fleshBag();
      }
      
      public function fleshAll() : *
      {
         this.explorePan();
         this.fleshBag();
      }
      
      public function fleshAllBox() : *
      {
         var n:* = undefined;
         var gd0:GoodsDefine = null;
         var strArr:Array = Game.gameDefine.explore[this.switchLabel.nowLabel];
         var arr9:Array = Game.goodsDefineGroup.getArr_byStrArr(strArr,this.GD.level);
         this.allBox.inData_byArr(arr9);
         var arr0:Array = [];
         for(n in arr9)
         {
            gd0 = arr9[n];
            arr0.push(gd0.pro / 10000);
         }
         this.nowExploreIndex = StringToDefine.getPro_byArr(arr0);
      }
      
      public function explorePan() : *
      {
         this.showBtn("start");
         var fill0:String = this.getBagFill();
         if(fill0 != "")
         {
            this.showBtn("no");
            this.setNoText(fill0);
         }
         this.fleshMustCoin();
         var GCoin:Number = Game.gameData.GCoin;
         var MCoin:int = Game.gameData.MCoin;
         this.coinTxt.text = GCoin + " G币";
         this.McoinTxt.text = MCoin + " M币";
         if(this.GorM)
         {
            if(this.mustCoin > GCoin)
            {
               this.showBtn("no");
               this.setNoText("G币不足，无法继续探索");
            }
         }
         else if(this.mustCoin > MCoin)
         {
            this.showBtn("no");
            this.setNoText("M币不足，无法继续探索");
         }
         if(this.GD.level < this.mustLevel - 1)
         {
            this.showBtn("no");
            this.setNoText("需求人物等级：" + this.mustLevel + "级，无法继续探索");
         }
      }
      
      public function setNoText(str0:String) : *
      {
         this.no_mc.txt.text = str0;
      }
      
      public function fleshMustCoin() : *
      {
         var str0:String = this.mustCoinArr[this.switchLabel.nowIndex];
         if(str0.indexOf("g") >= 0)
         {
            this.GorM = true;
         }
         else
         {
            this.GorM = false;
         }
         this.mustCoin = int(str0.substr(1));
         this.mustLevel = this.mustLevelArr[this.switchLabel.nowIndex];
      }
      
      public function fleshBag() : *
      {
         var n:* = undefined;
         var arr1:Array = this.itemsData.getArr_byExplore();
         this.itemsBox.inData_byItems(arr1);
         var arr0:Array = this.itemsBox.arr;
         for(n in this.sellArr)
         {
            if(n < arr0.length)
            {
               this.sellArr[n].visible = true;
            }
            else
            {
               this.sellArr[n].visible = false;
            }
         }
      }
      
      public function getBagFill() : String
      {
         if(this.GD.materialsItems.getFillB())
         {
            return "材料背包已满，无法继续探索";
         }
         if(this.GD.carItems.getFillB())
         {
            return "车身背包已满，无法继续探索";
         }
         if(this.GD.armsItems.getFillB())
         {
            return "主武器背包已满，无法继续探索";
         }
         if(this.GD.subItems.getFillB())
         {
            return "副武器背包已满，无法继续探索";
         }
         return "";
      }
      
      public function startExplore(event:MouseEvent) : *
      {
         this.allBox.arr[this.nowLightIndex].setBack(1);
         this.nowLightIndex = int(Math.random() * 9);
         this.allBox.arr[this.nowLightIndex].setBack(2);
         this.showBtn("complete");
         this.timer.start();
         this.exploreCover_mc.visible = true;
         this.switchLabel.mouseChildren = false;
      }
      
      public function completeExplore(event:MouseEvent) : *
      {
         this.timer.stop();
         this.showBtn("start");
         this.allBox.arr[this.nowLightIndex].setBack(1);
         this.nowLightIndex = this.nowExploreIndex;
         this.allBox.arr[this.nowLightIndex].setBack(2);
         this.getItems();
         this.explorePan();
      }
      
      public function overExplore() : *
      {
         this.getItemsEffect.x = this.dragBmpSp.x + this.dragBmpSp.width / 2 - 2;
         this.getItemsEffect.y = this.dragBmpSp.y + this.dragBmpSp.height / 2 - 10;
         this.getItemsEffect.gotoAndPlay(1);
         this.exploreCover_mc.visible = false;
         this.switchLabel.mouseChildren = true;
         this.allBox.arr[this.nowLightIndex].setBack(1);
         this.fleshAllBox();
         this.explorePan();
      }
      
      public function timerHandler(event:TimerEvent) : *
      {
         var beforeIndex:int = this.nowLightIndex;
         this.nowLightIndex = (this.nowLightIndex + 1) % 9;
         this.allBox.arr[beforeIndex].setBack(1);
         this.allBox.arr[this.nowLightIndex].setBack(2);
      }
      
      public function showBtn(str0:String) : *
      {
         this.btn.visible = false;
         this.btn2.visible = false;
         this.no_mc.visible = false;
         if(str0 == "start")
         {
            this.btn.visible = true;
         }
         else if(str0 == "complete")
         {
            this.btn2.visible = true;
         }
         else if(str0 == "no")
         {
            this.no_mc.visible = true;
         }
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.switchLabel.showState(event.index);
         this.fleshAllBox();
         this.explorePan();
      }
      
      public function sellClick(event:MouseEvent) : *
      {
         var str0:* = undefined;
         var index0:int = int(String(event.target.name).substr(1)) - 1;
         var icon0:ItemsIcon = this.itemsBox.arr[index0];
         this.nowItemsData = icon0.itemsData;
         if(this.nowItemsData.name != "white_chip" || this.nowItemsData.name != "blue_chip")
         {
            str0 = "你确定要卖出 <font color=\'#FFFF00\'>" + this.nowItemsData.nowNum + "个 " + this.nowItemsData.cnName + "</font> 吗？";
            str0 += "\n" + "出售价格为：<font color=\'#FFFF00\'>" + this.nowItemsData.getSellPrice() + "</font> G币 。";
            Game.uiGroup.checkTip.showCheck(str0,this.sellNowItems);
         }
         else
         {
            this.sellNowItems();
         }
      }
      
      public function sellNowItems() : *
      {
         var aid0:GoodsItemsData = this.nowItemsData;
         Game.IC.sellItems(aid0,this.itemsData);
         this.fleshBag();
         this.explorePan();
      }
      
      private function getItems() : *
      {
         var items0:* = undefined;
         var ig0:* = undefined;
         var affixLevel0:int = 0;
         var icon2:ItemsIcon = null;
         var icon0:ExploreIcon = this.allBox.arr[this.nowExploreIndex];
         var d0:GoodsDefine = icon0.itemsData;
         this.nowGetGood = d0;
         ig0 = this.GD[d0.type + "Items"];
         if(d0.type == "props" || d0.type == "materials")
         {
            trace("个数：" + d0.num);
            if(d0.id != "GCoin_card_4")
            {
               affixLevel0 = this.GD.level - 4 + Math.random() * 11;
               if(affixLevel0 < 0)
               {
                  affixLevel0 = 0;
               }
               items0 = ig0.addItems(d0.id,d0.num,affixLevel0);
               ++ig0.lastExplore;
               items0.exploreIndex = ig0.lastExplore;
            }
            else
            {
               this.GD.addCoin(d0.price);
            }
         }
         else
         {
            items0 = ig0.addItems(d0.id,true);
         }
         this.fleshBag();
         this.dragBmp.bitmapData = StringToDefine.getBmp(icon0.icon);
         this.dragBmpSp.visible = true;
         this.dragBmpSp.x = icon0.localToGlobal(new Point()).x + icon0.width / 2 - this.dragBmpSp.width / 2;
         this.dragBmpSp.y = icon0.localToGlobal(new Point()).y + icon0.height / 2 - this.dragBmpSp.height / 2;
         var mx:int = 114 - this.dragBmpSp.width / 2;
         var my:int = 36 - this.dragBmpSp.height / 2;
         if(d0.id == "GCoin_card_4")
         {
            mx = 396;
            my = 37;
         }
         if(items0 is GoodsItemsData)
         {
            icon2 = this.itemsBox.findItemsData(items0);
            if(icon2 is ItemsIcon)
            {
               mx = icon2.localToGlobal(new Point()).x + icon2.width / 2 - this.dragBmpSp.width / 2;
               my = icon2.localToGlobal(new Point()).y + icon2.height / 2 - this.dragBmpSp.height / 2;
            }
         }
         TweenLite.to(this.dragBmpSp,0.5,{
            "x":mx,
            "y":my,
            "visible":false,
            "ease":Regular.easeInOut,
            "onComplete":this.overExplore
         });
         if(this.GorM)
         {
            this.GD.addCoin(-this.mustCoin);
         }
         else
         {
            this.GD.addMCoin(-this.mustCoin);
         }
         Game.SG.playSound("exploreItems");
      }
      
      public function gotoChange(event:MouseEvent) : *
      {
         if(this.nowGetGood is GoodsDefine)
         {
            Game.uiGroup.gotoChange(this.nowGetGood.type);
         }
         else
         {
            Game.uiGroup.gotoChange("car");
         }
      }
   }
}

