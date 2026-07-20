package enemy.rolling
{
   import body.attack.ArmsAttack;
   import body.define.EnemyDefine;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   import enemy._normal.Normal_ExtraSkill;
   import enemy.electricSaw.ElectricSawAnimation;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class RollingBody
   {
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var img:MultipleImage = new MultipleImage();
      
      public var mot:GroundMotion = new GroundMotion();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var animation:ElectricSawAnimation;
      
      public var AAHD:RollingAAHD;
      
      public var ai:Rolling_AI;
      
      public var attack:ArmsAttack;
      
      public var extraSkill:Normal_ExtraSkill;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public function RollingBody()
      {
         super();
         this.animation = new ElectricSawAnimation(this.img,this.mot);
         this.AAHD = new RollingAAHD(this,this.img,this.armsDefine,this.define);
         this.ai = new Rolling_AI(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.extraSkill = new Normal_ExtraSkill(this);
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
         this.flesh_byDefine();
      }
      
      public function flesh_byDefine() : *
      {
         this.mot.inData(this.define.vx,this.define.vy,this.define.tweenValue,this.define.jumpHeight,this.define.jumpNum);
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
         this.define.setLevel(num);
         this.img.setLevel(num);
      }
      
      public function toDie() : *
      {
         this._die = 1;
         this.img.goPlayOnce("die");
         this.extraSkill.clear();
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.attack.stopAttack();
         this.ai.state = "noing";
         this.ai.enabled = false;
         Game.oneScene.shake.startShake(8,1,Math.random() * 10,-10,10,0,"cos");
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
      
      public function playStand() : *
      {
         this.img.goPlayLoop_break("stand");
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
         this.extraSkill.FTimer();
         this.shake.shakeTimer();
         this.animation.animationTimer();
         this.img.imageTimer();
         this.mot.motionTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
      }
   }
}

