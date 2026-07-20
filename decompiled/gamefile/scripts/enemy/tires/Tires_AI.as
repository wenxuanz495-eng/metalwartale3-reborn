package enemy.tires
{
   import enemy.AI.Enemy_AI;
   
   public class Tires_AI extends Enemy_AI
   {
      
      public function Tires_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.3;
         if(ran <= bilv)
         {
            baba.armsDefine.inData("Tires_1",1);
         }
         else if(ran <= bilv * 2)
         {
            baba.armsDefine.inData("Tires_2",0);
         }
         else
         {
            baba.armsDefine.inData("Tires_1",0);
         }
         baba.img.goPlayLoop("stand");
         super.attackOver();
      }
      
      override protected function reachTarget() : *
      {
         followFilp();
         baba.mot.stopFollow();
      }
      
      public function shootPan() : *
      {
         if(baba.armsDefine.id == "Tires_2")
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

