package body.lieutenant
{
   import UI.gaming.HeadTitle;
   import body.attack.ArmsAttack;
   import body.define.OneArmsDefine;
   import body.hero.*;
   import body.motion.BodyMotion;
   import body.skill.SkillGroup;
   import body.skill.SpeedUpSkill;
   import data.INIT;
   import effect.EffectSMC;
   import effect.GhostingEffectBMC;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class LieutenantBody
   {

      public static const INITIAL_MAIN_WEAPON:String = "soya_lv6";

      public static const SWITCH_MAIN_WEAPONS:Array = ["amplitude_lv3","microwave_lv3","schoolArms_lv3"];

      public static const MAIN_WEAPON_IMAGES:Array = ["soya_lv6","amplitude_lv3","microwave_lv3","schoolArms_lv3"];
      
      public var define:HeroCarDefine = new HeroCarDefine();
      
      public var img:HeroCarImage = new HeroCarImage();
      
      public var mot:BodyMotion = new BodyMotion();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var skill:SkillGroup = new SkillGroup();
      
      public var animation:HeroCarAnimation;
      
      public var key:LieutenantKey;
      
      public var AAHD:LieutenantAAHD;
      
      public var ai:Lieutenant_AI;
      
      public var speedUpSkill:SpeedUpSkill;
      
      internal var headTitle:HeadTitle = new HeadTitle();
      
      public var carDefine:CarDefine = new CarDefine();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("arms");
      
      public var attack:ArmsAttack;
      
      private var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "we";
      
      public var type:String = "hero";
      
      public var SG:SubBodyGroup = new SubBodyGroup();
      
      public var ghostingEffect:GhostingEffectBMC;
      
      private var plasmaTime:int = -1;
      
      public var plasmaD:Number = 135;
      
      private var dieEffect:EffectSMC;
      
      public var electNum:int = 4;
      
      public function LieutenantBody()
      {
         super();
         this.skill.BB = this;
         this.animation = new HeroCarAnimation(this.img.car,this.mot);
         this.key = new LieutenantKey(this);
         this.AAHD = new LieutenantAAHD(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.ai = new Lieutenant_AI(this);
         this.speedUpSkill = new SpeedUpSkill(this);
         this.skill.fleshSkillLevel([4,4,4,0,0]);
         this.img.addChild(this.headTitle);
         this.headTitle.y = -70;
         this.headTitle.x = 0;
         this.headTitle.txt.text = "罗杰中尉";
      }
      
      public function toDie() : *
      {
         this._die = 1;
         this.toStop();
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.attack.stopAttack();
         this.ai.enabled = false;
         this.dieEffect = Game.EG.addEffect("car","electric_effect",this.img);
         Game.oneScene.shake.startShake(20,1.2,Math.random() * 20,-10,20,1,"random");
         this.SG.clearSub();
      }
      
      public function get die() : int
      {
         return this._die;
      }
      
      public function get hitRect() : Rectangle
      {
         var rect0:Rectangle = this.carDefine.hitRect.clone();
         rect0.x += this.mot.x0;
         rect0.y += this.mot.y0;
         return rect0;
      }
      
      public function changeArms(id0:String, level0:int = 0) : *
      {
         var arr:Array = id0.split("_lv");
         this.attack.stopAttack();
         if(arr.length > 1)
         {
            id0 = arr[0];
            level0 = int(arr[1]) - 1;
         }
         this.armsDefine.inData(id0,level0);
         this.img.arms.showMC(this.armsDefine.armsImgLabel);
         this.img.ArmsFollowCar();
         this.img.arms.startHurtEffect(0.1);
      }
      
      public function changeUpdataArms() : *
      {
         var level0:int = (this.armsDefine.level + 1) % (this.armsDefine.armsMaxLevel + 1);
         this.changeArms(this.armsDefine.id,level0);
      }
      
      public function changeCar(id0:String) : *
      {
         this.carDefine.inData(id0);
         this.img.car.showMC(this.carDefine.imgLabel);
      }
      
      public function openPlasma(_time:Number) : *
      {
         if(this.die == 0 && !this.getPlasmaB())
         {
            this.plasmaTime = int(_time * INIT.FPS);
            this.img.plasmaShield.goOnce_ToLoop("plasmaShield_open","plasmaShield");
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
      
      public function inMouseXY(_x0:Number, _y0:Number) : *
      {
         this.img.inMouseXY(_x0,_y0);
         this.SG.inMouseXY(_x0,_y0);
      }
      
      public function speedUp(_time:Number = 0.2) : *
      {
         if(this.speedUpSkill.speedUpTime == -1)
         {
            this.img.car.rocket.playOnce();
            this.speedUpSkill.speedUp(_time);
         }
      }
      
      public function toJump() : *
      {
         this.mot.toJump();
         Game.EG.addEffect("car","jet_effect",Game.gameSprite.effectL,this.img.x,this.img.y);
         var define0:OneArmsDefine = Game.defineGroup.getArmsDefine("jumpBullet",0,"arms");
         ArmsAttack.shoot(define0,this,new Point(this.img.x,this.img.y - 10),define0.bulletAngle * Math.PI / 180);
      }
      
      public function moveToLeft() : *
      {
         this.mot.moveToLeft();
         this.img.flipToRight();
      }
      
      public function moveToRight() : *
      {
         this.mot.moveToRight();
         this.img.flipToLeft();
      }
      
      public function toStop() : *
      {
         this.mot.toStop();
      }
      
      public function get MX() : Number
      {
         var rect0:Rectangle = this.carDefine.hitRect;
         return this.mot.x0 + rect0.x + rect0.width / 2;
      }
      
      public function get MY() : Number
      {
         var rect0:Rectangle = this.carDefine.hitRect;
         return this.mot.y0 + rect0.y + rect0.height / 2;
      }
      
      public function bodyTimer() : *
      {
         this.SG.inPozision(this.img.rightB,this.mot.x0,this.mot.y0);
         this.ai.aiTimer();
         this.skill.skillTimer();
         this.mot.motionTimer();
         this.img.imageTimer();
         this.animation.animationTimer();
         this.attack.attackTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
         this.speedUpSkill.speedUpTimer();
         this.plasmaTimer();
         if(this._die > 0)
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
               else if(this.dieEffect.currentFrame == 25)
               {
                  this.img.visible = false;
               }
            }
         }
      }
   }
}

