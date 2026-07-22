package UI.change
{
   import UI.ClickEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CtrlArmsList extends Sprite
   {
      
      public var bu0:CtrlArmsButton;
      
      public var bu1:CtrlArmsButton;
      
      public var bu2:CtrlArmsButton;
      
      public var bu3:CtrlArmsButton;
      
      public var nameArr:Array = ["装备","卸下","升级","卖出","开启1个","强化","无法装备","使用全部","批量开启","选择形态","继续研发","研发/形态"];
      
      public var idArr:Array = [0,2,3];
      
      public var bu_arr:Array;
      
      public var back:MovieClip;
      
      public function CtrlArmsList()
      {
         super();
         this.bu_arr = [this.bu0,this.bu1,this.bu2,this.bu3];
         this.bu0.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.bu1.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.bu2.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.bu3.addEventListener(MouseEvent.CLICK,this.buttonClick);
         this.back.stop();
         this.fleshName(this.idArr);
      }
      
      public function fleshName(arr0:Array) : *
      {
         var m:* = undefined;
         var n:* = undefined;
         this.idArr = arr0;
         for(m in this.bu_arr)
         {
            this.bu_arr[m].visible = false;
         }
         for(n in arr0)
         {
            this.bu_arr[n].setText(this.nameArr[this.idArr[n]]);
            this.bu_arr[n].visible = true;
            this.bu_arr[n].index = this.idArr[n];
         }
         this.back.gotoAndStop(arr0.length);
      }
      
      public function buttonClick(event:MouseEvent) : *
      {
         var str0:String = event.target.name;
         var ce0:ClickEvent = new ClickEvent();
         ce0.index = event.target.index;
         ce0.goal = event.target;
         dispatchEvent(ce0);
      }
   }
}

