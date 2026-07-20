package UI.research
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.CarItemsData;
   
   public class CarUpgradeBox extends Sprite
   {
      
      public var progress_txt:TextField;
      
      public var level_txt:TextField;
      
      public var must_txt:TextField;
      
      public var mustCoin_txt:TextField;
      
      public var nowCoin_txt:TextField;
      
      public var condition_icon1:MovieClip;
      
      public var condition_icon2:MovieClip;
      
      public var condition_icon3:MovieClip;
      
      public var upgrade_btn:SimpleButton;
      
      public var no_btn:SimpleButton;
      
      public function CarUpgradeBox()
      {
         super();
         this.condition_icon1.stop();
         this.condition_icon2.stop();
         this.condition_icon3.stop();
      }
      
      public function inData(data0:CarItemsData) : *
      {
         this.progress_txt.text = data0.upgradeNum + "/" + data0.getMaxUpgradeLevel();
         var mustB:Boolean = true;
         var mustLv0:int = data0.getNextMustHeroLevel();
         this.level_txt.text = mustLv0 + "";
         if(mustLv0 > Game.gameData.level + 1)
         {
            mustB = false;
            this.condition_icon2.gotoAndStop(2);
         }
         else
         {
            this.condition_icon2.gotoAndStop(1);
         }
         var mustM0:int = data0.getNextMustM();
         this.mustCoin_txt.text = mustM0 + "";
         if(mustM0 > Game.gameData.MCoin)
         {
            mustB = false;
            this.condition_icon3.gotoAndStop(2);
         }
         else
         {
            this.condition_icon3.gotoAndStop(1);
         }
         this.nowCoin_txt.text = "当前M币：" + Game.gameData.MCoin;
         this.upgrade_btn.mouseEnabled = mustB;
         this.upgrade_btn.alpha = mustB ? 1 : 0.4;
      }
   }
}

