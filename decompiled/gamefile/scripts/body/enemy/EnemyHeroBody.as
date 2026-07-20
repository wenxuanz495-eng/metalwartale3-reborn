package body.enemy
{
   import UI.gaming.HeadTitle;
   import body.attack.ArmsAttack;
   import body.define.EnemyDefine;
   import body.hero.ArmsDefine;
   import body.hero.CarDefine;
   import body.hero.HeroCarAAHD;
   import body.hero.HeroCarAnimation;
   import body.hero.HeroCarImage;
   import body.motion.GroundMotion;
   import body.skill.SpeedUpSkill;
   import data.INIT;
   import effect.EffectSMC;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import image.ShakeMotion;
   
   public class EnemyHeroBody
   {
      
      public var img:HeroCarImage = new HeroCarImage();
      
      public var mot:GroundMotion = new GroundMotion();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var skill:EnemySkillGroup = new EnemySkillGroup();
      
      public var animation:HeroCarAnimation;
      
      public var key:EnemyHeroKey;
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var AAHD:HeroCarAAHD;
      
      public var headTitle:HeadTitle = new HeadTitle();
      
      public var carDefine:CarDefine = new CarDefine();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("arms");
      
      public var attack:ArmsAttack;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public var playerB:Boolean = false;
      
      public var SG:EnemySubGroup = new EnemySubGroup();
      
      public var speedUpSkill:SpeedUpSkill;
      
      private var plasmaTime:int = -1;
      
      public var plasmaD:Number = 135;
      
      private var dieEffect:EffectSMC;
      
      public var electNum:int = 0;
      
      public var hitRect:Rectangle = new Rectangle();
      
      public var ai:EnemyHero_AI;
      
      public function EnemyHeroBody()
      {
         super();
         this.define.baseLife = 3;
         this.define.baseExp = 3;
         this.define.baseCoin = 3;
         this.mot.jumpNum = 10;
         this.skill.BB = this;
         this.SG.baba = this;
         this.animation = new HeroCarAnimation(this.img.car,this.mot);
         this.key = new EnemyHeroKey(this);
         this.AAHD = new HeroCarAAHD(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.speedUpSkill = new SpeedUpSkill(this);
         this.ai = new EnemyHero_AI(this);
         this.img.addChild(this.headTitle);
         this.headTitle.y = -70;
         this.headTitle.x = 0;
      }
      
      public function upData_AILevel(level0:int = -1) : *
      {
         var l0:int = level0;
         this.define.aiLevel = l0;
      }
      
      public function setLevel(num:int) : *
      {
         this.define.setLevel(num);
      }
      
      public function rebirth() : *
      {
         this.img.sp.visible = true;
         this._die = 0;
         this.hitHurtB = 0;
         this.animation.enabled = true;
         this.attack.enabled = true;
         this.speedUpSkill.speedUpTime = -1;
         this.plasmaTime = -1;
         this.dieEffect = null;
      }
      
      public function toDie() : *
      {
         this.toStop();
         this.ai.enabled = false;
         this._die = 1;
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.shake.init();
         this.attack.stopAttack();
         this.img.stopAll();
         this.SG.stopAllImage();
         this.SG.stopAll();
         this.attack.enabled = false;
         this.dieEffect = Game.EG.addEffect("car","electric_effect",this.img);
         this.shake.startShake(30,1,Math.random() * 10,-5,5,1,"random");
      }
      
      public function playStand() : *
      {
         this.img.car.stop();
      }
      
      public function gamingInit() : *
      {
         this.mot.toStop();
         this.attack.stopLoop();
         this.skill.initSkillState();
         this.speedUpSkill.speedUpTime = -1;
         this.plasmaTime = -1;
         this.img.plasmaShield.goPlayLoop_break("plasmaShield_open");
         this.img.plasmaShield.stop();
         this.speedUpSkill.stopSpeedUp();
         this.SG.fleshAllPosition();
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
         this.carDefine.inData(id0,_itemsData);
         this.img.car.showMC(this.carDefine.imgLabel);
         this.img.ArmsFollowCar();
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
         if(this.die == 0 && !this.getPlasmaB())
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
      
      public function speedUpGap(_gap:Number = 300) : *
      {
         var _time:Number = NaN;
         if(this.speedUpSkill.speedUpTime == -1)
         {
            _time = _gap / (this.speedUpSkill.maxSpeed * 30);
            this.speedUpSkill.speedUp(_time);
         }
      }
      
      public function inMouseXY(_x0:Number, _y0:Number) : *
      {
         this.img.inMouseXY(_x0,_y0);
         this.SG.inMouseXY(_x0,_y0);
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
         this.skill.skillTimer();
         this.ai.aiTimer();
         this.mot.motionTimer();
         this.img.imageTimer();
         this.animation.animationTimer();
         this.attack.attackTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
         this.speedUpSkill.speedUpTimer();
         this.plasmaTimer();
         this.hitRectCount();
         if(this.mot.vx > 0.05)
         {
            this.img.flipToLeft();
         }
         else if(this.mot.vx < 0.05)
         {
            this.img.flipToRight();
         }
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
                        Game.oneScene.shake.startShake(20,1.2,Math.random() * 20,-5,5,1,"random");
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
                     this.SG.clearSub();
                  }
                  else if(this.dieEffect.currentFrame == 24)
                  {
                     this._die = 2;
                  }
               }
            }
         }
      }
   }
}

