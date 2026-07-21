package UI
{
   import UI._new.change.CtrlListCtrl;
   import UI._new.change._ChangeUI;
   import UI._new.icon.ChangeIconBox;
   import UI.arena.ArenArivalBar;
   import UI.arena.NewArenaUI;
   import UI.book.BookUI;
   import UI.button.BlueLabelButton;
   import UI.button.PicButton;
   import UI.change.ArmsIconBox;
   import UI.change.ArmsItemsTip;
   import UI.change.CarIconBox;
   import UI.change.CarItemsTip;
   import UI.change.ChangeEquipImage;
   import UI.change.ChangeUI;
   import UI.change.CtrlArmsList;
   import UI.dailySign.DailySignUI;
   import UI.dialog.ItemsTipbox;
   import UI.effect.BreakEffectUI;
   import UI.exchange.ExchangeUI;
   import UI.explore.ExploreIcon;
   import UI.explore.ExploreIconBox;
   import UI.explore.ExploreUI;
   import UI.extra.ExtraUI;
   import UI.fase.FaseUI;
   import UI.gameover.GameOverUI;
   import UI.gaming.GamingPauseUI;
   import UI.gaming.GamingUI;
   import UI.gaming.LeftMenuUI;
   import UI.gift.StarGiftUI;
   import UI.helper.HelperUI;
   import UI.icon.ItemsArmsIcon;
   import UI.icon.ItemsCarIcon;
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.items.ItemsInfoTip;
   import UI.level.LevelChooseUI;
   import UI.login.LoginUI;
   import UI.main.InfoTipBox;
   import UI.main.InfoUI;
   import UI.main.MainMenuUI;
   import UI.main.MainTitleButton;
   import UI.main.MainUI;
   import UI.rank.RankUI;
   import UI.research.ResearchUI;
   import UI.server.ServerUI;
   import UI.shop.MustTopDialogBox;
   import UI.shop.ShopIcon;
   import UI.shop.ShopIconBox;
   import UI.shop.ShopUI;
   import UI.test.ChipEditorUI;
   import UI.top.HighUI;
   import UI.tutorial.TutorialUI;
   import UI.union.UnionUI;
   import UI.vip.VipUI;
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
   import flash.display.DisplayObject;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.randAddData;
   import gameAll.high.HighArena_All;
   import goods.GoodsDefine;
   import gs.TweenLite;
   import gs.easing.Back;
   import image.GameSprite;
   import items.ItemsDefine;
   
   public class UIGroup
   {
      
      public var normalShopB:Boolean = false;
      
      public var newVB:Boolean = true;
      
      public var showSaveReturn:Boolean = false;
      
      public var gameSprite:GameSprite;
      
      public var menu:MainMenuUI;
      
      public var faseUI:FaseUI;
      
      public var loginUI:LoginUI;
      
      public var mainUI:MainUI;
      
      public var highUI:HighUI;
      
      public var newArenaUI:NewArenaUI;
      
      public var gamingUI:GamingUI;
      
      public var gameoverUI:GameOverUI;
      
      public var changeUI:ChangeUI;
      
      public var _changeUI:_ChangeUI;
      
      public var menuUI:GamingPauseUI;
      
      public var chooseLevelUI:LevelChooseUI;
      
      public var extraUI:ExtraUI;
      
      public var shopUI:ShopUI;
      
      public var exchangeUI:ExchangeUI;
      
      public var researchUI:ResearchUI;
      
      public var exploreUI:ExploreUI;
      
      public var rankUI:RankUI;
      
      public var tutorialUI:TutorialUI;
      
      public var unionUI:UnionUI;
      
      public var starGiftUI:StarGiftUI;
      
      public var bookUI:BookUI;
      
      public var vipUI:VipUI;
      
      public var dailySignUI:DailySignUI;
      
      public var helperUI:HelperUI;
      
      public var serverUI:ServerUI;
      
      public var returnMenuTab:Sprite;
      
      private var returnMenuTitle:TextField;
      
      private var returnMenuArrow:TextField;
      
      private var returnMenuWidth:Number = 14;
      
      private var returnMenuTargetWidth:Number = 14;
      
      public var breakEffectUI:BreakEffectUI;
      
      public var infoUI:InfoUI;
      
      public var carShow:ChangeEquipImage;
      
      public var checkTip:MustTopDialogBox;
      
      public var orderArr:Array = [];
      
      public var leftUI:LeftMenuUI;
      
      public var allback:AllBack;
      
      public var tipBox:ItemsTipbox;
      
      public var itemsTip:ItemsInfoTip;
      
      private var armsTip:ArmsItemsTip;
      
      private var carTip:CarItemsTip;
      
      public var infoTip:InfoTipBox;
      
      private var ctrlList:CtrlArmsList;
      
      public var timer0:Timer = new Timer(1000);
      
      public var save_t:int = 0;
      
      public var beforeMCoin:int = 0;
      
      public var loadingUI:LoadingUI;
      
      public var chipEditorUI:ChipEditorUI;
      
      public var affterOrderStr:String = "";
      
      public var zuobipan:ZuobiPan = new ZuobiPan();
      
      public var zuobipan2:ZuobiPan2 = new ZuobiPan2();
      
      public function UIGroup()
      {
         super();
      }
      
      public function firstInit() : *
      {
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var livenessArr:Array = null;
         var sib:ShopIconBox = null;
         var liveness_box:ItemsBox = null;
         this.gameSprite = Game.gameSprite;
         this.allback = new AllBack();
         this.allback.init();
         this.gameSprite.topUIL.addChild(this.allback);
         this.allback.visible = false;
         this.leftUI = new LeftMenuUI();
         this.leftUI.init();
         this.gameSprite.goHomeL.addChild(this.leftUI);
         this.menuUI = new GamingPauseUI();
         this.menuUI.init();
         this.gameSprite.topUIL.addChild(this.menuUI);
         this.infoUI = new InfoUI();
         this.carShow = new ChangeEquipImage();
         this.mainUI = new MainUI();
         this.gameSprite.topUIL.addChild(this.mainUI);
         this.highUI = new HighUI();
         this.gameSprite.topUIL.addChild(this.highUI);
         this.newArenaUI = new NewArenaUI();
         this.gameSprite.topUIL.addChild(this.newArenaUI);
         this.unionUI = new UnionUI();
         this.gameSprite.topUIL.addChild(this.unionUI);
         this.starGiftUI = new StarGiftUI();
         this.gameSprite.topUIL.addChild(this.starGiftUI);
         this.bookUI = new BookUI();
         this.gameSprite.topUIL.addChild(this.bookUI);
         this.vipUI = new VipUI();
         this.gameSprite.topUIL.addChild(this.vipUI);
         this.dailySignUI = new DailySignUI();
         this.gameSprite.topUIL.addChild(this.dailySignUI);
         this.helperUI = new HelperUI();
         this.gameSprite.topUIL.addChild(this.helperUI);
         this.changeUI = new ChangeUI();
         this.gameSprite.topUIL.addChild(this.changeUI);
         this.changeUI.init();
         this._changeUI = new _ChangeUI();
         this.gameSprite.topUIL.addChild(this._changeUI);
         this.gamingUI = new GamingUI();
         this.gameSprite.gamingUIL.addChild(this.gamingUI);
         this.gamingUI.init();
         this.gameoverUI = new GameOverUI();
         this.gameSprite.topUIL.addChild(this.gameoverUI);
         this.gameoverUI.init();
         this.chooseLevelUI = new LevelChooseUI();
         this.gameSprite.topUIL.addChild(this.chooseLevelUI);
         this.extraUI = new ExtraUI();
         this.gameSprite.topUIL.addChild(this.extraUI);
         this.shopUI = new ShopUI();
         this.shopUI.init();
         this.gameSprite.topUIL.addChild(this.shopUI);
         this.exchangeUI = new ExchangeUI();
         this.exchangeUI.init();
         this.gameSprite.topUIL.addChild(this.exchangeUI);
         this.researchUI = new ResearchUI();
         this.researchUI.init();
         this.gameSprite.topUIL.addChild(this.researchUI);
         this.researchUI.visible = false;
         this.exploreUI = new ExploreUI();
         this.exploreUI.init();
         this.gameSprite.topUIL.addChild(this.exploreUI);
         this.exploreUI.visible = false;
         this.rankUI = new RankUI();
         this.gameSprite.topUIL.addChild(this.rankUI);
         this.menu = new MainMenuUI(this);
         this.gameSprite.topUIL.addChild(this.menu);
         this.serverUI = new ServerUI();
         this.serverUI.visible = false;
         this.gameSprite.topUIL.addChild(this.serverUI);
         this.loginUI = new LoginUI();
         this.gameSprite.topUIL.addChild(this.loginUI);
         this.returnMenuTab = this.createReturnMenuTab();
         this.gameSprite.topUIL.addChild(this.returnMenuTab);
         this.breakEffectUI = new BreakEffectUI();
         this.breakEffectUI.visible = false;
         this.gameSprite.goHomeL.addChild(this.breakEffectUI);
         this.chipEditorUI = new ChipEditorUI();
         this.gameSprite.goHomeL.addChild(this.chipEditorUI);
         this.chipEditorUI.init();
         this.chipEditorUI.visible = false;
         this.gameSprite.goHomeL.addChild(this.gameoverUI.cardUI);
         this.tipBox = new ItemsTipbox();
         this.tipBox.inBackData(Game.swfLoaderManager.getResource("dialogbox","Dialogbox_mc3"));
         this.tipBox.visible = false;
         this.gameSprite.goHomeL.addChild(this.tipBox);
         this.itemsTip = new ItemsInfoTip();
         this.itemsTip.visible = false;
         this.gameSprite.goHomeL.addChild(this.itemsTip);
         this.armsTip = new ArmsItemsTip();
         this.armsTip.visible = false;
         this.gameSprite.goHomeL.addChild(this.armsTip);
         this.carTip = new CarItemsTip();
         this.carTip.visible = false;
         this.gameSprite.goHomeL.addChild(this.carTip);
         this.infoTip = new InfoTipBox();
         this.infoTip.visible = false;
         this.infoTip.mouseChildren = false;
         this.infoTip.mouseEnabled = false;
         this.allback.info.infoTip = this.infoTip;
         this.gameSprite.goHomeL.addChild(this.infoTip);
         this.ctrlList = new CtrlArmsList();
         this.gameSprite.goHomeL.addChild(this.ctrlList);
         CtrlListCtrl.ctrlList = this.ctrlList;
         this.ctrlList.addEventListener(ClickEvent.ON_CLICK,CtrlListCtrl.ctrlClick);
         this.ctrlList.visible = false;
         this.tutorialUI = new TutorialUI(this);
         this.gameSprite.goHomeL.addChild(this.tutorialUI);
         this.tutorialUI.visible = false;
         this.loadingUI = new LoadingUI();
         this.gameSprite.goHomeL.addChild(this.loadingUI);
         this.loadingUI.hide();
         this.loadingUI.txt.text = "";
         this.checkTip = new MustTopDialogBox();
         this.gameSprite.goHomeL.addChild(this.checkTip);
         this.checkTip.visible = false;
         this.returnMenuTab.visible = false;
         this.loginUI.createRole_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.leftUI.menu_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.menuUI.resumeGame_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.menuUI.restartLevel_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.menuUI.overLevel_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.changeUI.return_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.gameoverUI.restart_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.gameoverUI.continueGame_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.exchangeUI.return_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.exploreUI.return_btn.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.timer0.addEventListener(TimerEvent.TIMER,this.FTimer1s);
         this.timer0.start();
         this.researchUI.crystalBox.nowBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.nowBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.nowBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.upgradeBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.upgradeBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.upgradeBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.chipCubeUI.cubeItems.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.chipCubeUI.cubeItems.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.chipCubeUI.cubeItems.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.mustItems.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.mustItems.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.mustItems.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.chipCubeUI.bagItemsBox.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.chipCubeUI.bagItemsBox.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.chipCubeUI.bagItemsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.chipCubeUI.chipItemsBox.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.chipCubeUI.chipItemsBox.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.chipCubeUI.chipItemsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.chipBaptizeUI.bagItemsBox.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.chipBaptizeUI.bagItemsBox.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.chipBaptizeUI.bagItemsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.chipBaptizeUI.chipItems.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.chipBaptizeUI.chipItems.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.chipBaptizeUI.chipItems.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.crystalBox.chipBaptizeUI.mustItems.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.crystalBox.chipBaptizeUI.mustItems.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.crystalBox.chipBaptizeUI.mustItems.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.exploreUI.allBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.exploreUI.allBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.exploreUI.allBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.exploreUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.exploreUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.exploreUI.itemsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         for(n in this.shopUI.shopBox.allBox)
         {
            sib = this.shopUI.shopBox.allBox[n];
            sib.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
            sib.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
            sib.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         }
         this.changeUI.armsUI.nowArms.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.changeUI.armsUI.nowArms.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.changeUI.armsUI.nowArms.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.changeUI.armsUI.bagArms.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.changeUI.armsUI.bagArms.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.changeUI.armsUI.bagArms.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.changeUI.subUI.nowArms.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.changeUI.subUI.nowArms.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.changeUI.subUI.nowArms.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.changeUI.subUI.bagArms.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.changeUI.subUI.bagArms.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.changeUI.subUI.bagArms.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.changeUI.materialsUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.changeUI.materialsUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.changeUI.materialsUI.itemsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.changeUI.propsUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.changeUI.propsUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.changeUI.propsUI.itemsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.armsBox.armsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.armsBox.armsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.armsBox.armsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.armsBox.armsBox4.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.armsBox.armsBox4.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.armsBox.armsBox4.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.armsBox.nowInlayArms.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.armsBox.nowInlayArms.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.armsBox.nowInlayArms.addEventListener(MouseEvent.CLICK,this.itemsIconClick);
         this.researchUI.armsBox.mustArmsIcon.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.armsBox.mustArmsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.armsBox.mustArmsIcon.addEventListener(MouseEvent.CLICK,this.itemsIconClick);
         this.researchUI.subBox.armsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.subBox.armsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.subBox.armsBox.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.subBox.armsBox4.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.subBox.armsBox4.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.subBox.armsBox4.addEventListener(ClickEvent.ON_CLICK,this.itemsIconClick);
         this.researchUI.subBox.nowInlayArms.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.subBox.nowInlayArms.addEventListener(MouseEvent.CLICK,this.itemsIconClick);
         this.researchUI.subBox.nowInlayArms.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.subBox.mustArmsIcon.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.subBox.mustArmsIcon.addEventListener(MouseEvent.CLICK,this.itemsIconClick);
         this.researchUI.subBox.mustArmsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.carBox.carBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.carBox.carBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.researchUI.carBox.itemsIcon.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.carBox.itemsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.carBox.strengthenBox.mustItems1.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.carBox.strengthenBox.mustItems1.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.carBox.strengthenBox.mustItems2.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.carBox.strengthenBox.mustItems2.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.armsBox.conUI.nowArms.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.researchUI.armsBox.conUI.nowArms.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.researchUI.armsBox.conUI.mustItemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.researchUI.armsBox.conUI.mustItemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.allGiftUI.oneyuanUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.allGiftUI.oneyuanUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.taskUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.taskUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.taskUI.challengeUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.taskUI.challengeUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.taskUI.collectUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.taskUI.collectUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.taskUI.weekUI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.taskUI.weekUI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.allGiftUI.pay1UI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.allGiftUI.pay1UI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.allGiftUI.pay2UI.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.allGiftUI.pay2UI.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.leftUI.extraGift.itemsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.leftUI.extraGift.itemsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         livenessArr = this.mainUI.livenessUI.arr;
         for(n in livenessArr)
         {
            liveness_box = livenessArr[n].giftBox;
            liveness_box.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
            liveness_box.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         }
         this.mainUI.firstPayUI.armsIcon.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.mainUI.firstPayUI.armsIcon.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.mainUI.firstPayUI.carIcon.addEventListener(MouseEvent.MOUSE_OVER,this.itemsIconOver);
         this.mainUI.firstPayUI.carIcon.addEventListener(MouseEvent.MOUSE_OUT,this.itemsIconOut);
         this.mainUI.conChooseUI.armsBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.conChooseUI.armsBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.rankGiftUI.nowBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.rankGiftUI.nowBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.rankGiftUI.nextBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.rankGiftUI.nextBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.mainUI.payActivityUI.giftBox.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.mainUI.payActivityUI.giftBox.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.highUI.carBox.bagArms.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.highUI.carBox.bagArms.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.highUI.armsBox.nowArms.addEventListener(ClickEvent.ON_OVER,this.itemsIconOver);
         this.highUI.armsBox.nowArms.addEventListener(ClickEvent.ON_OUT,this.itemsIconOut);
         this.newArenaUI.arenaUI.addMouseOverOut(this.itemsIconOver,this.itemsIconOut);
      }
      
      public function gameInit() : *
      {
         this.mainUI.fleshData();
         this.infoUI.fleshData();
         this.loginUI.fleshHead();
         this.beforeMCoin = Game.gameData.MCoin;
         this.researchUI.crystalBox.newPlayerLogin();
         this.gameoverUI.cardUI.visible = false;
         this.researchUI.crystalBox.chipBaptizeUI.clear();
         this.researchUI.crystalBox.chipCubeUI.clear();
         this.changeUI.return_btn.setText("return");
         this.chooseLevelUI.levelBox.clear();
         this.unionUI.InitBuildAdd();
      }
      
      public function gameStartFlesh() : *
      {
         this.gamingUI.fleshNameAndHead();
         this.gamingUI.fleshTaskBox();
         this.allback.visible = false;
         this.allback.stopAll();
      }
      
      protected function onMouseFrame(event:Event) : void
      {
         this.gamingUI.pointer.x = Game.ME.stage.mouseX;
         this.gamingUI.pointer.y = Game.ME.stage.mouseY;
      }
      
      public function gameOverFlesh(fleshB:Boolean = true) : *
      {
         this.chooseLevelUI.fleshLock();
         if(fleshB)
         {
            this.mainUI.fleshData();
         }
         this.gamingUI.bossBarTarget = null;
         this.gamingUI.hideBossBar();
         this.allback.visible = true;
         this.allback.playAll();
         this.shopUI.gotoBackState = "return";
      }
      
      public function show(str:String) : *
      {
         trace("当前命令：" + str);
         if(this.researchUI.visible)
         {
            Game.gameData.fleshAdd_byItems();
         }
         if(this.changeUI.visible)
         {
            if(this.changeUI.btnBox.nowLabel != "materials")
            {
               if(this.changeUI.btnBox.nowLabel != "props")
               {
                  if(this.changeUI.btnBox.nowLabel == "car")
                  {
                  }
               }
            }
         }
         if(this.researchUI.visible && this.researchUI.crystalBox.visible)
         {
            this.researchUI.crystalBox.chipCubeUI.chipReturn();
            this.researchUI.crystalBox.chipBaptizeUI.chipReturn();
         }
         this.checkTip.visible = false;
         this.returnMenuTab.visible = false;
         this.orderArr.unshift(str);
         if(this.orderArr.length > 40)
         {
            this.orderArr.length = 40;
         }
         this.vipUI.visible = false;
         this.dailySignUI.visible = false;
         this.helperUI.visible = false;
         this.highUI.visible = false;
         this.newArenaUI.visible = false;
         this.faseUI.visible = false;
         this.chooseLevelUI.visible = false;
         this.mainUI.visible = false;
         this.changeUI.visible = false;
         this._changeUI.visible = false;
         this.mainUI.honorUI.visible = false;
         this.gamingUI.visible = false;
         this.gameoverUI.visible = false;
         this.leftUI.visible = false;
         this.menuUI.visible = false;
         this.shopUI.visible = false;
         this.exchangeUI.visible = false;
         this.researchUI.visible = false;
         this.exploreUI.visible = false;
         this.gameSprite.shootMouseL.visible = false;
         this.loginUI.visible = false;
         this.rankUI.visible = false;
         this.bookUI.visible = false;
         this.unionUI.visible = false;
         this.starGiftUI.visible = false;
         this.extraUI.visible = false;
         this.mainUI.taskUI.visible = false;
         this.tipBox.visible = false;
         CtrlListCtrl.hideList();
         this.allback.hideInfo();
         this.allback.hidePlayerBox();
         this.allback.fleshVolumeBtn();
         this.faseUI.clearLogo();
         this.allback.visible = true;
         this.allback.playAll();
         this.menu.visible = true;
         if(str != "return")
         {
            if(str == "fase")
            {
               this.allback.visible = false;
               this.allback.stopAll();
               this.faseUI.visible = true;
               this.faseUI.showLogo();
               this.faseUI.showPlayBtn();
               this.faseUI.hideLoaderBar();
               this.menu.visible = false;
            }
            else if(str == "union")
            {
               this.unionUI.visible = true;
               this.unionUI.Update();
            }
            else if(str == "starGift")
            {
               this.starGiftUI.Show();
            }
            else if(str == "book")
            {
               this.bookUI.visible = true;
            }
            else if(str == "vip")
            {
               this.vipUI.visible = true;
               this.vipUI.fleshData();
            }
            else if(str == "dailySign")
            {
               this.dailySignUI.visible = true;
               this.dailySignUI.fleshData();
            }
            else if(str == "helper")
            {
               this.helperUI.visible = true;
               this.helperUI.fleshData();
            }
            else if(str == "achievement")
            {
               this.menu.showBtn("main");
               this.mainUI.visible = true;
               this.mainUI.showHonor();
            }
            else if(str == "task")
            {
               this.mainUI.showTask();
            }
            else if(str == "high")
            {
               this.highUI.visible = true;
               this.highUI.showBox("high");
               this.highUI.openFlesh();
            }
            else if(str == "loader")
            {
               this.faseUI.visible = true;
               this.faseUI.resumeLogo();
               this.faseUI.showLoaderBar();
               Game.uiGroup.faseUI.StopGame();
               this.faseUI.showTips();
            }
            else if(str == "returnMain")
            {
               this.show("startGame");
            }
            else if(str == "startGame")
            {
               if(Game.gameState == "no" || Game.gameState == "chosen")
               {
                  this.menu.showBtn("main");
                  this.mainUI.visible = true;
                  this.infoUI.fleshData();
                  this.loginUI.clearAll();
                  this.fleshLabelNew();
                  this.noticePan();
                  this.allback.showInfo();
                  this.allback.showPlayerBox();
                  this.mainUI.hideAll();
                  this.returnMenuTab.visible = true;
                  this.returnMenuTab.mouseEnabled = true;
                  this.returnMenuTargetWidth = 14;
               }
               else
               {
                  this.show("resumeGame");
               }
            }
            else if(str == "main_arena" || str == "arena")
            {
               this.newArenaUI.visible = true;
               this.newArenaUI.showBox("arena");
               this.menu.showBtn("area");
            }
            else if(str == "returnArena")
            {
               this.show("main_arena");
            }
            else if(str == "gounion")
            {
               this.unionUI.visible = true;
               this.unionUI.Update(6);
            }
            else if(str == "login")
            {
               this.loginUI.visible = true;
               this.loginUI.showBox();
               this.menu.visible = false;
            }
            else if(str == "createRole")
            {
               if(Game.gameData.newLevelData.p1.lockNum > 1 || Game.gameDefine.nowLevel > 1)
               {
                  this.show("startGame");
               }
               else
               {
                  trace("直接开始第一关");
                  Game.eventGroup.chosenLevel();
               }
            }
            else if(str == "menu")
            {
               this.menu.visible = false;
               this.menuUI.visible = true;
               Game.eventGroup.fleshUI_byState();
               Game.eventGroup.pauseGame();
            }
            else if(str == "toBag")
            {
               this.gotoBag();
               this.allback.visible = true;
               this.allback.playAll();
               Game.eventGroup.pauseGame();
            }
            else if(str == "bagToMenu")
            {
               this.show("resumeGame");
               this.changeUI.showAll();
               this.menu.visible = false;
            }
            else if(str == "bagToMenu_shop")
            {
               this.shopUI.showAll();
               this.gameSprite.shootMouseL.visible = true;
               this.gamingUI.visible = true;
               this.leftUI.visible = true;
               this.allback.visible = false;
               this.allback.stopAll();
               Game.eventGroup.bagToMenu_shop();
               this.menu.visible = false;
            }
            else if(str == "resumeGame")
            {
               this.menu.visible = false;
               this.changeUI.return_btn.setText("return");
               this.gameSprite.shootMouseL.visible = true;
               this.gamingUI.visible = true;
               this.leftUI.visible = true;
               this.allback.visible = false;
               this.allback.stopAll();
               Game.eventGroup.resumeGame();
            }
            else if(str == "equip" || str == "main_equip")
            {
               Game.uiGroup._changeUI.visible = true;
               Game.uiGroup._changeUI.fleshData();
               this.allback.showInfo();
            }
            else if(str == "chooseLevel" || str == "main_startGame" || str == "continueGame" || str == "gonextcontinue")
            {
               this.menu.showBtn("extra");
               this.chooseLevelUI.visible = true;
               this.chooseLevelUI.fleshData();
               this.chooseLevelUI.showLabel("p1");
            }
            else if(str == "upgrade")
            {
               this.researchUI.visible = true;
               this.researchUI.fleshAll();
            }
            else if(str == "explore2222222")
            {
               this.exploreUI.visible = true;
               this.exploreUI.fleshAll();
            }
            else if(str == "extra" || str == "weekExtra" || str == "specialExtra" || str == "returnExtra" || str == "explore")
            {
               this.extraUI.visible = true;
               this.extraUI.fleshData();
               if(str == "extra" || str == "weekExtra" || str == "specialExtra")
               {
                  this.extraUI.showLabel(str);
               }
            }
            else if(str == "rank")
            {
               this.menu.showBtn("pay");
               this.rankUI.visible = true;
               this.rankUI.fleshData();
            }
            else if(str == "shop")
            {
               this.menu.showBtn("shop");
               this.shopUI.visible = true;
               this.shopUI.fleshPrice();
            }
            else if(str == "exchange")
            {
               this.shopUI.visible = true;
               this.shopUI.showBox(1);
               this.shopUI.fleshPrice();
            }
            else if(str == "restartLevel")
            {
               this.show("resumeGame");
               Game.eventGroup.restartLevel();
            }
            else if(str == "gameFail")
            {
               this.gameoverUItween();
               this.gameoverUI.visible = true;
               this.gameoverUI.failShow();
            }
            else if(str == "gameWin")
            {
               this.gameoverUItween();
               this.gameoverUI.visible = true;
               this.gameoverUI.winShow();
            }
         }
      }
      
      private function gameoverUItween() : *
      {
         this.gameoverUI.x = (1 - 0.7) * this.gameoverUI.width / 2;
         this.gameoverUI.y = (1 - 0.7) * this.gameoverUI.height / 2;
         this.gameoverUI.scaleX = 0.7;
         this.gameoverUI.scaleY = 0.7;
         TweenLite.to(this.gameoverUI,0.3,{
            "scaleX":1,
            "scaleY":1,
            "x":0,
            "y":0,
            "ease":Back.easeOut
         });
      }
      
      public function showTween(ui0:DisplayObject) : *
      {
         ui0.scaleX = 0.7;
         ui0.scaleY = 0.7;
         ui0.alpha = 0;
         TweenLite.to(ui0,0.5,{
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Back.easeOut
         });
      }
      
      public function hideTween(ui0:DisplayObject) : *
      {
         ui0.scaleX = 1;
         ui0.scaleY = 1;
         TweenLite.to(ui0,0.3,{
            "scaleX":0.7,
            "scaleY":0.7,
            "alpha":0,
            "ease":Back.easeIn
         });
      }
      
      private function noticePan() : *
      {
         if(Game.gameData.level <= 2)
         {
            Game.gameData.saveDataVersion = Game.versionNumber;
            return;
         }
         if(Game.versionNumber.substr(0,4) != Game.gameData.saveDataVersion.substr(0,4))
         {
            this.mainUI.showNotice();
            Game.testText.addTestText("----------当前游戏版本号（" + Game.versionNumber + "）" + "，存档游戏版本号（" + Game.gameData.saveDataVersion + "）");
            Game.gameData.saveDataVersion = Game.versionNumber;
            Game.gameData.taskData.fleshListData();
            this.newVB = true;
         }
         else
         {
            this.newVB = false;
            this.mainUI.hideNotice();
         }
      }
      
      public function doAffterOrder() : *
      {
         this.show(this.affterOrderStr);
      }
      
      public function restartExtraPayOrder() : *
      {
         Game.payController.decMCoin(Game.gameData.extraData.getRestart_M().MCoin,this.restartExtraPayOrder2);
      }
      
      public function restartExtraPayOrder2() : *
      {
         this.restartExtraCtrl();
         this.show("restartLevel");
      }
      
      public function restartExtraCtrl() : *
      {
         ++Game.gameData.extraData.buyNum;
      }
      
      public function restartExtraNoReward(e:* = null) : *
      {
         Game.gameData.extraData.useNoReward();
         this.restartLevel();
      }
      
      public function buttonClick(event:MouseEvent) : *
      {
         var order0:String = null;
         var mc0:* = event.target;
         if(mc0 is PicButton || mc0 is MainTitleButton)
         {
            order0 = mc0.text;
            if(order0 == "return")
            {
               if(this.orderArr[0] == "equip")
               {
                  Game.eventGroup.heroReturnWorld();
                  Game.eventGroup.fleshEquip();
                  this.gamingUI.fleshArms();
               }
               this.show("returnMain");
            }
            else if(order0 == "restartLevel")
            {
               this.checkTip.showCheck("是否要重玩本关卡？",this.restartLevel);
            }
            else if(order0 == "overLevel")
            {
               this.checkTip.showCheck("是否要退出本关卡？",this.overLevel);
            }
            else if(order0 == "restartExtra")
            {
               if(this.extraUI.extraState == "extra")
               {
                  if(Game.gameData.extraData.isLevelCooling(Game.gameData.nowGameLevel))
                  {
                     this.checkTip.showCheck("该精英副本正在冷却，重玩不会消耗挑战卡，也不会获得任何奖励。是否继续？",this.restartExtraNoReward);
                  }
                  else if(Game.gameData.extraData.hasFirstFree(Game.gameData.nowGameLevel))
                  {
                     Game.gameData.extraData.useFirstFree(Game.gameData.nowGameLevel);
                     this.restartLevel();
                  }
                  else if(Game.gameData.extraData.useChallengeCard())
                  {
                     this.checkTip.showTip("已消耗1张精英副本挑战卡。",1);
                     this.restartLevel();
                  }
                  else
                  {
                     this.checkTip.showCheck("没有精英副本挑战卡。重玩后不会获得任何奖励，是否继续？",this.restartExtraNoReward);
                  }
               }
               else if(this.extraUI.extraState == "weekExtra")
               {
                  this.checkTip.showCheck("是否要重玩该副本？",this.restartLevel);
               }
               else if(this.extraUI.extraState == "specialExtra")
               {
                  if(Game.gameData.specialExtraData.getNowNum() >= 1)
                  {
                     this.checkTip.showCheck("是否要重玩该副本？",this.restartLevel);
                  }
                  else
                  {
                     this.checkTip.showCheck2("今日该副本重玩次数使用完毕。",2);
                  }
               }
            }
            else if(order0 == "closeExtra")
            {
               this.checkTip.showCheck("是否主动放弃该副本？",this.overLevel);
            }
            else if(order0 != "createRole")
            {
               this.show(mc0.text);
            }
         }
         else if(mc0 is SimpleButton || mc0 is BlueLabelButton)
         {
            this.show(mc0.name.split("_btn")[0]);
         }
      }
      
      public function exploreNoFun(e:*) : *
      {
         this.checkTip.showCheck2("探索系统暂未开放。",2);
      }
      
      public function upLevel() : *
      {
         Game.eventGroup.upLevel(Game.gameData.level);
      }
      
      public function saveData(e:* = null) : *
      {
         Game.save_api.save();
         this.mainUI.startSaveDelay();
         this.showSaveReturn = true;
      }
      
      public function saveDataNoUI(e:* = null) : *
      {
         Game.save_api.save(false);
         this.mainUI.startSaveDelay();
         this.showSaveReturn = false;
      }
      
      public function clearData(e:* = null) : *
      {
         Game.saveController.ClearSO();
         Game.clearGameData();
      }
      
      public function showBagFill() : *
      {
         this.leftUI.fill_tip.visible = true;
         this.leftUI.fill_tip.play();
      }
      
      public function hideBagFill() : *
      {
         this.leftUI.fill_tip.visible = false;
         this.leftUI.fill_tip.stop();
      }
      
      public function showSupply() : *
      {
         Game.gameData.setLife(1,"mul");
         Game.SG.playSound("upgradeArms");
         Game.eventGroup.pauseGame();
         this.checkTip.showCheck2("你的战车已经修理完毕！",2,this.resumeGame,this.resumeGame);
      }
      
      public function resumeGame() : *
      {
         Game.eventGroup.resumeGame();
      }
      
      private function supplyYes() : *
      {
         this.show("equip");
         this._changeUI.bag.showLabel("car");
      }
      
      public function restartLevel() : *
      {
         this.show("restartLevel");
      }
      
      public function overLevel() : *
      {
         Game.eventGroup.closeLevel(false);
         this.show("startGame");
      }
      
      public function gotoResearch(labelStr:String, id0:String) : *
      {
         this.show("upgrade");
         this.researchUI.showBox(labelStr);
         this.researchUI.fleshAll();
         var gradeOrInlay:Boolean = true;
         var str1:* = labelStr.split("_")[0];
         var str2:* = labelStr.split("_")[1];
         if(str2 == "inlay")
         {
            gradeOrInlay = false;
         }
         if(id0 != "" && str1 != "player")
         {
            this.researchUI[str1 + "Box"].chooseByArmsID(id0,gradeOrInlay);
         }
      }
      
      public function gotoTrain(num0:int) : *
      {
         this.show("upgrade");
         this.researchUI.showBox("player_upgrade");
         this.researchUI.playerBox.trainOne_byIndex(num0);
      }
      
      public function gotoTrain_label(label0:String) : *
      {
         this.show("upgrade");
         this.researchUI.showBox("player_upgrade");
         this.researchUI.playerBox.trainOne(label0);
      }
      
      public function gotoChange(labelStr:String) : *
      {
         this.show("equip");
         this.changeUI.gotoUI(labelStr.split("_")[0]);
      }
      
      public function gotoExtraLevel() : *
      {
      }
      
      public function gotoBag() : *
      {
         this.show("");
         this.changeUI.visible = true;
         this.changeUI.materialsUI.fleshAll();
         this.changeUI.propsUI.fleshAll();
         this.changeUI.gotoUI("materials");
         this.changeUI.onlyShowMaterials();
      }
      
      public function gotoShop(labelStr:String) : *
      {
         this.show("shop");
         this.shopUI.fleshPrice();
         this.shopUI.showBox(0);
         this.shopUI.shopBox.showBox_byLabel(labelStr);
      }
      
      public function gotoPropsShop(e:* = null) : *
      {
         this.gotoShop("props");
      }
      
      public function uiTimer() : *
      {
         this.gamingUI.fleshBar();
      }
      
      public function uiTimer2() : *
      {
         this.gamingUI.skillBox.fleshData();
      }
      
      public function niubiSave() : *
      {
      }
      
      public function niubiSave2() : *
      {
      }
      
      public function itemsIconOut(event:* = null) : *
      {
         trace("离开事件");
         this.tipBox.hide();
      }
      
      public function itemsIconClick(event:*) : *
      {
         this.tipBox.hide();
      }
      
      public function itemsIconOver(event:*) : *
      {
         var iai:* = undefined;
         var tipmc0:* = undefined;
         var type0:String = null;
         var shopChipShowB:Boolean = false;
         this.armsTip.visible = false;
         this.carTip.visible = false;
         this.itemsTip.visible = false;
         trace("碰到事件");
         if(event.target is ItemsBox || event.target is ArmsIconBox || event.target is CarIconBox || event.target is ShopIconBox || event.target is ExploreIconBox || event.target is ChangeIconBox)
         {
            iai = event.goal;
            if(event.target is ExploreIconBox)
            {
               if(iai is ExploreIcon && Boolean(iai.name_txt.visible))
               {
                  return;
               }
            }
         }
         else if(event.target is ItemsIcon || event.target is ItemsArmsIcon || event.target is ItemsCarIcon || event.target is ShopIcon || event.target is ExploreIcon || event.target is ArenArivalBar)
         {
            iai = event.target;
         }
         var p0:Point = iai.localToGlobal(new Point());
         var mx:* = -1;
         if(iai.itemsData != null)
         {
            if(iai.itemsData is ItemsDefine)
            {
               this.itemsTip.inData_byDefine(iai.itemsData);
               tipmc0 = this.itemsTip;
            }
            else if(iai.itemsData is GoodsItemsData)
            {
               this.itemsTip.inData(iai.itemsData);
               tipmc0 = this.itemsTip;
            }
            else if(iai.itemsData is OneArmsDefine)
            {
               this.armsTip.inData_byDefine(iai.itemsData);
               tipmc0 = this.armsTip;
            }
            else if(iai.itemsData is ArmsItemsData)
            {
               this.armsTip.inData(iai.itemsData);
               tipmc0 = this.armsTip;
            }
            else if(iai.itemsData is CarDefine)
            {
               this.carTip.inData_byDefine(iai.itemsData);
               tipmc0 = this.carTip;
            }
            else if(iai.itemsData is CarItemsData)
            {
               this.carTip.inData(iai.itemsData);
               tipmc0 = this.carTip;
            }
            else if(iai.itemsData is HighArena_All)
            {
               this.carTip.inData_byHighArena_All(iai.itemsData);
               tipmc0 = this.carTip;
               mx = 1;
            }
            else if(iai.itemsData is GoodsDefine)
            {
               if(!iai.itemsData.showTipB)
               {
                  return;
               }
               type0 = iai.itemsData.type;
               shopChipShowB = false;
               if(type0 == "props" || type0 == "materials")
               {
                  type0 = "items";
                  shopChipShowB = true;
               }
               else if(type0 == "sub")
               {
                  type0 = "arms";
               }
               tipmc0 = this[type0 + "Tip"];
               if(shopChipShowB)
               {
                  tipmc0.inData_byDefine(iai.itemsData.define,iai.itemsData.chipLevelTipB,iai.itemsData.specialType,iai is ItemsIcon ? iai.showRandomB : false);
               }
               else
               {
                  tipmc0.inData_byDefine(iai.itemsData.define,iai.itemsData.specialType);
               }
               mx = 1;
               if(p0.x < 200)
               {
                  mx = -1;
               }
            }
            tipmc0.visible = true;
            this.tipBox.showDialog(tipmc0,iai,p0.x,p0.y,mx);
         }
      }
      
      private function armsIconOver(event:*) : *
      {
         var iai:ItemsArmsIcon = null;
         this.armsTip.visible = false;
         this.carTip.visible = false;
         this.itemsTip.visible = false;
         if(event.target is ArmsIconBox)
         {
            iai = event.goal;
         }
         else if(event.target is ItemsArmsIcon)
         {
            iai = event.target;
         }
         var p0:Point = iai.localToGlobal(new Point());
         if(iai.state == "fill")
         {
            if(iai.itemsData is OneArmsDefine)
            {
               this.armsTip.inData_byDefine(iai.itemsData);
            }
            else
            {
               this.armsTip.inData(iai.itemsData);
            }
            this.tipBox.showDialog(this.itemsTip,iai,p0.x,p0.y,1);
         }
      }
      
      public function clearNew() : *
      {
         this.researchUI.clearNew();
      }
      
      public function fleshNew() : *
      {
         var tt:int = getTimer();
         this.fleshNew_Skill();
         this.fleshNew_Arms();
         this.fleshLabelNew();
         trace("所耗时间：" + (getTimer() - tt));
      }
      
      public function fleshLabelNew() : *
      {
      }
      
      public function fleshNew_Skill() : *
      {
      }
      
      public function fleshNew_Arms() : *
      {
         this.researchUI.armsBox.fleshNew();
         this.researchUI.subBox.fleshNew();
      }
      
      public function FTimer1s(event:*) : *
      {
         var rankAdd:randAddData = Game.gameData.rankAdd;
         rankAdd.wasteTime();
         Game.gameData.vipData.FTimer();
         this.vipUI.FTimer();
         this.mainUI.FTimer1s();
         if(this.zuobipan.pan())
         {
            if(!Game.gameData.isZuobi)
            {
               this.zuobile("修改了指定数值！");
            }
         }
         if(this.zuobipan2.pan())
         {
            if(!Game.gameData.isZuobi)
            {
               this.zuobile("使用内存修改器！");
            }
         }
      }
      
      public function stopAllSound() : *
      {
         SoundMixer.soundTransform = new SoundTransform(0);
      }
      
      public function openAllSound() : *
      {
         SoundMixer.soundTransform = new SoundTransform(1);
      }
      
      public function pay(e:* = null) : *
      {
         Game.payController.openPayLink();
         trace("uigroup 充值！！！");
      }
      
      public function zuobile(str0:String = "") : *
      {
         Game.gameData.isZuobi = false;
         Game.gameData.zuobiStr = "";
      }
      
      public function showNoLogin(str0:String) : *
      {
         Game.eventGroup.clearAllCtrl();
         this.checkTip.showCheck2(str0);
      }
      
      public function showZuobile(str0:String = "", textStr0:String = "") : *
      {
         Game.gameData.isZuobi = false;
         Game.gameData.zuobiStr = "";
      }
      
      public function zuobiPanShow() : *
      {
         Game.gameData.isZuobi = false;
         Game.gameData.zuobiStr = "";
         return false;
      }
      
      public function panGift_BagEnough(d_arr:Array) : String
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         var str0:String = "";
         var GD:GameData = Game.gameData;
         var itemsBag_must:int = 0;
         var itemsCar_must:int = 0;
         for(n in d_arr)
         {
            d0 = d_arr[n];
            if(d0.type == "materials")
            {
               if(d0.id.indexOf("_chip") >= 0)
               {
                  itemsBag_must += d0.num;
               }
               else
               {
                  itemsBag_must++;
               }
            }
            else if(d0.type == "car")
            {
               itemsCar_must++;
            }
         }
         if(GD.carItems.getSurplus() < itemsCar_must)
         {
            str0 = "车库至少需要 " + itemsCar_must + " 个车位。";
         }
         if(GD.materialsItems.getSurplus() < itemsBag_must)
         {
            str0 = "材料背包至少需要 " + itemsBag_must + " 个空位。";
         }
         return str0;
      }
      
      public function addGift_byArr(d_arr:Array, firstB:Boolean = false, affixLevel0:int = -1, tipShowB:Boolean = true, armsRepeatPanB:Boolean = false) : *
      {
         var n:* = undefined;
         var d0:* = undefined;
         var items0:* = undefined;
         var ig0:* = undefined;
         var armsName0:String = null;
         var GD:GameData = Game.gameData;
         for(n in d_arr)
         {
            d0 = d_arr[n];
            if(d0 is String)
            {
               d0 = Game.goodsDefineGroup.getDefine_byStr3(d0,affixLevel0,true);
            }
            ig0 = GD[d0.type + "Items"];
            if(d0.type == "props" || d0.type == "materials")
            {
               if(firstB && Boolean(d0.getFastUseB()))
               {
                  if(d0.specialType == "offlineMCoin" || d0.id == "mcoin_reward_card" || d0.name == "M币")
                  {
                     GD.addMCoin(int(d0.price));
                  }
                  else if(d0.id == "GCoin_card_4")
                  {
                     GD.addCoin(d0.price);
                  }
                  else if(d0.id == "achieve_card_3")
                  {
                     GD.addAchieve(d0.price);
                  }
                  else if(d0.id == "exp_card_directly")
                  {
                     GD.addExp(d0.price);
                  }
               }
               else
               {
                  if(affixLevel0 == -1)
                  {
                     affixLevel0 = Game.gameData.level;
                  }
                  if(affixLevel0 < 0)
                  {
                     affixLevel0 = 0;
                  }
                  items0 = ig0.addItems(d0.id,d0.num,affixLevel0);
               }
            }
            else if(d0.type == "arms" || d0.type == "sub")
            {
               if(armsRepeatPanB)
               {
                  armsName0 = d0.id.split("_lv")[0];
                  if(!GD.checkArms_byIDArr([armsName0]))
                  {
                     items0 = ig0.addItems(d0.id,true);
                  }
               }
               else
               {
                  items0 = ig0.addItems(d0.id,true);
               }
            }
            else
            {
               items0 = ig0.addItems(d0.id,true,d0.define);
            }
         }
         if(tipShowB)
         {
            Game.uiGroup.checkTip.showTip("领取成功！",1);
            Game.SG.playSound("upgradeArms");
         }
         Game.uiGroup.infoUI.fleshData();
      }
      
      private function createReturnMenuTab() : Sprite
      {
         var tab:Sprite = new Sprite();
         tab.x = 0;
         tab.y = 350;
         tab.buttonMode = true;
         tab.mouseChildren = false;
         this.returnMenuTitle = new TextField();
         this.returnMenuTitle.defaultTextFormat = new TextFormat("_sans",18,16776960,true);
         this.returnMenuTitle.autoSize = TextFieldAutoSize.LEFT;
         this.returnMenuTitle.text = "返回主界面";
         this.returnMenuTitle.y = 11;
         tab.addChild(this.returnMenuTitle);
         this.returnMenuArrow = new TextField();
         this.returnMenuArrow.defaultTextFormat = new TextFormat("_sans",16,65535,true);
         this.returnMenuArrow.autoSize = TextFieldAutoSize.LEFT;
         this.returnMenuArrow.text = ">";
         this.returnMenuArrow.y = 12;
         tab.addChild(this.returnMenuArrow);
         tab.addEventListener(MouseEvent.ROLL_OVER,this.openReturnMenuTab);
         tab.addEventListener(MouseEvent.ROLL_OUT,this.closeReturnMenuTab);
         tab.addEventListener(MouseEvent.CLICK,this.clickReturnMenuTab);
         tab.addEventListener(Event.ENTER_FRAME,this.animateReturnMenuTab);
         this.returnMenuTab = tab;
         this.drawReturnMenuTab();
         return tab;
      }
      
      private function openReturnMenuTab(e:MouseEvent) : *
      {
         this.returnMenuTargetWidth = 138;
      }
      
      private function closeReturnMenuTab(e:MouseEvent) : *
      {
         this.returnMenuTargetWidth = 14;
      }
      
      private function clickReturnMenuTab(e:MouseEvent) : *
      {
         if(this.returnMenuWidth < 80)
         {
            this.returnMenuTargetWidth = 138;
            return;
         }
         this.returnMenuTab.mouseEnabled = false;
         this.checkTip.showCheck("是否保存当前进度并返回主界面？",this.confirmReturnMenu,this.cancelReturnMenu);
      }
      
      private function confirmReturnMenu() : *
      {
         this.returnMenuTargetWidth = 14;
         this.returnMenuTab.visible = false;
         Game.save_api.returnToMainMenu();
      }
      
      private function cancelReturnMenu() : *
      {
         this.returnMenuTab.mouseEnabled = true;
      }
      
      private function animateReturnMenuTab(e:Event) : *
      {
         if(!this.returnMenuTab.visible)
         {
            return;
         }
         var distance:Number = this.returnMenuTargetWidth - this.returnMenuWidth;
         if(Math.abs(distance) < 0.5)
         {
            this.returnMenuWidth = this.returnMenuTargetWidth;
         }
         else
         {
            this.returnMenuWidth += distance * 0.28;
         }
         this.drawReturnMenuTab();
      }
      
      private function drawReturnMenuTab() : *
      {
         this.returnMenuTab.graphics.clear();
         this.returnMenuTab.graphics.beginFill(263177,0.96);
         this.returnMenuTab.graphics.lineStyle(2,2739419,1);
         this.returnMenuTab.graphics.drawRect(-2,0,this.returnMenuWidth + 2,46);
         this.returnMenuTab.graphics.endFill();
         this.returnMenuTab.graphics.lineStyle(2,16755200,1);
         this.returnMenuTab.graphics.moveTo(this.returnMenuWidth - 2,5);
         this.returnMenuTab.graphics.lineTo(this.returnMenuWidth - 2,41);
         this.returnMenuTitle.x = 17;
         this.returnMenuTitle.alpha = Math.max(0,Math.min(1,(this.returnMenuWidth - 42) / 55));
         this.returnMenuArrow.x = this.returnMenuWidth - 11;
         this.returnMenuArrow.text = this.returnMenuTargetWidth > 14 ? "<" : ">";
      }
   }
}

