package bodyGroup
{
   import body.attack.AttackHitData;
   import body.bullet.LaserBody;
   import body.bullet.OneBulletBody;
   import body.enemy.EnemyHeroBody;
   import body.hero.HeroCarBody;
   import body.hero.SubBody;
   import body.lieutenant.LieutenantBody;
   import data.Lines;
   import data.Maths;
   import effect.EffectGroup;
   import effect.EffectSMC;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import gameAll.EventGroup;
   import hit.HitIO;
   import image.GameSprite;
   
   public class BodyGroupHit
   {
      
      private var BG:BodyGroup;
      
      private var gameSprite:GameSprite;
      
      private var EG:EffectGroup;
      
      private var eventGroup:EventGroup;
      
      private var hitRectArr:Array;
      
      private var moveRectArr:Array;
      
      private var moveRectArr2:Array;
      
      public function BodyGroupHit()
      {
         super();
      }
      
      public function init() : *
      {
         this.BG = Game.BG;
         this.gameSprite = Game.gameSprite;
         this.EG = Game.EG;
         this.eventGroup = Game.eventGroup;
      }
      
      public function updataHitRect() : *
      {
         this.hitRectArr = Game.oneScene.hitRectArr;
         this.moveRectArr = Game.oneScene.moveRectArr;
         this.moveRectArr2 = Game.oneScene.moveRectArr2;
      }
      
      private function bodyHit_bodyArr(b0:*, arr0:Array) : *
      {
         var n:* = undefined;
         var rect0:Rectangle = null;
         for(n in arr0)
         {
            rect0 = arr0[n].hitRect;
            b0.mot.BDG.hitRectInData(b0.hitRect,rect0);
         }
      }
      
      private function bodyHit_GroundRect(b0:*, arr0:Array, clearBGD:Boolean = false, viewB:Boolean = false) : *
      {
         var mra0:Rectangle = null;
         var mra1:Rectangle = null;
         var n:* = undefined;
         var rect0:Rectangle = null;
         var mot0:* = b0.mot;
         if(clearBGD)
         {
            mot0.BDG.initData();
         }
         var hitB:Boolean = true;
         if(viewB)
         {
            if(!mot0.viewB)
            {
               mra0 = this.moveRectArr[0];
               mra1 = this.moveRectArr[1];
               if(mot0.x0 < mra0.right + 180 || mot0.x0 > mra1.x - 180)
               {
                  hitB = false;
               }
               else
               {
                  mot0.viewB = true;
                  trace("敌人进去区域，开始碰撞");
               }
            }
         }
         if(hitB)
         {
            for(n in arr0)
            {
               rect0 = arr0[n];
               b0.mot.BDG.hitRectInData(b0.hitRect,rect0);
            }
         }
      }
      
      private function arrHit_GroundRect(arr1:Array, arr0:Array, clearBGD:Boolean = false, viewB:Boolean = false) : *
      {
         var m:* = undefined;
         var b0:* = undefined;
         for(m in arr1)
         {
            b0 = arr1[m];
            this.bodyHit_GroundRect(b0,arr0,clearBGD,viewB);
         }
      }
      
      private function planesHit_GroundRect(arr1:Array, arr0:Array, clearBGD:Boolean = false, viewB:Boolean = false) : *
      {
         var m:* = undefined;
         var b0:* = undefined;
         for(m in arr1)
         {
            b0 = arr1[m];
            if(b0.mot.type == "land")
            {
               this.bodyHit_GroundRect(b0,arr0,clearBGD,viewB);
            }
         }
      }
      
      private function bulletHit_Ground(bu_arr:Array) : *
      {
         var m:* = undefined;
         var bullet0:* = undefined;
         var n:* = undefined;
         var rect0:Rectangle = null;
         var ra0:Number = NaN;
         var bb:Boolean = false;
         var arr0:Array = this.hitRectArr;
         for(m in bu_arr)
         {
            bullet0 = bu_arr[m];
            if(bullet0.bulletType == "bullet")
            {
               if(!(bullet0.attackBody is SubBody && bullet0.floorBounce == 0))
               {
                  if(bullet0.imgLabel != "sub/energy_boom_bullet")
                  {
                     if(bullet0.width >= 0)
                     {
                        for(n in arr0)
                        {
                           rect0 = arr0[n];
                           if(bullet0.floorBounce != 0)
                           {
                              ra0 = HitIO.hitRectPoint_ra(rect0,bullet0.mot.x0,bullet0.mot.y0);
                              if(ra0 !== -1000)
                              {
                                 bullet0.mot.bounce(ra0,bullet0.floorBounce);
                                 break;
                              }
                           }
                           else
                           {
                              bb = HitIO.hitRectPoint(rect0,bullet0.mot.x0,bullet0.mot.y0);
                              if(bb)
                              {
                                 this.EG.addEffect(bullet0.imgFather,bullet0.hitImgLabel,this.gameSprite.effectL,bullet0.mot.x0,bullet0.mot.y0,bullet0.ra);
                                 bullet0.toDie(true);
                                 break;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function bulletHit_body(bu_arr:Array, body_arr:Array, clearHitEnemyB:Boolean = false, isabsolute:Boolean = false) : *
      {
         var m:* = undefined;
         var bullet0:* = undefined;
         var nn0:* = undefined;
         var body_arr2:* = undefined;
         var n:* = undefined;
         var b0:* = undefined;
         var heroPlasmaB:Boolean = false;
         var heroSpeedB:Boolean = false;
         var penetrationB:Boolean = false;
         var plasmaP:Point = null;
         var hurtRectArr:Array = null;
         var bb:Boolean = false;
         var multPoint:int = 0;
         var ignorePlasmaB:Boolean = false;
         var i:int = 0;
         var nextMot:Point = null;
         var nextMot2:Point = null;
         var ra0:Number = NaN;
         var bu0:LaserBody = null;
         var p0:Point = null;
         var effectAddB3:Boolean = false;
         var esmc3:EffectSMC = null;
         var effect3:EffectSMC = null;
         var sb0:SubBody = null;
         var shootP0:Point = null;
         var obj10:Object = null;
         var p2:Point = null;
         var b10:* = undefined;
         var effectAddB:Boolean = false;
         var esmc:EffectSMC = null;
         var effect2:EffectSMC = null;
         var imgLen:int = 0;
         for(m in bu_arr)
         {
            bullet0 = bu_arr[m];
            if(bullet0.width >= 0)
            {
               if(clearHitEnemyB)
               {
                  bullet0.hitEnemyB = false;
               }
               for(nn0 in body_arr)
               {
                  body_arr2 = body_arr[nn0];
                  for(n in body_arr2)
                  {
                     b0 = body_arr2[n];
                     heroPlasmaB = false;
                     heroSpeedB = false;
                     if(b0 is HeroCarBody || b0 is LieutenantBody || b0 is EnemyHeroBody)
                     {
                        if(Boolean(b0.getPlasmaB()))
                        {
                           heroPlasmaB = true;
                           plasmaP = b0.getPlasmaPoint();
                        }
                        heroSpeedB = Boolean(b0.getSpeedUpB());
                     }
                     penetrationB = false;
                     if(bullet0.penetrationB == 1 && bullet0.penetrationNum < 6)
                     {
                        penetrationB = true;
                     }
                     if(Boolean(b0.hasOwnProperty("ai")) && Game.LG.state == "normal")
                     {
                        if(Boolean(b0.ai.hasOwnProperty("plasmaB")))
                        {
                           heroPlasmaB = Boolean(b0.ai.plasmaB);
                        }
                     }
                     if((Boolean(b0.hitHurtB == 0 || bullet0.getBroken_PlasmaB() && heroPlasmaB)) && Boolean(!heroSpeedB) && b0.die == 0)
                     {
                        hurtRectArr = b0.AAHD.hurtRectArr;
                        multPoint = 8;
                        if(bullet0.bulletType == "bullet")
                        {
                           ignorePlasmaB = false;
                           if(bullet0.specialType == "Slow_Missile" || Boolean(bullet0.getBroken_PlasmaB()))
                           {
                              ignorePlasmaB = true;
                           }
                           if(bullet0.bounceNum == 0 || bullet0.nowBounceNum >= bullet0.bounceNum)
                           {
                              i = 0;
                              if(Boolean(heroPlasmaB && !ignorePlasmaB) && Boolean(plasmaP) && Boolean(b0.hasOwnProperty("plasmaD")))
                              {
                                 bb = HitIO.hitCirclePoint(plasmaP.x,plasmaP.y,b0.plasmaD,bullet0.mot.x0,bullet0.mot.y0);
                                 if(isabsolute && !bb)
                                 {
                                    for(i = multPoint; i > 0; i--)
                                    {
                                       nextMot = (bullet0 as OneBulletBody).mot.getNextBulletPoint(1 / multPoint * i);
                                       bb = HitIO.hitCirclePoint(plasmaP.x,plasmaP.y,b0.plasmaD,nextMot.x,nextMot.y);
                                       if(i == multPoint && bb)
                                       {
                                          bb = false;
                                          break;
                                       }
                                       if(bb)
                                       {
                                          bullet0.mot.x0 = nextMot.x;
                                          bullet0.mot.y0 = nextMot.y;
                                          break;
                                       }
                                    }
                                 }
                              }
                              else
                              {
                                 bb = HitIO.hitRectArrRect(hurtRectArr,bullet0.mot.x0 - bullet0.width,bullet0.mot.y0 - bullet0.width,bullet0.width * 2,bullet0.width * 2);
                                 if(isabsolute && !bb)
                                 {
                                    for(i = multPoint; i > 0; i--)
                                    {
                                       nextMot2 = (bullet0 as OneBulletBody).mot.getNextBulletPoint(1 / multPoint * i);
                                       bb = HitIO.hitRectArrRect(hurtRectArr,nextMot2.x - bullet0.width,nextMot2.y - bullet0.width,bullet0.width * 2,bullet0.width * 2);
                                       if(i == multPoint && bb)
                                       {
                                          bb = false;
                                          break;
                                       }
                                       if(bb)
                                       {
                                          bullet0.mot.x0 = nextMot2.x;
                                          bullet0.mot.y0 = nextMot2.y;
                                          break;
                                       }
                                    }
                                 }
                              }
                              if(bb)
                              {
                                 ++bullet0.penetrationNum;
                                 this.bulletHited(b0,bullet0,bullet0.mot.x0,bullet0.mot.y0,bullet0.ra,false,!(heroPlasmaB && !ignorePlasmaB),bullet0.beatBack);
                                 if(!penetrationB)
                                 {
                                    bullet0.toDie();
                                 }
                              }
                           }
                           else
                           {
                              if(Boolean(heroPlasmaB) && Boolean(plasmaP) && Boolean(b0.hasOwnProperty("plasmaD")))
                              {
                                 ra0 = HitIO.hitCirclePoint_ra(plasmaP.x,plasmaP.y,b0.plasmaD,bullet0.mot.x0,bullet0.mot.y0);
                              }
                              else
                              {
                                 ra0 = HitIO.hitRAR_ra(hurtRectArr,bullet0.mot.x0 - bullet0.width,bullet0.mot.y0 - bullet0.width,bullet0.width * 2,bullet0.width * 2);
                              }
                              if(ra0 != -1000)
                              {
                                 ++bullet0.penetrationNum;
                                 this.bulletHited(b0,bullet0,bullet0.mot.x0,bullet0.mot.y0,bullet0.ra,false,!heroPlasmaB,bullet0.beatBack);
                                 if(bullet0.targetBody != null)
                                 {
                                    bullet0.targetBody = null;
                                 }
                                 bullet0.mot.ra = ra0;
                                 bullet0.mot.x0 += Math.cos(ra0) + 20;
                                 bullet0.mot.y0 += Math.sin(ra0) + 20;
                                 ++bullet0.nowBounceNum;
                              }
                           }
                        }
                        else if(bullet0.bulletType == "laser")
                        {
                           bu0 = bullet0;
                           if(bu0.penetrationB == 1)
                           {
                              if(Boolean(heroPlasmaB) && Boolean(plasmaP) && Boolean(b0.hasOwnProperty("plasmaD")))
                              {
                                 p0 = HitIO.hitCircleLine(plasmaP.x,plasmaP.y,b0.plasmaD,bullet0.x0,bullet0.y0,bullet0.ra);
                              }
                              else if(hurtRectArr.length == 1)
                              {
                                 p0 = HitIO.hitRectLine2(hurtRectArr[0],bullet0.x0,bullet0.y0,bullet0.ra,bullet0.width);
                              }
                              else
                              {
                                 p0 = HitIO.hitRectArrLine2(hurtRectArr,bullet0.x0,bullet0.y0,bullet0.ra,bullet0.width);
                              }
                              if(p0 is Point)
                              {
                                 effectAddB3 = true;
                                 esmc3 = b0.define.hitEffectImg;
                                 if(esmc3 is EffectSMC)
                                 {
                                    if(esmc3.die < 2)
                                    {
                                       effectAddB3 = false;
                                    }
                                    else
                                    {
                                       b0.define.hitEffectImg = null;
                                    }
                                 }
                                 if(effectAddB3)
                                 {
                                    effect3 = this.EG.addEffect(bu0.imgFather,bu0.hitImgLabel,this.gameSprite.effectL,p0.x,p0.y);
                                    b0.define.hitEffectImg = effect3;
                                 }
                                 else
                                 {
                                    effect3 = b0.define.hitEffectImg;
                                    effect3.x = p0.x;
                                    effect3.y = p0.y;
                                 }
                                 effect3.mc.rotation = bu0.ra * 180 / Math.PI;
                                 ++bullet0.penetrationNum;
                                 this.bulletHited(b0,bu0,p0.x,p0.y,bu0.ra,false,!heroPlasmaB,bullet0.beatBack,false);
                                 bullet0.doEffect();
                              }
                           }
                        }
                     }
                  }
               }
               if(bullet0.bulletType == "laser" && bullet0.penetrationB == 0 && !bullet0.hitEnemyB)
               {
                  sb0 = bullet0.attackBody;
                  shootP0 = sb0.AAHD.shootPoint;
                  sb0.img.arms.length = 1000;
                  obj10 = HitIO.hitRectArrLaser2(body_arr,shootP0.x,shootP0.y,sb0.AAHD.shootRa,bullet0.width);
                  p2 = obj10.point;
                  if(p2 is Point)
                  {
                     b10 = obj10.b0;
                     if(b10.die == 0)
                     {
                        effectAddB = true;
                        esmc = bullet0.hitEffectImg;
                        if(esmc is EffectSMC)
                        {
                           if(esmc.die < 2)
                           {
                              effectAddB = false;
                           }
                        }
                        if(effectAddB)
                        {
                           effect2 = this.EG.addEffect(bullet0.imgFather,bullet0.hitImgLabel,this.gameSprite.effectL,p2.x,p2.y);
                           bullet0.hitEffectImg = effect2;
                        }
                        else
                        {
                           effect2 = bullet0.hitEffectImg;
                           effect2.x = p2.x;
                           effect2.y = p2.y;
                        }
                        effect2.mc.rotation = bullet0.ra * 180 / Math.PI;
                        imgLen = Maths.Long(shootP0.x - p2.x,shootP0.y - p2.y);
                        sb0.img.arms.length = imgLen;
                        bullet0.hitEnemyB = true;
                        ++bullet0.penetrationNum;
                        bullet0.doEffect();
                        this.eventGroup.hurt(b10,bullet0.hurt,bullet0.attackType,bullet0.itemsData,bullet0.attackBody,p2.x,p2.y,bullet0.hurt_0_B,false,bullet0.bulletType,bullet0,bullet0.mulHurt);
                     }
                  }
               }
            }
         }
      }
      
      private function bulletHited(b0:*, bullet0:*, x0:Number, y0:Number, ra:Number, inBodyB:Boolean = false, hurtB:Boolean = true, beatBack:Number = 0, effectB:Boolean = true) : *
      {
         var con0:* = undefined;
         var imgl0:String = null;
         var ra0:* = ra;
         var x00:Number = x0;
         var y00:Number = y0;
         if(effectB)
         {
            if(inBodyB)
            {
               con0 = b0.img;
               y00 = y0 - b0.img.y;
               if(b0.img.scaleX < 0)
               {
                  ra0 = Maths.flipRa_Y(ra);
                  x00 = -(x0 - b0.img.x);
               }
               else
               {
                  x00 = x0 - b0.img.x;
               }
            }
            else
            {
               con0 = this.gameSprite.effectL;
            }
            imgl0 = bullet0.hitImgLabel;
            if(imgl0 == "sub/cutter_hit_effect" || imgl0 == "cutter_hit_effect")
            {
               this.EG.addEffect(bullet0.imgFather,imgl0,this.gameSprite.effectL,x0 + Math.random() * 30 - 15,y0 + Math.random() * 30 - 15,Math.random() * Math.PI * 2);
            }
            else
            {
               this.EG.addEffect(bullet0.imgFather,imgl0,con0,x00,y00,ra0);
            }
         }
         if(beatBack > 0)
         {
            b0.shake.startShake(1.5,0.2,bullet0.ra,0,beatBack);
         }
         if(hurtB)
         {
            this.eventGroup.hurt(b0,bullet0.hurt,bullet0.attackType,bullet0.itemsData,bullet0.attackBody,x0,y0,bullet0.hurt_0_B,false,bullet0.bulletType,bullet0,bullet0.mulHurt);
         }
      }
      
      private function bodyHit_attackRect(b0:*, arr1:Array, heroSpeedB:* = false, heroPlasmaB:* = false, plasmaPoint:Point = null) : *
      {
         var hurtRectArr0:Array = null;
         var n:* = undefined;
         var e0:* = undefined;
         var ad:AttackHitData = null;
         var p0:Lines = null;
         var ra00:Number = NaN;
         var ra02:Number = NaN;
         if(b0.hitHurtB == 0 && !heroSpeedB && b0.die == 0)
         {
            hurtRectArr0 = b0.AAHD.hurtRectArr;
            for(n in arr1)
            {
               e0 = arr1[n];
               ad = e0.AAHD.attackData;
               if(ad is AttackHitData)
               {
                  if(ad.specialType == "Broken_Plasma" || !heroPlasmaB)
                  {
                     p0 = this.rectArrHit_attackData(hurtRectArr0,ad);
                     if(p0 is Lines)
                     {
                        ra00 = Math.atan2(b0.mot.y0 - e0.mot.y0,b0.mot.x0 - e0.mot.x0);
                        b0.shake.startShake(1.5,0.2,ra00,-ad.recoilValue / 2,ad.recoilValue,1,"random");
                        if(ad.hitImgLabel == "sub/cutter_hit_effect")
                        {
                           this.EG.addEffect("",ad.hitImgLabel,this.gameSprite.effectL,p0.x + Math.random() * 30 - 15,p0.y + Math.random() * 30 - 15,Math.random() * Math.PI * 2);
                        }
                        else if(ad.hitImgLabel == "Drilling/hit_effect")
                        {
                           ra02 = 0;
                           if(Boolean(e0.img.rightB))
                           {
                              ra02 = Math.PI;
                           }
                           this.EG.addEffect("",ad.hitImgLabel,this.gameSprite.effectL,p0.x,p0.y,ra02);
                        }
                        else
                        {
                           this.EG.addEffect("",ad.hitImgLabel,this.gameSprite.effectL,p0.x,p0.y,p0.ra);
                        }
                        this.eventGroup.hurt(b0,ad.hurt,ad.attackType,null,e0,p0.x,p0.y,ad.hurt_0_B,false,"area",null,ad.mulHurt);
                     }
                  }
               }
            }
         }
      }
      
      private function rectArrHit_attackData(arr0:Array, ad:AttackHitData) : Lines
      {
         var n1:* = undefined;
         var n2:* = undefined;
         var rect0:Rectangle = null;
         var p0:Point = null;
         var ra0:Number = NaN;
         var l0:Lines = null;
         var p1:Point = null;
         var rArr:Array = ad.hitRectArr;
         var lArr:Array = ad.hitLineArr;
         for(n1 in rArr)
         {
            rect0 = rArr[n1];
            p0 = HitIO.RectArr2_point(arr0,rect0);
            if(p0 is Point)
            {
               ra0 = ad.range;
               if(ra0 != 1000)
               {
                  return new Lines(p0.x,p0.y,ad.range);
               }
               return new Lines(p0.x,p0.y,ad.range);
            }
         }
         for(n2 in lArr)
         {
            l0 = lArr[n2];
            p1 = HitIO.hitRectArrLine2(arr0,l0.x,l0.y,l0.ra,l0.w,l0.len);
            if(p1 is Point)
            {
               return new Lines(p1.x,p1.y,l0.ra);
            }
         }
         return null;
      }
      
      private function bodyHit_funnel(b0:*, arr1:Array, heroSpeedB:* = false, heroPlasmaB:* = false, plasmaPoint:Point = null) : *
      {
         var n:* = undefined;
         var e0:* = undefined;
         var ad:AttackHitData = null;
         var lArr:Array = null;
         var n2:* = undefined;
         var l0:Lines = null;
         var p1:Point = null;
         var hurtRectArr0:Array = b0.AAHD.hurtRectArr;
         if(b0.hitHurtB == 0 && !heroPlasmaB && !heroSpeedB)
         {
            for(n in arr1)
            {
               e0 = arr1[n];
               ad = e0.AAHD.attackData;
               if(ad is AttackHitData)
               {
                  lArr = ad.hitLineArr;
                  for(n2 in lArr)
                  {
                     l0 = lArr[n2];
                     p1 = HitIO.hitRectArrLine2(hurtRectArr0,l0.x,l0.y,l0.ra,l0.w);
                     if(p1 is Point)
                     {
                        this.EG.addEffect("",ad.hitImgLabel,this.gameSprite.effectL,p1.x,p1.y,l0.ra);
                        this.eventGroup.hurt(b0,ad.hurt,ad.attackType,null,e0,p1.x,p1.y);
                     }
                  }
               }
            }
         }
      }
      
      private function bodyHit_explose(b0:*, arr1:Array, heroSpeedB:* = false, heroPlasmaB:* = false, plasmaPoint:Point = null) : *
      {
         var hurtRectArr:Array = null;
         var n:* = undefined;
         var e0:* = undefined;
         var r0:Rectangle = null;
         var bb:* = undefined;
         var plasmaP:Point = null;
         var n1:* = undefined;
         var e1:* = undefined;
         var bb3:* = undefined;
         if(b0.hitHurtB == 0 && !heroSpeedB)
         {
            if(!heroPlasmaB)
            {
               hurtRectArr = b0.AAHD.hurtRectArr;
               for(n in arr1)
               {
                  e0 = arr1[n];
                  if(e0.die == 0)
                  {
                     r0 = e0.hitRect;
                     bb = HitIO.hitRectArrRect(hurtRectArr,r0.x,r0.y,r0.width,r0.height);
                     if(Boolean(bb))
                     {
                        b0.shake.startShake(2,0.2,Math.random() * 10,0,e0.define.recoilValue);
                        this.eventGroup.hurt(b0,e0.define.hurt,e0.define.attackType,null,e0,r0.x + r0.width / 2,r0.y + r0.height / 2,true,false,"bullet",null,e0.define.mulHurt);
                        e0.toDie();
                        if(Game.LG.level.name == "僵尸狂潮")
                        {
                           Game.LG.level.bodyDie(e0);
                        }
                     }
                  }
               }
            }
            else
            {
               plasmaP = plasmaPoint;
               for(n1 in arr1)
               {
                  e1 = arr1[n1];
                  if(e1.die == 0)
                  {
                     bb3 = HitIO.hitCirclePoint(plasmaP.x,plasmaP.y,b0.plasmaD,e1.img.x,e1.img.y);
                     if(Boolean(bb3))
                     {
                        e1.toDie();
                        if(Game.LG.level.name == "僵尸狂潮")
                        {
                           Game.LG.level.bodyDie(e1);
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function getMinY(x0:Number) : Number
      {
         var p0:Point = HitIO.hitRectArrLine2(this.hitRectArr,x0,-10000,Math.PI / 2,1);
         if(p0 is Point)
         {
            return p0.y;
         }
         return 100000;
      }
      
      public function FTimer() : *
      {
         var n:* = undefined;
         var hero0:* = undefined;
         var heroPlasmaB:Boolean = false;
         var heroSpeedB:Boolean = false;
         var plasmaP:Point = null;
         var i:* = undefined;
         var attackRect_arr:Array = [this.BG.ElectricSaw_arr,this.BG.Drilling_arr,this.BG.Rolling_arr,this.BG.Striker_arr,this.BG.Intercessor_arr,this.BG.Charger_arr,this.BG.Gundam2_arr,this.BG.Gundam_arr,this.BG.Gear_arr];
         var tt:int = getTimer();
         for(n in this.BG.heroCar_arr)
         {
            hero0 = this.BG.heroCar_arr[n];
            heroPlasmaB = false;
            heroSpeedB = false;
            plasmaP = null;
            if(Boolean(hero0.getPlasmaB()))
            {
               heroPlasmaB = true;
               plasmaP = hero0.getPlasmaPoint();
            }
            heroSpeedB = Boolean(hero0.getSpeedUpB());
            this.bodyHit_GroundRect(hero0,this.hitRectArr,true);
            if(hero0 is HeroCarBody)
            {
               this.bodyHit_GroundRect(hero0,this.moveRectArr);
               this.bodyHit_GroundRect(hero0,this.moveRectArr2);
               this.bodyHit_bodyArr(hero0,this.BG.AtomicTower_arr);
               this.bodyHit_bodyArr(hero0,this.BG.Gear_arr);
            }
            else
            {
               this.bodyHit_GroundRect(hero0,this.moveRectArr,false,true);
            }
            for(i in attackRect_arr)
            {
               this.bodyHit_attackRect(hero0,attackRect_arr[i],heroSpeedB,heroPlasmaB,plasmaP);
            }
            this.bodyHit_funnel(hero0,this.BG.GundamFunnel_arr,heroSpeedB,heroPlasmaB,plasmaP);
            this.bodyHit_explose(hero0,this.BG.Spider_arr,heroSpeedB,heroPlasmaB,plasmaP);
            this.bodyHit_explose(hero0,this.BG.SmallSatellite_arr,heroSpeedB,heroPlasmaB,plasmaP);
         }
         this.arrHit_GroundRect(this.BG.weLand_arr,this.hitRectArr,true);
         this.bulletHit_body(this.BG.enemy_bullet,[this.BG.heroCar_arr,this.BG.weLand_arr,this.BG.weAir_arr],true);
         this.bulletHit_body(this.BG.we_bullet,this.BG.enemy_arr,true,true);
         this.bulletHit_body(this.BG.we_bullet,[this.BG.things_arr]);
         this.bulletHit_Ground(this.BG.we_bullet);
         this.bulletHit_Ground(this.BG.enemy_bullet);
         this.arrHit_GroundRect(this.BG.ElectricSaw_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Charger_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Spider_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Ostrich_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Tracker_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Tank_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Rolling_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Striker_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Intercessor_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.LandFort_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Gundam2_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.AtomicTower_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.Gear_arr,this.hitRectArr,true);
         this.planesHit_GroundRect(this.BG.Gundam_arr,this.hitRectArr,true);
         this.arrHit_GroundRect(this.BG.enemyHero_arr,this.hitRectArr,true);
      }
   }
}

