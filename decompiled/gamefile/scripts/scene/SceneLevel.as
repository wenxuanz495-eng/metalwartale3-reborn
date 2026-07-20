package scene
{
   import flash.display.Sprite;
   
   public class SceneLevel extends Sprite
   {
      
      public var mcName:String;
      
      public var moveRateX:Number;
      
      public var moveRateY:Number;
      
      public var levelWidth:int;
      
      public var levelHeight:int;
      
      public var gameLevel:String;
      
      public var cx:Number = 0;
      
      public var cy:Number = 0;
      
      public function SceneLevel()
      {
         super();
      }
      
      public function loadMC(mc0:*) : *
      {
         var l0:int = int(mc0.numChildren);
         for(var n:int = 0; n < l0; n++)
         {
            this.addChild(mc0.getChildAt(0));
         }
      }
      
      public function clearMC() : *
      {
         var l0:int = numChildren;
         for(var n:int = 0; n < l0; n++)
         {
            this.removeChild(getChildAt(0));
         }
      }
      
      public function inPositoin(x00:Number, y00:Number) : *
      {
         x = (x00 + this.cx) * this.moveRateX;
         y = (y00 + this.cy) * this.moveRateY;
      }
   }
}

