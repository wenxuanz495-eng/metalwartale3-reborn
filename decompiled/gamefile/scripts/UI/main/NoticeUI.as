package UI.main
{
   import UI.button.SountoScrollBar;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class NoticeUI extends Sprite
   {
      
      public var sBar:SountoScrollBar = new SountoScrollBar();
      
      public var cover_mc:Sprite;
      
      public var context_mc:Sprite = new Sprite();
      
      public var return_btn:SimpleButton;
      
      public var get_btn:SimpleButton;
      
      public function NoticeUI()
      {
         super();
         addChild(this.context_mc);
         this.context_mc.x = this.cover_mc.x;
         this.context_mc.y = this.cover_mc.y;
         this.sBar.x = 634 - 2;
         this.sBar.y = 100 + 3;
         addChild(this.sBar);
         this.sBar.setHigh(this.cover_mc.height - 6);
         this.context_mc.mask = this.cover_mc;
         this.get_btn.addEventListener(MouseEvent.CLICK,this.getGift);
      }
      
      public function fleshData() : *
      {
         var mc0:Sprite = null;
         if(this.context_mc.numChildren == 0)
         {
            mc0 = Game.swfLoaderManager.getResource("notice","notice");
            this.context_mc.addChild(mc0);
            this.sBar.setTarget(this.context_mc);
         }
         if(Game.gameData.giftData.buchangB)
         {
            this.get_btn.visible = false;
         }
         else
         {
            this.get_btn.visible = true;
         }
      }
      
      public function getGift(e:*) : *
      {
         var gift10:Array = [];
         gift10.push("GCoin,\t\t\t10000000,\t\t\t\t1");
         gift10.push("materials,\tsuperalloy_X,\t\t\t200");
         Game.gameData.giftData.buchangB = true;
         Game.uiGroup.addGift_byArr(gift10,true);
         this.fleshData();
      }
   }
}

