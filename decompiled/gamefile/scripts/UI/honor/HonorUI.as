package UI.honor
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.label.LabelCtrl;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import gameAll.honor.HonorData;
   import gameAll.honor.OneHonorDefine;

   public class HonorUI extends Sprite
   {

      public var labelCtrl:LabelCtrl = new LabelCtrl();

      public var ac_btn:SimpleButton;

      public var noac_btn:SimpleButton;

      public var have_btn:SimpleButton;

      public var no_btn:SimpleButton;

      public var light_sp:Sprite;

      public var honorData:HonorData;

      public var nowHonor_txt:TextField;

      public var property_txt:TextField;

      public var condition_txt:TextField;

      public var use_btn:SimpleButton;

      public var sBar:SountoScrollBar;

      public var con:Sprite = new Sprite();

      public var cover_mc:Sprite;

      public var bar_arr:Array = [];

      public var nowChoosebar:* = null;

      public var honor_mc:*;

      public var ac:AchievementUI;

      public var smallBtnWrap:Sprite = new Sprite();

      public var useSmallBtn:SimpleButton;

      public var giveupBtn:SimpleButton;

      public var hideBtn:SimpleButton;

      public var showBtn:SimpleButton;

      public var useWrap:Sprite;

      public var giveupWrap:Sprite;

      public var hideWrap:Sprite;

      public var showWrap:Sprite;

      public function HonorUI()
      {
         super();
         this.mouseEnabled = false;
         this.honor_mc.mouseEnabled = false;
         this.nowHonor_txt = this.honor_mc.nowHonor_txt;
         this.property_txt = this.honor_mc.property_txt;
         this.condition_txt = this.honor_mc.condition_txt;
         this.use_btn = this.honor_mc.use_btn;
         this.sBar = this.honor_mc.sBar;
         this.cover_mc = this.honor_mc.cover_mc;
         this.con.x = 40;
         this.con.y = 97;
         this.honor_mc.addChild(this.con);
         this.con.mask = this.cover_mc;
         this.honorData = Game.gameData.honorData;
         this.sBar.setHigh(this.cover_mc.height);
         this.labelCtrl.inData([this.have_btn,this.no_btn,this.ac_btn,this.noac_btn],this.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.use_btn.addEventListener(MouseEvent.CLICK,this.useClick);
         this.honor_mc.addChild(this.sBar);
         this.makeSmallButtons();
      }

      public function makeSmallButtons() : *
      {
         var BtnClass:Class = null;
         var W0:Number = this.use_btn.width;
         var H0:Number = this.use_btn.height;
         this.W0_cached = W0;
         var s0:Number = 0.46;
         var gap0:Number = 8;
         var sw0:Number = W0 * s0;
         var sh0:Number = H0 * s0;
         var cx0:Number = this.use_btn.x + W0 / 2;
         var yBottom:Number = this.use_btn.y + H0 - sh0;
         var yTop:Number = yBottom - sh0 - gap0;
         var xLeft:Number = cx0 - (sw0 * 2 + gap0) / 2;
         var xRight:Number = xLeft + sw0 + gap0;
         try
         {
            BtnClass = getDefinitionByName(getQualifiedClassName(this.use_btn)) as Class;
         }
         catch(err:Error)
         {
            BtnClass = null;
         }
         this.useSmallBtn = this.makeSmallBtn(BtnClass,"使用称号",xLeft,yTop,s0);
         this.giveupBtn = this.makeSmallBtn(BtnClass,"放弃称号",xRight,yTop,s0);
         this.hideBtn = this.makeSmallBtn(BtnClass,"隐藏称号",xLeft,yBottom,s0);
         this.showBtn = this.makeSmallBtn(BtnClass,"显示称号",xRight,yBottom,s0);
         this.useWrap = this.smallBtnWrap.getChildAt(0) as Sprite;
         this.giveupWrap = this.smallBtnWrap.getChildAt(1) as Sprite;
         this.hideWrap = this.smallBtnWrap.getChildAt(2) as Sprite;
         this.showWrap = this.smallBtnWrap.getChildAt(3) as Sprite;
         this.useSmallBtn.addEventListener(MouseEvent.CLICK,this.useSmallClick);
         this.giveupBtn.addEventListener(MouseEvent.CLICK,this.giveupClick);
         this.hideBtn.addEventListener(MouseEvent.CLICK,this.hideClick);
         this.showBtn.addEventListener(MouseEvent.CLICK,this.showClick);
         this.use_btn.visible = false;
         this.honor_mc.addChild(this.smallBtnWrap);
      }

      public function makeSmallBtn(BtnClass:Class, label0:String, px:Number, py:Number, sc:Number) : SimpleButton
      {
         var btn0:SimpleButton = null;
         var wrap0:Sprite = new Sprite();
         var t0:TextField = new TextField();
         var f0:DropShadowFilter = new DropShadowFilter(0,45,16776945,1,4,4,1.6);
         if(BtnClass != null)
         {
            btn0 = new BtnClass() as SimpleButton;
            this.stripBtnText(btn0);
            btn0.scaleX = sc;
            btn0.scaleY = sc;
            wrap0.addChild(btn0);
         }
         else
         {
            btn0 = this.makeCodeBtn();
            wrap0.addChild(btn0);
         }
         t0.defaultTextFormat = new TextFormat("_sans",13,16777215,true,null,null,null,null,"center");
         t0.text = label0;
         t0.width = this.W0_cached * sc + 6;
         t0.height = btn0.height + 8;
         t0.x = -3;
         t0.y = (btn0.height - t0.textHeight) / 2;
         t0.mouseEnabled = false;
         t0.filters = [f0];
         wrap0.addChild(t0);
         wrap0.x = px;
         wrap0.y = py;
         this.smallBtnWrap.addChild(wrap0);
         return btn0;
      }

      private var W0_cached:Number = 120;

      public function stripBtnText(btn0:SimpleButton) : *
      {
         var n:* = undefined;
         var c:DisplayObjectContainer = null;
         var m:int = 0;
         var states:Array = [btn0.upState,btn0.overState,btn0.downState];
         for(n in states)
         {
            c = states[n] as DisplayObjectContainer;
            if(c != null)
            {
               m = c.numChildren - 1;
               while(m > 0)
               {
                  c.getChildAt(m).visible = false;
                  m = m - 1;
               }
            }
         }
      }

      public function makeCodeBtn() : SimpleButton
      {
         var btn0:SimpleButton = new SimpleButton();
         btn0.upState = this.drawTrap(16773854,13394944);
         btn0.overState = this.drawTrap(16776932,14672839);
         btn0.downState = this.drawTrap(13394944,11175913);
         btn0.hitTestState = btn0.upState;
         return btn0;
      }

      public function drawTrap(color0:uint, color1:uint) : Sprite
      {
         var sp0:Sprite = new Sprite();
         var w0:Number = W0_cached > 0?W0_cached:120;
         var h0:Number = 30;
         var m0:Number = w0 * 0.08;
         sp0.graphics.beginFill(color0);
         sp0.graphics.lineStyle(1,11175913,1);
         sp0.graphics.moveTo(m0,0);
         sp0.graphics.lineTo(w0 - m0,0);
         sp0.graphics.lineTo(w0,h0);
         sp0.graphics.lineTo(0,h0);
         sp0.graphics.lineTo(m0,0);
         sp0.graphics.endFill();
         return sp0;
      }

      public function addBar_byArr(arr0:Array) : *
      {
         var n:* = undefined;
         var bar0:HonorTextBar = null;
         var d0:OneHonorDefine = null;
         this.clearAllBar();
         for(n in arr0)
         {
            bar0 = new HonorTextBar();
            d0 = arr0[n];
            bar0.inData_byDefine(d0);
            bar0.x = 0 + (bar0.width + 7) * (n % 3);
            bar0.y = 0 + (bar0.height + 7) * int(n / 3);
            bar0.addEventListener(MouseEvent.CLICK,this.barClick);
            this.con.addChild(bar0);
            this.bar_arr.push(bar0);
         }
         this.sBar.setTarget(this.con);
      }

      public function clearAllBar() : *
      {
         var n:* = undefined;
         var bar0:HonorTextBar = null;
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            bar0.clear();
            this.con.removeChild(bar0);
            bar0.removeEventListener(MouseEvent.CLICK,this.barClick);
         }
         this.bar_arr.length = 0;
         this.nowChoosebar = null;
      }

      public function showLabel(label0:String) : *
      {
         var arr1:Array = null;
         var arr2:Array = null;
         this.honorData.checkWeaponMasterHonor();
         this.labelCtrl.setChoose_byLabel(label0);
         this.ac.visible = false;
         this.honor_mc.visible = false;
         if(label0 == "ac")
         {
            this.ac.visible = true;
            this.ac.completeB = true;
            this.ac.show_byType(this.ac.nowType);
         }
         else if(label0 == "noac")
         {
            this.ac.visible = true;
            this.ac.completeB = false;
            this.ac.show_byType(this.ac.nowType);
         }
         else
         {
            this.honor_mc.visible = true;
            arr1 = this.honorData.honor_arr;
            arr2 = this.honorData.getArray2();
            if(label0 == "have")
            {
               this.addBar_byArr(arr1);
               this.use_btn.visible = false;
               this.smallBtnWrap.visible = true;
            }
            else
            {
               this.addBar_byArr(arr2);
               this.use_btn.visible = false;
               this.smallBtnWrap.visible = false;
            }
            if(this.bar_arr.length > 0)
            {
               this.nowChoosebar = this.bar_arr[0];
            }
            this.fleshData();
         }
      }

      public function fleshData() : *
      {
         var data0:OneHonorDefine = null;
         if(Boolean(this.nowChoosebar))
         {
            this.chooseBar(this.nowChoosebar);
         }
         data0 = this.honorData.getNowDefine();
         if(this.honorData.hideHonor == true && data0 != null && data0.name != "no")
         {
            this.nowHonor_txt.text = data0.cnName + "（已隐藏）";
         }
         else
         {
            this.nowHonor_txt.text = data0.cnName;
         }
         this.fleshSmallBtnState();
      }

      public function fleshSmallBtnState() : *
      {
         var useEnableB:Boolean = false;
         var d0:* = null;
         if(Boolean(this.nowChoosebar))
         {
            d0 = this.nowChoosebar.itemsData;
            if(d0.name != this.honorData.nowHonor && this.honorData.getData(d0.name) != null)
            {
               useEnableB = true;
            }
         }
         this.setSmallBtnState(this.useWrap,this.useSmallBtn,useEnableB);
         this.setSmallBtnState(this.giveupWrap,this.giveupBtn,this.honorData.nowHonor != "no");
         this.setSmallBtnState(this.hideWrap,this.hideBtn,this.honorData.hideHonor != true);
         this.setSmallBtnState(this.showWrap,this.showBtn,this.honorData.hideHonor == true);
      }

      public function setSmallBtnState(wrap0:Sprite, btn0:SimpleButton, enableB:Boolean) : *
      {
         if(Boolean(wrap0) && Boolean(btn0))
         {
            wrap0.alpha = enableB?1:0.3;
            btn0.mouseEnabled = enableB;
         }
      }

      public function chooseBar(bar0:HonorTextBar) : *
      {
         var n:* = undefined;
         var data0:* = undefined;
         var bar1:HonorTextBar = null;
         var d0:OneHonorDefine = bar0.itemsData;
         this.property_txt.text = d0.pro;
         this.condition_txt.text = d0.condition;
         if(d0.name == this.honorData.nowHonor)
         {
            this.setUseBtn("no");
         }
         else
         {
            data0 = this.honorData.getData(d0.name);
            if(data0 == null)
            {
               this.setUseBtn("no");
            }
            else
            {
               this.setUseBtn("");
            }
         }
         for(n in this.bar_arr)
         {
            bar1 = this.bar_arr[n];
            bar1.setState(0);
         }
         bar0.setState(1);
      }

      private function setUseBtn(state0:String = "") : *
      {
         if(state0 == "no")
         {
            this.use_btn.alpha = 0.3;
            this.use_btn.mouseEnabled = false;
         }
         else
         {
            this.use_btn.alpha = 1;
            this.use_btn.mouseEnabled = true;
         }
      }

      public function barClick(e:MouseEvent) : *
      {
         this.nowChoosebar = e.target;
         this.fleshData();
      }

      public function labelClick(e:*) : *
      {
         trace("显示标签:" + this.labelCtrl.nowLabel);
         this.showLabel(this.labelCtrl.nowLabel);
      }

      public function useClick(e:*) : *
      {
         if(Boolean(this.nowChoosebar))
         {
            this.honorData.nowHonor = this.nowChoosebar.itemsData.name;
            this.fleshData();
            Game.SG.playSound("buyItems");
            Game.uiGroup.checkTip.showTip("使用成功！",1);
            Game.gameData.fleshAdd_byItems();
            Game.uiGroup.infoUI.fleshData();
            Game.eventGroup.fleshHonor();
            Game.uiGroup.carShow.copyAll();
         }
      }

      public function useSmallClick(e:*) : *
      {
         this.useClick(e);
      }

      public function giveupClick(e:*) : *
      {
         if(this.honorData.nowHonor != "no")
         {
            this.honorData.nowHonor = "no";
            this.fleshData();
            Game.SG.playSound("buyItems");
            Game.uiGroup.checkTip.showTip("已放弃称号！",1);
            Game.gameData.fleshAdd_byItems();
            Game.uiGroup.infoUI.fleshData();
            Game.eventGroup.fleshHonor();
            Game.uiGroup.carShow.copyAll();
         }
      }

      public function hideClick(e:*) : *
      {
         if(this.honorData.hideHonor != true)
         {
            this.honorData.hideHonor = true;
            this.fleshData();
            Game.uiGroup.checkTip.showTip("称号已隐藏（属性仍生效）",1);
            Game.eventGroup.fleshHonor();
         }
      }

      public function showClick(e:*) : *
      {
         if(this.honorData.hideHonor == true)
         {
            this.honorData.hideHonor = false;
            this.fleshData();
            Game.uiGroup.checkTip.showTip("称号已显示",1);
            Game.eventGroup.fleshHonor();
         }
      }

      public function hide(e:* = null) : *
      {
         visible = false;
      }
   }
}
