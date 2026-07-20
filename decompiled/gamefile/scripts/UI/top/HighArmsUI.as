package UI.top
{
   import UI.change.ArmsIconBox;
   import flash.display.Sprite;
   
   public class HighArmsUI extends Sprite
   {
      
      public var nowArms:ArmsIconBox = new ArmsIconBox("bag",false);
      
      public function HighArmsUI()
      {
         super();
         this.nowArms.setNum(6,4,710,314);
         this.nowArms.x = 235;
         this.nowArms.y = 75;
         addChild(this.nowArms);
         this.fleshData();
      }
      
      public function fleshData() : *
      {
         var arr1:Array = Game.defineGroup.getExtraArmsArr();
         arr1.reverse();
         this.nowArms.inData_byArr2(arr1);
      }
   }
}

