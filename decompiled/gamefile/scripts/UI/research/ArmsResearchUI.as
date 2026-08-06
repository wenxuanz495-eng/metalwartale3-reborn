package UI.research
{
   import UI.ClickEvent;
   import UI.button.SountoScrollBar;
   import UI.change.ArmsIconBox;
   import UI.change.ArmsItemsTip;
   import UI.dialog.ItemsTipbox;
   import UI.icon.ItemsArmsIcon;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.items.ItemsInfoTip;
   import UI.label.LabelCtrl;
   import UI.page.PageBox;
   import UI.shop.MustTopDialogBox;
   import body.define.OneArmsDefine;
   import data.Maths;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gameAll.NormalMustDefine;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.GoodsItemsDataGroup;
   import gameAll.data.PlayerData;
   import gs.TweenLite;
   import items.ItemsDefine;
   
   public class ArmsResearchUI extends Sprite
   {
      
      public var filter:ArmsDataFilter = new ArmsDataFilter();
      
      public var itemsData:ArmsItemsDataGroup;
      
      public var materialsItems:GoodsItemsDataGroup;
      
      public var armsFatherLabel:String = "arms";
      
      public var label:String = "upgrade";
      
      public var inlayBox:*;
      
      public var upgradeBox:*;
      
      public var armsBox:ArmsIconBox = new ArmsIconBox();
      
      public var armsBox4:ArmsIconBox = new ArmsIconBox();
      
      private var armsLevelViewport:Sprite = new Sprite();
      
      private var armsLevelScroll:SountoScrollBar = new SountoScrollBar();
      
      public var left_labelNum:int = 0;
      
      public var pageBox:PageBox;
      
      public var nowArmsChoose:ItemsArmsIcon = null;
      
      public var conUI:ConArmsUpgradeUI = new ConArmsUpgradeUI();
      
      public var upgradeCheckTip:MustTopDialogBox = new MustTopDialogBox();
      
      public var need_mc:*;
      
      public var needLevel_txt:TextField;
      
      public var mustLevel_txt:TextField;
      
      public var mustCoin_txt:TextField;
      
      public var nowCoinTxt:TextField;
      
      public var nowScoreTxt:TextField;
      
      public var mustItemsBox:ItemsBox = new ItemsBox();
      
      public var mustArmsIcon:ItemsArmsIcon = new ItemsArmsIcon();
      
      public var upgrade_btn:SimpleButton;
      
      public var no_btn:SimpleButton;
      
      public var condition_icon1:MovieClip;
      
      public var condition_icon3:MovieClip;
      
      public var condition_icon4:MovieClip;
      
      public var no_arr:Array;
      
      public var upgradePointer:Sprite;
      
      public var maxLevelShow:*;
      
      public var upgrade_conditionB:Boolean = true;
      
      public var upgradeNonMaterialB:Boolean = true;
      
      public var upgradeMaterialsB:Boolean = true;

      public var upgradeCoinB:Boolean = true;
      
      private var useResearchUpgradeCardB:Boolean = false;
      
      public var nowArms:ItemsArmsIcon = null;
      
      public var prevLabel:String = "";
      
      public var shop_mc:*;
      
      public var noArmsShow:*;
      
      public var nowInlayArms:ItemsArmsIcon = new ItemsArmsIcon();
      
      public var chipLabelCtrl:LabelCtrl = new LabelCtrl();
      
      public var name_txt:TextField;
      
      public var value_txt:TextField;
      
      public var holeItemsBox:ItemsBox = new ItemsBox("bag",true);
      
      public var chipHoleItems:ItemsIcon;
      
      public var bagItemsBox:ItemsBox = new ItemsBox();
      
      public var bagBack:Sprite;
      
      public var pageBox_2:PageBox;
      
      public var buy_btn:SimpleButton;
      
      public var gotoUpgrade_btn:SimpleButton;
      
      public var nowHoleIndex:int = 0;
      
      private var dragTarget:*;
      
      private var dragFather:*;
      
      private var dragBmp:Bitmap = new Bitmap();
      
      private var dragBmpSp:Sprite = new Sprite();
      
      private var dragPoint:Point = new Point();
      
      private var iconOverB:Boolean = false;
      
      private var nowHoleMust:NormalMustDefine = null;
      
      private var bagFillB_mc:Sprite;
      
      private var trainTitle_txt:TextField;
      
      private var trainValue_txt:TextField;
      
      private var train_btn:SimpleButton;
      
      private var oneSell_btn:SimpleButton;
      
      public var dps_txt:TextField;
      
      private var tipBox:ItemsTipbox = new ItemsTipbox();
      
      private var tip_mc:ArmsItemsTip = new ArmsItemsTip();
      
      private var itemsTip:ItemsInfoTip = new ItemsInfoTip();
      
      public var newG:Array = [];
      
      public var mustExchange:ArmsMustExchange = new ArmsMustExchange();
      
      public function ArmsResearchUI()
      {
         super();
         this.mustExchange.init(this);
         this.mouseEnabled = false;
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         this.armsBox.setNum(2,5,233,360);
         this.armsBox.x = 36;
         this.armsBox.y = 88;
         addChild(this.armsBox);
         this.armsBox.addEventListener(ClickEvent.ON_CLICK,this.armsBoxClick);
         var need_mc0:* = this.upgradeBox.need_mc;
         this.upgrade_btn = need_mc0.upgrade_btn;
         this.no_btn = need_mc0.no_btn;
         this.no_btn.addEventListener(MouseEvent.CLICK,this.gotoInlayClick);
         this.shop_mc = this.upgradeBox.need_mc.shop_mc;
         this.shop_mc.visible = false;
         this.shop_mc.shop_btn.setText("arms_gotoShop");
         this.shop_mc.exchange_btn.setText("arms_gotoExchange");
         this.shop_mc.shop_btn.addEventListener(MouseEvent.CLICK,this.gotoArmsShop);
         this.shop_mc.exchange_btn.addEventListener(MouseEvent.CLICK,this.gotoArmsExchange);
         this.armsBox4.x = 0;
         this.armsBox4.y = 0;
         this.armsBox4.setNum(1,5,140,360);
         this.armsBox4.continuousVertical = true;
         this.armsBox4.addEventListener(ClickEvent.ON_OUT,this.armsIconOut);
         this.armsLevelViewport.x = 300;
         this.armsLevelViewport.y = 88;
         this.armsLevelViewport.scrollRect = new Rectangle(0,0,140,360);
         this.armsLevelViewport.addChild(this.armsBox4);
         this.armsLevelViewport.addEventListener(MouseEvent.MOUSE_WHEEL,this.armsLevelWheel);
         addChild(this.armsLevelViewport);
         this.armsLevelScroll.x = 445;
         this.armsLevelScroll.y = 88;
         this.armsLevelScroll.setHigh(360);
         addChild(this.armsLevelScroll);
         this.mustLevel_txt = need_mc0.levelTxt;
         this.mustCoin_txt = need_mc0.coinTxt;
         this.nowCoinTxt = need_mc0.nowCoinTxt;
         this.nowScoreTxt = need_mc0.nowScoreTxt;
         this.mustItemsBox.setLabelClass(ItemsIcon);
         this.mustItemsBox.setNum(6,1,355,110);
         this.mustItemsBox.x = 198;
         this.mustItemsBox.y = 221;
         need_mc0.addChild(this.mustItemsBox);
         this.mustItemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mustItemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mustArmsIcon.x = 480;
         this.mustArmsIcon.y = 9;
         need_mc0.addChild(this.mustArmsIcon);
         this.condition_icon1 = need_mc0.condition_icon1;
         this.condition_icon3 = need_mc0.condition_icon3;
         this.condition_icon4 = need_mc0.condition_icon4;
         this.condition_icon1.stop();
         this.condition_icon3.stop();
         this.condition_icon4.stop();
         this.no_arr = [need_mc0.no_1,need_mc0.no_2,need_mc0.no_3];
         this.maxLevelShow = this.upgradeBox.maxLevelShow;
         need_mc0.addChild(this.shop_mc);
         this.upgrade_btn.addEventListener(MouseEvent.MOUSE_UP,this.upgradeClick);
         this.chipHoleItems = this.inlayBox.chipHoleItems;
         this.noArmsShow.txt.text = "你没有这种类型的武器。";
         this.noArmsShow.visible = false;
         this.nowInlayArms.x = 160;
         this.nowInlayArms.y = this.chipHoleItems.y - 20;
         this.inlayBox.addChild(this.nowInlayArms);
         this.dps_txt = this.inlayBox.dps_txt;
         this.holeItemsBox.setLabelClass(ItemsIcon);
         this.holeItemsBox.setNum(4,1,226,113);
         this.holeItemsBox.x = 386;
         this.holeItemsBox.y = this.chipHoleItems.y;
         this.inlayBox.addChild(this.holeItemsBox);
         this.bagItemsBox.setLabelClass(ItemsIcon);
         this.bagItemsBox.setNum(5,4,296,245);
         this.bagItemsBox.x = this.chipHoleItems.x + 10;
         this.bagItemsBox.y = 91;
         this.inlayBox.addChild(this.bagItemsBox);
         this.pageBox_2 = this.inlayBox.pageBox;
         this.buy_btn = this.inlayBox.buy_btn;
         this.gotoUpgrade_btn = this.inlayBox.upgrade_btn;
         this.gotoUpgrade_btn.addEventListener(MouseEvent.CLICK,this.gotoUpradeClick);
         this.inlayBox.addChild(this.buy_btn);
         this.name_txt = this.inlayBox.name_txt;
         this.value_txt = this.inlayBox.value_txt;
         this.bagBack = this.inlayBox.bagBack;
         this.buy_btn.visible = false;
         this.buy_btn.addEventListener(MouseEvent.CLICK,this.buyLockHole);
         this.chipLabelCtrl.inData([this.inlayBox.chip_btn,this.inlayBox.cry_btn],this.inlayBox.light_sp);
         this.chipLabelCtrl.addEventListener(ClickEvent.ON_CLICK,this.chipLabelClick);
         this.chipLabelCtrl.setChoose(0);
         this.bagFillB_mc = this.inlayBox.bagFillB_mc;
         this.bagFillB_mc.visible = false;
         this.inlayBox.addChild(this.bagFillB_mc);
         this.bagItemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.bagItemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.bagBack.addEventListener(MouseEvent.MOUSE_UP,this.bagBackUp);
         this.holeItemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.holeItemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.nowInlayArms.addEventListener(MouseEvent.MOUSE_OVER,this.nowInlayArmsOver);
         this.nowInlayArms.addEventListener(MouseEvent.MOUSE_OUT,this.nowInlayArmsOut);
         this.chipHoleItems.addEventListener(MouseEvent.MOUSE_UP,this.chipUp);
         this.chipHoleItems.addEventListener(MouseEvent.MOUSE_DOWN,this.chipDown);
         this.chipHoleItems.addEventListener(MouseEvent.MOUSE_OVER,this.chipOver);
         this.chipHoleItems.addEventListener(MouseEvent.MOUSE_OUT,this.chipOut);
         this.bagItemsBox.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.bagItemsBox.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.holeItemsBox.addEventListener(ClickEvent.ON_DOWN,this.iconDown);
         this.holeItemsBox.addEventListener(ClickEvent.ON_UP,this.iconUp);
         this.dragBmpSp.addChild(this.dragBmp);
         this.dragBmpSp.mouseChildren = false;
         this.dragBmpSp.mouseEnabled = false;
         addChild(this.dragBmpSp);
         this.oneSell_btn = this.inlayBox.oneSell_btn;
         this.oneSell_btn.addEventListener(MouseEvent.CLICK,this.oneSell);
         this.trainTitle_txt = this.inlayBox.trainTitle_txt;
         this.trainValue_txt = this.inlayBox.trainValue_txt;
         this.train_btn = this.inlayBox.train_btn;
         this.train_btn.addEventListener(MouseEvent.CLICK,this.gotoTrain);
         this.tipBox.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc3"));
         this.tipBox.visible = false;
         this.tipBox.mouseChildren = false;
         this.tipBox.mouseEnabled = false;
         addChild(this.tipBox);
         this.tip_mc.visible = false;
         this.tip_mc.mouseChildren = false;
         this.tip_mc.mouseEnabled = false;
         addChild(this.tip_mc);
         this.itemsTip.visible = false;
         this.itemsTip.mouseChildren = false;
         this.itemsTip.mouseEnabled = false;
         addChild(this.itemsTip);
         addChild(this.upgradeCheckTip);
         this.upgradeCheckTip.visible = false;
         addChild(this.conUI);
         this.conUI.visible = false;
         this.conUI.no_btn.addEventListener(MouseEvent.CLICK,this.gotoInlayClick);
      }
      
      public function init() : *
      {
         this.itemsData = Game.gameData.armsItems;
         this.materialsItems = Game.gameData.materialsItems;
      }
      
      public function fleshAll() : *
      {
         trace(this.armsFatherLabel + "武器升级和强化刷新。");
         this.fleshArmsBox();
         this.fleshBag();
         this.fleshTrain();
         this.chooseInlayArmsIcon_byIndex(0);
      }
      
      public function fleshTrain() : *
      {
         var pd0:PlayerData = Game.gameData.playerData;
         if(this.armsFatherLabel == "arms")
         {
            this.trainTitle_txt.text = "射击训练加成";
            this.trainValue_txt.text = pd0.attackAdd.getPer() + pd0.allAdd.getPer() + "%";
         }
         else
         {
            this.trainTitle_txt.text = "控制训练加成";
            this.trainValue_txt.text = pd0.subAdd.getPer() + pd0.allAdd.getPer() + "%";
         }
      }
      
      public function fleshArmsBox() : *
      {
         var nowpage00:int = this.pageBox.nowPage;
         var arr2:Array = this.filter.getOneList(this.armsFatherLabel,this.itemsData);
         this.armsBox.inData_byArr(arr2,true);
         this.pageBox.table = this.armsBox;
         this.armsBox.showPage(nowpage00,false,false);
         this.pageBox.fleshByTable();
         this.fleshBag();
      }
      
      private function armsLevelWheel(e:MouseEvent) : void
      {
         if(this.armsBox4.height > 360)
         {
            this.armsLevelScroll.setPer(this.armsLevelScroll.getPer() - e.delta * 0.08);
         }
      }
      
      public function clearNew() : *
      {
         this.armsBox.clearNew();
      }
      
      public function fleshNew() : *
      {
      }
      
      public function getNewB() : Boolean
      {
         return false;
      }
      
      public function fleshBag() : *
      {
         var arr0:Array = null;
         if(this.chipLabelCtrl.nowLabel == "chip")
         {
            arr0 = this.materialsItems.getArr_byType(["chip"]);
         }
         else
         {
            arr0 = this.materialsItems.getArr_byType(["crystal"]);
         }
         this.bagItemsBox.inData_byItems(arr0);
         this.pageBox_2.table = this.bagItemsBox;
         this.pageBox_2.fleshByTable();
      }
      
      public function showBox(label0:String) : *
      {
         this.label = label0;
         this.inlayBox.visible = false;
         this.upgradeBox.visible = false;
         this.conUI.visible = false;
         if(this.label == "inlay")
         {
            this.inlayBox.visible = true;
         }
         else if(this.label == "con")
         {
            this.conUI.visible = true;
         }
         else
         {
            this.upgradeBox.visible = true;
         }
      }
      
      public function gotoTrain(e:*) : *
      {
         if(this.armsFatherLabel == "arms")
         {
            Game.uiGroup.gotoTrain_label("attack");
         }
         else
         {
            Game.uiGroup.gotoTrain_label("sub");
         }
      }
      
      public function oneSell(e:*) : *
      {
         var n:* = undefined;
         var arr1:Array = null;
         var m:* = undefined;
         var arr0:Array = this.materialsItems.getArrByName("white_chip");
         for(n in arr0)
         {
            Game.IC.sellItems(arr0[n],this.materialsItems);
         }
         arr1 = this.materialsItems.getArrByName("blue_chip");
         for(m in arr1)
         {
            Game.IC.sellItems(arr1[m],this.materialsItems);
         }
         if(arr0.length > 0 || arr1.length > 0)
         {
            this.fleshBag();
         }
      }
      
      public function buyLockHole(event:MouseEvent) : *
      {
         this.nowHoleMust = Game.gameDefine.holeMust;
         this.nowHoleMust.fleshByIndex(this.nowHoleIndex);
         Game.uiGroup.checkTip.nowGCoin = Game.gameData.GCoin;
         Game.uiGroup.checkTip.nowMCoin = Game.gameData.MCoin;
         Game.uiGroup.checkTip.nowLevel = Game.gameData.level;
         Game.uiGroup.checkTip.showMustCheck(this.nowHoleMust,"开启这个晶体孔需要：",this.buyCheckTip);
      }
      
      public function affterBuyCheckTip() : *
      {
         var id0:ArmsItemsData = null;
         if(this.nowHoleMust is NormalMustDefine)
         {
            trace("开启孔");
            id0 = this.nowInlayArms.itemsData;
            id0.nowHoleNum = this.nowHoleIndex + 1;
            this.fleshHole_byNowInlayArms();
            Game.gameData.addCoin(-this.nowHoleMust.GCoin);
         }
      }
      
      public function buyCheckTip() : *
      {
         if(this.nowHoleMust is NormalMustDefine)
         {
            if(this.nowHoleMust.MCoin > 0)
            {
               Game.payController.decMCoin(this.nowHoleMust.MCoin,this.affterBuyCheckTip);
            }
            else
            {
               this.affterBuyCheckTip();
            }
         }
      }
      
      public function gotoPay() : *
      {
         trace("前往充值");
      }
      
      private function mouseUp(event:MouseEvent) : *
      {
         if(this.dragTarget != null)
         {
            this.stopDraging();
         }
      }
      
      private function armsIconOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function armsIconOver(event:ClickEvent) : *
      {
      }
      
      private function nowInlayArmsOver(event:MouseEvent) : *
      {
      }
      
      private function nowInlayArmsOut(event:MouseEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function itemsIconOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function itemsIconOver(event:ClickEvent) : *
      {
         var iai:ItemsIcon = null;
         if(this.dragTarget == null)
         {
            iai = event.goal;
            this.buy_btn.visible = false;
            if(iai.state == "fill")
            {
               if(iai.itemsData is ItemsDefine)
               {
                  this.itemsTip.inData_byDefine(iai.itemsData);
                  this.tipBox.showDialog(this.itemsTip,iai,iai.x + event.target.x + this.upgradeBox.x + this.upgradeBox.need_mc.x,iai.y + event.target.y + this.upgradeBox.y + this.upgradeBox.need_mc.y,1);
               }
               else
               {
                  this.itemsTip.inData(iai.itemsData);
                  this.tipBox.showDialog(this.itemsTip,iai,iai.x + event.target.x + this.inlayBox.x,iai.y + event.target.y + this.inlayBox.y,1);
               }
            }
            else if(iai.state == "lock")
            {
               this.nowHoleIndex = event.index;
               this.buy_btn.visible = true;
               this.buy_btn.x = iai.x + event.target.x;
               this.buy_btn.y = iai.y + event.target.y;
            }
         }
      }
      
      private function chipLabelClick(e:*) : *
      {
         this.fleshBag();
      }
      
      public function chooseIcon(index0:int) : *
      {
         if(this.nowArmsChoose != null)
         {
            this.nowArmsChoose.setState2("");
         }
         if(index0 > this.armsBox.arr.length - 1)
         {
            index0 = this.armsBox.arr.length - 1;
         }
         this.nowArmsChoose = this.armsBox.arr[index0];
         this.nowArmsChoose.setState2("choose");
      }
      
      public function chooseInlayArmsIcon_byIndex(index0:int) : *
      {
         trace("选择武器：" + index0);
         this.chooseIcon(index0);
         this.chooseInlayArmsIcon();
      }
      
      public function chooseInlayArmsIcon() : *
      {
         var aid0:ArmsItemsData = null;
         this.showBox("inlay");
         this.showArmsBox4();
         var upgradeB:String = this.getUpgradeB();
         if(upgradeB == "only")
         {
            this.chooseGradeArmsIcon();
            this.no_btn.mouseEnabled = false;
            this.no_btn.alpha = 0.4;
            return;
         }
         if(upgradeB == "yes" || upgradeB == "con")
         {
            this.gotoUpgrade_btn.alpha = 1;
            this.gotoUpgrade_btn.mouseEnabled = true;
         }
         else
         {
            this.gotoUpgrade_btn.alpha = 0.4;
            this.gotoUpgrade_btn.mouseEnabled = false;
         }
         this.no_btn.mouseEnabled = true;
         this.no_btn.alpha = 1;
         if(this.nowArmsChoose.itemsData is OneArmsDefine)
         {
            aid0 = null;
         }
         else
         {
            aid0 = this.nowArmsChoose.itemsData;
         }
         trace("选择武器3：" + aid0);
         if(aid0 != null)
         {
            this.inlayBox.visible = true;
            this.inlayBox.alpha = 0;
            TweenLite.to(this.inlayBox,0.5,{"alpha":1});
            this.nowInlayArms.inData_byItems(aid0);
            this.nowInlayArms.setState2("choose");
            this.nowInlayArms.setActived(false);
            this.fleshHole_byNowInlayArms();
         }
         else
         {
            this.inlayBox.visible = false;
         }
      }
      
      public function fleshHole_byNowInlayArms() : *
      {
         var aid0:ArmsItemsData = this.nowInlayArms.itemsData;
         aid0.fleshData();
         var obj:Object = aid0.add.getInfo2();
         this.name_txt.text = obj.name;
         this.value_txt.text = obj.value;
         this.holeItemsBox.inData_byHole(aid0);
         this.chipHoleItems.inData_byItems(aid0.chipHole);
         Game.gameData.fleshAdd_byItems();
         var dps0:Number = Math.round(aid0.define.getAllDps());
         this.dps_txt.htmlText = "战斗力:<font color=\'#FFFF00\'>" + dps0 + "</font>";
      }
      
      public function chooseByArmsID(id0:String, gradeOrInlay:Boolean = true) : *
      {
         var n:* = undefined;
         var icon0:ItemsArmsIcon = null;
         var ad0:* = undefined;
         var id2:String = null;
         for(n in this.armsBox.arr)
         {
            icon0 = this.armsBox.arr[n];
            ad0 = icon0.itemsData;
            id2 = "";
            if(ad0 is OneArmsDefine)
            {
               id2 = ad0.id;
            }
            else
            {
               id2 = ad0.getID();
            }
            if(id2 == id0)
            {
               if(gradeOrInlay)
               {
                  this.chooseGradeArmsIcon_byIndex(n);
               }
               else
               {
                  this.chooseInlayArmsIcon_byIndex(n);
               }
               return;
            }
         }
      }
      
      public function gotoUpradeClick(e:*) : *
      {
         if(this.getUpgradeB() == "con")
         {
            this.chooseConArmsIcon();
         }
         else
         {
            this.chooseGradeArmsIcon();
         }
      }
      
      public function chooseConArmsIcon() : *
      {
         this.showBox("con");
         this.conUI.chooseIcon(this.nowArmsChoose);
      }
      
      public function getUpgradeB() : String
      {
         var define0:OneArmsDefine = null;
         var aid0:ArmsItemsData = null;
         var arr2:Array = null;
         if(this.nowArmsChoose.itemsData is OneArmsDefine)
         {
            return "only";
         }
         aid0 = this.nowArmsChoose.itemsData;
         define0 = aid0.getArmsDefine();
         if(define0.id.indexOf("con") == 0)
         {
            return "con";
         }
         arr2 = Game.defineGroup.getArmsDefineArr(define0.id,this.armsFatherLabel,true);
         if(define0.level + 1 >= arr2.length)
         {
            return "no";
         }
         return "yes";
      }
      
      public function chooseGradeArmsIcon_byIndex(index0:int) : *
      {
         this.chooseIcon(index0);
         this.chooseGradeArmsIcon();
      }
      
      public function chooseGradeArmsIcon() : *
      {
         var define0:OneArmsDefine = null;
         var aid0:ArmsItemsData = null;
         this.showBox("upgrade");
         this.maxLevelShow.visible = false;
         this.upgradeBox.need_mc.visible = true;
         this.upgradePointer.visible = true;
         var upgradeB:String = this.getUpgradeB();
         if(upgradeB == "only")
         {
            this.no_btn.mouseEnabled = false;
            this.no_btn.alpha = 0.4;
         }
         else
         {
            this.no_btn.mouseEnabled = true;
            this.no_btn.alpha = 1;
         }
         var aid_level:int = -1;
         if(this.nowArmsChoose.itemsData is OneArmsDefine)
         {
            define0 = this.nowArmsChoose.itemsData;
            aid0 = null;
         }
         else
         {
            aid0 = this.nowArmsChoose.itemsData;
            define0 = aid0.getArmsDefine();
            aid_level = define0.level;
         }
         var arr2:Array = Game.defineGroup.getArmsDefineArr(define0.id,this.armsFatherLabel,true);
         this.showArmsBox4();
         if(aid0 != null)
         {
            if(aid_level >= arr2.length - 1)
            {
               Game.uiGroup.checkTip.showCheck("该武器已经升级至最高等级。",this.chooseInlayArmsIcon,this.chooseInlayArmsIcon);
               this.upgradeBox.need_mc.visible = false;
            }
            else
            {
               this.showArmsMust(aid_level + 1);
               this.prevLabel = aid0.baseLabel;
            }
         }
         else
         {
            if(this.itemsData.getFillB())
            {
               this.maxLevelShow.visible = true;
               this.maxLevelShow.txt.text = "军械库中的武器包裹已满，无法研发该武器。";
               this.upgradeBox.need_mc.visible = false;
            }
            else
            {
               this.showArmsMust(0);
            }
            this.prevLabel = "";
         }
      }
      
      private function showArmsBox4() : *
      {
         var define0:OneArmsDefine = null;
         var aid0:ArmsItemsData = null;
         var m:* = undefined;
         var d0:OneArmsDefine = null;
         var n:* = undefined;
         var icon5:ItemsArmsIcon = null;
         var d5:OneArmsDefine = null;
         var d_level0:int = 0;
         if(this.nowArmsChoose.itemsData is OneArmsDefine)
         {
            define0 = this.nowArmsChoose.itemsData;
            aid0 = null;
         }
         else
         {
            aid0 = this.nowArmsChoose.itemsData;
            define0 = aid0.getArmsDefine();
         }
         var arr2:Array = Game.defineGroup.getArmsDefineArr(define0.id,this.armsFatherLabel,true);
         var aid_level:int = -1;
         if(aid0 != null)
         {
            d0 = define0;
            aid_level = d0.level;
         }
         var arr5:Array = [];
         var arms_len:int = int(arr2.length);
         var first_index:int = 0;
         var last_index:int = arr2.length - 1;
         arr5 = arr2;
         this.armsBox4.inData_byArr2(arr5);
         this.armsBox4.y = 0;
         this.armsLevelScroll.setTarget(this.armsBox4,true);
         if(arms_len > 5 && aid_level > 0)
         {
            this.armsLevelScroll.setPer(Math.min(1,aid_level / Math.max(1,arms_len - 1)));
         }
         else
         {
            this.armsLevelScroll.setPer(0);
         }
         this.armsBox4.first_index = first_index;
         this.armsBox4.setTypeAll(0);
         var chooseIcon0:ItemsArmsIcon = this.armsBox4.arr[0];
         for(m in this.armsBox4.arr)
         {
            icon5 = this.armsBox4.arr[m];
            d5 = icon5.itemsData;
            d_level0 = d5.level;
            icon5.setNum(d_level0 + 1 + "");
            if(d_level0 == aid_level)
            {
               chooseIcon0 = icon5;
               icon5.setType(0);
               icon5.setState2("choose");
               icon5.setActived(false);
            }
            else if(d_level0 < aid_level)
            {
               icon5.setType(0);
               icon5.setActived(false);
            }
            else
            {
               icon5.setType(3);
               icon5.setActived(false);
            }
         }
         this.upgradePointer.y = chooseIcon0.y + chooseIcon0.height / 2 + this.armsBox4.y;
      }
      
      public function showArmsMust(index0:int) : *
      {
         var arr1:Array = null;
         var n:* = undefined;
         var icon1:ItemsIcon = null;
         var d1:ItemsDefine = null;
         var aid1:GoodsItemsData = null;
         var ssxxnum:int = 0;
         var d2:OneArmsDefine = null;
         var aid:ArmsItemsData = null;
         this.upgrade_conditionB = true;
         this.upgradeNonMaterialB = true;
         this.upgradeMaterialsB = true;
         this.upgradeCoinB = true;
         this.no_arr[0].visible = false;
         this.no_arr[1].visible = false;
         this.no_arr[2].visible = false;
         this.mustLevel_txt.visible = true;
         this.mustArmsIcon.visible = true;
         this.nowArms = this.armsBox4.arr[index0 - this.armsBox4.first_index];
         var d0:OneArmsDefine = this.nowArms.itemsData;
         var findStr0:String = Game.goodsDefineGroup.getBuySite(d0.getLabel());
         this.shop_mc.visible = true;
         this.shop_mc.txt.visible = false;
         this.shop_mc.shop_btn.setText("arms_gotoShop");
         if(findStr0 == "all")
         {
            this.shop_mc.shop_btn.visible = true;
            this.shop_mc.exchange_btn.visible = true;
            return;
         }
         if(findStr0 == "shop")
         {
            this.shop_mc.shop_btn.visible = true;
            this.shop_mc.exchange_btn.visible = false;
            return;
         }
         if(findStr0 == "exchange")
         {
            this.shop_mc.shop_btn.visible = false;
            this.shop_mc.exchange_btn.visible = true;
            return;
         }
         if(findStr0 == "pay")
         {
            this.shop_mc.shop_btn.setText("arms_gotoPay");
            this.shop_mc.shop_btn.visible = true;
            this.shop_mc.exchange_btn.visible = false;
            return;
         }
         if(findStr0 == "activity")
         {
            this.shop_mc.shop_btn.visible = false;
            this.shop_mc.exchange_btn.visible = false;
            this.shop_mc.txt.visible = true;
            this.shop_mc.txt.text = "通过活动获得";
         }
         else if(findStr0 == "star")
         {
            this.shop_mc.shop_btn.visible = false;
            this.shop_mc.exchange_btn.visible = false;
            this.shop_mc.txt.visible = true;
            this.shop_mc.txt.text = "通过星星奖励获得";
         }
         else if(findStr0 == "grow")
         {
            this.shop_mc.shop_btn.visible = false;
            this.shop_mc.exchange_btn.visible = false;
            this.shop_mc.txt.visible = true;
            this.shop_mc.txt.text = "通过成长计划获得";
         }
         else
         {
            this.shop_mc.visible = false;
         }
         if(d0.mustArenaScore > 0)
         {
            this.upgradeBox.need_mc.txt_needname.text = "需要的竞技场积分";
            this.mustLevel_txt.text = String(d0.mustArenaScore);
            if(Game.gameData.arenaData.score < d0.mustArenaScore)
            {
               this.upgrade_conditionB = false;
               this.upgradeNonMaterialB = false;
               this.condition_icon1.gotoAndStop(2);
            }
            else
            {
               this.condition_icon1.gotoAndStop(1);
            }
            this.nowScoreTxt.text = "当前积分：" + Game.gameData.arenaData.score;
         }
         else
         {
            this.upgradeBox.need_mc.txt_needname.text = "需要的人物等级";
            this.mustLevel_txt.text = String(d0.mustLevel);
            if(Game.gameData.level < d0.mustLevel - 1)
            {
               this.upgrade_conditionB = false;
               this.upgradeNonMaterialB = false;
               this.condition_icon1.gotoAndStop(2);
            }
            else
            {
               this.condition_icon1.gotoAndStop(1);
            }
            if(d0.mustLevel == 0)
            {
               this.no_arr[0].visible = true;
               this.mustLevel_txt.visible = false;
            }
            this.nowScoreTxt.text = "当前等级：" + (Game.gameData.level + 1);
         }
         this.mustCoin_txt.text = String(d0.price);
         this.nowCoinTxt.text = "当前G币：" + Game.gameData.GCoin;
         if(Game.gameData.GCoin < d0.price)
         {
            this.upgrade_conditionB = false;
            this.upgradeCoinB = false;
            this.condition_icon4.gotoAndStop(2);
         }
         else
         {
            this.condition_icon4.gotoAndStop(1);
         }
         var arr0:Array = d0.mustItems;
         if(arr0.length > 0)
         {
            arr1 = Game.itemsDefineGroup.getArr_byStrArr(arr0);
            this.mustItemsBox.inData_byArr(arr1);
            for(n in this.mustItemsBox.arr)
            {
               icon1 = this.mustItemsBox.arr[n];
               d1 = icon1.itemsData;
               if(Game.gameData.modCraftFree)
               {
                  icon1.setCondition(1);
                  icon1.setMustNum(9999,d1.nowNum);
                  continue;
               }
               aid1 = this.materialsItems.getItemsByBase(d1.name);
               if(aid1 == null)
               {
                  aid1 = Game.gameData.propsItems.getItemsByBase(d1.name);
               }
               icon1.setNum(100);
               if(aid1 != null)
               {
                  trace("存在物品：" + d1.name);
                  if(d1.nowNum <= aid1.nowNum)
                  {
                     trace("物品数量足够！！！！");
                     icon1.setCondition(1);
                     icon1.setMustNum(aid1.nowNum,d1.nowNum);
                  }
                  else
                  {
                     trace("物品数量不够");
                     icon1.setCondition(2);
                     this.upgrade_conditionB = false;
                     this.upgradeMaterialsB = false;
                     icon1.setMustNum(aid1.nowNum,d1.nowNum);
                  }
               }
               else if(d1.nowNum <= 0 && Boolean(icon1))
               {
                  icon1.setCondition(1);
                  ssxxnum = 0;
                  if(Boolean(aid1))
                  {
                     ssxxnum = aid1.nowNum;
                  }
                  icon1.setMustNum(ssxxnum,0);
               }
               else
               {
                  icon1.setCondition(2);
                  this.upgrade_conditionB = false;
                  this.upgradeMaterialsB = false;
                  icon1.setMustNum(0,d1.nowNum);
                  trace("不存在物品：" + d1.name);
               }
            }
         }
         else
         {
            this.mustItemsBox.clear();
            this.no_arr[1].visible = true;
         }
         this.mustExchange.inData(d0);
         if(d0.mustArms != "")
         {
            d2 = Game.defineGroup.getAD_byStr(d0.mustArms);
            this.mustArmsIcon.inData_byDefine(d2);
            aid = this.itemsData.getItemsByBase(d2.id,false);
            if(aid == null)
            {
               aid = Game.gameData.armsItems.getItemsByBase(d2.id,false);
            }
            if(aid != null)
            {
               trace("搜索到的武器等级：" + aid.getLevel() + "    当前合成所需等级：" + d2.level);
               if(aid.getLevel() >= d2.level)
               {
                  this.condition_icon3.gotoAndStop(1);
               }
               else
               {
                  this.upgrade_conditionB = false;
                  this.upgradeNonMaterialB = false;
                  this.condition_icon3.gotoAndStop(2);
               }
            }
            else
            {
               this.upgrade_conditionB = false;
               this.upgradeNonMaterialB = false;
               this.condition_icon3.gotoAndStop(2);
            }
         }
         else
         {
            this.mustArmsIcon.clearData();
            this.condition_icon3.gotoAndStop(1);
            this.no_arr[2].visible = true;
            this.mustArmsIcon.visible = false;
         }
         if(Game.gameData.modCraftFree)
         {
            this.upgrade_conditionB = true;
            this.upgradeNonMaterialB = true;
            this.upgradeMaterialsB = true;
            this.upgradeCoinB = true;
            this.condition_icon1.gotoAndStop(1);
            this.condition_icon3.gotoAndStop(1);
            this.condition_icon4.gotoAndStop(1);
         }
         if(this.upgrade_conditionB || (this.upgradeNonMaterialB || d0.id == "zhonglichongjipao") && Game.gameData.propsItems.getNumByBase("research_upgrade_card") > 0)
         {
            this.upgrade_btn.alpha = 1;
            this.upgrade_btn.enabled = true;
         }
         else
         {
            this.upgrade_btn.alpha = 0.4;
            this.upgrade_btn.enabled = false;
         }
      }
      
      public function gotoInlayClick(e:*) : *
      {
         this.chooseInlayArmsIcon();
      }
      
      public function gotoArmsShop(e:*) : *
      {
         if(this.shop_mc.shop_btn.text == "arms_gotoPay")
         {
            this.gotoShop("pay");
         }
         else
         {
            this.gotoShop("shop",this.armsFatherLabel);
         }
      }
      
      public function gotoShop(targetName0:String, father0:String = "arms") : *
      {
         if(father0.indexOf("sub") >= 0)
         {
            father0 = "sub";
         }
         if(targetName0 == "pay")
         {
            Game.uiGroup.menu.show("main");
            Game.uiGroup.mainUI.showGettingUI();
         }
         else if(targetName0 == "shop" || targetName0 == "all")
         {
            Game.uiGroup.menu.show("shop");
            Game.uiGroup.shopUI.showBox(0);
            Game.uiGroup.shopUI.shopBox.showBox_byLabel(father0);
         }
         else if(targetName0 == "exchange")
         {
            Game.uiGroup.menu.show("shop");
            Game.uiGroup.shopUI.showBox(1);
         }
      }
      
      public function gotoArmsExchange(e:*) : *
      {
         this.gotoShop("exchange",this.armsFatherLabel);
      }
      
      private function iconDown(event:ClickEvent) : *
      {
         var iai:ItemsIcon = event.goal;
         if(iai.state == "fill")
         {
            this.tipBox.hide();
            this.dragTarget = event.goal;
            this.dragFather = event.target;
            this.startDraging();
         }
      }
      
      private function bagBackUp(event:MouseEvent) : *
      {
         var items0:GoodsItemsData = null;
         var id0:ArmsItemsData = null;
         var inBagB:Boolean = false;
         if(this.dragTarget is ItemsIcon)
         {
            items0 = this.dragTarget.itemsData;
            id0 = this.nowInlayArms.itemsData;
            inBagB = this.materialsItems.inBagTest(items0);
            if(!inBagB)
            {
               Game.uiGroup.checkTip.showTip("背包已满，无法完成此操作！",2);
               Game.SG.playSound("failureItems");
            }
            else
            {
               if(this.dragFather == this.holeItemsBox)
               {
                  if(this.returnEquippedCrystalToBag(items0,id0))
                  {
                     this.fleshHole_byNowInlayArms();
                     this.fleshBag();
                     Game.SG.playSound("dragDown");
                  }
               }
               else if(this.dragFather == null && this.returnEquippedChipToBag(items0,id0))
               {
                  trace("芯片孔:" + items0.site + "   拖到背包");
                  this.fleshHole_byNowInlayArms();
                  this.fleshBag();
                  Game.SG.playSound("dragDown");
               }
            }
         }
      }
      
      private function iconUp(event:ClickEvent) : *
      {
         var box0:* = undefined;
         var iai:ItemsIcon = null;
         var items0:GoodsItemsData = null;
         var id0:ArmsItemsData = null;
         var inBagB:Boolean = false;
         var items2:GoodsItemsData = null;
         var id3:GoodsItemsData = null;
         var str3:* = undefined;
         var items3:GoodsItemsData = null;
         if(this.dragTarget is ItemsIcon)
         {
            this.iconOverB = true;
            box0 = event.target;
            iai = event.goal;
            items0 = this.dragTarget.itemsData;
            id0 = this.nowInlayArms.itemsData;
            inBagB = this.materialsItems.inBagTest(items0);
            if(box0 == this.bagItemsBox && this.dragFather == this.holeItemsBox)
            {
               trace("镶嵌孔:" + items0.site + "   拖到背包");
               if(!inBagB)
               {
                  Game.uiGroup.checkTip.showTip("背包已满，无法完成此操作！",2);
                  Game.SG.playSound("failureItems");
               }
               else
               {
                  if(this.returnEquippedCrystalToBag(items0,id0))
                  {
                     this.fleshHole_byNowInlayArms();
                     this.fleshBag();
                     Game.SG.playSound("dragDown");
                  }
               }
            }
            else if(this.dragTarget == this.chipHoleItems && box0 == this.bagItemsBox)
            {
               if(!inBagB)
               {
                  Game.uiGroup.checkTip.showTip("背包已满，无法完成此操作！",2);
                  Game.SG.playSound("failureItems");
               }
               else if(items0.type == "chip" && this.returnEquippedChipToBag(items0,id0))
               {
                  trace("芯片孔:" + items0.site + "   拖到背包");
                  this.fleshHole_byNowInlayArms();
                  this.fleshBag();
                  Game.SG.playSound("dragDown");
               }
            }
            else if(box0 == this.holeItemsBox && this.dragFather == this.bagItemsBox)
            {
               if(items0.type != "chip")
               {
                  trace("背包镶拖到嵌孔:" + event.index);
                  if(iai.state == "blank")
                  {
                     items2 = items0.copy(1);
                     items2.site = event.index;
                     if(this.materialsItems.useItemsDataReal(items0))
                     {
                        id0.holeArr[items2.site] = items2;
                        this.fleshHole_byNowInlayArms();
                        this.fleshBag();
                        Game.SG.playSound("holeChip");
                     }
                     else
                     {
                        Game.SG.playSound("dragDown");
                     }
                  }
                  else if(iai.state == "fill")
                  {
                     id3 = iai.itemsData;
                     if(id3.name != items0.name || id3.type == "chip")
                     {
                        items3 = items0.copy(1);
                        items3.site = event.index;
                        if(!this.materialsItems.useItemsDataReal(items0))
                        {
                           Game.SG.playSound("dragDown");
                        }
                        else
                        {
                           str3 = this.materialsItems.addItemsData(id3.copy(1),1,false);
                           if(str3 == null)
                           {
                              this.materialsItems.addItemsData(items3,1,false);
                              Game.SG.playSound("dragDown");
                           }
                           else
                           {
                              id0.holeArr[items3.site] = items3;
                              this.fleshHole_byNowInlayArms();
                              this.fleshBag();
                              Game.SG.playSound("holeChip");
                           }
                        }
                     }
                  }
               }
            }
            this.stopDraging();
         }
      }
      
      private function chipUp(event:MouseEvent) : *
      {
         var items0:GoodsItemsData = null;
         var id0:ArmsItemsData = null;
         var items2:GoodsItemsData = null;
         var id3:GoodsItemsData = null;
         var str3:* = undefined;
         var items3:GoodsItemsData = null;
         var iai:* = event.target;
         if(this.dragTarget is ItemsIcon)
         {
            if(this.dragFather == this.bagItemsBox)
            {
               items0 = this.dragTarget.itemsData;
               id0 = this.nowInlayArms.itemsData;
               if(items0.isPurpleChip() && !id0.canInstallPurpleChip())
               {
                  Game.uiGroup.checkTip.showTip(id0.getPurpleChipBlockReason(),2);
                  Game.SG.playSound("failureItems");
                  this.stopDraging();
                  return;
               }
               if(items0.type == "chip")
               {
                  if(iai.state == "blank")
                  {
                     trace("嵌入芯片");
                     items2 = items0.copy(1);
                     items2.site = 0;
                     if(this.materialsItems.useItemsDataReal(items0))
                     {
                        id0.chipHole = items2;
                        this.fleshHole_byNowInlayArms();
                        this.fleshBag();
                        Game.SG.playSound("holeChip");
                     }
                  }
                  else if(iai.state == "fill")
                  {
                     id3 = iai.itemsData;
                     if(id3.type == "chip")
                     {
                        items3 = items0.copy(1);
                        items3.site = 0;
                        if(!this.materialsItems.useItemsDataReal(items0))
                        {
                           trace("芯片不存在或数量不足，不执行替换");
                           Game.SG.playSound("dragDown");
                        }
                        else
                        {
                           str3 = this.materialsItems.addItemsData(id3,1,false);
                           if(str3 == null)
                           {
                              this.materialsItems.addItemsData(items3,1,false);
                              trace("旧芯片无法放回背包，已撤销替换");
                              Game.SG.playSound("dragDown");
                              this.fleshBag();
                              return;
                           }
                           id0.chipHole = items3;
                           this.fleshHole_byNowInlayArms();
                           this.fleshBag();
                           trace("替换物品成功！");
                           Game.SG.playSound("holeChip");
                        }
                     }
                  }
               }
            }
            if(this.dragTarget != null)
            {
               this.stopDraging();
            }
         }
      }

      private function returnEquippedChipToBag(items0:GoodsItemsData, id0:ArmsItemsData) : Boolean
      {
         if(id0 == null || id0.chipHole !== items0)
         {
            return false;
         }
         if(this.materialsItems.addItemsData(items0.copy(1),1,false) == null)
         {
            return false;
         }
         id0.chipHole = new Object();
         id0.fleshData();
         return true;
      }

      private function returnEquippedCrystalToBag(items0:GoodsItemsData, id0:ArmsItemsData) : Boolean
      {
         var holeIndex0:int = -1;
         if(id0 == null || items0 == null || items0.type == "chip")
         {
            return false;
         }
         holeIndex0 = id0.holeArr.indexOf(items0);
         if(holeIndex0 < 0 && items0.site >= 0 && items0.site < id0.holeArr.length && id0.holeArr[items0.site] === items0)
         {
            holeIndex0 = items0.site;
         }
         if(holeIndex0 < 0)
         {
            return false;
         }
         if(this.materialsItems.addItemsData(items0.copy(1),1,false) == null)
         {
            return false;
         }
         id0.holeArr[holeIndex0] = new Object();
         id0.fleshData();
         return true;
      }
      
      private function chipDown(event:MouseEvent) : *
      {
         var iai:* = event.target;
         if(iai.state == "fill")
         {
            this.tipBox.hide();
            this.dragTarget = event.target;
            this.dragFather = null;
            this.startDraging();
         }
      }
      
      private function chipOut(e:*) : *
      {
         this.tipBox.hide();
      }
      
      private function chipOver(event:*) : *
      {
         var iai:ItemsIcon = event.target;
         if(this.dragTarget == null)
         {
            if(iai.state == "fill")
            {
               if(iai.itemsData is ItemsDefine)
               {
                  this.itemsTip.inData_byDefine(iai.itemsData);
                  this.tipBox.showDialog(this.itemsTip,iai,iai.x + this.upgradeBox.x,iai.y + this.upgradeBox.y,1);
               }
               else
               {
                  this.itemsTip.inData(iai.itemsData);
                  this.tipBox.showDialog(this.itemsTip,iai,iai.x + this.upgradeBox.x,iai.y + this.upgradeBox.y,1);
               }
            }
         }
      }
      
      private function startDraging() : *
      {
         if(this.dragTarget != null)
         {
            this.dragBmp.bitmapData = StringToDefine.getBmp(this.dragTarget.icon);
            this.dragBmpSp.visible = false;
            this.dragPoint.x = this.mouseX;
            this.dragPoint.y = this.mouseY;
         }
         this.addEventListener(Event.ENTER_FRAME,this.dragIcon);
      }
      
      private function stopDraging(event:MouseEvent = null) : *
      {
         this.removeEventListener(Event.ENTER_FRAME,this.dragIcon);
         this.dragTarget.iconReturn();
         this.dragTarget = null;
         this.dragFather = null;
         this.dragBmp.bitmapData.dispose();
         this.dragBmpSp.visible = false;
      }
      
      private function dragIcon(event:Event) : *
      {
         var len:* = Maths.Long(this.dragPoint.x - mouseX,this.dragPoint.y - mouseY);
         if(len > 5)
         {
            this.dragBmpSp.visible = true;
            this.dragTarget.iconLeave();
            this.dragBmpSp.x = this.mouseX - this.dragBmpSp.width / 2;
            this.dragBmpSp.y = this.mouseY - this.dragBmpSp.height + 10;
         }
      }
      
      public function armsBoxClick(event:ClickEvent) : *
      {
         this.chooseInlayArmsIcon_byIndex(event.goal.index);
      }
      
      public function upgradeClick(event:MouseEvent) : *
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var items2:ArmsItemsData = null;
         var items0:ItemsDefine = null;
         var bocc:Boolean = false;
         var blackHoleCardB:Boolean = false;
         if(this.upgrade_btn.alpha < 1)
         {
            return;
         }
         d0 = this.nowArms.itemsData;
         blackHoleCardB = !Game.gameData.modCraftFree && d0.id == "zhonglichongjipao" && d0.mustArenaScore > Game.gameData.arenaData.score;
         if((!this.upgradeMaterialsB || !this.upgradeCoinB || blackHoleCardB) && !this.useResearchUpgradeCardB)
         {
            if(Game.gameData.propsItems.getNumByBase("research_upgrade_card") > 0)
            {
               Game.uiGroup.checkTip.showCheck2("研发材料或G币不足，是否消耗1张研发升级卡完成本次研发？",1,this.upgradeWithResearchCard);
            }
            return;
         }
         if(!Game.gameData.modCraftFree && !this.useResearchUpgradeCardB)
         {
            for(n in this.mustItemsBox.arr)
            {
               items0 = this.mustItemsBox.arr[n].itemsData;
               bocc = this.materialsItems.useItemsNum(items0.name,items0.nowNum);
               if(bocc == false)
               {
                  Game.gameData.propsItems.useItemsNum(items0.name,items0.nowNum);
               }
            }
         }
         else if(!Game.gameData.modCraftFree)
         {
            Game.gameData.propsItems.useItemsNum("research_upgrade_card",1);
         }
         if(!this.useResearchUpgradeCardB && !Game.gameData.modCraftFree)
         {
            Game.gameData.addCoin(-d0.price);
         }
         items2 = this.itemsData.getItemsByBase(this.prevLabel);
         if(items2 is ArmsItemsData)
         {
            items2.baseLabel = d0.getLabel();
            items2.inData_byDefine();
            items2.fleshData();
            trace("升级到武器：" + d0.getLabel());
            Game.uiGroup.checkTip.showTip("升级成功！",1);
         }
         else
         {
            this.itemsData.addItems(d0.getLabel());
            Game.uiGroup.checkTip.showTip("你获得了一把新武器！",1);
         }
         this.itemsData.fleshData();
         Game.SG.playSound("upgradeArms");
         var index0:int = this.nowArmsChoose.index;
         this.fleshArmsBox();
         this.chooseIcon(index0);
         this.chooseGradeArmsIcon();
         Game.gameData.honorData.checkWeaponMasterHonor();
         this.useResearchUpgradeCardB = false;
      }
      
      private function upgradeWithResearchCard() : *
      {
         this.useResearchUpgradeCardB = true;
         this.upgradeClick(null);
      }
   }
}

