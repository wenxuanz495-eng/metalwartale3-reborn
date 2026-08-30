package UI.honor
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.label.LabelCtrl;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
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
               this.use_btn.visible = true;
            }
            else
            {
               this.addBar_byArr(arr2);
               this.use_btn.visible = false;
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
         if(Boolean(this.nowChoosebar))
         {
            this.chooseBar(this.nowChoosebar);
         }
         var data0:OneHonorDefine = this.honorData.getNowDefine();
         this.nowHonor_txt.text = data0.cnName;
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
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
   }
}

