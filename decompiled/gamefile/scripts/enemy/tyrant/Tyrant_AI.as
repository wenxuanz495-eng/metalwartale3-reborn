package enemy.tyrant
{
   import enemy.AI.Enemy_AI;
   
   public class Tyrant_AI extends Enemy_AI
   {
      
      public function Tyrant_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = Math.random();
         var bilv:Number = 0.4;
         if(ran <= bilv)
         {
            baba.armsDefine.inData("Tyrant",0);
         }
         else
         {
            baba.armsDefine.inData("Tyrant",1);
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
         if(baba.armsDefine.id == "Tyrant" && baba.armsDefine.level == 0)
         {
            if(baba.attack.state == "shoot")
            {
               Game.oneScene.shake.startShake(10,0.3,0,-25,25,0,"random");
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

