package enemy._die
{
   import data.INIT;
   
   public class EnemyDialogue
   {
      
      public var b0:* = null;
      
      public var role:String = "self";
      
      public var time:int = 60;
      
      public var label:String = "";
      
      public function EnemyDialogue()
      {
         super();
      }
      
      public function inData(str0:String) : *
      {
         var arr0:Array = str0.split("/");
         this.role = arr0[0];
         this.time = Number(arr0[1]) * INIT.FPS;
         this.label = arr0[2];
      }
      
      public function toString() : String
      {
         return "role:" + this.role + "  label:" + this.label + "  time:" + this.time;
      }
   }
}

