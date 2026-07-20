package UI.page
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PageButton extends MovieClip
   {
      
      public var txt:TextField;
      
      public var state:int = 0;
      
      private var _actived:Boolean = true;
      
      public var noLabelB:Boolean = false;
      
      public function PageButton()
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
      
      protected function MOver(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("over");
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop(this.getLabel());
         }
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("down");
         }
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("over");
         }
      }
      
      public function setText(str:int) : *
      {
         this.txt.text = String(str);
      }
      
      public function getText() : int
      {
         return int(this.txt.text);
      }
   }
}

