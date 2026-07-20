package body.bullet
{
   import body.attack.ArmsAttack;
   import body.define.OneArmsDefine;
   import flash.geom.Point;
   
   public class SpecialAttack
   {
      
      public function SpecialAttack()
      {
         super();
      }
      
      public static function Skill_Laser(baba:*, x0:Number, y0:Number) : *
      {
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine("Skill_Laser",1,"enemyArms");
         var ra0:Number = 0;
         var x1:int = x0;
         var y1:int = y0;
         for(var n:int = 0; n < 4; n++)
         {
            x1 = x0 + d0.shootPoint.y * Math.cos(ra0);
            y1 = y0 + d0.shootPoint.y * Math.sin(ra0);
            ArmsAttack.shoot(d0,baba,new Point(x1,y1),ra0,-1000);
            ra0 += Math.PI / 2;
         }
      }
      
      public static function Knowing_LightingBall(baba:*, x0:Number, y0:Number) : *
      {
         var d0:OneArmsDefine = null;
         if(baba.define.id == "heianxianzhi")
         {
            d0 = Game.defineGroup.getArmsDefine("heianxianzhi",2,"enemyArms");
         }
         else
         {
            d0 = Game.defineGroup.getArmsDefine("Knowing",2,"enemyArms");
         }
         ArmsAttack.shoot(d0,baba,new Point(x0,y0),-Math.PI / 2);
      }
      
      public static function DarkTemplar_Slay(baba:*, x0:Number, y0:Number) : *
      {
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine("DarkTemplar",1,"enemyArms");
         ArmsAttack.shoot(d0,baba,new Point(x0,y0),-Math.PI / 2);
      }
      
      public static function Clear_Energy() : *
      {
         Game.gameData.armsItems.clearAllArmsEnergy();
      }
      
      public static function Reduce_Missile() : *
      {
         Game.BG.hero.mot.setReduceMul(0.5,5);
      }
      
      public static function Stop_Missile() : *
      {
         Game.BG.hero.mot.setReduceMul(0,4);
      }
      
      public static function Stop_Laser() : *
      {
         Game.BG.hero.mot.setReduceMul(0,2);
      }
      
      public static function Slow_Effect(_mul0:Number, _time0:Number) : *
      {
         Game.BG.hero.mot.setReduceMul(_mul0,_time0);
      }
      
      public static function UnableAttack_Missile() : *
      {
         Game.BG.hero.setNoAttack(5);
         trace("死机！死机！死机！死机！死机！");
      }
      
      public static function Chipped_Baby(baba:*, x0:Number, y0:Number, hurt0:int) : *
      {
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine("Chipped_Baby",0,"arms");
         d0.hurtArr = [hurt0 / 6];
         d0.baseHurt = hurt0 / 6;
         var ra0:Number = 0;
         var x1:int = x0;
         var y1:int = y0;
         ArmsAttack.shoot(d0,baba,new Point(x1,y1),ra0,-1000);
      }
      
      public static function Proton_Impact(baba:*, x0:Number, y0:Number, hurt0:int) : *
      {
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine("protonImpact_boom",0,"sub");
         d0.hurtArr = [hurt0];
         d0.baseHurt = hurt0;
         var ra0:Number = 0;
         var x1:int = x0;
         var y1:int = y0;
         ArmsAttack.shoot(d0,baba,new Point(x1,y1),ra0,-1000);
      }
      
      public static function Sula_Laser(bu0:OneBulletBody) : *
      {
         trace("------------------------执行：Sula_Laser");
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine("Sula_Laser",0);
         d0.hurtArr = [bu0.hurt];
         d0.hurt_0_B = bu0.hurt_0_B;
         d0.baseHurt = bu0.hurt;
         ArmsAttack.shoot(d0,bu0.attackBody,new Point(bu0.mot.x0,bu0.mot.y0),d0.bulletAngle / 180 * Math.PI);
      }
   }
}

