package enemy.tank
{
   import enemy.AI.Enemy_AI;
   
   public class Tank_AI extends Enemy_AI
   {
      
      public function Tank_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.3;
         if(ran <= bilv)
         {
            baba.armsDefine.inData("Tank_2",0);
         }
         else if(ran <= bilv * 2)
         {
            baba.armsDefine.inData("Tank_1",0);
         }
         else
         {
            baba.armsDefine.inData("Tank_3",0);
         }
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function followFilp() : *
      {
         if(baba.mot.x0 < attackX)
         {
            baba.img.flipToLeft();
            baba.img.goOnce_ToLoop("flip","stand");
         }
         else
         {
            baba.img.flipToRight();
            baba.img.goOnce_ToLoop("flip","stand");
         }
      }
      
      override protected function reachTarget() : *
      {
         this.followFilp();
         baba.mot.stopFollow();
      }
      
      public function shootPan() : *
      {
         if(baba.armsDefine.id == "Tank_3")
         {
            if(baba.attack.state == "shoot")
            {
               Game.oneScene.showScreenEffect();
               Game.oneScene.shake.startShake(20,1,-baba.AAHD.shootRa,-40,40,0,"random");
            }
         }
      }
      
      override public function aiTimer() : *
      {
         if(enabled)
         {
            this.shootPan();
            super.aiTimer();
         }
      }
   }
}

