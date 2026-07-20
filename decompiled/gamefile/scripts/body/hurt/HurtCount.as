package body.hurt
{
   import gameAll.data.ArmsItemsData;
   
   public class HurtCount
   {
      
      public static var type:Array = ["mixed","motion","energy","boom"];
      
      public static var defenceCn:Array = ["混合装甲","爆炸反应装甲","复合装甲","电磁干扰装甲"];
      
      public static var attackCn:Array = ["混合","动能","束能","爆炸"];
      
      public static var rate:Array = [[1,1,1,1],[1,1,0.75,1.5],[1,1.5,1,0.75],[1,0.75,1.5,1]];
      
      public static var defence_type:Array = ["mixed","motion","energy","boom"];
      
      public function HurtCount()
      {
         super();
      }
      
      public static function getHurt(value:Number, attack:String, defence:String) : Number
      {
         var in1:int = getIndex(attack);
         var in2:int = getIndex(defence);
         var r0:Number = Number(rate[in1][in2]);
         return value * r0;
      }
      
      public static function getDefenceCn(str0:String) : String
      {
         var f0:int = type.indexOf(str0);
         if(f0 == -1)
         {
            f0 = 0;
         }
         return defenceCn[f0];
      }
      
      public static function getAttackCn(str0:String) : String
      {
         var f0:int = type.indexOf(str0);
         if(f0 == -1)
         {
            f0 = 0;
         }
         return attackCn[f0];
      }
      
      public static function getDefenceLabel(str0:String) : String
      {
         var f0:int = defence_type.indexOf(str0);
         if(f0 == -1)
         {
            f0 = 0;
         }
         return type[f0];
      }
      
      public static function getCritHurt(itemsData:ArmsItemsData, hurt0:Number) : Number
      {
         var crit_pro:Number = itemsData.getCrit_pro();
         var crit_mul:Number = itemsData.getCrit_mul();
         var random:Number = Math.random();
         if(random <= crit_pro)
         {
            return hurt0 * crit_mul;
         }
         return 0;
      }
      
      public static function getIndex(str:String) : int
      {
         var n:* = undefined;
         for(n in type)
         {
            if(type[n] == str)
            {
               return n;
            }
         }
         return 0;
      }
   }
}

