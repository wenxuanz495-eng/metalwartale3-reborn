package UI.top
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class HighBar extends Sprite
   {
      
      public var mc:MovieClip;
      
      public var t1:TextField;
      
      public var t2:TextField;
      
      public var t3:TextField;
      
      public var t4:TextField;
      
      public var t5:TextField;
      
      public var t_arr:Array = [];
      
      public var view_btn:SimpleButton;
      
      public var obj:Object = new Object();
      
      public var name_arr:Array = [];
      
      public var light_mc:MovieClip;
      
      public function HighBar()
      {
         super();
         this.mouseEnabled = false;
      }
      
      public function setFace(mc0:MovieClip) : *
      {
         var vb1:* = undefined;
         var lmc1:* = undefined;
         this.mc = mc0;
         for(var i:int = 0; i < 5; i++)
         {
            this.t_arr.push(this.mc.getChildByName("t" + (i + 1)));
            vb1 = this.mc.getChildByName("view_btn");
            this.view_btn = vb1;
            lmc1 = this.mc.getChildByName("light_mc");
            this.light_mc = lmc1;
         }
         this.mc.stop();
         addChild(this.mc);
         if(Boolean(this.light_mc))
         {
            this.light_mc.stop();
         }
         if(Boolean(this.view_btn))
         {
            this.view_btn.visible = false;
         }
      }
      
      public function setStyle(str0:String) : *
      {
         if(str0 == "title")
         {
            if(Boolean(this.view_btn))
            {
               this.view_btn.visible = false;
            }
            this.setBack(2);
         }
         else if(Boolean(this.view_btn))
         {
            this.view_btn.visible = true;
         }
      }
      
      public function setBack(num0:int) : *
      {
         this.mc.gotoAndStop(num0);
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
   }
}

