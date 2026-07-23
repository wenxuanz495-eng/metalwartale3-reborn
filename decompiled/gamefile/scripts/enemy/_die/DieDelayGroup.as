package enemy._die
{
   import body.enemy.EnemyHeroBody;
   import body.motion.SuspendMotion;
   import enemy.intercessor.IntercessorBody;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DieDelayGroup
   {
      
      public var enabled:Boolean = true;
      
      public var str:String = "";
      
      public var arr:Array = [];
      
      public var diaArr:Array = [];
      
      public var firstDiaArr:Array = [];
      
      public var now_t:int = 0;
      
      public var followBody:* = null;
      
      public function DieDelayGroup()
      {
         super();
      }
      
      public static function stopAttack(b0:*, moveOrder:String = "middle") : *
      {
         var p0:Point = null;
         var p1:Point = null;
         var minY:int = 0;
         b0.ai.enabled = false;
         b0.hitHurtB = 1;
         if(b0 is EnemyHeroBody)
         {
            b0.SG.stopAll();
            b0.attack.stopAttack();
         }
         if(moveOrder == "middle")
         {
            p0 = Game.oneScene.getLockMiddle();
            trace("获得屏幕中心点:" + p0);
            p1 = p0.clone();
            if(b0.img.x + 300 < p0.x)
            {
               p1.x -= 300;
            }
            else if(b0.img.x - 300 > p0.x)
            {
               p1.x += 300;
            }
            minY = Game.BGHit.getMinY(p1.x);
            if(b0.mot is SuspendMotion)
            {
               p1.y = minY - 150;
            }
            else
            {
               p1.y = minY;
            }
            if(b0.img.x < p0.x - 300 || b0.img.x > p0.x + 300)
            {
               trace("跟踪目标:" + p0);
               b0.mot.followPoint(p1.x,p1.y);
            }
         }
      }
      
      public static function startAttack(b0:*) : *
      {
         b0.ai.enabled = true;
         b0.hitHurtB = 0;
      }
      
      public static function stopDie(b0:*) : *
      {
         var lighting_mc:MovieClip = null;
         var rect0:Rectangle = null;
         b0._die = 1;
         b0.hitHurtB = 1;
         if(Boolean(b0.hasOwnProperty("attack")))
         {
            b0.attack.stopAttack();
         }
         if(Boolean(b0.hasOwnProperty("animation")))
         {
            b0.animation.enabled = false;
         }
         b0.mot.toStopBreak();
         b0.playStand();
         b0.ai.state = "noing";
         b0.ai.enabled = false;
         if(b0 is EnemyHeroBody)
         {
            b0.SG.stopAll();
         }
         if(Boolean(b0.img.hasOwnProperty("lighting_mc")))
         {
            lighting_mc = Game.swfLoaderManager.getResource("car","enemy_die_electric");
            b0.img.addChild(lighting_mc);
            b0.img.lighting_mc = lighting_mc;
            rect0 = b0.define.hitRect;
            lighting_mc.scaleX = rect0.width / lighting_mc.width * 1.3;
            lighting_mc.scaleY = rect0.height / lighting_mc.height * 1.3;
            lighting_mc.x = rect0.x + rect0.width / 2;
            lighting_mc.y = rect0.y + rect0.height / 2;
            lighting_mc.play();
            Game.SG.playDeathDelayElectric();
         }
      }
      
      public static function startDie(b0:*) : *
      {
         Game.eventGroup.bodyDie(b0);
      }
      
      public function gameOver() : *
      {
         this.diaArr.length = 0;
         this.firstDiaArr.length = 0;
         this.now_t = 0;
         this.arr.length = 0;
         this.followBody = null;
      }
      
      public function addDialogue(str0:String, b0:*) : *
      {
         var n:* = undefined;
         var ed0:EnemyDialogue = null;
         this.diaArr.length = 0;
         this.firstDiaArr.length = 0;
         this.now_t = 0;
         var arr0:Array = str0.split(",");
         for(n in arr0)
         {
            ed0 = new EnemyDialogue();
            ed0.b0 = b0;
            ed0.inData(arr0[n]);
            this.diaArr.push(ed0);
            trace("创建EnemyDialogue：" + ed0);
         }
      }
      
      public function dialogueTimer() : *
      {
         var ed0:EnemyDialogue = null;
         var b0:* = undefined;
         var str0:String = null;
         var ed2:EnemyDialogue = null;
         if(this.diaArr.length > 0)
         {
            ++this.now_t;
            ed0 = this.diaArr[0];
            if(this.now_t >= ed0.time)
            {
               this.now_t = 0;
               b0 = ed0.b0;
               trace("执行命令：" + ed0);
               if(ed0.role == "die")
               {
                  b0.define.dieDelay.lighting_mc.visible = false;
                  b0.define.dieDelay.lighting_mc.stop();
                  b0.define.dieDelay.toDie();
                  return;
               }
               if(ed0.role == "hero")
               {
                  b0 = Game.BG.hero;
               }
               str0 = Game.gameDefine.dialogue.text[ed0.label];
               Game.dialogboxGroup.showDialog(b0,str0,null);
               this.flipToHero(b0);
               this.diaArr.shift();
               if(this.diaArr.length == 0)
               {
                  ed2 = new EnemyDialogue();
                  ed2.b0 = ed0.b0;
                  ed0.time = 90;
                  ed0.role = "die";
                  this.diaArr.push(ed0);
               }
            }
         }
      }
      
      public function addFisrtDialogue(str0:String, b0:*) : *
      {
         var n:* = undefined;
         var ed0:EnemyDialogue = null;
         this.firstDiaArr.length = 0;
         this.diaArr.length = 0;
         this.now_t = 0;
         b0.ai.enabled = false;
         b0.hitHurtB = 1;
         var p0:Point = Game.oneScene.getPositionMiddle();
         var p1:Point = p0.clone();
         var cx:int = b0.img.x - p0.x;
         if(cx > 0)
         {
            p1.x += 300;
         }
         else
         {
            p1.x -= 300;
         }
         var minY:int = Game.BGHit.getMinY(p1.x);
         if(b0.mot is SuspendMotion)
         {
            p1.y = minY - 150;
         }
         else
         {
            p1.y = minY;
         }
         if(b0 is EnemyHeroBody)
         {
            b0.SG.stopAll();
            b0.attack.stopAttack();
         }
         b0.mot.followPoint(p1.x,p1.y);
         this.followBody = b0;
         var arr0:Array = str0.split(",");
         for(n in arr0)
         {
            ed0 = new EnemyDialogue();
            ed0.b0 = b0;
            ed0.inData(arr0[n]);
            this.firstDiaArr.push(ed0);
            trace("创建游戏开始前对话：" + ed0);
         }
      }
      
      public function firstDialogueTimer() : *
      {
         var ed0:EnemyDialogue = null;
         var b0:* = undefined;
         var str0:String = null;
         var ed2:EnemyDialogue = null;
         if(this.firstDiaArr.length > 0)
         {
            ++this.now_t;
            ed0 = this.firstDiaArr[0];
            if(this.now_t >= ed0.time)
            {
               this.now_t = 0;
               b0 = ed0.b0;
               if(ed0.role == "start")
               {
                  trace("start——————————");
                  b0.ai.enabled = true;
                  b0.hitHurtB = 0;
                  Game.LG.level.firstDialogueOver(b0);
                  this.firstDiaArr.shift();
                  return;
               }
               if(ed0.role == "change")
               {
                  if(b0 is IntercessorBody)
                  {
                     b0.changeState("adjudicator");
                  }
                  this.firstDiaArr.shift();
               }
               else
               {
                  if(ed0.role == "hero")
                  {
                     b0 = Game.BG.hero;
                  }
                  str0 = Game.gameDefine.dialogue.text[ed0.label];
                  Game.dialogboxGroup.showDialog(b0,str0,null);
                  this.flipToHero(b0);
                  this.firstDiaArr.shift();
                  if(this.firstDiaArr.length == 0)
                  {
                     ed2 = new EnemyDialogue();
                     ed2.b0 = ed0.b0;
                     ed0.time = 90;
                     ed0.role = "start";
                     this.firstDiaArr.push(ed0);
                  }
               }
            }
         }
      }
      
      public function flipToHero(b0:*) : *
      {
         if(b0.mot.x0 - Game.BG.hero.mot.x0 > 0)
         {
            b0.img.flipToRight();
         }
         else
         {
            b0.img.flipToLeft();
         }
      }
      
      public function addDieDelay(b0:*) : *
      {
         b0._die = 1;
         b0.hitHurtB = 1;
         if(Boolean(b0.hasOwnProperty("attack")))
         {
            b0.attack.stopAttack();
         }
         if(Boolean(b0.hasOwnProperty("animation")))
         {
            b0.animation.enabled = false;
         }
         b0.mot.toStopBreak();
         b0.playStand();
         b0.ai.state = "noing";
         b0.ai.enabled = false;
         if(b0 is EnemyHeroBody)
         {
            b0.SG.stopAll();
         }
         this.flipToHero(b0);
         var dd:DieDelay = new DieDelay();
         dd.b0 = b0;
         b0.define.dieDelay = dd;
         var mc0:MovieClip = Game.swfLoaderManager.getResource("car","enemy_die_electric");
         dd.lighting_mc = mc0;
         dd.addLighting();
         this.arr.push(dd);
         var dia0:String = b0.define.dialogue;
         trace("根据单位的对话添加对话命令:" + dia0);
         if(dia0 != "")
         {
            this.addDialogue(dia0,b0);
         }
      }
      
      public function dieDelayTimer() : *
      {
         var n:* = undefined;
         var dd:DieDelay = null;
         var arr2:Array = [];
         for(n in this.arr)
         {
            dd = this.arr[n];
            ++dd.tt;
            if(dd.tt >= dd.max_t)
            {
               dd.lighting_mc.stop();
               Game.eventGroup.bodyDie(dd.b0);
               dd.b0 = null;
            }
            else
            {
               arr2.push(dd);
               if(dd.lighting_mc.currentFrame == 1)
               {
                  dd.b0.shake.startShake(30,1,Math.random() * 10,-2,2,0.5,"random");
               }
            }
         }
         this.arr = arr2;
      }
      
      public function FTimer() : *
      {
         var cx0:int = 0;
         if(this.enabled)
         {
            this.dieDelayTimer();
            this.dialogueTimer();
            if(this.followBody != null)
            {
               cx0 = 0;
               if(this.followBody.mot is SuspendMotion)
               {
                  cx0 = int(this.followBody.mot.getGap());
               }
               else
               {
                  cx0 = int(this.followBody.mot.getGapX());
               }
               if(cx0 < 50)
               {
                  trace("怪物到达目标点点，此时开始进行firstDialogueTimer()");
                  this.followBody = null;
                  this.firstDialogueTimer();
               }
            }
            else
            {
               this.firstDialogueTimer();
            }
         }
      }
      
      public function pause() : *
      {
         var n:* = undefined;
         var dd:DieDelay = null;
         this.enabled = false;
         for(n in this.arr)
         {
            dd = this.arr[n];
            dd.lighting_mc.stop();
         }
      }
      
      public function resume() : *
      {
         var n:* = undefined;
         var dd:DieDelay = null;
         this.enabled = true;
         for(n in this.arr)
         {
            dd = this.arr[n];
            dd.lighting_mc.play();
         }
      }
   }
}

