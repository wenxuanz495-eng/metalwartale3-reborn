package UI.button
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class PicButton extends Sprite
   {
      
      public var state:int = -1;
      
      private var _actived:Boolean = true;
      
      public var noLabelB:Boolean = false;
      
      public var back:MovieClip;
      
      public var pic:MovieClip;
      
      public var label:String = "normal";
      
      public var text:String = "return";
      
      public var newTipB:Boolean = true;
      
      public var new_tip:Sprite;
      
      public var newB:Boolean = false;
      
      public var newLevel:int = -1;
      
      public var realLevel:int = -1;
      
      public function PicButton()
      {
         super();
         this.new_tip.visible = false;
         this.init();
      }
      
      public function init() : *
      {
         this.buttonMode = true;
         this.back.stop();
         this.back.back.stop();
         this.pic.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      public function setText(str:String) : *
      {
         this.pic.gotoAndStop(str);
         this.text = str;
      }
      
      protected function getLabel() : String
      {
         if(this.state == 0 || this.state == -1)
         {
            return "normal";
         }
         if(this.state == 1)
         {
            return "normal";
         }
         return "";
      }
      
      public function setState(value:int) : *
      {
         this.state = value;
         this.gotoLabel(this.getLabel());
      }
      
      public function setBack(str:String) : *
      {
         this.back.gotoAndStop(str);
         this.gotoLabel(this.label);
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         if(bb)
         {
            this.mouseEnabled = true;
            this.gotoLabel("normal");
         }
         else
         {
            this.mouseEnabled = false;
            if(this.noLabelB)
            {
               this.gotoLabel("no");
            }
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      public function gotoLabel(label0:String) : *
      {
         if(this.actived || label0 == "no")
         {
            this.back.back.gotoAndStop(label0);
            this.label = label0;
         }
      }
      
      public function showNew() : *
      {
         this.new_tip.visible = true;
         this.newB = true;
      }
      
      public function hideNew() : *
      {
         this.new_tip.visible = false;
         this.newB = false;
         this.newLevel = this.realLevel;
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         this.gotoLabel("over");
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         this.gotoLabel(this.getLabel());
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         this.gotoLabel("down");
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         this.gotoLabel("over");
      }
   }
}

