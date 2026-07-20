package enemy.mammoth
{
   import enemy._normal.Normal_Land_AI;
   
   public class Mammoth_AI extends Normal_Land_AI
   {
      
      public var skill_t:Number = 0;
      
      public var skill_list:Array = [1,1,2,1,0,0];
      
      public var nowIndex:int = 0;
      
      public function Mammoth_AI(_baba:*)
      {
         super(_baba);
      }
      
      override public function attackAI() : *
      {
         super.attackAI();
         if(this.skill_t > 60)
         {
            this.skill_t = 0;
            baba.define.hurt_0 *= 1.1;
         }
         else
         {
            this.skill_t += 1 / 30;
         }
      }
      
      override protected function attackOver() : *
      {
         this.nowIndex = (this.nowIndex + 1) % this.skill_list.length;
         var index0:int = int(this.skill_list[this.nowIndex]);
         baba.armsDefine.inData(armsName,index0);
         baba.img.goPlayLoop("stand");
         randomValue = Math.random();
         randomValue2 = Math.random();
      }
      
      override public function acceptHurt(value0:Number, attackType:String, defenceType:String) : Number
      {
         if(attackType == "energy")
         {
            return 0;
         }
         return value0;
      }
   }
}

