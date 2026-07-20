package enemy.AI
{
   import body.attack.ArmsAttack;
   import body.define.OneArmsDefine;
   import data.Maths;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.Strong;
   
   public class EnemySkillDefine
   {
      
      public var enabled:Boolean = true;
      
      public var maxCD:int = 100;
      
      public var nowCD:int = 0;
      
      public var label:String = "";
      
      public var baba:*;
      
      public var plasma_mc:MovieClip;
      
      public var pBilv:Number = 1;
      
      public var mulHurt:Number = 0;
      
      public function EnemySkillDefine(_baba:*)
      {
         super();
         this.baba = _baba;
         var rect0:Rectangle = this.baba.define.hitRect;
         var sc0:Number = 1;
         if(rect0.width > rect0.height)
         {
            sc0 = rect0.width / 80;
         }
         else
         {
            sc0 = rect0.height / 80;
         }
         this.pBilv = sc0;
      }
      
      public static function shootBullet(b0:*, armsLabel:String, _point:Point = null) : *
      {
         var rightB:Boolean = Boolean(b0.img.rightB);
         var x0:int = int(b0.img.x);
         var y0:int = int(b0.img.y);
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine(armsLabel,0,"enemyArms");
         x0 += d0.shootPoint.x;
         y0 += d0.shootPoint.y;
         if(_point is Point)
         {
            x0 = _point.x;
            y0 = _point.y;
         }
         var ra0:Number = d0.bulletAngle * Math.PI / 180;
         if(rightB)
         {
            ra0 = Maths.flipRa_Y(ra0);
         }
         ArmsAttack.shoot(d0,b0,new Point(x0,y0),ra0,-1000);
      }
      
      public function closeSkill() : *
      {
         this.enabled = false;
      }
      
      public function openSkill() : *
      {
         this.enabled = true;
      }
      
      public function happen() : *
      {
         if(this.nowCD >= this.maxCD)
         {
            this.nowCD = this.maxCD / 3 * (1 - Math.random() * 2);
            this[this.label]();
            if(this.label == "Plasma" || this.label == "BackPlasma")
            {
               if(Boolean(this.baba.ai.plasmaB))
               {
                  this.nowCD = this.maxCD / 3 * 2;
               }
               else
               {
                  this.nowCD = 0;
               }
            }
         }
         else
         {
            ++this.nowCD;
         }
      }
      
      public function Skill_Drop() : *
      {
         this.shoot("Skill_Drop");
      }
      
      public function Skill_Drop2() : *
      {
         this.shoot("Skill_Drop2");
      }
      
      public function Skill_Follow() : *
      {
         this.shoot("Skill_Follow");
      }
      
      public function Skill_Curve() : *
      {
         this.shoot("Skill_Curve");
      }
      
      public function Energy_Boom() : *
      {
         this.shoot("Energy_Boom");
      }
      
      public function Mines_Boom() : *
      {
         this.shoot("Mines_Boom");
      }
      
      public function Mines_Boom_2() : *
      {
         this.shoot("Mines_Boom_2");
      }
      
      public function Life_Reply() : *
      {
         this.baba.define.addLifePer(0.01);
      }
      
      public function Reduce_Missile() : *
      {
         this.shoot("Reduce_Missile");
      }
      
      public function UnableAttack_Missile() : *
      {
         this.shoot("UnableAttack_Missile");
      }
      
      public function Skill_Laser() : *
      {
         this.shoot2("Skill_Laser");
      }
      
      public function Skill_Laser2() : *
      {
         this.shoot_pointHero("Skill_Laser2");
      }
      
      public function Fiexd_Mines() : *
      {
         var x0:int = Game.BG.hero.img.x;
         var y0:int = Game.BGHit.getMinY(x0);
         this.shoot("Fiexd_Mines",new Point(x0,y0));
      }
      
      public function Forever_Lighting() : *
      {
         this.shoot2("Forever_Lighting");
      }
      
      public function Clear_Energy() : *
      {
      }
      
      public function EMP_5() : *
      {
      }
      
      public function Slow_Missile() : *
      {
         this.nowCD = 0;
         this.maxCD -= 30;
         if(this.maxCD < 3 * 30)
         {
            this.maxCD = 3 * 30;
         }
         this.shoot("Slow_Missile");
      }
      
      public function Strong_Life() : *
      {
         this.baba.define.mulLife(1.5);
      }
      
      public function Strong_Hurt() : *
      {
         this.baba.define.hurt_0 *= 1.5;
      }
      
      public function shoot2(armsLabel:String) : *
      {
         var x0:int = int(this.baba.MX);
         var y0:int = int(this.baba.MY);
         var d0:OneArmsDefine = Game.defineGroup.getArmsDefine(armsLabel,0,"enemyArms");
         d0.mulHurt = this.mulHurt;
         var ra0:Number = 0;
         var x1:int = x0;
         var y1:int = y0;
         if(this.baba.mot.type == "land")
         {
            ra0 = Math.PI / 2 * 3;
            y1 -= d0.shootPoint.y;
         }
         else
         {
            ra0 = Math.PI / 2;
            y1 += d0.shootPoint.y;
         }
         var mb0:* = this.baba.ai.targetBody;
         if(Boolean(mb0))
         {
            ra0 = Math.atan2(mb0.mot.y0 - y0,mb0.mot.x0 - x0);
         }
         return ArmsAttack.shoot(d0,this.baba,new Point(x1,y1),ra0,-1000);
      }
      
      public function shoot_pointHero(armsLabel:String) : *
      {
         var x0:int = 0;
         var y0:int = 0;
         var d0:OneArmsDefine = null;
         var ra0:Number = NaN;
         var x1:int = 0;
         var y1:int = 0;
         var b0:* = this.baba.ai.targetBody;
         if(b0 != null)
         {
            x0 = int(this.baba.MX);
            y0 = int(this.baba.MY);
            d0 = Game.defineGroup.getArmsDefine(armsLabel,0,"enemyArms");
            d0.mulHurt = this.mulHurt;
            ra0 = Math.atan2(b0.MY - y0,b0.MX - x0);
            x1 = x0 + d0.shootPoint.x;
            y1 = y0 + d0.shootPoint.y;
            return ArmsAttack.shoot(d0,this.baba,new Point(x1,y1),ra0,-1000);
         }
         return null;
      }
      
      public function shoot(armsLabel:String, _point:Point = null) : *
      {
         var x0:int = 0;
         var y0:int = 0;
         var d0:OneArmsDefine = null;
         var ra0:Number = NaN;
         var b0:* = this.baba.ai.targetBody;
         var rightB:Boolean = Boolean(this.baba.img.rightB);
         if(b0 != null)
         {
            x0 = int(this.baba.img.x);
            y0 = int(this.baba.img.y);
            d0 = Game.defineGroup.getArmsDefine(armsLabel,0,"enemyArms");
            d0.mulHurt = this.mulHurt;
            x0 += d0.shootPoint.x;
            y0 += d0.shootPoint.y;
            if(_point is Point)
            {
               x0 = _point.x;
               y0 = _point.y;
            }
            ra0 = d0.bulletAngle * Math.PI / 180;
            if(rightB)
            {
               ra0 = Maths.flipRa_Y(ra0);
            }
            ArmsAttack.shoot(d0,this.baba,new Point(x0,y0),ra0,-1000);
         }
      }
      
      public function Plasma() : *
      {
         if(this.plasma_mc == null)
         {
            this.baba.hitHurtB = 1;
            this.plasma_mc = Game.swfLoaderManager.getResource("parts","enemy_plasma");
            this.plasma_mc.play();
            Game.gameSprite.effectL.addChild(this.plasma_mc);
            this.showPlasma();
         }
         else if(this.plasma_mc.visible)
         {
            this.hidePlasma();
         }
         else
         {
            this.showPlasma();
         }
      }
      
      public function BackPlasma() : *
      {
         if(this.plasma_mc == null)
         {
            this.baba.ai.skill.hurtBack = 0;
            this.plasma_mc = Game.swfLoaderManager.getResource("parts","enemy_plasma");
            this.plasma_mc.play();
            Game.gameSprite.effectL.addChild(this.plasma_mc);
            this.showPlasma(false,false);
            this.baba.ai.skill.hurtBack = 0.1;
         }
         else if(this.plasma_mc.visible)
         {
            this.hidePlasma();
            this.baba.ai.skill.hurtBack = 0;
         }
         else
         {
            this.showPlasma(false,false);
            this.baba.ai.skill.hurtBack = 0.1;
         }
      }
      
      public function clearPlasma() : *
      {
         if(this.plasma_mc != null)
         {
            if(this.plasma_mc.parent != null)
            {
               this.plasma_mc.parent.removeChild(this.plasma_mc);
            }
            this.plasma_mc = null;
         }
      }
      
      public function showPlasma(noHurtB:Boolean = true, aiPlasmaB:Boolean = true) : *
      {
         trace("开启护盾");
         if(noHurtB)
         {
            this.baba.hitHurtB = 1;
         }
         if(aiPlasmaB)
         {
            this.baba.ai.plasmaB = true;
         }
         this.plasma_mc.visible = true;
         var sc0:Number = this.pBilv * 0.4;
         this.plasma_mc.scaleX = sc0;
         this.plasma_mc.scaleY = sc0;
         TweenLite.to(this.plasma_mc,0.3,{
            "scaleX":this.pBilv,
            "scaleY":this.pBilv,
            "ease":Strong.easeOut
         });
      }
      
      public function hidePlasma() : *
      {
         trace("关闭护盾");
         this.baba.hitHurtB = 0;
         this.baba.ai.plasmaB = false;
         var sc0:Number = this.pBilv * 0.4;
         this.plasma_mc.scaleX = this.pBilv;
         this.plasma_mc.scaleY = this.pBilv;
         TweenLite.to(this.plasma_mc,0.3,{
            "scaleX":sc0,
            "scaleY":sc0,
            "ease":Strong.easeIn,
            "visible":false
         });
      }
   }
}

