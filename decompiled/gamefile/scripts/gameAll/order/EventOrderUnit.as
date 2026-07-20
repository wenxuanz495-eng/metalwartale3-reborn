package gameAll.order
{
   public class EventOrderUnit
   {
      
      public static var pro_arr:Array = [];
      
      public var name:String = "";
      
      public var trueName:String = "";
      
      public var dialogue:String = "";
      
      public var firstDialogue:String = "";
      
      public var type:String = "";
      
      public var superNum:int = 0;
      
      public var level:int = -1;
      
      public var life_0:Number = -1;
      
      public var hurt_0:Number = 1;
      
      public var coin_0:Number = 1;
      
      public var exp_0:Number = 1;
      
      public var dropItemsArr:Array = [];
      
      public var number:int = 0;
      
      public var showNum:int = 0;
      
      public function EventOrderUnit()
      {
         super();
      }
      
      public function get leftNum() : int
      {
         return this.number - this.showNum;
      }
      
      public function get rate() : Number
      {
         return this.showNum / this.number;
      }
      
      public function inData_byXML(xml0:*) : *
      {
         this.name = String(xml0);
         this.number = int(xml0.@number);
         this.type = String(xml0.@type);
         if(Game.LG.state == "normal")
         {
            if(this.type == "" && this.number >= 3)
            {
               this.number = Math.ceil(this.number * 0.6);
            }
         }
         this.superNum = int(xml0.@superNum);
         if(this.type == "")
         {
            this.type = "soldier";
         }
         if(String(xml0.@level) != "")
         {
            this.level = int(xml0.@level);
         }
         if(String(xml0.@life) != "")
         {
            this.life_0 = int(xml0.@life);
         }
         this.exp_0 = xml0.@exp;
         this.coin_0 = xml0.@coin;
         this.hurt_0 = xml0.@hurt;
         this.trueName = xml0.@trueName;
         this.dialogue = String(xml0.@dialogue);
         this.firstDialogue = String(xml0.@firstDialogue);
         this.dropItemsArr = String(xml0.@dropItems).split(",");
      }
   }
}

