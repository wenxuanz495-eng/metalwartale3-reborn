package enemy.striker
{
   import enemy.AI.Enemy_AI;
   
   public class Striker_AI extends Enemy_AI
   {
      
      public function Striker_AI(_baba:*)
      {
         super(_baba);
      }
      
      override public function stopAttack() : *
      {
         if(Boolean(baba.img.shootB))
         {
            baba.img.goPlayLoop("stand");
         }
         state = "noing";
         ClearAllFun();
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      override protected function attackOrder() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.3;
         if(ran <= bilv)
         {
            baba.img.goOnce_ToLoop("shoot_1","stand");
         }
         else if(ran <= bilv * 2)
         {
            baba.img.goOnce_ToLoop("shoot_2","stand");
         }
         else
         {
            baba.img.goOnce_ToLoop("shoot_3","stand");
         }
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         if(!baba.extraSkill.enabled)
         {
            if(ran < 0.5)
            {
               baba.mot.vxmax_Fi = (baba.define.vx + 200) / 30;
            }
            else
            {
               baba.mot.vxmax_Fi = baba.define.vx / 30;
            }
         }
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
   }
}

