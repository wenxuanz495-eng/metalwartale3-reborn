package hit
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class HitPointGroup
   {
      
      public var arr:Array = new Array();
      
      public var effectArr:Array = new Array();
      
      public function HitPointGroup()
      {
         super();
      }
      
      public function copy() : HitPointGroup
      {
         var n:* = undefined;
         var m:* = undefined;
         var hpg:HitPointGroup = new HitPointGroup();
         for(n in this.arr)
         {
            hpg.arr[n] = new Array();
            for(m in this.arr[n])
            {
               hpg.arr[n][m] = this.arr[n][m].clone();
            }
            hpg.effectArr[n] = this.effectArr[n];
         }
         return hpg;
      }
      
      public function inData_byMC(mc0:MovieClip) : *
      {
         var m0:int = 0;
         var m:int = 0;
         var hp_mc:DisplayObject = null;
         var hp_name:String = null;
         var f0:int = 0;
         var hp:HitPoint = null;
         var f1:int = 0;
         var str0:String = null;
         var num:int = mc0.totalFrames;
         for(var n:int = 0; n <= num - 1; n++)
         {
            this.arr[n] = new Array();
            mc0.gotoAndStop(n + 1);
            m0 = mc0.numChildren;
            for(m = 0; m <= m0 - 1; m++)
            {
               hp_mc = mc0.getChildAt(m);
               hp_name = hp_mc.name;
               f0 = hp_name.indexOf("hitPoint");
               if(f0 >= 0)
               {
                  hp = new HitPoint(hp_mc.x,hp_mc.y);
                  this.arr[n].push(hp);
               }
               if(!(this.effectArr[n] is String))
               {
                  f1 = hp_name.indexOf("effect_");
                  if(f1 >= 0)
                  {
                     str0 = hp_name.substr(f1 + 7);
                     this.effectArr[n] = str0;
                  }
               }
            }
         }
      }
   }
}

