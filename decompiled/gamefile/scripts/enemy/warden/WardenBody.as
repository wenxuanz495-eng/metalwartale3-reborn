package enemy.warden
{
   import body.attack.ArmsAttack;
   import body.define.EnemyDefine;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   import body.motion.SuspendMotion;
   import enemy.AI.WeAttack_AI;
   import enemy._normal.Normal_AAHD;
   import enemy._normal.Normal_ExtraSkill;
   import enemy._normal.Normal_FlyBody;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class WardenBody
   {
      
      public var mot:*;
      
      public var mot1:GroundMotion = new GroundMotion();
      
      public var mot2:SuspendMotion = new SuspendMotion();
      
      public var animation:WardenAnimation;
      
      public var img:MultipleImage = new MultipleImage();
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var attack:ArmsAttack;
      
      public var AAHD:Normal_AAHD;
      
      public var ai:Warden_AI;
      
      public var we_AI:WeAttack_AI;
      
      public var extraSkill:Normal_ExtraSkill;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public var shakeRange:int = 8;
      
      public var toDieB:Boolean = true;
      
      public var nowState:String = "fly";
      
      public function WardenBody()
      {
         super();
         this.mot = this.mot2;
         this.animation = new WardenAnimation(this);
         this.AAHD = new Normal_AAHD(this,this.img,this.armsDefine,this.define);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.ai = new Warden_AI(this);
         this.we_AI = new WeAttack_AI(this,this.ai);
         this.extraSkill = new Normal_ExtraSkill(this);
         this.setState("fly");
      }
      
      public function setState(str0:String) : *
      {
         var b1:Normal_FlyBody = null;
         var b2:Normal_FlyBody = null;
         this.AAHD.lastLabel = str0;
         this.animation.state = str0;
         this.ai.nowState = str0;
         this.img.goPlayLoop(this.nowState);
         if(this.mot == this.mot1)
         {
            this.mot2.inData_byOther(this.mot1);
         }
         else
         {
            this.mot1.inData_byOther(this.mot2);
         }
         if(str0 == "fly")
         {
            this.mot = this.mot2;
            if(this.nowState != str0)
            {
               this.img.goOnce_ToLoop("stand__fly","fly");
               this.armsDefine.inData(this.ai.armsName,1);
               this.define.rectLevel = 1;
               this.flesh_byDefine();
            }
         }
         else
         {
            this.mot = this.mot1;
            if(this.nowState != str0)
            {
               this.img.goOnce_ToLoop("fly__stand","stand");
               this.armsDefine.inData(this.ai.armsName,0);
               this.define.rectLevel = 0;
               this.flesh_byDefine();
               b1 = Game.BG.getUnit("小守卫");
               b1.x = this.mot.x0 - 50;
               b1.y = this.mot.y0;
               b1.ai.attackBody(this.ai.targetBody);
               b2 = Game.BG.getUnit("小守卫");
               b2.x = this.mot.x0 + 50;
               b2.y = this.mot.y0;
               b2.ai.attackBody(this.ai.targetBody);
            }
         }
         this.nowState = str0;
      }
      
      public function playStand() : *
      {
         this.img.goPlayLoop_break(this.AAHD.lastLabel);
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
         this.flesh_byDefine();
      }
      
      public function flesh_byDefine() : *
      {
         this.mot1.inData(0,this.define.vy,this.define.tweenValue,this.define.jumpHeight,this.define.jumpNum);
         this.mot2.inData(this.define.vx,this.define.vy,this.define.tweenValue,this.define.jumpHeight,this.define.jumpNum);
         this.ai.inData(this.define.grapRect,this.define.attackDelay,this.define.affterAttack,this.define.nextAttackTime,this.define.hoverRect);
      }
      
      public function upData_AILevel(level0:int = -1) : *
      {
         var l0:int = level0;
         if(l0 == -1)
         {
            l0 = this.define.aiLevel + 1;
         }
         this.define.aiLevel = l0;
         this.flesh_byDefine();
      }
      
      public function setLevel(num:int) : *
      {
         this.armsDefine.level = num;
         this.define.setLevel(num);
      }
      
      public function toDie() : *
      {
         if(this.toDieB)
         {
            this._die = 1;
            this.animation.enabled = false;
            this.img.goPlayOnce("die");
            this.hitHurtB = 1;
            this.attack.stopAttack();
            this.ai.state = "noing";
            this.ai.enabled = false;
            this.we_AI.enabled = false;
            this.extraSkill.clear();
            Game.oneScene.shake.startShake(4,0.8,Math.random() * 10,-this.shakeRange,this.shakeRange,0,"cos");
         }
      }
      
      public function get die() : int
      {
         if(this._die > 0)
         {
            if(this.img.dieB && this.img.lastFrameB)
            {
               return 2;
            }
            return 1;
         }
         return 0;
      }
      
      public function get hitRect() : Rectangle
      {
         var rect0:Rectangle = this.define.hitRect.clone();
         rect0.x += this.mot.x0;
         rect0.y += this.mot.y0;
         return rect0;
      }
      
      public function set x(value:Number) : *
      {
         this.mot2.setX(value);
         this.mot1.x0 = value;
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         this.mot2.setY(value);
         this.mot1.y0 = value;
         this.img.y = int(value);
      }
      
      public function get MX() : Number
      {
         var rect0:Rectangle = this.define.hitRect;
         return this.mot.x0 + rect0.x + rect0.width / 2;
      }
      
      public function get MY() : Number
      {
         var rect0:Rectangle = this.define.hitRect;
         return this.mot.y0 + rect0.y + rect0.height / 2;
      }
      
      public function bodyTimer() : *
      {
         this.attack.attackTimer();
         this.ai.aiTimer();
         this.we_AI.FTimer();
         this.img.imageTimer();
         this.mot.motionTimer();
         this.extraSkill.FTimer();
         this.animation.animationTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
      }
   }
}

