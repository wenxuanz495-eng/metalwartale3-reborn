package UI.vip
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import goods.GoodsDefine;
   
   public class VipGoodBar extends Sprite
   {
      
      public var name_txt:TextField;
      
      public var price_txt:TextField;
      
      public var _btn:SimpleButton;
      
      public var icon_con:Sprite;
      
      public var mouse_mc:Sprite;
      
      public var index:int = 0;
      
      public var define:GoodsDefine = null;
      
      public function VipGoodBar()
      {
         super();
      }
      
      public function fleshPrice() : *
      {
         if(Boolean(this.define))
         {
            if(Game.gameData.MCoin < this.define.Mprice)
            {
               this._btn.mouseEnabled = false;
               this._btn.alpha = 0.4;
            }
            else
            {
               this._btn.mouseEnabled = true;
               this._btn.alpha = 1;
            }
         }
      }
   }
}

