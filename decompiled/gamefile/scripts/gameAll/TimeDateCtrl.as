package gameAll
{
   import data.StringDate;
   import gameAll.data.randAddData;
   
   public class TimeDateCtrl
   {
      
      public var getSaveDate:StringDate = new StringDate();
      
      public var nowSaveDate:StringDate = new StringDate();
      
      public function TimeDateCtrl()
      {
         super();
      }
      
      public function toString() : String
      {
         var str0:String = "-----------服务器时间列表----------------\n";
         str0 += "getSaveDate：" + this.getSaveDate.getStr() + "\n";
         str0 += "nowSaveDate：" + this.nowSaveDate.getStr() + "\n";
         str0 += "firstTimeDate：" + Game.gameData.rankAdd.firstTimeDate + "\n";
         str0 += "存档时间和读档时间的天数相差：" + this.saveToGet() + "\n";
         return str0 + "----------------------------------";
      }
      
      public function saveToGet() : int
      {
         return this.nowSaveDate.compareDate(this.getSaveDate);
      }
      
      public function lastLoginToGet() : int
      {
         return Game.gameData.rankAdd.lastLoginTime.compareDate(this.getSaveDate);
      }
      
      public function lastLoginToGet2() : int
      {
         if(Game.uiGroup.serverUI.getSelectData() == null)
         {
            return 0;
         }
         var day:int = Game.uiGroup.serverUI.getSelectData().compareDate(this.getSaveDate);
         if(day > 500)
         {
            return 0;
         }
         return day;
      }
      
      public function giftPan() : *
      {
         var day2:int = 0;
         var rankAdd:randAddData = Game.gameData.rankAdd;
         var day0:int = rankAdd.getLoginGiftTime.compareDate(this.getSaveDate);
         if(day0 == 0)
         {
            Game.testText.addTestText("当天上线，不作处理。");
         }
         else if(day0 == 1)
         {
            day2 = rankAdd.firstTimeDate.compareDate(this.getSaveDate);
            if(day2 > 600 || day2 < 0)
            {
               Game.testText.addTestText("满足600天，或者第一天登陆时间为空，重置firstTimeDate");
               rankAdd.firstTimeDate.inData_byObj(this.getSaveDate);
               rankAdd.continueDays = 1;
            }
            else
            {
               rankAdd.continueDays = day2 + 1;
               Game.testText.addTestText("当前连续登陆次数：" + (day2 + 1));
            }
         }
         else
         {
            Game.testText.addTestText("第一天上线，存入时间firstTimeDate");
            rankAdd.firstTimeDate.inData_byObj(this.getSaveDate);
            rankAdd.continueDays = 1;
         }
         Game.testText.addTestText("最早一次连续登陆的时间：" + rankAdd.firstTimeDate.toString());
      }
      
      public function getLoginGift() : *
      {
         Game.gameData.rankAdd.getLoginGiftTime.inData_byObj(Game.timeDate.getSaveDate);
         this.giftPan();
         Game.uiGroup.saveDataNoUI();
      }
      
      public function getRankGift() : *
      {
         Game.gameData.rankAdd.getRankGiftTime.inData_byObj(Game.timeDate.getSaveDate);
         this.giftPan();
      }
      
      public function getLocalTimeStr() : String
      {
         var date0:Date = new Date();
         var sd0:StringDate = new StringDate();
         sd0.inData_byObj(date0);
         return sd0.getStr();
      }
   }
}

