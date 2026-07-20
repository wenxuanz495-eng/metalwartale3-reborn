package UI.top
{
   import UI.button.SountoScrollBar;
   import UI.change.CarIconBox;
   import UI.icon.ItemsCarIcon;
   import flash.display.Sprite;
   
   public class HighCarUI extends Sprite
   {
      
      public var bagArms:CarIconBox = new CarIconBox("bag",false);
      
      public var sBar:SountoScrollBar;
      
      public var cover_mc:Sprite;
      
      public function HighCarUI()
      {
         super();
         this.bagArms.setNum(2,7,520,128 * 7);
         this.bagArms.x = 263 + 35;
         this.bagArms.y = 45;
         addChild(this.bagArms);
         addChild(this.sBar);
         this.fleshData();
         this.bagArms.mask = this.cover_mc;
         this.sBar.setHigh(342);
         this.sBar.setTarget(this.bagArms);
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var icon0:ItemsCarIcon = null;
         var arr0:Array = ["purplex6","optimusPrime2","avanty","megatron","optimusPrime","platinumChariots","mcQueen","moumou","bentley","prime","adui_z","kamikaze","jufengzhichui","yueguang"];
         arr0.reverse();
         var arr1:Array = Game.defineGroup.getCarArr_byLabelArr(arr0);
         this.bagArms.inData_byDefine(arr1);
         for(n in this.bagArms.arr)
         {
            icon0 = this.bagArms.arr[n];
         }
         this.sBar.setPer(0);
         this.sBar.setTarget(this.bagArms,false);
      }
   }
}

