package UI.shop
{
   import UI.button.BasicButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ShopBuyButton extends BasicButton
   {
      
      public var txt:TextField;
      
      public var data:Object = null;
      
      public function ShopBuyButton()
      {
         super();
         noLabelB = true;
      }
      
      override public function clear() : *
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,MOver);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,MDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,MUp);
         this.removeEventListener(MouseEvent.MOUSE_OUT,MOut);
      }
      
      public function setText(str0:String) : *
      {
         this.txt.text = str0;
      }
   }
}

