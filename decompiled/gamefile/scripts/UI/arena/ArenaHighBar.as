package UI.arena
{
   import UI.ClickEvent;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ArenaHighBar extends Normal_HighBar
   {
      
      public var t1:TextField;
      
      public var t2:TextField;
      
      public var t3:TextField;
      
      public var t4:TextField;
      
      public var _btn:SimpleButton;
      
      public function ArenaHighBar()
      {
         super();
      }
      
      override public function init() : *
      {
         barMaxNum = 4;
         this._btn.addEventListener(MouseEvent.CLICK,this.btnClick);
         super.init();
      }
      
      override public function setStyle(str0:String) : *
      {
         super.setStyle(str0);
         if(str0 == "title")
         {
            this._btn.visible = false;
         }
      }
      
      public function btnClick(e:* = null) : *
      {
         var downEvent:ClickEvent = new ClickEvent(ClickEvent.ON_CLICK);
         downEvent.goal = this;
         this.dispatchEvent(downEvent);
      }
      
      override public function inPageNum(num0:int) : *
      {
         this._btn.visible = num0 == 0;
      }
   }
}

