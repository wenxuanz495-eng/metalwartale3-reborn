package ctrl4399.skin
{
   import ctrl4399.strconst.AllConst;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   
   public class CtrlSkin
   {
      
      private var _facade:Facade = Facade.getInstance();
      
      private var _lc:LoaderContext;
      
      private var _loc:Loader;
      
      public function CtrlSkin()
      {
         super();
      }
      
      public function init() : void
      {
         this.assetLoaded();
      }
      
      private function assetLoaded(param1:Event = null) : void
      {
         Singleton.registerClass(AllConst.SPC_ScoreCont,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_ScoreCont) as Class);
         Singleton.registerClass(AllConst.SPC_ScoreView,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_ScoreView) as Class);
         Singleton.registerClass(AllConst.SPC_BTN_TOP,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_BTN_TOP) as Class);
         Singleton.registerClass(AllConst.SPC_INPUT,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_INPUT) as Class);
         Singleton.registerClass(AllConst.SPC_BTN_PRE_LOG,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_BTN_PRE_LOG) as Class);
         Singleton.registerClass(AllConst.SPC_BTN_RESTART,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_BTN_RESTART) as Class);
         Singleton.registerClass(AllConst.SPC_RegCont,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_RegCont) as Class);
         Singleton.registerClass(AllConst.SPC_LogScoreCont,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_LogScoreCont) as Class);
         Singleton.registerClass(AllConst.SPC_LogScoreView,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_LogScoreView) as Class);
         Singleton.registerClass(AllConst.SPC_TxtPanel,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_TxtPanel) as Class);
         Singleton.registerClass(AllConst.SPC_SortCont,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SortCont) as Class);
         Singleton.registerClass(AllConst.SPC_SortView,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SortView) as Class);
         Singleton.registerClass(AllConst.SPC_BTN_WORLD,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_BTN_WORLD) as Class);
         Singleton.registerClass(AllConst.SPC_BTN_FRIEND,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_BTN_FRIEND) as Class);
         Singleton.registerClass(AllConst.SPC_SListSelf,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SListSelf) as Class);
         Singleton.registerClass(AllConst.SPC_SListOther,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SListOther) as Class);
         Singleton.registerClass(AllConst.SPC_SBtnBg,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SBtnBg) as Class);
         Singleton.registerClass(AllConst.SPC_TabTxt,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_TabTxt) as Class);
         Singleton.registerClass(AllConst.SPC_SCROLL_DOWN,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SCROLL_DOWN) as Class);
         Singleton.registerClass(AllConst.SPC_SCROLL_THUMB,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SCROLL_THUMB) as Class);
         Singleton.registerClass(AllConst.SPC_SCROLL_TRACE,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SCROLL_TRACE) as Class);
         Singleton.registerClass(AllConst.SPC_SCROLL_UP,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SCROLL_UP) as Class);
         Singleton.registerClass(AllConst.SPC_View_Shop,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_View_Shop) as Class);
         Singleton.registerClass(AllConst.SPC_Cont_Shop,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_Cont_Shop) as Class);
         Singleton.registerClass(AllConst.SPC_View_Shop_Item,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_View_Shop_Item) as Class);
         Singleton.registerClass(AllConst.SPC_Cont_Shop_Item,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_Cont_Shop_Item) as Class);
         Singleton.registerClass(AllConst.SPC_CONT,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_CONT) as Class);
         Singleton.registerClass(AllConst.SPC_VIEW,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_VIEW) as Class);
         Singleton.registerClass(AllConst.GL_TITLE_TOOL,ApplicationDomain.currentDomain.getDefinition(AllConst.GL_TITLE_TOOL) as Class);
         Singleton.registerClass(AllConst.GL_AD_MASK,ApplicationDomain.currentDomain.getDefinition(AllConst.GL_AD_MASK) as Class);
         Singleton.registerClass(AllConst.EMPTY_TIP,ApplicationDomain.currentDomain.getDefinition(AllConst.EMPTY_TIP) as Class);
         Singleton.registerClass(AllConst.WAIT_MC,ApplicationDomain.currentDomain.getDefinition(AllConst.WAIT_MC) as Class);
         Singleton.registerClass(AllConst.SAVE_TIP,ApplicationDomain.currentDomain.getDefinition(AllConst.SAVE_TIP) as Class);
         Singleton.registerClass(AllConst.SAVE_LIST_VIEW,ApplicationDomain.currentDomain.getDefinition(AllConst.SAVE_LIST_VIEW) as Class);
         Singleton.registerClass(AllConst.SAVE_LIST_ITME,ApplicationDomain.currentDomain.getDefinition(AllConst.SAVE_LIST_ITME) as Class);
         Singleton.registerClass(AllConst.SPC_NET_FAILURE_VIEW,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_NET_FAILURE_VIEW) as Class);
         Singleton.registerClass(AllConst.SPC_NET_FAILURE_BTN,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_NET_FAILURE_BTN) as Class);
         Singleton.registerClass(AllConst.ERROR_TIP_UI,ApplicationDomain.currentDomain.getDefinition(AllConst.ERROR_TIP_UI) as Class);
         Singleton.registerClass(AllConst.SORT_BACK_BTN_SKIN,ApplicationDomain.currentDomain.getDefinition(AllConst.SORT_BACK_BTN_SKIN) as Class);
         Singleton.registerClass(AllConst.SPC_SecondaryLogView,ApplicationDomain.currentDomain.getDefinition(AllConst.SPC_SecondaryLogView) as Class);
         this._facade.sendNotification(AllConst.SKIN_LOAD_OK);
      }
   }
}

