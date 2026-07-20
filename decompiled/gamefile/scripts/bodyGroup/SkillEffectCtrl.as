package bodyGroup
{
   import flash.geom.Rectangle;
   
   public class SkillEffectCtrl
   {
      
      public function SkillEffectCtrl()
      {
         super();
      }
      
      public function fullLighting(hurt0:Number) : *
      {
         var n:* = undefined;
         var b0:* = undefined;
         var trueHurt0:Number = NaN;
         var rect0:Rectangle = Game.oneScene.viewRangeRect2;
         var arr0:Array = Game.BG.getHurtEnemy_byRect(rect0);
         for(n in arr0)
         {
            b0 = arr0[n];
            Game.EG.addEffect("heroFly","lighting",Game.gameSprite.effectL,b0.MX,b0.MY,0,true);
            trueHurt0 = Game.gameData.getAllDps() * hurt0 / Game.gameData.getAllArmsAdd();
            if(b0.type != "boss")
            {
               if(b0.type == "soldier")
               {
               }
            }
            Game.eventGroup.hurt(b0,trueHurt0,"mixed",null,Game.BG.hero,b0.MX,b0.MY,false);
         }
         if(arr0.length > 0)
         {
            Game.SG.playSound("lighting_sound");
            Game.SG.playSound("lighting_sound");
            Game.SG.playSound("lighting_sound");
            Game.SG.playSound("lighting_sound");
         }
      }
   }
}

