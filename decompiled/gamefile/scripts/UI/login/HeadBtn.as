package UI.login
{
   import UI.button.MoreStateButton;
   import flash.events.MouseEvent;
   
   public class HeadBtn extends MoreStateButton
   {
      
      public function HeadBtn()
      {
         super();
         newTipB = false;
      }
      
      override public function init() : *
      {
         this.buttonMode = true;
         this.stop();
         txt_mc.stop();
         back.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,MOut);
      }
      
      override public function changeBack(str0:String) : *
      {
      }
      
      override public function goLabel(str:String) : *
      {
         if(state == 3)
         {
            str = "lock_" + str;
         }
         back.gotoAndStop(str);
         label0 = str;
      }
   }
}

