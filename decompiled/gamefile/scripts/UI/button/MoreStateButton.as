package UI.button
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MoreStateButton extends MovieClip
   {
      
      public var state:int = -1;
      
      private var _actived:Boolean = true;
      
      public var noLabelB:Boolean = true;
      
      public var txt_mc:MovieClip;
      
      public var back:*;
      
      public var index:int = 0;
      
      public var text:String = "";
      
      public var label0:String = "normal";
      
      public var newTipB:Boolean = true;
      
      public var new_tip:Sprite;
      
      public var newB:Boolean = false;
      
      public var newLevel:int = -1;
      
      public var realLevel:int = -1;
      
      public function MoreStateButton()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.buttonMode = true;
         this.stop();
         this.txt_mc.stop();
         this.back.stop();
         this.back.back.stop();
         this.new_tip = this.back.new_tip;
         this.new_tip.visible = false;
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
         if(this.state == 3)
         {
            return "normal";
         }
         if(this.state == 2)
         {
            return "no";
         }
         return "";
      }
      
      public function setState(value:int) : *
      {
         this.state = value;
         if(value == 0)
         {
            this.goLabel("normal");
            this.actived = true;
         }
         else if(value == 1)
         {
            this.actived = false;
            this.goLabel("normal2");
         }
         else if(value == 2)
         {
            this.actived = false;
         }
         else if(value == 3)
         {
            this.actived = true;
            this.goLabel("normal");
         }
      }
      
      public function setText(str:String) : *
      {
         try
         {
            this.text = str;
            this.txt_mc.gotoAndStop(str);
         }
         catch(e:Error)
         {
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
      
      public function changeBack(str0:String) : *
      {
         this.back.gotoAndStop(str0);
         this.goLabel(this.label0);
         if(this.newTipB)
         {
            this.new_tip = this.back.new_tip;
            this.new_tip.visible = this.newB;
         }
         this.new_tip.visible = this.newB;
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         enabled = bb;
         if(bb)
         {
            this.mouseEnabled = true;
            this.goLabel("normal");
         }
         else
         {
            this.mouseEnabled = false;
            if(this.noLabelB)
            {
               this.goLabel("no");
            }
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      public function goLabel(str:String) : *
      {
         if(this.state == 3)
         {
            str = "lock_" + str;
         }
         this.back.back.gotoAndStop(str);
         this.label0 = str;
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         this.goLabel("over");
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         this.goLabel(this.getLabel());
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         this.goLabel("down");
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         this.goLabel("over");
      }
      
      public function clear() : *
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
   }
}

