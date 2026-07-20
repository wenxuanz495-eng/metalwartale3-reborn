package UI.rank
{
   import UI.button.PicButton;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class RankUI extends Sprite
   {
      
      public var pay_btn:SimpleButton;
      
      public var allGift_btn:PicButton;
      
      public var gettingReward_btn:PicButton;
      
      public var baifen_bar:Sprite;
      
      public var baifen_txt:TextField;
      
      public var light_mc:Sprite;
      
      public var rankName_txt:TextField;
      
      public var pointer:Sprite;
      
      public var mc_name:MovieClip;
      
      public var test_txt:TextField;
      
      public function RankUI()
      {
         super();
         this.gettingReward_btn.visible = false;
         this.pay_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
         var str0:String = "";
         str0 += "<a href=\"event:incMoney\">incMoney 13</a><br>";
         str0 += "<a href=\"event:decMoney\">decMoney 13</a><br>";
         str0 += "<a href=\"event:getBalance\">getBalance</a><br>";
         str0 += "<a href=\"event:getTotalPaied\">getTotalPaied</a><br>";
         str0 += "<a href=\"event:getTotalRecharged\">getTotalRecharged</a><br>";
         this.test_txt.htmlText = str0;
         this.test_txt.addEventListener(TextEvent.LINK,this.linkFun);
         this.allGift_btn.setBack("new_orange");
         this.allGift_btn.setText("allGift");
         this.allGift_btn.addEventListener(MouseEvent.CLICK,this.allGiftClick);
         this.gettingReward_btn.setText("gettingReward");
         this.gettingReward_btn.noLabelB = true;
         this.gettingReward_btn.setBack("new_orange");
         this.gettingReward_btn.addEventListener(MouseEvent.CLICK,this.rankGiftClick);
      }
      
      public function linkFun(event:TextEvent) : *
      {
      }
      
      public function allGiftClick(e:*) : *
      {
         Game.uiGroup.menu.show("main");
         Game.uiGroup.mainUI.showAllGift();
      }
      
      public function fleshData() : *
      {
         this.rankName_txt.text = Game.gameData.playerRank;
         if(this.rankName_txt.length > 3)
         {
            this.rankName_txt.setTextFormat(new TextFormat(null,35));
         }
         else
         {
            this.rankName_txt.setTextFormat(new TextFormat(null,40));
         }
         var baifen:Number = Game.gameData.achieve / Game.gameData.maxAchieve;
         this.baifen_txt.text = Game.gameData.achieve + "/" + Game.gameData.maxAchieve;
         if(baifen < 0)
         {
            baifen = 0;
         }
         else if(baifen > 1)
         {
            baifen = 1;
         }
         this.baifen_bar.scaleX = baifen;
         trace("light_mc.x " + this.light_mc.x);
         this.light_mc.x = this.baifen_bar.x + this.baifen_bar.width;
         var lv0:int = Game.gameData.rankLevel;
         if(lv0 > 15)
         {
            this.pointer.visible = true;
            this.mc_name.gotoAndStop(2);
            if(lv0 % 15 > 9)
            {
               this.pointer.visible = false;
            }
         }
         else
         {
            this.pointer.visible = true;
            this.mc_name.gotoAndStop(1);
         }
         if(lv0 <= 0)
         {
            this.pointer.visible = false;
         }
         else
         {
            this.pointer.visible = true;
            if(lv0 > 15)
            {
               this.pointer.y = 132 + (391 - 116) / 14 * (lv0 % 16);
            }
            else
            {
               this.pointer.y = 132 + (391 - 116) / 14 * (lv0 - 1);
            }
         }
         var rankLevel:int = Game.gameData.rankLevel;
         if(rankLevel < 4)
         {
            this.gettingReward_btn.actived = false;
         }
         else
         {
            this.gettingReward_btn.actived = !Game.gameData.rankAdd.rankGiftB;
         }
      }
      
      public function rankGiftClick(e:* = null) : *
      {
         Game.uiGroup.mainUI.gettingUI.rankGiftClick();
      }
   }
}

