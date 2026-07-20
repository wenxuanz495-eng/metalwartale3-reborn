package body.image
{
   public class AnimationOrder
   {
      
      public var label:String = "";
      
      public var repeat:int = 0;
      
      public var repeatNow:int = 0;
      
      public var life:Number = 0;
      
      public function AnimationOrder(label0:String, repeat0:int = 0, life0:Number = 0)
      {
         super();
         this.label = label0;
         this.repeat = repeat0;
         this.life = life0;
      }
   }
}

