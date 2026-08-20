package gameAll.level
{
   import UI.gaming.GamingUI;
   import body.lieutenant.LieutenantBody;
   import enemy.charger.ChargerBody;
   import enemy.gundam.GundamBody;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import gameAll.data.ArmsItemsData;
   
   public class Level_0 extends Levels
   {
      
      private var state:String = "no";
      
      private var lieu:LieutenantBody;
      
      private var gundam:GundamBody;
      
      private var magic_cube:MovieClip;
      
      private var gundamText:String = "";
      
      private var cubePoint:Point;
      
      private var gamingUI:GamingUI;
      
      public function Level_0()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         Game.gameData.setValue_byLevel();
         this.gamingUI = Game.uiGroup.gamingUI;
         this.gamingUI.fleshShowArms();
         this.gamingUI.hideSkillIcon();
         this.gamingUI.hideArmsBar();
         Game.uiGroup.leftUI.hideBtn();
         addOnceFun(this.ctrlTipShow,1 / 5);
         hero.changeRocket(1);
         hero.changePlasma(1);
         Game.uiGroup.fleshNew();
         Game.payController2.payCtrl("getTotalRecharged",true);
      }
      
      private function test() : *
      {
         hero.mot.x0 = 3750;
         hero.mot.y0 = 400;
         Game.oneScene.inPositionMiddle(hero.mot.x0,hero.mot.y0);
         this.lieutenantShow();
      }
      
      override public function showDownUI() : *
      {
      }
      
      private function addCube() : *
      {
         this.magic_cube = Game.swfLoaderManager.getResource("items","magic_cube");
         this.magic_cube.x = this.cubePoint.x;
         this.magic_cube.y = this.cubePoint.y;
         Game.gameSprite.effectL.addChild(this.magic_cube);
      }
      
      private function lieuDespise() : *
      {
         this.lieu.ai.enabled = false;
         this.lieu.toStop();
         Game.dialogboxGroup.showDialog(this.lieu,"原能魔方！！");
         hero.hitHurtB = 1;
         this.gundam = BG.addGundam();
         this.gundam.setLevel(1000);
         this.gundam.img.goPlayLoop_break("plane");
         this.gundam.changeState("plane");
         this.gundam.ai.enabled = false;
         this.gundam.mot.x0 = 5400;
         this.gundam.mot.y0 = this.magic_cube.y + 130;
         this.gundam.mot.toStop();
         this.gundam.mot.stopFollow();
      }
      
      private function gundamShow() : *
      {
         this.gundam.img.flipToRight();
         this.gundam.speedUp(1);
         this.gundam.mot.followPoint(this.magic_cube.x,this.magic_cube.y + 130);
         Game.uiGroup.gamingUI.bossBarTarget = this.gundam;
         addFun(this.gundamHitCube);
      }
      
      private function gundamHitCube() : *
      {
         var cx:Number = this.gundam.mot.x0 - this.magic_cube.x;
         var cy:Number = this.gundam.mot.y0 - 130 - this.magic_cube.y;
         if(Math.abs(cx) < 200 && Math.abs(cy) < 200)
         {
            this.magic_cube.parent.removeChild(this.magic_cube);
            removeFun(this.gundamHitCube);
            Game.dialogboxGroup.showDialog(this.lieu,"？？？？？？？",null,3);
            this.gundam.mot.followPoint(Game.oneScene.moveRectArr[1].x - 200,441 - 300 / Math.sqrt(3));
            addOnceFun(this.gundamChange,3 / 5);
            addOnceFun(this.gundamSay1,2 / 5);
            addOnceFun(this.gundamSay2,5 / 5);
            addOnceFun(this.gundamSay3,1 / 5);
            addOnceFun(this.gundamSay4,2 / 5);
            addOnceFun(this.lieuAgainst,0.5 / 5);
            addOnceFun(this.lieuDie,0.5 / 5);
            addOnceFun(this.heroSeeLieu,2 / 5);
            addOnceFun(this.heroSay,4 / 5);
            addOnceFun(this.gundamLieu,5 / 5);
            addOnceFun(this.gundamChange3,6 / 5);
            addOnceFun(this.gundamLeave,0.8 / 5);
            addOnceFun(this.getItms,2 / 5);
            addOnceFun(this.gamingUI.showArmsBar,4 / 5);
            addOnceFun(this.showArms,0.5 / 5);
            addOnceFun(this.showEnegry,5 / 4);
            addOnceFun(this.showEnegry2,5 / 4);
            addOnceFun(Game.oneScene.unLockView,3 / 5);
         }
      }
      
      private function gundamChange() : *
      {
         this.gundam.changeState("fly");
         this.gundam.ai.nowAttackOrder = "Gundam_fly_2";
         this.gundam.img.flipToRight();
         this.lieu.ai.enabled = true;
      }
      
      private function gundamSay1() : *
      {
         Game.dialogboxGroup.showDialog(this.gundam,"蝼蚁们！你们的力量微不足道！");
      }
      
      private function gundamSay2() : *
      {
         hero.key.enabled = false;
         hero.toStop();
         this.lieu.ai.followB = false;
         this.lieu.toStop();
         var cx:Number = hero.img.x - Game.oneScene.getPositionMiddle().x;
         var mx0:Number = 0;
         var my0:Number = 441 - 250 / Math.sqrt(3);
         var dic0:String = "no";
         if(cx > 0)
         {
            mx0 = hero.img.x - 300;
            this.gundam.img.flipToLeft();
            dic0 = "left";
         }
         else
         {
            mx0 = hero.img.x + 300;
            this.gundam.img.flipToRight();
            dic0 = "right";
         }
         var cxx:Number = this.gundam.img.x - mx0;
         var cxt:Number = Math.abs(cxx / 2000);
         trace("cxt:" + cxt);
         this.gundam.speedUp(cxt,dic0);
         this.gundam.mot.followPoint(mx0,my0);
      }
      
      private function gundamSay3() : *
      {
         Game.dialogboxGroup.showDialog(this.gundam,"来吧！接受审判之光的制裁吧！",null,3);
      }
      
      private function gundamSay4() : *
      {
         this.gundam.armsDefine.inData("Gundam_fly_2",0);
         this.gundam.attack.startAttackOnce();
      }
      
      private function lieuAgainst() : *
      {
         var cx:Number = this.lieu.img.x - hero.img.x;
         var cxt:Number = Math.abs(cx / 1000);
         if(cx > 0)
         {
            this.lieu.img.flipToRight();
         }
         else
         {
            this.lieu.img.flipToLeft();
         }
         this.lieu.speedUp(cxt);
         this.lieu.toJump();
      }
      
      private function lieuDie() : *
      {
         this.lieu.toDie();
         Game.BG.clearArr(Game.BG.sub_arr);
         hero.SG.fleshByArr(["elecGun_lv1"]);
         hero.key.enabled = true;
      }
      
      private function heroSeeLieu() : *
      {
         Game.dialogboxGroup.showDialog(this.lieu,"想成为英雄的话， 就一定要坚持自己的正义。接下来靠你了…");
      }
      
      private function heroSay() : *
      {
         Game.dialogboxGroup.showDialog(hero,"不！罗杰中尉！",null,3);
      }
      
      private function gundamLieu() : *
      {
         BG.delBody_inArr(BG.heroCar_arr,this.lieu);
         Game.dialogboxGroup.showDialog(this.gundam,"那个中尉居然舍身为你挡了一枪！人类还真有意思，我，等你来复仇！");
         hero.hitHurtB = 0;
      }
      
      private function gundamChange3() : *
      {
         this.gundam.changeState("plane");
         this.gundam.img.flipToRight();
         this.gundam.mot.followPoint(this.gundam.mot.x0 - 100,this.gundam.mot.y0);
      }
      
      private function gundamLeave() : *
      {
         this.gundam.mot.followPoint(-2800,-1300);
         this.gundam.img.flipToRight();
         this.gundam.speedUp(0.6);
         this.gamingUI.bossBarTarget = null;
         this.gamingUI.hideBossBar();
         this.gundam.hitHurtB = 1;
      }
      
      private function getItms() : *
      {
         Game.dialogboxGroup.showGameTip("1-1-5");
         Game.gameData.armsItems.addItems("fireFairy_lv1");
         Game.gameData.armsItems.changeArmsByLabel("fireFairy_lv1");
         this.gamingUI.fleshArms();
      }
      
      private function showArms() : *
      {
         var jumpicon:DisplayObject = this.gamingUI.arms2;
         var p0:Point = jumpicon.localToGlobal(new Point());
         p0.x += jumpicon.width / 2;
         Game.dialogboxGroup.showSkillTip("1-1-6",p0);
         BG.clearArr(BG.Gundam_arr);
         this.gundam = null;
      }
      
      private function showEnegry() : *
      {
         var jumpicon:DisplayObject = this.gamingUI.arms2;
         var p0:Point = jumpicon.localToGlobal(new Point());
         p0.x += jumpicon.width / 2;
         p0.y += jumpicon.height - 5;
         p0.x -= 35;
         p0.y -= 31;
         Game.dialogboxGroup.showSkillTip("1-1-7",p0);
      }
      
      private function showEnegry2() : *
      {
         Game.dialogboxGroup.showSkillTip("1-1-8",new Point(123,42));
      }
      
      private function ctrlTipShow() : *
      {
         Game.dialogboxGroup.showGameTip("1-1-1");
      }
      
      private function lieutenantShow() : *
      {
         var lieu0:LieutenantBody = BG.addLieutenantBody();
         lieu0.SG.fleshByArr(["snake_lv1","protonImpact_lv1","lightningBall_lv4"]);
         lieu0.SG.fleshAllPosition();
         var pp0:Point = Game.oneScene.getPositionMiddle();
         lieu0.mot.x0 = pp0.x - 500;
         lieu0.mot.y0 = pp0.y;
         lieu0.ai.followBody = hero;
         lieu0.moveToRight();
         lieu0.speedUp(0.4);
         BG.allEnemyAttackHero(lieu0);
         this.lieu = lieu0;
         this.state = "lieuShow";
      }
      
      private function skillShow() : *
      {
         this.gamingUI.showSkillIcon();
         Game.gameData.playerData.setFullSkillArr([1,1,1,0,0]);
         Game.eventGroup.fleshSkill();
      }
      
      private function skillTeach() : *
      {
         var jumpicon:DisplayObject = this.gamingUI.skillBox.arr[1];
         var p0:Point = jumpicon.localToGlobal(new Point());
         p0.x += jumpicon.width / 2;
         Game.dialogboxGroup.showSkillTip("1-1-3",p0,10);
      }
      
      private function skillTeach2() : *
      {
         var jumpicon:DisplayObject = this.gamingUI.skillBox.arr[3];
         var p0:Point = jumpicon.localToGlobal(new Point());
         p0.x += jumpicon.width;
         Game.dialogboxGroup.showSkillTip("1-1-31",p0,4);
      }
      
      private function lieuTalk2() : *
      {
         var cx0:Number = this.lieu.img.x - hero.img.x;
         var xx0:Number = -70;
         if(cx0 > 0)
         {
            xx0 = 70;
         }
         Game.dialogboxGroup.showDialog(this.lieu,"这些特殊功能都有冷却时间，谨慎使用！");
         this.lieu.ai.enabled = true;
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         if(b0.type == "boss")
         {
            this.gamingUI.hideBossBar();
            this.cubePoint = new Point(b0.img.x,b0.img.y - 70);
            addOnceFun(this.addCube,1 / 5);
            addOnceFun(this.lieuDespise,3 / 5);
            addOnceFun(this.gundamShow,3 / 5);
         }
      }
      
      override public function bodyAdd(b0:*) : *
      {
         if(b0 is ChargerBody)
         {
            b0.ai.bilvArr = [1,1];
            this.lieu.ai.enabled = true;
         }
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         if(id0 == "enemy1")
         {
            Game.dialogboxGroup.showGameTip("1-1-2");
         }
         else if(id0 == "enemy2")
         {
            addOnceFun(this.lieutenantShow,9 / 5);
         }
         else if(id0 == "enemy4")
         {
            Game.dialogboxGroup.showDialog(this.lieu,"快，主控室遭到攻击！我们必须抓紧时间！");
            addOnceFun(this.lieuSay10,3 / 5);
            this.lieu.ai.enabled = false;
            this.lieu.toStop();
            Game.oneScene.showScreenEffect();
            this.state = "chargerShow";
         }
      }
      
      public function lieuSay10() : *
      {
         Game.dialogboxGroup.showDialog(this.lieu,"要是原能魔方被夺走，那就麻烦大了，那可是人类胜利的关键！",null,6);
      }
      
      override public function unlockView() : *
      {
         var cx0:Number = NaN;
         var xx0:Number = NaN;
         if(this.state == "lieuShow")
         {
            this.state = "lieuShowing";
            cx0 = this.lieu.img.x - hero.img.x;
            xx0 = -70;
            if(cx0 > 0)
            {
               xx0 = 70;
            }
            this.lieu.ai.enabled = false;
            this.lieu.toStop();
            Game.dialogboxGroup.showDialog(this.lieu,"嘿！列兵！你的超合金战车拥有2种特殊功能！我来帮你激活它们！");
            addOnceFun(this.skillShow,4 / 5);
            addOnceFun(this.skillTeach,0.5 / 5);
            addOnceFun(this.skillTeach2,3 / 5);
            addOnceFun(this.lieuTalk2,4 / 5);
            addOnceFun(super.unlockView,3 / 5);
         }
         else if(this.state == "chargerShow")
         {
            this.state = "chargerShowing";
         }
         else
         {
            Game.oneScene.unLockView();
         }
      }
      
      override protected function enemyOverEvent(id0:String) : *
      {
      }
      
      override public function exitEvent() : *
      {
         var items0:ArmsItemsData = Game.gameData.subItems.addItems("elecGun_lv1");
         Game.gameData.subItems.bag_to_equip(items0.site,0);
         this.gamingUI.showArmsBar();
         this.gamingUI.showSkillIcon();
         Game.uiGroup.leftUI.showBtn();
         super.exitEvent();
      }
   }
}

