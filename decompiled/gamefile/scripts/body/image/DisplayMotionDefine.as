package body.image
{
   public class DisplayMotionDefine
   {
      
      public var label:String = "";
      
      public var imgLabel:String = "";
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var rotation:Number = 0;
      
      public var visible:Boolean = true;
      
      public var alpha:Number = 1;
      
      public var deepIndex:int = 0;
      
      public function DisplayMotionDefine()
      {
         super();
      }
      
      public function toString() : String
      {
         return this.label;
      }
   }
}

