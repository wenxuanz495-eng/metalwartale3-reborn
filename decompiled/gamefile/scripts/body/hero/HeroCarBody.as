package body.hero
{
   import UI.gaming.HeadTitle;
   import body.attack.ArmsAttack;
import body.motion.BodyMotion;
import body.skill.SkillGroup;
import body.skill.SpeedUpSkill;
   import data.INIT;
   import effect.EffectSMC;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameAll.data.*;
   import image.ShakeMotion;
   
   public class HeroCarBody
   {
      
      public var img:HeroCarImage = new HeroCarImage();
      
      public var mot:BodyMotion = new BodyMotion();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var skill:SkillGroup = new SkillGroup();
      
      public var animation:HeroCarAnimation;
      
      public var key:HeroCarKey;
      
      public var define:HeroCarDefine = new HeroCarDefine();
      
      public var AAHD:NewHeroCarAAHD;
      
      public var headTitle:HeadTitle = new HeadTitle();
      
      public var carDefine:CarDefine = new CarDefine();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("arms");
      
      public var attack:ArmsAttack;
      
      private var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "we";
      
      public var type:String = "hero";
      
      public var SG:SubBodyGroup = new SubBodyGroup();
      
      public var speedUpSkill:SpeedUpSkill;

      // Standalone air-gravity state kept inside an existing timeline class.
      // A new ABC class is not safe to inject into this SWF with FFDec.
      private var airGravityMaxCharges:int = 0;
      private var airGravityCharges:int = 0;
      private var airGravityRecoveryTime:Number = 3.5;
      private var airGravityRecoveryTimer:Number = -1;
      
      private var plasmaTime:int = -1;
      
      public var plasmaD:Number = 135;
      
      private var dieEffect:EffectSMC;
      
      public var electNum:int = 1;
      
      public var plasmaEnabled:Boolean = true;
      
      public var hitRect:Rectangle = new Rectangle();
      
      public var noAttack_t:Number = -1;
      
      public var ai:Hero_AI;
      
      public var arena_ai:HeroArena_AI;
      
      public var level_ai:HeroLevel_AI;
      
      public function HeroCarBody()
      {
         super();
         this.skill.BB = this;
         this.SG.baba = this;
         this.animation = new HeroCarAnimation(this.img.car,this.mot);
         this.key = new HeroCarKey(this);
         this.AAHD = new NewHeroCarAAHD(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.speedUpSkill = new SpeedUpSkill(this);
         this.ai = new Hero_AI(this);
         this.level_ai = new HeroLevel_AI(this);
         this.arena_ai = new HeroArena_AI(this);
         this.img.addChild(this.headTitle);
         this.headTitle.y = -70;
         this.headTitle.x = 0;
      }
      
      public function rebirth() : *
      {
         this.dieEffect = null;
         this.img.sp.visible = true;
         this._die = 0;
         this.hitHurtB = 0;
         this.animation.enabled = true;
         this.key.enabled = true;
         this.attack.enabled = true;
         this.SG.attackB = true;
         this.speedUpSkill.speedUpTime = -1;
         this.plasmaTime = -1;
      }
      
      public function stopAllImage() : *
      {
         this.img.stopAll();
         this.SG.stopAll();
         this.SG.stopAllImage();
      }
      
      public function toDie() : *
      {
         this.readyToDie();
         this.changeState("stand");
         this.dieEffect = Game.EG.addEffect("car","electric_effect",this.img);
         Game.oneScene.shake.startShake(20,1.2,Math.random() * 20,-10,20,1,"random");
         this.shake.startShake(30,1,Math.random() * 10,-5,5,1,"random");
      }
      
      public function readyToDie() : *
      {
         this.stopAllImage();
         this._die = 1;
         this.toStop();
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.key.enabled = false;
         this.shake.init();
         this.attack.stopAttack();
         this.attack.enabled = false;
         this.SG.stopAll();
         this.speedUpSkill.stopSpeedUp();
      }
      
      public function gamingInit() : *
      {
         this.mot.F_G = 2;
         this.mot.baseVxmax_Fi = BodyMotion.MOVE_VX;
         this.img.otherGamingInit();
         this.skill.initSkillState();
         this.configureAirGravitySkill();
         this.dieEffect = null;
         this.plasmaEnabled = true;
         this.SG.attackB = true;
         this.SG.showAll();
         this.rebirth();
         this.noAttack_t = -1;
         this.mot.toStop();
         this.attack.stopLoop();
         this.speedUpSkill.speedUpTime = -1;
         this.plasmaTime = -1;
         this.img.plasmaShield.goPlayLoop_break("plasmaShield_open");
         this.img.plasmaShield.stop();
         this.speedUpSkill.stopSpeedUp();
         this.SG.fleshAllPosition();
      }

      public function configureAirGravitySkill() : *
      {
         var jumpSkill:* = this.skill.getSkill("jump");
         if(jumpSkill != null && jumpSkill.levelDefine != null)
         {
            this.airGravityMaxCharges = int(jumpSkill.levelDefine.maxNum);
            if(this.airGravityMaxCharges < 0)
            {
               this.airGravityMaxCharges = 0;
            }
            this.airGravityCharges = this.airGravityMaxCharges;
            this.airGravityRecoveryTime = 3.5;
            this.airGravityRecoveryTimer = -1;
         }
      }

      public function canUseAirGravity() : Boolean
      {
         // Skill level controls stored charges; one airborne sequence is capped separately.
         return this.airGravityCharges > 0 && this.mot.airJumpNow < 10;
      }

      public function getAirGravityCharges() : int
      {
         return this.airGravityCharges;
      }

      public function getAirGravityMaxCharges() : int
      {
         return this.airGravityMaxCharges;
      }

      public function getAirGravityRecoveryPer() : Number
      {
         var per:Number = 0;
         if(this.airGravityCharges >= this.airGravityMaxCharges)
         {
            return 0;
         }
         if(this.airGravityRecoveryTime > 0 && this.airGravityRecoveryTimer > 0)
         {
            per = this.airGravityRecoveryTimer / this.airGravityRecoveryTime;
         }
         if(per < 0)
         {
            return 0;
         }
         if(per > 1)
         {
            return 1;
         }
         return per;
      }

      public function consumeAirGravity() : Boolean
      {
         if(!this.canUseAirGravity())
         {
            return false;
         }
         --this.airGravityCharges;
         if(this.airGravityCharges < this.airGravityMaxCharges && this.airGravityRecoveryTimer < 0)
         {
            this.airGravityRecoveryTimer = 0;
         }
         return true;
      }

      private function airGravityTimer() : *
      {
         if(this.airGravityCharges >= this.airGravityMaxCharges)
         {
            this.airGravityRecoveryTimer = -1;
            return;
         }
         if(this.airGravityRecoveryTimer < 0)
         {
            this.airGravityRecoveryTimer = 0;
         }
         this.airGravityRecoveryTimer += 1 / 30;
         if(this.airGravityRecoveryTimer >= this.airGravityRecoveryTime)
         {
            ++this.airGravityCharges;
            this.airGravityRecoveryTimer = this.airGravityCharges < this.airGravityMaxCharges ? 0 : -1;
         }
      }
      
      public function get die() : int
      {
         return this._die;
      }
      
      public function set die(value:int) : *
      {
         this._die = value;
      }
      
      public function hitRectCount() : *
      {
         this.hitRect = this.carDefine.hitRect.clone();
         this.hitRect.x += this.mot.x0;
         this.hitRect.y += this.mot.y0;
      }
      
      public function changeArmsItems(itemsData:ArmsItemsData = null) : *
      {
         this.changeArms(itemsData.baseLabel,0,itemsData);
      }
      
      public function refreshArms() : void
      {
      }
      
      public function changeArms(id0:String, level0:int = 0, itemsData:* = null) : *
      {
         var arr:Array = id0.split("_lv");
         if(arr.length > 1)
         {
            id0 = arr[0];
            level0 = int(arr[1]) - 1;
         }
         this.armsDefine.inData(id0,level0,"",itemsData);
         this.img.arms.showMC(this.armsDefine.armsImgLabel);
         this.img.arms.startHurtEffect(0.1);
      }
      
      public function changeUpdataArms() : *
      {
         var level0:int = (this.armsDefine.level + 1) % (this.armsDefine.armsMaxLevel + 1);
         this.changeArms(this.armsDefine.id,level0);
      }
      
      public function changeCarItems(_itemsData:CarItemsData) : *
      {
         this.changeCar(_itemsData.baseLabel,_itemsData);
      }
      
      public function changeCar(id0:String, _itemsData:CarItemsData = null) : *
      {
         var skin0:CarItemsData = null;
         var skinDefine0:CarDefine = null;
         this.carDefine.inData(id0,_itemsData);
         skin0 = Game.gameData.carItems.getActiveSkin();
         if(skin0 != null)
         {
            skinDefine0 = skin0.getDefine();
         }
         this.img.car.showMC(skinDefine0 != null ? skinDefine0.imgLabel : this.carDefine.imgLabel);
         this.img.ArmsFollowCar();
         this.img.plasmaShield.y = this.carDefine.hitRect.y + this.carDefine.hitRect.height / 2 - 20;
      }
      
      public function changeRocket(lv0:int) : *
      {
         if(lv0 < 1)
         {
            lv0 = 1;
         }
         else if(lv0 > 12)
         {
            lv0 = 12;
         }
         this.img.car.rocket.showMC("rocket_lv" + lv0);
      }
      
      public function changePlasma(lv0:int) : *
      {
         if(lv0 < 1)
         {
            lv0 = 1;
         }
         else if(lv0 > 12)
         {
            lv0 = 12;
         }
         this.img.car.plasma.showMC("plasma_lv" + lv0);
      }
      
      public function openPlasma(_time:Number) : *
      {
         if(this.die == 0 && this.plasmaTime <= 0)
         {
            this.plasmaTime = int(_time * INIT.FPS);
            this.img.plasmaShield.goOnce_ToLoop("plasmaShield_open","plasmaShield",false);
         }
      }
      
      public function closePlasma() : *
      {
         this.plasmaTime = -1;
         this.img.plasmaShield.goPlayOnce("plasmaShield_close");
      }
      
      public function getPlasmaPoint() : Point
      {
         var p0:Point = new Point();
         p0.x = this.img.plasmaShield.x + this.img.x;
         p0.y = this.img.plasmaShield.y + this.img.y;
         return p0;
      }
      
      public function getPlasmaB() : Boolean
      {
         if(!this.plasmaEnabled)
         {
            return false;
         }
         if(this.plasmaTime >= 0)
         {
            return true;
         }
         return false;
      }
      
      private function plasmaTimer() : *
      {
         if(this.plasmaTime > 0)
         {
            --this.plasmaTime;
         }
         else if(this.plasmaTime == 0)
         {
            this.closePlasma();
         }
      }
      
      public function getSpeedUpB() : Boolean
      {
         return this.speedUpSkill.getSpeedUpB();
      }
      
      public function speedUp(_time:Number = 0.2) : *
      {
         if(this.speedUpSkill.speedUpTime == -1)
         {
            this.img.car.rocket.playOnce();
            this.speedUpSkill.speedUp(_time);
         }
      }
      
      public function inMouseXY(_x0:Number, _y0:Number) : *
      {
         if(this.noAttack_t == -1)
         {
            this.img.inMouseXY(_x0,_y0);
            this.SG.inMouseXY(_x0,_y0);
         }
      }
      
      public function attackAll() : *
      {
         this.attack.startAttack();
         this.SG.attackAll();
      }
      
      public function moveToLeft() : *
      {
         this.mot.moveToLeft();
         if(this.img.bodyState == "stand")
         {
            this.img.flipToRight();
         }
      }
      
      public function moveToRight() : *
      {
         this.mot.moveToRight();
         if(this.img.bodyState == "stand")
         {
            this.img.flipToLeft();
         }
      }
      
      public function toStop() : *
      {
         this.mot.toStop();
      }
      
      public function set x(value:Number) : *
      {
         this.mot.x0 = value;
         this.img.x = int(value);
         this.SG.heroX = value;
         this.hitRectCount();
      }
      
      public function set y(value:Number) : *
      {
         this.mot.y0 = value;
         this.img.y = int(value);
         this.SG.heroY = value;
         this.hitRectCount();
      }
      
      public function get MX() : Number
      {
         var rect0:Rectangle = this.carDefine.hitRect;
         if(this.img.bodyState == "fly")
         {
            rect0 = this.AAHD.flyHitRect;
         }
         return this.mot.x0 + rect0.x + rect0.width / 2;
      }
      
      public function get MY() : Number
      {
         var rect0:Rectangle = this.carDefine.hitRect;
         if(this.img.bodyState == "fly")
         {
            rect0 = this.AAHD.flyHitRect;
         }
         return this.mot.y0 + rect0.y + rect0.height / 2;
      }
      
      public function energyUse() : *
      {
         var aid:ArmsItemsData = null;
         var arr0:Array = null;
         var aid0:ArmsItemsData = null;
         if(this.attack.state == "start")
         {
            if(Game.gameData.nowArmsIndex >= 0)
            {
               aid = Game.gameData.nowArmsData;
               if(aid == null)
               {
                  return;
               }
               if(aid.nowEnergy >= 1)
               {
                  aid.setEnergy(-1);
               }
               else
               {
                  arr0 = Game.gameData.armsItems.equArr;
                  aid0 = arr0[int(arr0.length * Math.random())];
                  if(Boolean(aid0))
                  {
                     Game.eventGroup.changArms(aid0.site);
                  }
               }
            }
         }
         if(this.attack.state == "shoot")
         {
            aid = Game.gameData.nowArmsData;
            if(aid == null || aid.nowEnergy <= 0)
            {
               return;
            }
            if(Game.oneScene.lockB)
            {
               Game.gameData.bulletNum += this.armsDefine.bulletNum * this.armsDefine.shootNum;
            }
         }
      }
      
      public function setNoAttack(tt0:Number) : *
      {
         this.noAttack_t = tt0;
         this.attack.stopLoop();
      }
      
      public function getCtrlB() : Boolean
      {
         return !this.ai.enabled && !this.arena_ai.enabled && !this.level_ai.enabled;
      }
      
      public function changeState(str0:String, changeT0:Number = 0) : *
      {
         if(this.img.bodyState != str0)
         {
            this.img.changeState(str0,changeT0);
            if(str0 == "fly")
            {
               this.armsDefine.inData("flyLaser",0,"arms");
               this.armsDefine.baseHurt = Game.gameData.getAllDps() * 0.06 / Game.gameData.getAllArmsAdd();
               this.mot.F_G = 0.5;
               this.mot.baseVxmax_Fi = BodyMotion.MOVE_VX;
               this.img.changeToStand = this.changeToStand;
               this.SG.hideAll();
            }
            else
            {
               this.attack.stopAttack();
               this.img.fly.stopArms();
               Game.eventGroup.fleshArms();
               this.mot.F_G = 2;
               this.mot.baseVxmax_Fi = BodyMotion.MOVE_VX;
               this.SG.showAll();
            }
         }
      }
      
      private function changeToStand() : *
      {
         this.changeState("stand");
      }
      
      public function bodyTimer() : *
      {
         this.SG.inPozision(this.img.rightB,this.mot.x0,this.mot.y0);
         this.skill.skillTimer();
         this.key.keyTimer();
         this.mot.motionTimer();
         this.img.imageTimer();
         this.animation.animationTimer();
         this.attack.attackTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
         this.speedUpSkill.speedUpTimer();
         this.airGravityTimer();
         this.plasmaTimer();
         this.energyUse();
         this.hitRectCount();
         this.ai.aiTimer();
         this.level_ai.aiTimer();
         this.arena_ai.aiTimer();
         if(this._die > 0)
         {
            if(this.dieEffect != null)
            {
               if(this.dieEffect.label == "electric_effect")
               {
                  if(this.dieEffect.currentFrame >= 29)
                  {
                     --this.electNum;
                     if(this.electNum < 0)
                     {
                        Game.oneScene.shake.startShake(20,1.2,Math.random() * 20,-10,20,1,"random");
                        this.dieEffect = Game.EG.addEffect("car","boom_effect",this.img);
                     }
                     else
                     {
                        this.dieEffect.gotoAndPlay(1);
                        this.shake.startShake(30,1,Math.random() * 10,-5,5,1,"random");
                     }
                  }
               }
               else if(this.dieEffect.label == "boom_effect")
               {
                  if(this.dieEffect.currentFrame == 14)
                  {
                     this.img.sp.visible = false;
                  }
                  else if(this.dieEffect.currentFrame == 24)
                  {
                     Game.eventGroup.gameFail();
                  }
               }
            }
         }
         if(this.noAttack_t <= 0 && this.noAttack_t > -1)
         {
            this.noAttack_t = -1;
         }
         else if(this.noAttack_t > 0)
         {
            this.noAttack_t -= 1 / 30;
         }
      }
   }
}

