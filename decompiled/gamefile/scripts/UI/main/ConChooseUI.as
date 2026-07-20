package UI.main
{
   import UI.change.ArmsIconBox;
   import UI.icon.ItemsArmsIcon;
   import body.define.OneArmsDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConChooseUI extends Sprite
   {
      
      public var btn_arr:Array = [];
      
      public var armsBox:ArmsIconBox = new ArmsIconBox();
      
      public var return_btn:SimpleButton;
      
      public function ConChooseUI()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.armsBox.setNum(4,3,536,284);
         this.armsBox.x = 210;
         this.armsBox.y = 110;
         addChild(this.armsBox);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var icon0:ItemsArmsIcon = null;
         var btn0:SimpleButton = null;
         var arr0:Array = Game.defineGroup.getConDefineArr();
         this.armsBox.inData_byArr2(arr0);
         var arr1:Array = this.armsBox.arr;
         for(n in arr1)
         {
            icon0 = arr1[n];
            btn0 = Game.swfLoaderManager.getResource("ui","choose_btn");
            btn0.x = icon0.x + this.armsBox.x + 55;
            btn0.y = icon0.y + this.armsBox.y + 80;
            addChild(btn0);
            this.btn_arr.push(btn0);
            btn0.addEventListener(MouseEvent.CLICK,this.btnClick);
         }
      }
      
      public function btnClick(e:*) : *
      {
         var index0:int = this.btn_arr.indexOf(e.target);
         var d0:OneArmsDefine = this.armsBox.arr[index0].itemsData;
         if(Game.gameData.checkArms_byIDArr([d0.id]) == "")
         {
            Game.gameData.armsItems.addItems(d0.getLabel());
         }
         Game.gameData.giftData.haveConB = true;
         Game.uiGroup.checkTip.showTip("领取成功！",1);
         Game.SG.playSound("upgradeArms");
         this.hide();
         Game.uiGroup.mainUI._main.fleshBtn();
      }
      
      public function show20(e:* = null) : *
      {
         if(Game.gameData.level < 19)
         {
            Game.uiGroup.checkTip.showCheck2("人物等级必须到达20级才能领取！",2);
            this.hide();
         }
         else
         {
            this.show();
         }
      }
      
      public function show(e:* = null) : *
      {
         if(this.armsBox.arr.length == 0)
         {
            this.fleshData();
         }
         this.visible = true;
      }
      
      public function hide(e:* = null) : *
      {
         this.visible = false;
      }
   }
}

