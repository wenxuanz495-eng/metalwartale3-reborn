package body.attack
{
   import body.bullet.BulletLink;
   import body.define.OneArmsDefine;
   import body.hero.HeroCarBody;
   import bodyGroup.BodyGroup;
   import data.INIT;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class ArmsAttack extends EventDispatcher
   {
      
      private var BG:BodyGroup;
      
      public var baba:*;
      
      public var AAHD:*;
      
      private var define:*;
      
      private var now_t:Number = 0;
      
      private var shootNum:int = 0;

      // 火神炮原始状态机每 4 个游戏帧完成一次实际发射，约为 7.5 发/秒。
      // 独立累积器只改变实际发射频率，不改 shootNum、子弹数量或面板数据。
      private static const FIRE_FAIRY_BASE_PERIOD_FRAMES:Number = 4;
      private var fireFairyFrameAccumulator:Number = 0;
      
      public var state:String = "stoping";
      
      public var loopB:Boolean = false;
      
      private var preinputB:Boolean = false;
      
      public var enabled:Boolean = true;
      
      public function ArmsAttack(in_baba:*, _AAHD:*, in_define:*)
      {
         super();
         this.baba = in_baba;
         this.define = in_define;
         this.AAHD = _AAHD;
      }
      
      public static function shoot(d:OneArmsDefine, attackBody:*, shootPoint:Point, shootRa:Number, bulletAngle:Number = -1000, tran1:Number = -1000, _shootNum:int = 1) : *
      {
         var attackEvent:AttackEvent = null;
         var p0:Point = null;
         var bu0:* = undefined;
         var tran0:Number = NaN;
         var ra0:Number = NaN;
         var ran0:Number = NaN;
         var btlen:Number = NaN;
         var btlen2:Number = NaN;
         for(var n:int = 0; n <= d.bulletNum - 1; n++)
         {
            attackEvent = new AttackEvent();
            p0 = shootPoint;
            if(d.secondBulletImg != "")
            {
               if(d.id == "charged")
               {
                  ran0 = Math.random();
                  if(ran0 > 0.6)
                  {
                     bu0 = BulletLink.getBulletByDefine(d);
                  }
                  else
                  {
                     bu0 = BulletLink.getBulletByDefine(d,d.secondBulletImg);
                  }
               }
               else if(_shootNum % 2 == 0)
               {
                  bu0 = BulletLink.getBulletByDefine(d,d.secondBulletImg);
               }
               else if(n == 1)
               {
                  bu0 = BulletLink.getBulletByDefine(d,d.secondBulletImg);
               }
               else
               {
                  bu0 = BulletLink.getBulletByDefine(d);
               }
            }
            else
            {
               bu0 = BulletLink.getBulletByDefine(d);
            }
            bu0.attackBody = attackBody;
            if(d.specialType == "Knowing_LightingBall")
            {
               attackEvent.x0 = Game.BG.hero.img.x;
               attackEvent.y0 = Game.BGHit.getMinY(attackEvent.x0);
            }
            else
            {
               attackEvent.x0 = p0.x;
               attackEvent.y0 = p0.y;
            }
            attackEvent.v0 = d.bulletSpeed;
            attackEvent.vmax = d.bulletMaxV;
            attackEvent.va = d.bulletMaxVa;
            tran0 = d.bulletTranslation;
            if(tran1 != -1000)
            {
               tran0 = tran1;
            }
            ra0 = shootRa;
            if(d.bulletNum == 1)
            {
               attackEvent.ra = ra0 + (Math.random() * d.angleRange - d.angleRange / 2) / 180 * Math.PI;
               attackEvent.x0 += Math.cos(ra0 + Math.PI / 2) * tran0;
               attackEvent.y0 += Math.sin(ra0 + Math.PI / 2) * tran0;
            }
            else
            {
               btlen = Math.abs(tran0) * 2;
               attackEvent.ra = ra0 + (d.angleRange / (d.bulletNum - 1) * n - d.angleRange / 2) / 180 * Math.PI;
               btlen2 = btlen / (d.bulletNum - 1) * n - btlen / 2;
               attackEvent.x0 += Math.cos(ra0 + Math.PI / 2) * btlen2;
               attackEvent.y0 += Math.sin(ra0 + Math.PI / 2) * btlen2;
            }
            attackEvent.attackBody = attackBody;
            attackEvent.bullet = bu0;
            Game.BG.shootEvent(attackEvent);
         }
         if(Boolean(attackBody))
         {
            attackBody.shake.startShake(1.5,0.2,attackEvent.ra - Math.PI,0,d.recoilValue);
         }
         return bu0;
      }
      
      public function startAttack() : *
      {
         var d:OneArmsDefine = this.define;
         if(this.enabled)
         {
            if(this.state == "stoping" || this.state == "stop")
            {
               this.state = "start";
            }
            else if(this.state == "overing")
            {
               if(d.attackGap - this.now_t < 0.5)
               {
                  this.preinputB = true;
               }
            }
            this.loopB = true;
         }
      }
      
      public function startLoop() : *
      {
         if(this.enabled)
         {
            this.loopB = true;
         }
      }
      
      public function startAttackOnce() : *
      {
         if(this.enabled)
         {
            if(this.state == "stoping")
            {
               this.state = "start";
            }
            this.loopB = false;
         }
      }
      
      public function startAttackOnce_break() : *
      {
         if(this.enabled)
         {
            this.state = "start";
            this.loopB = false;
         }
      }
      
      public function stopAttack() : *
      {
         this.now_t = 0;
         this.state = "stoping";
         this.shootNum = 0;
         this.fireFairyFrameAccumulator = 0;
         this.loopB = false;
         this.preinputB = false;
      }
      
      public function stopLoop() : *
      {
         this.loopB = false;
      }
      
      public function attackPan() : *
      {
         var d:OneArmsDefine = this.define;
         if((d.id == "fireFairy" && d.shootNum == 1 && this.baba is HeroCarBody) || this.state == "fireFairyLooping")
         {
            this.attackPanFireFairy(d);
            return;
         }
         var tran1:Number = NaN;
         var len0:int = 0;
         var oushu0:int = 0;
         var d2:OneArmsDefine = null;
         if(this.state != "stoping")
         {
            if(this.state == "start")
            {
               if(d.imgLoopTime == 0)
               {
                  this.AAHD.imgAttackOnce();
               }
               else
               {
                  this.AAHD.imgAttackLoop(d.imgLoopTime);
               }
               this.now_t = 0;
               this.shootNum = 0;
               if(d.attackDelay == 0 || d.attackGap == 0)
               {
                  this.state = "shoot";
               }
               else
               {
                  this.state = "delaying";
               }
            }
            else if(this.state == "delaying")
            {
               this.now_t += 1 / INIT.FPS;
               if(this.now_t >= d.attackDelay || this.now_t >= d.attackGap)
               {
                  this.state = "shoot";
               }
            }
            else if(this.state == "shoot")
            {
               ++this.shootNum;
               tran1 = -1000;
               len0 = int(d.tranArr.length);
               if(len0 > 0)
               {
                  oushu0 = (this.shootNum - 1) / len0 % 2;
                  if(oushu0 == 0)
                  {
                     tran1 = Number(d.tranArr[(this.shootNum - 1) % len0]);
                  }
                  else
                  {
                     tran1 = Number(d.tranArr[len0 - 1 - (this.shootNum - 1) % len0]);
                  }
               }
               if(d.bulletLink is BulletLink)
               {
                  if(this.shootNum == d.bulletLink.index)
                  {
                     d2 = d.bulletLink.getDefine();
                     d2.level = d.level;
                     this.shootNow(d2,tran1,this.shootNum);
                  }
                  else
                  {
                     this.shootNow(d,tran1,this.shootNum);
                  }
               }
               else
               {
                  this.shootNow(d,tran1,this.shootNum);
               }
               if(d.shootNum > 1)
               {
                  if(this.shootNum >= d.shootNum)
                  {
                     this.state = "overing";
                  }
                  else if(d.shootGap == 0)
                  {
                     this.state = "shoot";
                  }
                  else
                  {
                     this.state = "shootDelaying";
                  }
               }
               else
               {
                  this.state = "overing";
               }
            }
            else if(this.state == "shootDelaying")
            {
               this.now_t += 1 / INIT.FPS;
               if(this.now_t >= d.attackDelay + this.shootNum * d.shootGap)
               {
                  this.state = "shoot";
               }
            }
            else if(this.state == "overing")
            {
               if(this.now_t >= d.attackGap)
               {
                  this.state = "over";
               }
               this.now_t += 1 / INIT.FPS;
            }
            else if(this.state == "over")
            {
               if(this.loopB || this.preinputB)
               {
                  this.state = "start";
                  this.preinputB = false;
               }
               else
               {
                  this.state = "stop";
               }
            }
            else if(this.state == "stop")
            {
               this.state = "stoping";
               this.now_t = 0;
               this.shootNum = 0;
            }
         }
      }

      private function getFireFairyShootMultiplier(d:OneArmsDefine) : Number
      {
         if(d.level <= 0)
         {
            return 1;
         }
         if(d.level == 1)
         {
            return 2;
         }
         if(d.level == 2)
         {
            return 3;
         }
         return 3.5;
      }

      private function shootFireFairy(d:OneArmsDefine) : *
      {
         this.shootNum = 1;
         this.shootNow(d,-1000,this.shootNum);
      }

      private function attackPanFireFairy(d:OneArmsDefine) : *
      {
         if(this.state != "stoping")
         {
            if(this.state == "start")
            {
               if(d.imgLoopTime == 0)
               {
                  this.AAHD.imgAttackOnce();
               }
               else
               {
                  this.AAHD.imgAttackLoop(d.imgLoopTime);
               }
               this.now_t = 0;
               this.shootNum = 0;
               this.fireFairyFrameAccumulator = 0;
               if(d.attackDelay == 0 || d.attackGap == 0)
               {
                  this.state = "shoot";
               }
               else
               {
                  this.state = "delaying";
               }
            }
            else if(this.state == "delaying")
            {
               this.now_t += 1 / INIT.FPS;
               if(this.now_t >= d.attackDelay || this.now_t >= d.attackGap)
               {
                  this.state = "shoot";
               }
            }
            else if(this.state == "shoot")
            {
               this.shootFireFairy(d);
               this.fireFairyFrameAccumulator = 0;
               if(this.loopB)
               {
                  this.state = "fireFairyLooping";
               }
               else
               {
                  this.state = "overing";
               }
            }
            else if(this.state == "fireFairyLooping")
            {
               if(!this.loopB)
               {
                  this.state = "overing";
               }
               else
               {
                  this.fireFairyFrameAccumulator += this.getFireFairyShootMultiplier(d) / FIRE_FAIRY_BASE_PERIOD_FRAMES;
                  while(this.fireFairyFrameAccumulator >= 1)
                  {
                     this.fireFairyFrameAccumulator -= 1;
                     this.AAHD.imgAttackOnce();
                     this.shootFireFairy(d);
                  }
               }
            }
            else if(this.state == "overing")
            {
               if(this.now_t >= d.attackGap)
               {
                  this.state = "over";
               }
               this.now_t += 1 / INIT.FPS;
            }
            else if(this.state == "over")
            {
               if(this.loopB || this.preinputB)
               {
                  this.state = "start";
                  this.preinputB = false;
               }
               else
               {
                  this.state = "stop";
               }
            }
            else if(this.state == "stop")
            {
               this.state = "stoping";
               this.now_t = 0;
               this.shootNum = 0;
               this.fireFairyFrameAccumulator = 0;
            }
         }
      }
      
      private function shootNow(d:OneArmsDefine, tran1:Number = -1000, _shootNum:int = 1) : *
      {
         var p0:Point = this.AAHD.shootPoint;
         if(d.bulletType == "laser" && this.AAHD.hasOwnProperty("laserPoint") && this.AAHD.laserPoint is Point)
         {
            p0 = this.AAHD.laserPoint;
         }
         shoot(d,this.baba,p0,this.AAHD.shootRa,this.AAHD.bulletAngle,tran1,_shootNum);
      }
      
      public function attackTimer() : *
      {
         this.attackPan();
      }
   }
}

