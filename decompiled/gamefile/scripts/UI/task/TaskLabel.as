package UI.task
{
   import UI.button.BasicButton;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TaskLabel extends BasicButton
   {
      
      public var nameTxt:TextField;
      
      public var star_mc:MovieClip;
      
      public var state_mc:MovieClip;
      
      public var index:int = 0;
      
      public var itemsData:*;
      
      public function TaskLabel()
      {
         super();
         noLabelB = true;
         this.setStar(1);
         this.setNowState("no");
      }
      
      override public function set actived(bb:Boolean) : *
      {
         _actived = bb;
         if(bb)
         {
            this.mouseEnabled = true;
         }
         else
         {
            this.mouseEnabled = false;
         }
      }
      
      override public function setState(value:int) : *
      {
         state = value;
         if(value == 0)
         {
            this.gotoAndStop("normal");
            this.actived = true;
         }
         else if(value == 1)
         {
            this.actived = false;
            this.gotoAndStop("normal2");
         }
         else if(value == 2)
         {
            this.gotoAndStop("no");
            this.actived = false;
         }
         else if(value == 3)
         {
            this.actived = true;
            this.gotoAndStop("normal");
         }
      }
      
      public function setText(str0:String) : *
      {
         this.nameTxt.text = str0;
      }
      
      public function get text() : String
      {
         return this.nameTxt.text;
      }
      
      public function setStar(value0:int) : *
      {
         value0++;
         if(value0 >= 1 && value0 <= 5)
         {
            this.star_mc.gotoAndStop(int(value0));
         }
         else
         {
            this.star_mc.gotoAndStop(1);
         }
      }
      
      public function setNowState(str0:String) : *
      {
         this.state_mc.gotoAndStop(str0);
      }
   }
}

