package UI.honor
{
   import UI.ClickEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class AchievementLabel extends Sprite
   {
      
      public var bigNameArr:Array;
      
      public var bigCnNameArr:Array;
      
      public var big_arr:Array = [];
      
      public var small_arr:Array = [];
      
      public var nowIndex:int = 0;
      
      public var nowSmallType:String = "";
      
      public var bigGrap:int = 40;
      
      public function AchievementLabel()
      {
         super();
         this.bigNameArr = Game.gameDefine.honor.ac.bigNameArr;
         this.bigCnNameArr = Game.gameDefine.honor.ac.bigCnNameArr;
      }
      
      public function addBigLabel() : *
      {
         var n:* = undefined;
         var btn0:AchievementLabelBtn = null;
         for(n in this.bigNameArr)
         {
            btn0 = new AchievementLabelBtn();
            btn0.index = n;
            btn0.id_name = this.bigNameArr[n];
            btn0.setText(this.bigCnNameArr[n]);
            addChild(btn0);
            btn0.x = 0;
            btn0.y = 0 + n * this.bigGrap;
            this.big_arr.push(btn0);
            btn0.addEventListener(MouseEvent.CLICK,this.bigClick);
         }
      }
      
      public function rangeBigLabel() : *
      {
         var n:* = undefined;
         var btn0:AchievementLabelBtn = null;
         for(n in this.big_arr)
         {
            btn0 = this.big_arr[n];
            if(n <= this.nowIndex)
            {
               btn0.y = 0 + n * this.bigGrap;
            }
            else
            {
               btn0.y = 0 + n * this.bigGrap + this.small_arr.length * 26 + 10;
            }
         }
      }
      
      public function normalRangeBigLabel() : *
      {
         var n:* = undefined;
         var btn0:AchievementLabelBtn = null;
         for(n in this.big_arr)
         {
            btn0 = this.big_arr[n];
            if(n <= this.nowIndex)
            {
               btn0.y = 0 + n * this.bigGrap;
            }
         }
      }
      
      public function addSmallLabel(y0:int) : *
      {
         var n:* = undefined;
         var btn0:AchievementLabelBtn2 = null;
         this.clearSmallLabel();
         var id_name0:String = this.big_arr[this.nowIndex].id_name;
         var list0:Array = Game.gameDefine.honor.ac[id_name0 + "ListArr"];
         for(n in list0)
         {
            btn0 = new AchievementLabelBtn2();
            btn0.index = n;
            btn0.id_name = list0[n][0];
            btn0.setText(list0[n][1]);
            addChild(btn0);
            btn0.x = 45;
            btn0.y = 0 + n * 30 + y0;
            this.small_arr.push(btn0);
            btn0.addEventListener(MouseEvent.CLICK,this.smallClick);
         }
      }
      
      public function clearSmallLabel() : *
      {
         var n:* = undefined;
         var btn0:AchievementLabelBtn2 = null;
         for(n in this.small_arr)
         {
            btn0 = this.small_arr[n];
            btn0.clear();
            removeChild(btn0);
         }
         this.small_arr.length = 0;
      }
      
      private function bigClick(event:MouseEvent, btn0:* = null) : *
      {
         var n:* = undefined;
         var btn1:AchievementLabelBtn = null;
         if(btn0 == null)
         {
            btn0 = event.target;
         }
         this.nowIndex = btn0.index;
         for(n in this.big_arr)
         {
            btn1 = this.big_arr[n];
            btn1.setState(0);
         }
         btn0.setState(1);
         this.normalRangeBigLabel();
         this.addSmallLabel(btn0.y + this.bigGrap);
         this.rangeBigLabel();
      }
      
      private function smallClick(event:MouseEvent, btn0:* = null) : *
      {
         var n:* = undefined;
         var clickEvent:ClickEvent = null;
         var btn1:AchievementLabelBtn2 = null;
         if(btn0 == null)
         {
            btn0 = event.target;
         }
         this.nowSmallType = btn0.id_name;
         for(n in this.small_arr)
         {
            btn1 = this.small_arr[n];
            btn1.setState(0);
         }
         btn0.setState(1);
         clickEvent = new ClickEvent();
         clickEvent.goal = btn0;
         clickEvent.index = btn0.index;
         this.dispatchEvent(clickEvent);
      }
      
      public function chooseLabel(bigIndex0:int, smallIndex0:int) : *
      {
         this.bigClick(null,this.big_arr[bigIndex0]);
         this.smallClick(null,this.small_arr[smallIndex0]);
      }
   }
}

