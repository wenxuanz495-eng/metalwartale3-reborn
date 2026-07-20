package UI
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TestTextUI extends Sprite
   {
      
      public var testArr:Array = [];
      
      public var testTxt:TextField;
      
      public var txt2:TextField;
      
      public function TestTextUI()
      {
         super();
      }
      
      public function addTestText(str0:String) : *
      {
         if(!this.testTxt)
         {
            return;
         }
         if(Game.gameDefine != null)
         {
            if(Game.gameDefine.getTestB())
            {
               this.testTxt.appendText(str0 + "\n");
            }
         }
         else
         {
            this.testTxt.appendText(str0 + "\n");
         }
      }
      
      public function flesh() : *
      {
         this.txt2.text = "当前版本充值数：" + (Game.payController2.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged2);
         this.txt2.appendText("\n总充值数：" + Game.payController2.nowRecharged);
      }
   }
}

