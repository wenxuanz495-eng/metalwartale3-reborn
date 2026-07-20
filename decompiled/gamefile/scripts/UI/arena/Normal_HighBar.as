package UI.arena
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class Normal_HighBar extends Sprite
   {
      
      public var t_arr:Array = [];
      
      public var obj:Object = new Object();
      
      public var name_arr:Array = [];
      
      public var light_mc:MovieClip;
      
      public var barMaxNum:int = 5;
      
      public var backType:int = 1;
      
      public var index:int = 0;
      
      public function Normal_HighBar()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         for(var i:int = 0; i < this.barMaxNum; i++)
         {
            this.t_arr.push(this["t" + (i + 1)]);
         }
         this.light_mc.stop();
      }
      
      public function setStyle(str0:String) : *
      {
         var n:* = undefined;
         var t0:TextField = null;
         if(str0 == "title")
         {
            for(n in this.t_arr)
            {
               t0 = this.t_arr[n];
               t0.textColor = 65280;
            }
            this.setBack(2);
         }
      }
      
      public function setBack(num0:int) : *
      {
         this.backType = num0;
         this.light_mc.gotoAndStop(num0);
      }
      
      public function setContext(arr0:Array) : *
      {
         var n:* = undefined;
         var t0:TextField = null;
         for(n in arr0)
         {
            t0 = this.t_arr[n];
            if(Boolean(t0))
            {
               t0.text = Game.sensitiveWords.encode(String(arr0[n]));
            }
            else
            {
               t0.text = "";
            }
         }
      }
      
      public function inPageNum(num0:int) : *
      {
      }
   }
}

