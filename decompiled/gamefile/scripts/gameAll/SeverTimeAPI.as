package gameAll
{
   import data.StringDate;
   import flash.events.DataEvent;
   
   public class SeverTimeAPI
   {
      
      public var yesFun:Function;
      
      public var noFun:Function;
      
      public var nowTime:StringDate = new StringDate();
      
      public function SeverTimeAPI()
      {
         super();
      }
      
      public function is8() : Boolean
      {
         if(this.nowTime.getDateStr() == "2013-08-11")
         {
            return true;
         }
         return false;
      }
      
      public function than8() : Boolean
      {
         var d0:StringDate = new StringDate();
         d0.inData_byStr("2013-08-11");
         if(d0.compareDate(this.nowTime) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function getTime(_yesFun:Function = null, _noFun:Function = null) : *
      {
         Game.uiGroup.loadingUI.show("获取服务器时间中……");
         this.yesFun = _yesFun;
         this.noFun = _noFun;
         var serviceHold:* = Game.serviceHold;
         if(Boolean(serviceHold))
         {
            serviceHold.getServerTime();
         }
         else
         {
            this.onGetServerTimeHandler();
         }
      }
      
      public function onGetServerTimeHandler(evt:DataEvent = null) : void
      {
         Game.uiGroup.loadingUI.hide();
         var serviceHold:* = Game.serviceHold;
         var testText:* = Game.testText;
         var time00:String = "";
         if(Boolean(serviceHold))
         {
            time00 = evt.data;
         }
         else
         {
            time00 = Game.getNowLocalTime();
         }
         this.nowTime.inData_byStr(time00);
         testText.addTestText("当前服务器时间为：" + time00);
         testText.addTestText(Game.timeDate.toString());
         testText.addTestText(Game.gameData.rankAdd.toString());
         testText.addTestText("_________________________________");
         if(this.yesFun is Function)
         {
            this.yesFun(time00);
         }
      }
   }
}

