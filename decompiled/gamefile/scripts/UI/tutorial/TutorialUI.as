package UI.tutorial
{
   import UI.ClickEvent;
   import UI.UIGroup;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.GameData;
   import gs.TweenLite;
   import other.FunGroup;
   
   public class TutorialUI extends Sprite
   {
      
      public var UIG:UIGroup;
      
      public var mc:MovieClip;
      
      public var fun:FunGroup = new FunGroup();
      
      public var timer:Timer = new Timer(500);
      
      public var mustOverFun:String = "";
      
      private var arms_site0:int = 0;
      
      public var repeatB:Boolean = true;
      
      private var _isCarDo:Boolean = false;
      
      public function TutorialUI(_uig:*)
      {
         super();
         this.mc.stop();
         this.UIG = _uig;
         this.timer.addEventListener(TimerEvent.TIMER,this.FTimer);
         this.timer.start();
         this.mc.close_btn.addEventListener(MouseEvent.CLICK,this.overTutorial);
      }
      
      public function toTutorial() : *
      {
         var lv0:int = 0;
         trace("触发*******toTutorial() ");
         var GD:GameData = Game.gameData;
         if(GD.nowDifficult == 0)
         {
            lv0 = GD.newLevelData.p1.lockNum;
            this.startChipTutorial();
            if(GD.level == 3)
            {
               this.startArmsTutorial();
            }
            else if(GD.level == 5)
            {
               this.startSkillTutorial();
            }
            else if(GD.level != 7)
            {
               if(GD.level == 9)
               {
               }
            }
         }
      }
      
      public function overTutorial(e:* = null) : *
      {
         this.doMustOverFun(false);
      }
      
      public function showTween() : *
      {
         this.visible = true;
         this.mc.visible = true;
         this.mc.alpha = 0;
         TweenLite.to(this.mc,0.5,{
            "alpha":1,
            "delay":0.7
         });
      }
      
      public function doMustOverFun(showB:Boolean = true) : *
      {
         if(showB)
         {
            this.showTween();
         }
         else
         {
            TweenLite.to(this.mc,0.5,{
               "alpha":0,
               "visible":false
            });
         }
         if(this.mustOverFun != "")
         {
            this[this.mustOverFun]();
            trace("执行过程：" + this.mustOverFun);
            this.mustOverFun = "";
         }
      }
      
      public function startChipTutorial(e:* = null) : *
      {
         if(Game.gameData.tutorial == 0 || !this.repeatB)
         {
            Game.gameData.tutorial = 1;
            this.showTween();
            this.UIG.menu.strengthen_btn.addEventListener(MouseEvent.CLICK,this.chip_2);
            this.mc.gotoAndStop("chip_1");
            this.mustOverFun = "chip_1_over";
         }
      }
      
      internal function chip_1_over(e:* = null) : *
      {
         this.UIG.menu.strengthen_btn.removeEventListener(MouseEvent.CLICK,this.chip_2);
      }
      
      public function chip_2(e:* = null) : *
      {
         this.doMustOverFun();
         if(this.UIG.researchUI.labelCtrl.nowLabel != "arms_inlay")
         {
            this.mc.gotoAndStop("chip_2");
            this.UIG.researchUI.labelCtrl.arr[1].addEventListener(MouseEvent.CLICK,this.chip_3);
            this.mustOverFun = "chip_2_over";
         }
         else
         {
            this.chip_3();
         }
      }
      
      internal function chip_2_over(e:* = null) : *
      {
         this.UIG.researchUI.labelCtrl.arr[1].removeEventListener(MouseEvent.CLICK,this.chip_3);
      }
      
      public function chip_3(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("chip_3");
         this.UIG.researchUI.armsBox.chipHoleItems.addEventListener(MouseEvent.MOUSE_UP,this.chip_4);
         this.mustOverFun = "chip_3_over";
      }
      
      internal function chip_3_over(e:* = null) : *
      {
         this.UIG.researchUI.armsBox.chipHoleItems.removeEventListener(MouseEvent.MOUSE_UP,this.chip_4);
      }
      
      public function chip_4(e:* = null) : *
      {
         if(this.UIG.researchUI.armsBox.chipHoleItems.state == "fill")
         {
            this.doMustOverFun();
            this.mc.gotoAndStop("chip_4");
            this.fun.addOnceFun(this.chip_5,2 / 15);
            this.mustOverFun = "chip_4_over";
         }
      }
      
      internal function chip_4_over(e:* = null) : *
      {
         this.fun.ClearAllFun();
      }
      
      public function chip_5(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("chip_5");
         this.UIG.menu.main_btn.addEventListener(MouseEvent.CLICK,this.chip_6);
         this.mustOverFun = "chip_5_over";
      }
      
      internal function chip_5_over(e:* = null) : *
      {
         this.UIG.menu.main_btn.removeEventListener(MouseEvent.CLICK,this.chip_6);
      }
      
      public function chip_6(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("chip_6");
         this.UIG.mainUI._main.chooseLevel_btn.addEventListener(MouseEvent.CLICK,this.chip_7);
         this.mustOverFun = "chip_6_over";
      }
      
      internal function chip_6_over(e:* = null) : *
      {
         this.UIG.mainUI._main.chooseLevel_btn.removeEventListener(MouseEvent.CLICK,this.chip_7);
      }
      
      public function chip_7(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("chip_7");
         this.UIG.chooseLevelUI.levelBox.arr[1].addEventListener(MouseEvent.CLICK,this.overTutorial);
         this.mustOverFun = "chip_7_over";
      }
      
      internal function chip_7_over(e:* = null) : *
      {
         this.UIG.chooseLevelUI.levelBox.arr[1].removeEventListener(MouseEvent.CLICK,this.overTutorial);
      }
      
      public function startSkillTutorial(e:* = null) : *
      {
         if(Game.gameData.tutorial == 2 || !this.repeatB)
         {
            Game.gameData.tutorial = 3;
            this.showTween();
            this.UIG.menu.skill_btn.addEventListener(MouseEvent.CLICK,this.skill_3);
            this.mc.gotoAndStop("skill_1");
            this.mustOverFun = "skill_1_over";
         }
      }
      
      internal function skill_1_over(e:* = null) : *
      {
         this.UIG.menu.skill_btn.removeEventListener(MouseEvent.CLICK,this.skill_3);
      }
      
      public function skill_3(e:* = null) : *
      {
         this.doMustOverFun();
         if(this.UIG.researchUI.playerBox.labelCtrl.nowLabel != "attack")
         {
            this.mc.gotoAndStop("skill_3");
            this.UIG.researchUI.playerBox.label_mc.attack_btn.addEventListener(MouseEvent.CLICK,this.skill_4);
            this.mustOverFun = "skill_3_over";
         }
         else
         {
            this.skill_4();
         }
      }
      
      internal function skill_3_over(e:* = null) : *
      {
         this.UIG.researchUI.playerBox.label_mc.attack_btn.removeEventListener(MouseEvent.CLICK,this.skill_4);
      }
      
      internal function skill_4(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("skill_4");
         this.mustOverFun = "skill_4_over";
         this.UIG.researchUI.playerBox._btn.addEventListener(MouseEvent.CLICK,this.overTutorial);
      }
      
      internal function skill_4_over(e:* = null) : *
      {
         this.UIG.researchUI.playerBox._btn.removeEventListener(MouseEvent.CLICK,this.overTutorial);
      }
      
      public function startArmsTutorial(e:* = null) : *
      {
         this.showTween();
         this.UIG.menu.strengthen_btn.addEventListener(MouseEvent.CLICK,this.arms_2);
         this.mc.gotoAndStop("arms_1");
         this.mustOverFun = "arms_1_over";
      }
      
      internal function arms_1_over(e:* = null) : *
      {
         this.UIG.menu.strengthen_btn.removeEventListener(MouseEvent.CLICK,this.arms_2);
      }
      
      public function arms_2(e:* = null) : *
      {
         this.doMustOverFun();
         if(this.UIG.researchUI.labelCtrl.nowLabel != "arms_inlay")
         {
            this.mc.gotoAndStop("arms_2");
            this.UIG.researchUI.label_mc.arms_inlay_btn.addEventListener(MouseEvent.CLICK,this.arms_3);
            this.mustOverFun = "arms_2_over";
         }
         else
         {
            this.arms_3();
         }
      }
      
      internal function arms_2_over(e:* = null) : *
      {
         this.UIG.researchUI.label_mc.arms_inlay_btn.removeEventListener(MouseEvent.CLICK,this.arms_3);
      }
      
      public function arms_3(e:* = null) : *
      {
         this.doMustOverFun();
         if(this.UIG.researchUI.armsBox.armsBox.arr[2].state2 != "choose")
         {
            this.mc.gotoAndStop("arms_3");
            this.UIG.researchUI.armsBox.armsBox.arr[2].addEventListener(MouseEvent.CLICK,this.arms_4);
            this.mustOverFun = "arms_3_over";
         }
         else
         {
            this.arms_4();
         }
      }
      
      internal function arms_3_over(e:* = null) : *
      {
         this.UIG.researchUI.armsBox.armsBox.arr[2].removeEventListener(MouseEvent.CLICK,this.arms_4);
      }
      
      internal function arms_4(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("arms_4");
         this.mustOverFun = "arms_4_over";
         this.UIG.researchUI.armsBox.upgrade_btn.addEventListener(MouseEvent.CLICK,this.arms_5);
      }
      
      internal function arms_4_over(e:* = null) : *
      {
         this.UIG.researchUI.armsBox.upgrade_btn.removeEventListener(MouseEvent.CLICK,this.arms_5);
      }
      
      internal function arms_5(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("arms_5");
         this.mustOverFun = "arms_5_over";
         this.UIG.menu.change_btn.addEventListener(MouseEvent.CLICK,this.arms_6);
      }
      
      internal function arms_5_over(e:* = null) : *
      {
         this.UIG.menu.change_btn.removeEventListener(MouseEvent.CLICK,this.arms_6);
      }
      
      internal function arms_6(e:* = null) : *
      {
         this.doMustOverFun();
         if(this.UIG._changeUI.bag.label.nowLabel != "arms")
         {
            this.mc.gotoAndStop("arms_6");
            this.UIG._changeUI.bag.arms_btn.addEventListener(MouseEvent.CLICK,this.arms_7);
            this.mustOverFun = "arms_6_over";
         }
         else
         {
            this.arms_7();
         }
      }
      
      internal function arms_6_over(e:* = null) : *
      {
         this.UIG._changeUI.bag.arms_btn.removeEventListener(MouseEvent.CLICK,this.arms_7);
      }
      
      internal function arms_7(e:* = null) : *
      {
         this.doMustOverFun();
         var aid:ArmsItemsDataGroup = Game.gameData.armsItems;
         var aid0:ArmsItemsData = aid.getItemsByBase("cannon_lv1");
         if(aid0 is ArmsItemsData)
         {
            if(aid0.site != 0)
            {
               aid.bag_to_bag(aid0.site,0);
               this.UIG._changeUI.bag.fleshData();
            }
         }
         else
         {
            this.overTutorial();
         }
         this.mc.gotoAndStop("arms_7");
         this.arms_site0 = 2;
         this.mustOverFun = "arms_7_over";
         this.UIG._changeUI.armsBox.addEventListener(ClickEvent.ON_UP,this.car_1);
      }
      
      internal function arms_7_over(e:* = null) : *
      {
         this.UIG._changeUI.armsBox.removeEventListener(ClickEvent.ON_UP,this.car_1);
      }
      
      internal function car_1(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("car_1");
         this.UIG._changeUI.bag.car_btn.addEventListener(MouseEvent.CLICK,this.car_2);
         this.mustOverFun = "car_1_over";
      }
      
      internal function car_1_over(e:* = null) : *
      {
         this.UIG._changeUI.bag.car_btn.removeEventListener(ClickEvent.ON_UP,this.car_1);
      }
      
      internal function car_2(e:* = null) : *
      {
         this.doMustOverFun();
         if(this._isCarDo == false)
         {
            this.mc.gotoAndStop("car_2");
            this.UIG._changeUI.carBox.addEventListener(ClickEvent.ON_UP,this.arms_76);
            this.mustOverFun = "car_2_over";
            this._isCarDo = true;
         }
         else
         {
            this.overTutorial();
         }
      }
      
      internal function car_2_over(e:* = null) : *
      {
         this.UIG._changeUI.carBox.removeEventListener(ClickEvent.ON_UP,this.arms_76);
      }
      
      internal function arms_76(e:* = null) : *
      {
         if(this.UIG._changeUI.armsBox.arr[2].state == "fill")
         {
            this.doMustOverFun();
            this.mc.gotoAndStop("arms_76");
            this.UIG._changeUI.bag.sub_btn.addEventListener(MouseEvent.CLICK,this.arms_77);
            this.mustOverFun = "arms_76_over";
         }
      }
      
      internal function arms_76_over(e:* = null) : *
      {
         this.UIG._changeUI.bag.sub_btn.removeEventListener(MouseEvent.CLICK,this.arms_77);
      }
      
      internal function arms_77(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("arms_77");
         this.UIG._changeUI.subBox.arr[1].addEventListener(MouseEvent.CLICK,this.arms_8);
         this.mustOverFun = "arms_77_over";
      }
      
      internal function arms_77_over(e:* = null) : *
      {
         this.UIG._changeUI.subBox.arr[1].removeEventListener(MouseEvent.CLICK,this.arms_8);
      }
      
      internal function arms_8(e:* = null) : *
      {
         this.doMustOverFun();
         this.mc.gotoAndStop("arms_8");
         this.UIG.menu.shop_btn.addEventListener(MouseEvent.CLICK,this.overTutorial);
         this.mustOverFun = "arms_8_over";
      }
      
      internal function arms_8_over(e:* = null) : *
      {
         this.UIG.menu.shop_btn.removeEventListener(MouseEvent.CLICK,this.overTutorial);
      }
      
      public function FTimer(event:*) : *
      {
         this.fun.FTimer2();
      }
   }
}

