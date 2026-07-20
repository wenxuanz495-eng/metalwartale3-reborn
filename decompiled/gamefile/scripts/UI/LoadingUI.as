package UI
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class LoadingUI extends Sprite
   {
      
      public var mc:MovieClip;
      
      public var txt:TextField;
      
      public function LoadingUI()
      {
         super();
      }
      
      public function show(str0:String = "") : *
      {
         visible = true;
         this.mc.play();
         if(str0 == "")
         {
            this.txt.text = "数据处理中";
         }
         else
         {
            this.txt.text = str0;
         }
         trace("显示loading！！！！！！！！！！！！！！！！");
      }
      
      public function hide() : *
      {
         visible = false;
         this.mc.stop();
      }
   }
}

