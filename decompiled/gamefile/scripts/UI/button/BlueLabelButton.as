package UI.button
{
   import flash.events.MouseEvent;
   
   public class BlueLabelButton extends MoreStateButton
   {
      
      public function BlueLabelButton()
      {
         super();
      }
      
      override public function init() : *
      {
         this.buttonMode = true;
         this.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,MOut);
      }
      
      override public function goLabel(str:String) : *
      {
         if(state == 3)
         {
            str = "lock_" + str;
         }
         gotoAndStop(str);
         label0 = str;
      }
      
      override public function setText(str:String) : *
      {
      }
   }
}

