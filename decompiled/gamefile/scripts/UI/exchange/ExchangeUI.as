package UI.exchange
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.button.PicButton;
   import UI.label.LabelBox;
   import UI.page.PageBox;
   import UI.shop.ShopIcon;
   import UI.shop.ShopIconBox;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   import goods.GoodsDefineGroup;
   
   public class ExchangeUI extends Sprite
   {
      
      public var cover_mc:Sprite;
      
      public var front_mc:Sprite;
      
      public var GDG:GoodsDefineGroup;
      
      public var GD:GameData;
      
      public var return_btn:PicButton;
      
      public var gotoChange_btn:SimpleButton;
      
      public var pay_btn:SimpleButton;
      
      public var Xnum_txt:TextField;
      
      public var switchLabel:LabelBox;
      
      public var armsBox:ShopIconBox;
      
      public var subBox:ShopIconBox;
      
      public var carBox:ShopIconBox;
      
      public var materialsBox:ShopIconBox;
      
      public var propsBox:ShopIconBox;
      
      public var pageBox:PageBox;
      
      public var allBox:Array;
      
      public var nowBuyGoods:GoodsDefine = null;
      
      public var labelNameArr:Array;
      
      public var noGoodsShow:*;
      
      public function ExchangeUI()
      {
         var n:* = undefined;
         var sib:ShopIconBox = null;
         this.switchLabel = new LabelBox();
         this.armsBox = new ShopIconBox();
         this.subBox = new ShopIconBox();
         this.carBox = new ShopIconBox();
         this.materialsBox = new ShopIconBox();
         this.propsBox = new ShopIconBox();
         this.allBox = [];
         this.labelNameArr = ["car","props","materials","arms","sub"];
         super();
         this.noGoodsShow.visible = false;
         this.noGoodsShow.txt.text = "暂无该类型商品";
         this.cover_mc.mouseChildren = false;
         this.cover_mc.mouseEnabled = false;
         this.front_mc.mouseChildren = false;
         this.front_mc.mouseEnabled = false;
         this.switchLabel.setLabelClass(MoreStateButton);
         this.switchLabel.addLabel(["no","no","no","no","no"],493,true,"shop");
         addChild(this.switchLabel);
         this.switchLabel.x = 340;
         this.switchLabel.y = 57;
         this.switchLabel.showState(0);
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.allBox = [this.carBox,this.propsBox,this.materialsBox,this.armsBox,this.subBox];
         for(n in this.allBox)
         {
            sib = this.allBox[n];
            sib.setLabelClass(ShopIcon);
            sib.setNum(2,4,585,340);
            sib.x = 273;
            sib.y = 70;
            addChild(sib);
            sib.addEventListener(ClickEvent.ON_CLICK,this.iconClick);
         }
         this.gotoChange_btn.addEventListener(MouseEvent.CLICK,this.gotoChange);
         this.addChild(this.return_btn);
         this.pay_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
         this.switchLabel.showState(1);
      }
      
      public function init() : *
      {
         this.GDG = Game.goodsDefineGroup;
         this.GD = Game.gameData;
         this.fleshAll();
      }
      
      public function clearAll() : *
      {
         this.armsBox.clear();
         this.subBox.clear();
         this.carBox.clear();
         this.materialsBox.clear();
         this.propsBox.clear();
      }
      
      public function getXnum() : int
      {
         return this.GD.materialsItems.getNumByBase("superalloy_X");
      }
      
      public function useXnum(num0:int) : *
      {
         this.GD.materialsItems.useItemsNum("superalloy_X",num0);
      }
      
      public function fleshAll() : *
      {
         this.armsBox.inData_byArr(this.GDG.Xarms);
         this.subBox.inData_byArr(this.GDG.Xsub);
         this.carBox.inData_byArr(this.GDG.Xcar);
         this.materialsBox.inData_byArr(this.GDG.Xmaterials);
         this.propsBox.inData_byArr(this.GDG.Xprops);
         this.fleshPrice();
         this.showBox(this.switchLabel.nowIndex);
      }
      
      private function gotoChange(event:MouseEvent) : *
      {
         Game.uiGroup.gotoChange(this.labelNameArr[this.switchLabel.nowIndex]);
      }
      
      public function fleshPrice() : *
      {
         var n:* = undefined;
         var sib:ShopIconBox = null;
         var Xnum:int = this.getXnum();
         this.Xnum_txt.text = Xnum + "";
         for(n in this.allBox)
         {
            sib = this.allBox[n];
            sib.fleshPrice_byX(Xnum);
         }
      }
      
      public function showBox_byLabel(label0:String) : *
      {
         this.showBox(this.labelNameArr.indexOf(label0));
      }
      
      public function showBox(num:int) : *
      {
         var n:* = undefined;
         var sib:ShopIconBox = null;
         this.switchLabel.showState(num);
         for(n in this.allBox)
         {
            sib = this.allBox[n];
            if(num == n)
            {
               sib.visible = true;
               this.pageBox.table = sib;
               this.pageBox.fleshByTable();
               if(sib.arr.length == 0)
               {
                  this.noGoodsShow.visible = true;
               }
               else
               {
                  this.noGoodsShow.visible = false;
               }
            }
            else
            {
               sib.visible = false;
            }
         }
      }
      
      private function labelClick(event:ClickEvent) : *
      {
         this.showBox(event.index);
      }
      
      private function iconClick(event:ClickEvent) : *
      {
         var n2:* = undefined;
         var arr03:Array = null;
         var n3:* = undefined;
         var id02:String = null;
         var aid0:ArmsItemsData = null;
         var id03:String = null;
         var aid3:ArmsItemsData = null;
         var str1:* = undefined;
         var str2:* = undefined;
         var icon0:ShopIcon = event.goal;
         var d0:GoodsDefine = icon0.itemsData;
         this.nowBuyGoods = d0;
         var arr02:Array = ["amplitude","microwave"];
         for(n2 in arr02)
         {
            id02 = arr02[n2];
            if(d0.id.indexOf(id02) >= 0)
            {
               aid0 = this.GD.armsItems.getItemsByBase(id02,false);
               if(aid0 is ArmsItemsData)
               {
                  Game.uiGroup.checkTip.showCheck2("此商品只能购买一次。",3);
                  return;
               }
            }
         }
         arr03 = ["flyBlade","highEnergy","positron"];
         for(n3 in arr03)
         {
            id03 = arr03[n3];
            if(d0.id.indexOf(id03) >= 0)
            {
               aid3 = this.GD.subItems.getItemsByBase(id03,false);
               if(aid3 is ArmsItemsData)
               {
                  Game.uiGroup.checkTip.showCheck2("此商品只能购买一次。",3);
                  return;
               }
            }
         }
         if(!this.GD[d0.type + "Items"].getFillB())
         {
            str1 = "你确定要兑换 <font color=\'#FFFF00\'>" + d0.name + "</font> 吗？";
            str2 = "本次兑换消耗：" + "<font color=\'#FFFF00\'>" + d0.Xprice + "</font> 个超合金X";
            Game.uiGroup.checkTip.showCheck(str1 + "\n" + str2,this.yesBuy);
         }
         else
         {
            Game.uiGroup.checkTip.showCheck2("您的背包已满，无法购买商品。",3);
         }
      }
      
      private function yesBuy() : *
      {
         var d0:GoodsDefine = this.nowBuyGoods;
         var price0:int = d0.Xprice;
         this.buyAffterFun();
      }
      
      public function buyAffterFun() : *
      {
         var newGood:* = undefined;
         var m:int = 0;
         var d0:GoodsDefine = this.nowBuyGoods;
         var price0:int = d0.Xprice;
         this.useXnum(price0);
         var goodsNum:int = 1;
         if(d0.type == "props" || d0.type == "materials")
         {
            goodsNum = d0.num;
            if(d0.id.indexOf("_chip") > 0)
            {
               for(m = 0; m < goodsNum; m++)
               {
                  newGood = this.GD[d0.type + "Items"].addItems(d0.id,1,int(this.GD.level - 4 + Math.random() * 7));
               }
            }
            else
            {
               newGood = this.GD[d0.type + "Items"].addItems(d0.id,goodsNum);
            }
         }
         else
         {
            newGood = this.GD[d0.type + "Items"].addItems(d0.id);
         }
         if(d0.type == "car")
         {
            if(newGood.getArmsDefine().mustLevel <= this.GD.level)
            {
               this.GD.carItems.bag_to_equip(newGood.site,0);
               Game.eventGroup.fleshCar();
               this.GD.fleshAdd_byItems();
               Game.uiGroup.carShow.copyAll();
            }
         }
         Game.SG.playSound("buyItems");
         this.fleshPrice();
         Game.uiGroup.infoUI.fleshData();
         this.nowBuyGoods = null;
      }
   }
}

