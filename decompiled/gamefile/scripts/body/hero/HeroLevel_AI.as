package body.hero
{
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import gameAll.data.ArmsItemsData;
   
   public class HeroLevel_AI
   {
      
      public var BB:HeroCarBody;
      
      public var enabled:Boolean = false;
      
      public var pickItemsB:Boolean = true;
      
      public var left_X:int = -10000;
      
      public var attackBody:* = null;
      
      private var isJump:Boolean = false;
      
      public function HeroLevel_AI(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function startAI() : *
      {
         this.enabled = true;
         this.pickItemsB = true;
         trace("开启了ai");
      }
      
      public function stopAI() : *
      {
         this.enabled = false;
      }
      
      public function moveTimer() : *
      {
         var rect0:Rectangle = null;
         var x0:int = this.BB.mot.x0;
         var mx0:int = 0;
         var my0:int = 0;
         var lockB:Boolean = Game.oneScene.lockB;
         if(Game.gameData.materialsItems.getFillB())
         {
            this.pickItemsB = true;
         }
         if(lockB)
         {
            rect0 = Game.oneScene.viewRangeRect2;
            mx0 = rect0.x + rect0.width / 2;
            this.pickItemsB = false;
            this.left_X = -10000;
            this.swingShoot();
            this.changeArms();
         }
         else
         {
            this.BB.attack.stopLoop();
            this.BB.SG.stopAll();
            if(!this.pickItemsB)
            {
               if(this.left_X < 0)
               {
                  this.left_X = Game.itemsGroup.getLeft_X_limit(x0,1000) - 140;
                  if(this.left_X < x0 - 10000)
                  {
                     this.left_X = x0 - 140;
                  }
               }
               mx0 = this.left_X;
               if(x0 < mx0 + 60)
               {
                  this.pickItemsB = true;
               }
            }
            else
            {
               mx0 = x0 + 1000;
            }
         }
         trace("当前点：" + x0 + "   目标点：" + mx0);
         if(x0 < mx0 - 50)
         {
            this.BB.moveToRight();
         }
         else if(x0 > mx0 + 50)
         {
            this.BB.moveToLeft();
         }
         else
         {
            this.BB.toStop();
         }
         var bdg:* = this.BB.mot.BDG;
         if(bdg.dof[2].type >= 1 || bdg.dof[3].type >= 1)
         {
            if(this.BB.mot.vy > -0.1)
            {
               if(!this.isJump)
               {
                  this.toJump();
                  setTimeout(this.toJump,600);
                  this.isJump = true;
               }
            }
         }
      }
      
      private function toJump() : void
      {
         this.BB.key.useSkillName("jump");
         this.BB.key.toJump();
         this.isJump = false;
      }
      
      private function changeArms() : *
      {
         var arr0:Array = null;
         var aid0:ArmsItemsData = null;
         var aid1:ArmsItemsData = Game.gameData.nowArmsData;
         if(aid1.nowEnergy <= 0)
         {
            arr0 = Game.gameData.armsItems.equArr;
            aid0 = arr0[int(arr0.length * Math.random())];
            Game.eventGroup.changArms(aid0.site);
         }
      }
      
      public function swingShoot() : *
      {
         var earr:Array = null;
         var num0:int = 0;
         var chooseB:Boolean = false;
         if(this.attackBody == null)
         {
            chooseB = true;
         }
         else if(this.attackBody.die > 0)
         {
            this.attackBody = null;
            chooseB = true;
         }
         else
         {
            this.BB.inMouseXY(this.attackBody.MX,this.attackBody.MY);
            this.BB.attack.startAttack();
            this.BB.SG.attackAll();
            if(Math.random() < 0.2)
            {
               chooseB = true;
            }
         }
         if(chooseB)
         {
            earr = Game.BG.getLiveEnemy();
            if(earr.length > 0)
            {
               num0 = earr.length * Math.random();
               this.attackBody = earr[num0];
            }
            else
            {
               this.attackBody = null;
               this.BB.attack.stopLoop();
               this.BB.SG.stopAll();
            }
         }
      }
      
      public function aiTimer() : *
      {
         if(this.enabled)
         {
            this.moveTimer();
         }
      }
   }
}

