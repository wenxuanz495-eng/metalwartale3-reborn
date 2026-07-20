package enemy.spiderFort
{
   import enemy.AI.Enemy_AI;
   
   public class SpiderFort_AI extends Enemy_AI
   {
      
      public function SpiderFort_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         baba.img.goPlayLoop("move");
         super.attackOver();
      }
      
      override protected function attackOrder() : *
      {
         var x0:Number = Number(baba.mot.x0);
         var y0:Number = Number(baba.mot.y0);
         var ra0:Number = Math.atan2(attackY - y0,attackX - x0) * 180 / Math.PI;
         if(ra0 < -30 && ra0 > -60 || ra0 < -120 && ra0 > -150)
         {
            baba.armsDefine.inData("SpiderFort_1",1);
         }
         else if(ra0 <= -60 && ra0 >= -120)
         {
            baba.armsDefine.inData("SpiderFort_1",2);
         }
         else
         {
            baba.armsDefine.inData("SpiderFort_1",0);
         }
         baba.attack.startAttackOnce_break();
      }
      
      override protected function reachTarget() : *
      {
         this.followFilp();
         baba.mot.toTargetB = false;
      }
      
      override protected function followFilp() : *
      {
         if(baba.mot.x0 < attackX)
         {
            baba.mot.moveToRight();
            baba.img.flipToLeft();
         }
         else
         {
            baba.mot.moveToLeft();
            baba.img.flipToRight();
         }
      }
      
      override public function stopAttack() : *
      {
         this.attackOver();
         targetBody = null;
         state = "no";
         this.ClearAllFun();
      }
   }
}

