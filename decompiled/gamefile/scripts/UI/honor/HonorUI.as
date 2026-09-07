package UI.honor
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.label.LabelCtrl;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
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
         var yBottom:Number = this.use_btn.y + this.use_btn.height;
         var cx0:Number = this.use_btn.x + this.use_btn.width / 2;
         var sw0:Number = 114;
         var sh0:Number = 36;
         var gap0:Number = 10;
         var yTop:Number = yBottom - sh0 * 2 - gap0;
         var xLeft:Number = cx0 - (sw0 * 2 + gap0) / 2;
         var xRight:Number = xLeft + sw0 + gap0;
         this.useWrap = this.makeSmallBtn("y","使用称号",xLeft,yTop);
         this.giveupWrap = this.makeSmallBtn("y","放弃称号",xRight,yTop);
         this.hideWrap = this.makeSmallBtn("b","隐藏称号",xLeft,yBottom);
         this.showWrap = this.makeSmallBtn("b","显示称号",xRight,yBottom);
         this.useSmallBtn = this.useWrap.getChildAt(0) as SimpleButton;
         this.giveupBtn = this.giveupWrap.getChildAt(0) as SimpleButton;
         this.hideBtn = this.hideWrap.getChildAt(0) as SimpleButton;
         this.showBtn = this.showWrap.getChildAt(0) as SimpleButton;
         this.useSmallBtn.addEventListener(MouseEvent.CLICK,this.useSmallClick);
         this.giveupBtn.addEventListener(MouseEvent.CLICK,this.giveupClick);
         this.hideBtn.addEventListener(MouseEvent.CLICK,this.hideClick);
         this.showBtn.addEventListener(MouseEvent.CLICK,this.showClick);
         this.use_btn.visible = false;
         this.honor_mc.addChild(this.smallBtnWrap);
      }

      public function makeSmallBtn(style0:String, label0:String, px:Number, py:Number) : Sprite
      {
         var wrap0:Sprite = new Sprite();
         var btn0:SimpleButton = new SimpleButton();
         btn0.upState = this.drawUi3Frame(style0,false);
         btn0.overState = this.drawUi3Frame(style0,true);
         btn0.downState = this.drawUi3Frame(style0,true);
         btn0.hitTestState = btn0.upState;
         wrap0.addChild(btn0);
         var t0:TextField = new TextField();
         var f0:DropShadowFilter = new DropShadowFilter(0,45,0,0.9,3,3,1);
         t0.defaultTextFormat = new TextFormat("_sans",14,16777215,true,null,null,null,null,"center");
         t0.text = label0;
         t0.width = 114;
         t0.height = 36;
         t0.x = 0;
         t0.y = (36 - t0.textHeight) / 2;
         t0.mouseEnabled = false;
         t0.filters = [f0];
         wrap0.addChild(t0);
         wrap0.x = px;
         wrap0.y = py;
         this.smallBtnWrap.addChild(wrap0);
         return wrap0;
      }

      public function drawUi3Frame(style0:String, hoverB:Boolean) : Sprite
      {
         var edge0:uint = 0;
         var bright0:uint = 0;
         var fill0:uint = 0;
         if(style0 == "b")
         {
            edge0 = hoverB?56319:27828;
            bright0 = hoverB?56319:55805;
            fill0 = 396568;
         }
         else
         {
            edge0 = hoverB?16572931:9325825;
            bright0 = hoverB?16572931:16631552;
            fill0 = 1638403;
         }
         var sp0:Sprite = new Sprite();
         var g0:* = sp0.graphics;
         g0.lineStyle(2,edge0,1);
         g0.drawRoundRect(1,1,112,34,10,10);
         g0.lineStyle(2,bright0,1);
         g0.drawRoundRect(4,4,106,28,7,7);
         g0.beginFill(fill0,1);
         g0.drawRoundRect(6,6,102,24,5,5);
         g0.endFill();
         g0.lineStyle(1,bright0,0.75);
         g0.moveTo(18,7.5);
         g0.lineTo(96,7.5);
         var f0:GlowFilter = new GlowFilter(bright0,0.55,8,8,1);
         sp0.filters = [f0];
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
