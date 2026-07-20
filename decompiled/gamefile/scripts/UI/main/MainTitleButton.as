package UI.main
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   
   public class MainTitleButton extends MovieClip
   {
      
      public var state:int = -1;
      
      private var _actived:Boolean = true;
      
      public var pic:MovieClip;
      
      public var noLabelB:Boolean = false;
      
      public var back:Sprite;
      
      public var label:String = "normal";
      
      public var text:String = "return";
      
      public var index:int = 0;
      
      public var new_tip:Sprite;
      
      public var newB:Boolean = false;
      
      public function MainTitleButton()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.new_tip.visible = false;
         this.buttonMode = true;
         this.stop();
         this.pic.stop();
         this.pic.info_txt.visible = false;
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.back.mouseEnabled = false;
         this.back.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
      }
      
      public function setText(str:String) : *
      {
         this.text = str;
         this.pic.gotoAndStop(str);
         this.pic.info_txt.visible = false;
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
      
      public function setBack(str:String) : *
      {
      }
      
      public function setState(value:int) : *
      {
         this.state = value;
         this.gotoLabel(this.getLabel());
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         if(bb)
         {
            this.mouseEnabled = true;
         }
         else
         {
            this.mouseEnabled = false;
            if(this.noLabelB)
            {
               this.gotoLabel("no");
               this.pic.info_txt.visible = false;
            }
         }
      }
      
      public function get actived() : Boolean
      {
         return this._actived;
      }
      
      public function showInfo() : *
      {
         this.pic.info_txt.visible = true;
         this.pic.info_txt.alpha = 0;
         TweenLite.to(this.pic.info_txt,0.5,{"alpha":1});
      }
      
      public function gotoLabel(label0:String) : *
      {
         this.new_tip.visible = this.newB;
         this.gotoAndStop(label0);
         this.label = label0;
         this.back.mouseEnabled = false;
         this.back.mouseChildren = false;
      }
      
      protected function MOver(event:MouseEvent) : *
      {
         this.gotoLabel("over");
         this.showInfo();
         this.back.mouseEnabled = false;
         this.back.mouseChildren = false;
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         this.gotoLabel(this.getLabel());
         this.pic.info_txt.visible = false;
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         this.gotoLabel("down");
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         this.gotoLabel("over");
         this.back.mouseEnabled = false;
         this.back.mouseChildren = false;
      }
   }
}

