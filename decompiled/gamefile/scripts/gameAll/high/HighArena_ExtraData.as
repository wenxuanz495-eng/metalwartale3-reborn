package gameAll.high
{
   import data.StringToDefine;
   
   public class HighArena_ExtraData
   {
      
      public var name:String = "无";
      
      public var lv:int = 3;
      
      public var head:String = "s1";
      
      public var group:String = "无";
      
      public var life:Number = 200;
      
      public var defence:Number = 50;
      
      public var dps:Number = 500;
      
      public var skill:Array = [11,12,10];
      
      public var arms:Array = ["soya_lv1"];
      
      public var sub:Array = ["highEnergy_lv2","cutter_lv4","positron_lv2","lightningBall_lv4","lightningBall_lv4","chipped_lv4","flyBlade_lv2","protonImpact_lv1"];
      
      public var car:String = "beetle";
      
      public function HighArena_ExtraData()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["lv","head","group","life","defence","dps","car"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.name = Game.sensitiveWords.encode(obj.name);
         this.skill = StringToDefine.copyArray(obj.skill);
         this.arms = StringToDefine.copyArray(obj.arms);
         this.sub = StringToDefine.copyArray(obj.sub);
      }
      
      public function copy() : Object
      {
         var d0:HighArena_ExtraData = new HighArena_ExtraData();
         d0.inData_byObj(this);
         return d0;
      }
   }
}

