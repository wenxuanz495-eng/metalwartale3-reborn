package UI.button
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BasicButton extends MovieClip
   {
      
      public var state:int = -1;
      
      protected var _actived:Boolean = true;
      
      public var noLabelB:Boolean = false;
      
      public function BasicButton()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.buttonMode = true;
         this.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      protected function getLabel() : String
      {
         if(this.state == 0 || this.state == -1)
         {
            return "normal";
         }
         if(this.state == 1)
         {
            return "normal2";
         }
         return "";
      }
      
      public function clear() : *
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      public function setState(value:int) : *
      {
         this.state = value;
         this.gotoAndStop(this.getLabel());
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         if(bb)
         {
            this.mouseEnabled = true;
            if(this.currentLabel == "no")
            {
               this.gotoAndStop(this.getLabel());
            }
         }
         else
         {
            this.mouseEnabled = false;
            if(this.noLabelB)
            {
               this.gotoAndStop("no");
            }
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      protected function fleshTest() : *
      {
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("over");
            this.fleshTest();
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop(this.getLabel());
            this.fleshTest();
         }
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("down");
            this.fleshTest();
         }
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("over");
            this.fleshTest();
         }
      }
   }
}

