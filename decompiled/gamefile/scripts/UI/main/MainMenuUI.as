package UI.main
{
   import UI.UIGroup;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MainMenuUI extends Sprite
   {
      
      public var UIG:UIGroup;
      
      public var nowOrder:String = "";
      
      public var main_btn:SimpleButton;
      
      public var change_btn:SimpleButton;
      
      public var strengthen_btn:SimpleButton;
      
      public var skill_btn:SimpleButton;
      
      public var aide_btn:SimpleButton;
      
      public var crystal_btn:SimpleButton;
      
      public var top_btn:SimpleButton;
      
      public var achievement_btn:SimpleButton;
      
      public var book_btn:SimpleButton;
      
      public var shop_btn:SimpleButton;
      
      public var btn_arr:Array;
      
      public function MainMenuUI(uig:UIGroup)
      {
         var n:* = undefined;
         var btn0:SimpleButton = null;
         this.btn_arr = [];
         super();
         this.UIG = uig;
         this.btn_arr = [this.main_btn,this.change_btn,this.strengthen_btn,this.skill_btn,this.aide_btn,this.crystal_btn,this.top_btn,this.achievement_btn,this.book_btn,this.shop_btn];
         for(n in this.btn_arr)
         {
            btn0 = this.btn_arr[n];
            btn0.addEventListener(MouseEvent.CLICK,this.btnClick);
            btn0.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
            btn0.addEventListener(MouseEvent.MOUSE_OVER,this.btnOver);
            btn0.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut);
         }
      }
      
      public function show(str:String) : *
      {
         if(str == "shop")
         {
            this.UIG.show("shop");
         }
         else if(str == "main")
         {
            this.UIG.show("startGame");
            this.UIG.mainUI.hideAll();
         }
         else if(str == "change")
         {
            this.UIG.show("equip");
         }
         else if(str == "strengthen")
         {
            this.UIG.show("upgrade");
            this.UIG.researchUI.showBox("arms_inlay");
         }
         else if(str == "crystal")
         {
            this.UIG.show("upgrade");
            this.UIG.researchUI.showBox("crystal_upgrade");
         }
         else if(str == "skill")
         {
            this.UIG.show("upgrade");
            this.UIG.researchUI.showBox("player_upgrade");
         }
         else if(str == "top")
         {
            this.UIG.show("high");
         }
         else if(str == "achievement")
         {
            this.UIG.show("achievement");
         }
         else if(str == "aide")
         {
            this.UIG.show("union");
         }
         else if(str == "book")
         {
            this.UIG.show("book");
         }
      }
      
      public function showBtn(str0:String) : *
      {
      }
      
      public function btnClick(event:MouseEvent) : *
      {
         var str0:String = event.target.name.split("_btn")[0];
         this.show(str0);
      }
      
      public function btnMove(event:MouseEvent = null) : *
      {
      }
      
      public function btnOver(event:MouseEvent) : *
      {
      }
      
      public function btnOut(event:MouseEvent) : *
      {
      }
   }
}

