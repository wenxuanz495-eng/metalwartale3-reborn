package enemy.tercelFighter
{
   import body.attack.ArmsAttack;
   import body.define.EnemyDefine;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.SuspendMotion;
   import enemy.bansheeFighter.BansheeFighterAAHD;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class TercelFighterBody
   {
      
      public var mot:SuspendMotion = new SuspendMotion();
      
      public var img:MultipleImage = new MultipleImage();
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var attack:ArmsAttack;
      
      public var AAHD:BansheeFighterAAHD;
      
      public var ai:TercelFighter_AI;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public function TercelFighterBody()
      {
         super();
         this.AAHD = new BansheeFighterAAHD(this,this.img,this.armsDefine,this.define);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.ai = new TercelFighter_AI(this);
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
         this.flesh_byDefine();
      }
      
      public function flesh_byDefine() : *
      {
         this.mot.inData(this.define.vx,this.define.vy,this.define.tweenValue);
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
         this._die = 1;
         this.img.goPlayOnce("die");
         this.hitHurtB = 1;
         this.attack.stopAttack();
         this.ai.state = "noing";
         this.ai.enabled = false;
         Game.oneScene.shake.startShake(4,0.8,Math.random() * 10,-12,12,0,"cos");
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
         this.mot.setX(value);
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         this.mot.setY(value);
         this.img.y = int(value);
      }
      
      public function playStand() : *
      {
         this.img.goPlayLoop_break("stand");
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
         this.img.imageTimer();
         this.mot.motionTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
      }
   }
}

