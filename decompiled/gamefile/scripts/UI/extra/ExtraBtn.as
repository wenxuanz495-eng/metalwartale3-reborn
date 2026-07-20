package UI.extra
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ExtraBtn extends MovieClip
   {
      
      public var picFirst:int = 0;
      
      public var state2_mc:MovieClip;
      
      public var txt:TextField;
      
      public var pic:MovieClip;
      
      public var index:int = 0;
      
      public var state:int = -1;
      
      private var _actived:Boolean = true;
      
      public var noLabelB:Boolean = true;
      
      public var visible2:Boolean = true;
      
      public var num_mc:*;
      
      public var picMc:MovieClip;
      
      public function ExtraBtn()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.num_mc.visible = false;
         this.buttonMode = true;
         this.stop();
         this.pic.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.setState2("no");
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.picMc = Game.swfLoaderManager.getResource("LevelPic","extraPic");
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
      
      public function setNum(num0:int) : *
      {
         this.num_mc.txt.text = num0 + "";
         this.num_mc.visible = num0 != 0;
      }
      
      public function setState(value:int) : *
      {
         this.state = value;
         this.gotoAndStop(this.getLabel());
      }
      
      public function setState2(str0:String) : *
      {
         this.state2_mc.gotoAndStop(str0);
         if(str0 == "no")
         {
            this.actived = false;
         }
         else
         {
            this.actived = true;
         }
      }
      
      public function setState2_byNum(num0:int) : *
      {
         this.state2_mc.gotoAndStop(num0 + 1);
         if(num0 == 0)
         {
            this.actived = false;
         }
         else
         {
            this.actived = true;
         }
      }
      
      public function fleshPic() : *
      {
         if(this.index + 1 + this.picFirst <= this.picMc.totalFrames)
         {
            this.picMc.gotoAndStop(this.index + 1 + this.picFirst);
         }
         else
         {
            this.picMc.gotoAndStop(this.picMc.totalFrames);
         }
         this.pic.addChild(this.picMc);
      }
      
      public function set actived(bb:Boolean) : *
      {
         this._actived = bb;
         if(bb)
         {
            if(this.currentLabel == "no")
            {
               this.gotoAndStop(this.getLabel());
            }
         }
         else if(this.noLabelB)
         {
            this.gotoAndStop("no");
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
            this.fleshPic();
         }
      }
      
      protected function MOut(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop(this.getLabel());
            this.fleshPic();
         }
      }
      
      protected function MDown(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("down");
            this.fleshPic();
         }
      }
      
      protected function MUp(event:MouseEvent) : *
      {
         if(this.actived)
         {
            this.gotoAndStop("over");
            this.fleshPic();
         }
      }
      
      public function setText(str:int) : *
      {
         this.index = str;
         if(this.index == 0)
         {
            this.txt.text = "序章";
         }
         else
         {
            this.txt.text = "第" + String(this.index) + "关";
         }
         this.picMc.gotoAndStop(this.index + 1 + this.picFirst);
         this.fleshPic();
      }
      
      public function setText2(str:String) : *
      {
         this.txt.text = str;
      }
      
      public function getText() : int
      {
         return this.index;
      }
   }
}

