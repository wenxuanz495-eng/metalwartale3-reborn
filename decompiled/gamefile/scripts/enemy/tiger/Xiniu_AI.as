package enemy.tiger
{
   import enemy._normal.Normal_Land_AI;
   
   public class Xiniu_AI extends Normal_Land_AI
   {
      
      public function Xiniu_AI(_baba:*)
      {
         super(_baba);
      }
      
      override public function attackAI() : *
      {
         super.attackAI();
         var l0:String = baba.img.nowLabel;
         var f0:int = int(baba.img.nowMC.currentFrame);
         if(l0 == "shoot1" && f0 >= 1 && f0 <= 13)
         {
            if(baba.img.scaleX > 0)
            {
               baba.mot.eVx = baba.mot.vxmax;
            }
            else
            {
               baba.mot.eVx = -baba.mot.vxmax;
            }
         }
         else
         {
            baba.mot.eVx = 0;
         }
      }
   }
}

