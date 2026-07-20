package UI.gift
{
   import UI.page.PageBox;
   import UI.union.UnionUI;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import goods.StarGiftData;
   
   public class GrowGiftUI extends Sprite
   {
      
      private var _shoplistPage:int = 0;
      
      private const ONEPAGECOUNT:int = 10;
      
      private var _unionShopList:Array = [];
      
      private var _tempID:int = -1;
      
      private var father:UnionUI = null;
      
      public var mc_list_0:MovieClip;
      
      public var mc_list_1:MovieClip;
      
      public var mc_list_2:MovieClip;
      
      public var mc_list_3:MovieClip;
      
      public var mc_list_4:MovieClip;
      
      public var mc_list_5:MovieClip;
      
      public var mc_list_6:MovieClip;
      
      public var mc_list_7:MovieClip;
      
      public var mc_list_8:MovieClip;
      
      public var mc_list_9:MovieClip;
      
      public var txt_nowStar:TextField;
      
      public var return_btn:SimpleButton;
      
      private var pageBox:PageBox;
      
      public function GrowGiftUI()
      {
         super();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.onCloseClick);
         this.pageBox = new PageBox();
         this.pageBox.x = 478;
         this.pageBox.y = 463;
         this.addChild(this.pageBox);
      }
      
      public function Show() : void
      {
         if(!Game.gameData.growVip)
         {
            this.affter_yes_goodsClick();
         }
         this.visible = true;
         var starArr:Array = Game.growGiftDefineGroup.GetStarGiftArr();
         var len:int = int(starArr.length);
         var maxC:int = Math.ceil(len / this.ONEPAGECOUNT);
         this.pageBox.setTotalPage(maxC,this._shoplistPage,true);
         this.pageBox.fleshFun = this.updateUI;
         this._shoplistPage = 0;
         this.updateUI();
      }
      
      private function affter_yes_goodsClick() : *
      {
         Game.gameData.growVip = true;
         Game.uiGroup.checkTip.showTip("购买成功！",1);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.saveDataNoUI();
         Game.uiGroup.allback.info.fleshData();
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
      
      protected function onCloseClick(event:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function updateUI() : void
      {
         this._shoplistPage = this.pageBox.nowPage;
         var starArr:Array = Game.growGiftDefineGroup.GetStarGiftArr();
         this.updateMember(starArr);
      }
      
      private function updateMember(arr:Array) : void
      {
         var nowMax:int = 0;
         var obj:StarGiftData = null;
         var color:String = null;
         var hasCount:int = 0;
         var starStr:String = null;
         nowMax = Game.gameData.level + 1;
         this.txt_nowStar.text = nowMax + "";
         for(var i:int = 0; i < this.ONEPAGECOUNT; i++)
         {
            (this["mc_list_" + i]["txt_name"] as TextField).text = "";
            (this["mc_list_" + i]["txt_unionCondition"] as TextField).text = "";
            (this["mc_list_" + i]["txt_price"] as TextField).text = "";
            (this["mc_list_" + i]["btn_buy"] as SimpleButton).visible = false;
            this["mc_list_" + i].visible = false;
            (this["mc_list_" + i]["btn_buy"] as SimpleButton).alpha = 0.3;
            (this["mc_list_" + i]["btn_buy"] as SimpleButton).mouseEnabled = false;
            if(Boolean(this["mc_list_" + i]) && Boolean(arr) && Boolean(arr[i + this.ONEPAGECOUNT * this._shoplistPage]))
            {
               obj = arr[i + this.ONEPAGECOUNT * this._shoplistPage];
               this["mc_list_" + i].visible = true;
               this.addIcon(this["mc_list_" + i]["mc_icon"],obj.Icon,"itemsUI");
               (this["mc_list_" + i]["txt_name"] as TextField).text = "" + obj.Name;
               (this["mc_list_" + i]["txt_price"] as TextField).text = obj.GiftDesc;
               (this["mc_list_" + i]["btn_buy"] as SimpleButton).visible = true;
               color = "#ff0000";
               hasCount = 1 - Game.gameData.giftData.GetGrowShopedByID(obj.Id);
               if(nowMax >= obj.NeedNum && hasCount > 0)
               {
                  color = "#00ff00";
                  (this["mc_list_" + i]["btn_buy"] as SimpleButton).alpha = 1;
                  (this["mc_list_" + i]["btn_buy"] as SimpleButton).mouseEnabled = true;
               }
               starStr = "";
               if(hasCount <= 0)
               {
                  starStr = "<font color=\'" + color + "\'>" + "已领取" + "</font>";
               }
               else
               {
                  starStr = "<font color=\'" + color + "\'>" + nowMax + "/" + obj.NeedNum + "</font>";
               }
               (this["mc_list_" + i]["txt_unionCondition"] as TextField).htmlText = starStr;
               this["mc_list_" + i].buyID = obj.Id;
               (this["mc_list_" + i]["btn_buy"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.sureBuy);
            }
         }
      }
      
      protected function sureBuy(event:MouseEvent) : void
      {
         var ep:DisplayObject = event.currentTarget.parent;
         if(ep["buyID"] != null)
         {
            this._tempID = ep["buyID"];
            var giftData:StarGiftData = Game.growGiftDefineGroup.GetOneGift(int(ep["buyID"]));
            Game.uiGroup.addGift_byArr(giftData.GiftArr,true,Game.gameData.level,true,true);
            Game.gameData.giftData.AddGrowShopedByID(this._tempID);
            this.updateUI();
            return;
         }
      }
      
      private function addIcon(mccontains:DisplayObjectContainer, imgLabel:String, father:String = "") : void
      {
         var bit:Bitmap = null;
         while(mccontains.numChildren > 0)
         {
            mccontains.removeChildAt(0);
         }
         var temp:* = Game.swfLoaderManager.getResource("",imgLabel);
         if(temp == null)
         {
            temp = Game.swfLoaderManager.getResource(father,imgLabel);
            temp.stop();
            temp.x = -temp.width / 2;
            temp.y = -temp.height / 2;
            if(Boolean(temp["basePoint"]))
            {
               temp["basePoint"].visible = false;
            }
            if(Boolean(temp["shootPoint"]))
            {
               temp["shootPoint"].visible = false;
            }
         }
         var mc:MovieClip = null;
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         mccontains.addChild(mc);
      }
   }
}

