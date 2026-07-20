package body.bullet
{
   import body.hero.HeroCarAAHD;
   import body.image.SingleMovieclip;
   import flash.geom.Point;
   
   public class OneBulletBody extends BulletBody
   {
      
      public var img:SingleMovieclip;
      
      public var mot:OneBulletMotion = new OneBulletMotion();
      
      public var nowBounceNum:int = 0;
      
      public var bulletVra:Number = 0;
      
      private var nowVra:Number = 0;
      
      public var floorBounce:Number = 0;
      
      private var scale_t:int = 0;
      
      private var lightning_t:int = 0;
      
      private var first_v:Number = 0;
      
      public function OneBulletBody()
      {
         super();
      }
      
      override public function init(img0:SingleMovieclip, x0:Number, y0:Number, v0:Number, ra:Number, vmax:Number, va:Number) : *
      {
         this.img = img0;
         this.first_v = v0;
         this.mot.setInit(x0,y0,v0,ra,vmax,va);
         if(this.bulletVra !== -1000)
         {
            this.img.mc.rotation = ra * 180 / Math.PI;
         }
         this.x = x0;
         this.y = y0;
         live_t = 0;
         this.img.play();
      }
      
      public function set followB(value:Number) : *
      {
         this.mot.followVra = value;
      }
      
      public function get followB() : Number
      {
         return this.mot.followVra;
      }
      
      public function set gravity(value:Number) : *
      {
         this.mot.gravity = value;
      }
      
      public function set x(value:Number) : *
      {
         this.mot.x0 = value;
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         this.mot.y0 = value;
         this.img.y = int(value);
      }
      
      public function get ra() : Number
      {
         return this.mot.ra;
      }
      
      public function doEffect(_selfDie:Boolean = false) : *
      {
         var sarr0:Array = null;
         if(specialType == "")
         {
            return;
         }
         if(specialType == "Skill_Laser")
         {
            SpecialAttack.Skill_Laser(attackBody,this.mot.x0,this.mot.y0);
         }
         else if(specialType == "Knowing_LightingBall")
         {
            SpecialAttack.Knowing_LightingBall(attackBody,this.mot.x0,this.mot.y0);
         }
         else if(specialType == "DarkTemplar_Slay")
         {
            SpecialAttack.DarkTemplar_Slay(attackBody,this.mot.x0,this.mot.y0);
         }
         else if(specialType == "Clear_Energy")
         {
            if(!_selfDie)
            {
               SpecialAttack.Clear_Energy();
            }
         }
         else if(specialType == "Reduce_Missile")
         {
            if(!_selfDie)
            {
               SpecialAttack.Reduce_Missile();
            }
         }
         else if(specialType == "Sula_Laser")
         {
            SpecialAttack.Sula_Laser(this);
         }
         else if(specialType == "Stop_Missile")
         {
            if(!_selfDie)
            {
               SpecialAttack.Stop_Missile();
            }
         }
         else if(specialType == "Stop_Laser")
         {
            if(!_selfDie)
            {
               SpecialAttack.Stop_Laser();
            }
         }
         else if(specialType == "UnableAttack_Missile")
         {
            if(!_selfDie)
            {
               SpecialAttack.UnableAttack_Missile();
            }
         }
         else if(specialType == "Chipped_Baby")
         {
            SpecialAttack.Chipped_Baby(attackBody,this.mot.x0,this.mot.y0,hurt);
         }
         else if(specialType == "Proton_Impact")
         {
            SpecialAttack.Proton_Impact(attackBody,this.mot.x0,this.mot.y0,hurt);
         }
         else if(specialType.indexOf("Slow_Effect") >= 0)
         {
            sarr0 = specialType.split(",");
            SpecialAttack.Slow_Effect(Number(sarr0[1]),Number(sarr0[2]));
         }
      }
      
      override public function toDie(_selfDie:Boolean = false) : *
      {
         this.doEffect(_selfDie);
         super.toDie(_selfDie);
      }
      
      private function followTarget() : *
      {
         if(targetBody != null)
         {
            if(followDelay >= 1000)
            {
               if(Math.abs(this.mot.v0) < 5)
               {
                  this.mot.a0 = 4;
                  this.mot.ra = Math.atan2(targetBody.MY - this.mot.y0,targetBody.MX - this.mot.x0);
               }
            }
            if(live_t >= followDelay && live_t < followMaxTime)
            {
               if(targetBody.hitHurtB == 0)
               {
                  this.mot.startFollow(targetBody.MX,targetBody.MY);
                  if(specialType == "FollowMaxV")
                  {
                     this.mot.vmax = this.first_v * 2;
                     this.mot.a0 = 2;
                  }
               }
               else
               {
                  targetBody = null;
                  this.mot.stopFollow();
               }
            }
            else
            {
               this.mot.stopFollow();
            }
         }
      }
      
      public function follow(b0:*) : *
      {
         if(targetBody == null)
         {
            targetBody = b0;
         }
      }
      
      public function followAttackBody() : *
      {
         if(targetBody != attackBody)
         {
            targetBody = attackBody;
            this.mot.vraMax *= 2;
            this.followB = 1;
         }
      }
      
      public function lightningTimer() : *
      {
         var b0:* = undefined;
         if(this.lightning_t > lightning)
         {
            this.lightning_t = 0;
            b0 = Game.BG.getRandom_Gap(attackBody.camp,this.mot.x0,this.mot.y0,1000);
            if(b0 != null)
            {
               if(b0.AAHD is HeroCarAAHD)
               {
                  if(Boolean(b0.getPlasmaB()) || Boolean(b0.getSpeedUpB()))
                  {
                     return;
                  }
               }
               hurt_0_B = !specialType == "Forever_Lighting";
               ++penetrationNum;
               Game.eventGroup.hurt(b0,hurt,attackType,itemsData,attackBody,b0.MX,b0.MY,hurt_0_B,false,"bullet",this);
               Game.EG.lightning.Show(new Point(this.mot.x0,this.mot.y0),new Point(b0.MX,b0.MY),Math.random() * 10);
               Game.SG.playSound("lightningBall_lightning");
            }
         }
         else
         {
            ++this.lightning_t;
         }
      }
      
      override public function bodyTimer() : *
      {
         var ss0:Number = NaN;
         diePan();
         this.followTarget();
         this.mot.motionTimer();
         if(this.bulletVra !== -1000)
         {
            this.nowVra += this.bulletVra;
            this.img.mc.rotation = this.mot.ra * 180 / Math.PI + this.nowVra;
         }
         this.img.x = int(this.mot.x0);
         this.img.y = int(this.mot.y0);
         if(scale > 0)
         {
            ++this.scale_t;
            ss0 = 1 - (Math.cos(this.scale_t) + 1) / 4 * scale;
            this.img.mc.scaleX = ss0;
            this.img.mc.scaleY = ss0;
            width = width2 * ss0;
         }
         if(lightning > 0)
         {
            this.lightningTimer();
         }
      }
   }
}

