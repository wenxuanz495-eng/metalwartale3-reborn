package UI.level
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class LevelButton extends MovieClip
   {
      
      public var txt:TextField;
      
      public var pic:MovieClip;
      
      public var index:int = 0;
      
      public var picFirst:int = 0;
      
      public var state:int = -1;
      
      private var _actived:Boolean = true;
      
      public var noLabelB:Boolean = true;
      
      public var visible2:Boolean = true;
      
      public var star_mc:MovieClip;
      
      public var picMc:MovieClip;
      
      public function LevelButton()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.star_mc.stop();
         this.star_mc.visible = false;
         this.buttonMode = true;
         this.stop();
         this.pic.stop();
         this.mouseEnabled = true;
         this.mouseChildren = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.MOver);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.MDown);
         this.addEventListener(MouseEvent.MOUSE_UP,this.MUp);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.MOut);
         this.picMc = Game.swfLoaderManager.getResource("LevelPic","pic");
      }
      
      public function setStar(num0:int = 0, ishide:Boolean = false) : *
      {
         this.star_mc.visible = true;
         this.star_mc.gotoAndStop(num0 + 1);
         if(ishide)
         {
            this.star_mc.visible = false;
         }
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

