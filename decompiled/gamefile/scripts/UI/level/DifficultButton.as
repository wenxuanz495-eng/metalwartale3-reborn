package UI.level
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class DifficultButton extends MovieClip
   {
      
      public var state:int = -1;
      
      private var _actived:Boolean = true;
      
      public var noLabelB:Boolean = true;
      
      public var index:int = 0;
      
      public var text:String = "";
      
      public var txt:TextField;
      
      public function DifficultButton()
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
      
      public function setText(str:String) : *
      {
         this.text = str;
         this.txt.text = str;
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
         if(value == 0)
         {
            this.gotoAndStop("normal");
            this.setText(this.text);
            this.actived = true;
         }
         else if(value == 1)
         {
            this.actived = false;
            this.gotoAndStop("normal2");
            this.setText(this.text);
         }
         else if(value == 2)
         {
            this.actived = false;
         }
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         enabled = bb;
         if(!bb)
         {
            if(this.noLabelB)
            {
               this.gotoAndStop("no");
               this.setText(this.text);
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
            this.setText(this.text);
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop(this.getLabel());
            this.setText(this.text);
         }
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("down");
            this.setText(this.text);
         }
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("over");
            this.setText(this.text);
         }
      }
   }
}

