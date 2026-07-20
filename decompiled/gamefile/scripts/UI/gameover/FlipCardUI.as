package UI.gameover
{
   import data.TextWay;
   import fl.transitions.easing.None;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import goods.GoodsDefine;
   import gs.TweenLite;
   import gs.easing.Back;
   
   public class FlipCardUI extends MovieClip
   {
      
      public var DD:*;
      
      public var num_txt:TextField;
      
      public var return_btn:SimpleButton;
      
      public var return2_btn:SimpleButton;
      
      public var card_arr:Array = [];
      
      private var _nowNum:String = "";
      
      private var type_arr:Array = [];
      
      private var listenB:Boolean = false;
      
      public var index:int = -1;
      
      public function FlipCardUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         var bar0:FlipCardBar = null;
         for(var i:int = 0; i < 5; i++)
         {
            bar0 = new FlipCardBar();
            bar0.y = 247 - 240;
            bar0.x = 198 + 140 * i - Game.stageWidth / 2;
            addChild(bar0);
            this.card_arr.push(bar0);
            bar0.index = i;
            bar0.buttonMode = true;
            bar0._mc.addEventListener(MouseEvent.MOUSE_OVER,this.cardOver);
            bar0._mc.addEventListener(MouseEvent.MOUSE_OUT,this.cardOut);
            bar0._mc.addEventListener(MouseEvent.CLICK,this.cardClick);
            bar0.itemsIcon.addEventListener(MouseEvent.MOUSE_OVER,Game.uiGroup.itemsIconOver);
            bar0.itemsIcon.addEventListener(MouseEvent.MOUSE_OUT,Game.uiGroup.itemsIconOut);
            bar0.armsIcon.addEventListener(MouseEvent.MOUSE_OVER,Game.uiGroup.itemsIconOver);
            bar0.armsIcon.addEventListener(MouseEvent.MOUSE_OUT,Game.uiGroup.itemsIconOut);
         }
         this.return_btn.addEventListener(MouseEvent.CLICK,this.returnFun);
         this.return2_btn.addEventListener(MouseEvent.CLICK,this.returnFun);
         this.addEventListener(Event.ENTER_FRAME,this.enterFrame);
         this.flipStart_init();
      }
      
      public function get nowNum() : int
      {
         return int(TextWay.getText(this._nowNum));
      }
      
      public function set nowNum(v0:int) : *
      {
         this._nowNum = TextWay.toCode(String(v0));
      }
      
      public function flipStart_init(levelState0:String = "normal") : *
      {
         if(levelState0 == "normal")
         {
            this.DD = Game.gameDefine.flipCard;
         }
         else if(levelState0 == "arena")
         {
            this.DD = Game.gameDefine.arenaFlipCard;
            Game.uiGroup.unionUI.CUnionTask.AddTaskGoal(1);
         }
         else if(levelState0 == "extra")
         {
            this.DD = Game.gameDefine.extraFlipCard;
         }
         else if(levelState0 == "specialExtra")
         {
            this.DD = Game.gameDefine.extraFlipCard;
         }
         else if(levelState0 == "union")
         {
            this.DD = Game.gameDefine.unionFlipCard;
         }
         this.nowNum = this.DD.getFlipNum(Game.gameData.rankLevel);
         if(Game.gameData.vipData.nowVip != "")
         {
            ++this.nowNum;
         }
         this.typeArr_init();
         this.showAllOpposite();
         this.num_txt.text = this.nowNum + "";
      }
      
      public function typeArr_init() : *
      {
         var n:* = undefined;
         this.type_arr = [];
         for(n in this.card_arr)
         {
            this.type_arr.push("");
         }
      }
      
      public function returnFun(e:*) : *
      {
         if(this.nowNum > 0)
         {
            Game.uiGroup.checkTip.showCheck2("你还有翻牌机会，是否真的要离开？",1,this.hide);
         }
         else
         {
            this.hide();
         }
      }
      
      public function hide(e:* = null) : *
      {
         this.visible = false;
         Game.uiGroup.saveDataNoUI();
         Game.eventGroup.toTutorial();
      }
      
      private function showAllOpposite() : *
      {
         var n:* = undefined;
         var bar0:FlipCardBar = null;
         for(n in this.card_arr)
         {
            bar0 = this.card_arr[n];
            bar0.init();
            bar0.scaleX = 1;
            bar0.scaleY = 1;
         }
      }
      
      private function cardOver(e:*) : *
      {
         var bar0:* = e.target.parent;
         if(!this.listenB && !bar0.showTextB && this.nowNum > 0)
         {
            TweenLite.to(bar0,0.5,{
               "scaleX":1.05,
               "scaleY":1.05,
               "ease":Back.easeOut
            });
         }
      }
      
      private function cardOut(e:*) : *
      {
         var bar0:* = e.target.parent;
         if(!this.listenB && !bar0.showTextB && this.nowNum > 0)
         {
            TweenLite.to(bar0,0.3,{
               "scaleX":1,
               "scaleY":1,
               "ease":None.easeNone
            });
         }
      }
      
      private function cardClick(e:*) : *
      {
         var type0:String = null;
         var d_str0:String = null;
         var d0:GoodsDefine = null;
         var bagFillB:Boolean = false;
         var aid0:* = undefined;
         var bar0:* = e.target.parent;
         if(!this.listenB && !bar0.showTextB && this.nowNum > 0)
         {
            this.index = bar0.index;
            --this.nowNum;
            this.num_txt.text = this.nowNum + "";
            type0 = this.DD.getType_byArr(this.type_arr);
            this.type_arr[this.index] = type0;
            d_str0 = this.DD.getGoodsDefineStr_byType(type0,Game.gameData.nowGameEnemyLevel);
            trace("d_str0：" + d_str0 + "Game.gameData.nowGameEnemyLevel：" + Game.gameData.nowGameEnemyLevel);
            bar0.goodsDefineStr = d_str0;
            d0 = bar0.getDefine();
            bagFillB = false;
            if(Game.gameData.materialsItems.getSurplus() <= 0 && d0.type == "materials")
            {
               aid0 = Game.gameData.materialsItems.getItemsByBase(d0.id);
               if(aid0 == null)
               {
                  bagFillB = true;
                  bar0.txt.gotoAndStop(2);
               }
            }
            if(bagFillB)
            {
               bar0.txt.gotoAndStop(2);
            }
            else
            {
               bar0.txt.gotoAndStop(1);
               if((d0.type == "sub" || d0.type == "arms") && Game.gameData.checkArms_byIDArr([d0.define.id]) != "")
               {
                  bar0.txt.gotoAndStop(3);
               }
               else
               {
                  Game.uiGroup.addGift_byArr([d0],true,-1,false);
               }
            }
            bar0.playToPositive();
            this.listenB = true;
         }
      }
      
      private function enterFrame(e:*) : *
      {
         var n:* = undefined;
         var bar0:FlipCardBar = null;
         for(n in this.card_arr)
         {
            bar0 = this.card_arr[n];
            if(bar0._mc.currentFrameLabel == "to2" && !bar0.showTextB)
            {
               bar0.showGoodsDefine();
               if(this.index == n)
               {
                  this.listenB = false;
                  this.index = -1;
                  bar0.scaleX = 1;
                  bar0.scaleY = 1;
                  if(bar0.txt.currentFrame == 1)
                  {
                     Game.SG.playSound("upgradeArms");
                  }
                  else
                  {
                     Game.SG.playSound("failureItems");
                  }
                  if(this.nowNum <= 0)
                  {
                     this.showAllCard();
                     trace("翻牌后自动保存  Game.uiGroup.saveDataNoUI()");
                  }
               }
            }
         }
      }
      
      private function showAllCard() : *
      {
         var n:* = undefined;
         var index0:int = 0;
         var type0:String = null;
         var d_str0:String = null;
         var bar0:* = undefined;
         for(n in this.type_arr)
         {
            index0 = this.type_arr.indexOf("");
            if(index0 == -1)
            {
               break;
            }
            type0 = this.DD.getType_byArr(this.type_arr);
            this.type_arr[index0] = type0;
            d_str0 = this.DD.getGoodsDefineStr_byType(type0,Game.gameData.nowGameEnemyLevel);
            bar0 = this.card_arr[index0];
            bar0.goodsDefineStr = d_str0;
            bar0.showYouGetB = false;
            bar0.playToPositive();
         }
      }
   }
}

