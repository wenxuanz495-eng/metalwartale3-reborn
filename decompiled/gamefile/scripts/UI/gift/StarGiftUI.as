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
   
   public class StarGiftUI extends Sprite
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
      
      public function StarGiftUI()
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
         this.visible = true;
         var starArr:Array = Game.startGiftDefineGroup.GetStarGiftArr();
         var len:int = int(starArr.length);
         var maxC:int = Math.ceil(len / this.ONEPAGECOUNT);
         this.pageBox.setTotalPage(maxC,this._shoplistPage,true);
         this.pageBox.fleshFun = this.updateUI;
         this._shoplistPage = 0;
         this.updateUI();
      }
      
      public function Hide() : void
      {
         this.visible = false;
      }
      
      protected function onCloseClick(event:MouseEvent) : void
      {
         Game.uiGroup.show("chooseLevel");
         this.visible = false;
      }
      
      private function updateUI() : void
      {
         this._shoplistPage = this.pageBox.nowPage;
         var starArr:Array = Game.startGiftDefineGroup.GetStarGiftArr();
         this.updateMember(starArr);
      }
      
      private function updateMember(arr:Array) : void
      {
         var nowMax:int = 0;
         var obj:StarGiftData = null;
         var color:String = null;
         var hasCount:int = 0;
         var mbCompensated:int = 0;
         var mbReward:int = 0;
         var starStr:String = null;
         nowMax = Game.gameData.newLevelData.plusAllStar();
         var allMax:int = Game.gameData.newLevelData.getAllStar();
         this.txt_nowStar.text = nowMax + "/" + allMax;
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
               mbReward = obj.getMCoinReward();
               (this["mc_list_" + i]["txt_price"] as TextField).text = obj.GiftDesc + "、" + mbReward + " MB";
               (this["mc_list_" + i]["btn_buy"] as SimpleButton).visible = true;
               color = "#ff0000";
               hasCount = 1 - Game.gameData.giftData.GetStarShopedByID(obj.Id);
               mbCompensated = Game.gameData.giftData.GetStarMBCompensatedByID(obj.Id);
               if(nowMax >= obj.NeedNum && hasCount > 0)
               {
                  color = "#00ff00";
                  (this["mc_list_" + i]["btn_buy"] as SimpleButton).alpha = 1;
                  (this["mc_list_" + i]["btn_buy"] as SimpleButton).mouseEnabled = true;
               }
               else if(hasCount <= 0 && mbCompensated <= 0)
               {
                  color = "#00ffff";
                  (this["mc_list_" + i]["btn_buy"] as SimpleButton).alpha = 1;
                  (this["mc_list_" + i]["btn_buy"] as SimpleButton).mouseEnabled = true;
               }
               starStr = "";
               if(hasCount <= 0 && mbCompensated <= 0)
               {
                  starStr = "<font color='" + color + "'>可领取 " + mbReward + " MB补偿</font>";
               }
               else if(hasCount <= 0)
               {
                  starStr = "<font color=\'" + color + "\'>" + "已领取" + "</font>";
               }
               else
               {
                  starStr = "<font color=\'" + color + "\'>" + nowMax + "/" + obj.NeedNum + "</font>";
               }
               (this["mc_list_" + i]["txt_unionCondition"] as TextField).htmlText = starStr;
               this["mc_list_" + i].buyID = obj.Id;
               this["mc_list_" + i].mbOnly = hasCount <= 0;
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
            var giftData:StarGiftData = Game.startGiftDefineGroup.GetOneGift(int(ep["buyID"]));
            var mbReward:int = giftData.getMCoinReward();
            if(Boolean(ep["mbOnly"]))
            {
               if(Game.gameData.giftData.GetStarMBCompensatedByID(this._tempID) <= 0)
               {
                  Game.gameData.addMCoin(mbReward);
                  Game.gameData.giftData.AddStarMBCompensatedByID(this._tempID);
                  Game.uiGroup.checkTip.showTip("星星奖励MB补偿：获得 " + mbReward + " MB",1);
                  Game.uiGroup.saveDataNoUI("领取星星奖励MB补偿");
               }
               this.updateUI();
               return;
            }
            Game.uiGroup.addGift_byArr(giftData.GiftArr,true,Game.gameData.level,true,true);
            Game.gameData.addMCoin(mbReward);
            Game.gameData.giftData.AddStarShopedByID(this._tempID);
            Game.gameData.giftData.AddStarMBCompensatedByID(this._tempID);
            Game.uiGroup.saveDataNoUI("领取星星奖励");
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

