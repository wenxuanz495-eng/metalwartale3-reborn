package enemy.satellite
{
   import enemy.AI.Enemy_AI;
   
   public class Satellite_AI extends Enemy_AI
   {
      
      public function Satellite_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function attackOrder() : *
      {
         baba.img.goOnce_ToLoop("shoot","fly");
         var b0:SmallSatelliteBody = Game.BG.addSmallSatellite();
         b0.x = baba.img.x;
         b0.y = baba.img.y;
         b0.setLevel(baba.define.level);
         var mx0:int = baba.img.x + Math.random() * 80 - 40;
         var my0:int = baba.img.y + 70;
         b0.mot.followPoint(mx0,my0);
         Game.BG.addLifeBar(b0);
      }
      
      override protected function getAttackEndB() : Boolean
      {
         return baba.img.endFrameB;
      }
   }
}

