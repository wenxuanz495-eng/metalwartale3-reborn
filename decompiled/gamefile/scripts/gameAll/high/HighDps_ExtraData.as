package gameAll.high
{
   public class HighDps_ExtraData
   {
      
      public var playerName:String = "";
      
      public var group:String = "无";
      
      public var skillNum:Array = [11,12,10];
      
      public var armsLabel:String = "soya_lv1";
      
      public var subArr:Array = ["highEnergy_lv2","cutter_lv4","positron_lv2","lightningBall_lv4","lightningBall_lv4","chipped_lv4","flyBlade_lv2","protonImpact_lv1"];
      
      public var carLabel:String = "lambo";
      
      public function HighDps_ExtraData()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["group","skillNum","armsLabel","subArr","carLabel"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
      }
      
      public function inData_byHighArena(obj:*) : *
      {
         this.playerName = obj.name;
         this.group = obj.group;
         this.skillNum = obj.skill;
         this.armsLabel = obj.arms[0];
         this.subArr = obj.sub;
         this.carLabel = obj.car;
      }
      
      public function isZuobi(dps0:Number) : Boolean
      {
         return false;
      }
      
      public function toString() : String
      {
         var str0:String = "";
         str0 += "------------------\n";
         str0 += "skillNum：" + this.skillNum + "\n";
         str0 += "armsLabel：" + this.armsLabel + "\n";
         str0 += "subArr：" + this.subArr + "\n";
         str0 += "carLabel：" + this.carLabel + "\n";
         return str0 + "------------------";
      }
   }
}

