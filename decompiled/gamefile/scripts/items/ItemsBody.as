package items
{
   import flash.display.MovieClip;
   
   public class ItemsBody
   {
      
      public var mot:FloatingMotion = new FloatingMotion();
      
      public var img:MovieClip;
      
      public var label:String = "";
      
      public var define:ItemsDefine = null;
      
      public var addType:String = "";
      
      public var addValue:Number = 0;
      
      public var die:int = 0;
      
      public var hitB:Boolean = false;
      
      public var enemyType:String = "";
      
      public var hitFloorDisappearB:Boolean = false;
      
      public var magnetB:Boolean = false;
      
      public function ItemsBody()
      {
         super();
      }
      
      public function get x() : Number
      {
         return this.mot.x0;
      }
      
      public function get y() : Number
      {
         return this.mot.y0;
      }
      
      public function set x(value:Number) : *
      {
         this.mot.x0 = value;
         this.img.x = value;
      }
      
      public function set y(value:Number) : *
      {
         this.mot.y2 = value;
         this.img.y = value;
      }
      
      public function bodyTimer() : *
      {
         this.mot.motionTimer();
         if(this.hitFloorDisappearB)
         {
            if(this.mot.jumpNum > 0)
            {
               this.die = 1;
            }
         }
         this.img.x = this.mot.x0;
         this.img.y = this.mot.y0;
      }
   }
}

