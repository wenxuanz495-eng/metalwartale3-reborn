package UI.honor
{
   import data.StringToDefine;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.honor.AchievementOneData;
   import gameAll.honor.AchievementOneDefine;
   import gameAll.honor.OneHonorDefine;
   
   public class AchievementBar extends Sprite
   {
      
      public var name_txt:TextField;
      
      public var _txt1:TextField;
      
      public var _txt2:TextField;
      
      public var _btn:SimpleButton;
      
      public var no_btn:*;
      
      public var itemsData:* = null;
      
      public function AchievementBar()
      {
         super();
         this.no_btn.txt.text = "已领取";
         this.no_btn.stop();
      }
      
      public function inData(d0:*) : *
      {
         this.itemsData = d0;
         if(d0 is AchievementOneDefine)
         {
            this.inData_byDefine(d0);
         }
         else
         {
            this.inData_byData(d0);
         }
      }
      
      public function inData_byDefine(d0:AchievementOneDefine) : *
      {
         var honor_d:OneHonorDefine = null;
         this.name_txt.text = d0.cnName;
         var txt0:String = "";
         txt0 += StringToDefine.getFontColor("目标：","#00FFFF") + d0.info;
         var ptype0:String = d0.getProgressType();
         if(ptype0 == "stateNumberType")
         {
            txt0 += "\n" + StringToDefine.getFontColor("进度：","#00FFFF") + d0.getProgress(Game.gameData.getOneData_byType(d0.type));
         }
         else
         {
            txt0 += "\n" + StringToDefine.getFontColor("进度：","#00FFFF") + d0.getProgress();
         }
         this._txt1.htmlText = txt0;
         var txt2:String = "";
         txt2 += d0.acValue + " 点成就点数";
         if(d0.honor != "")
         {
            honor_d = Game.gameData.honorData.getDefine(d0.honor);
            if(Boolean(honor_d))
            {
               txt2 += "\n称号“" + StringToDefine.getFontColor(honor_d.cnName,"#FF66FF") + "”";
            }
         }
         var giftArr0:Array = Game.goodsDefineGroup.getArr_byStrArr(d0.giftArr,1,true);
         var giftStr0:String = Game.goodsDefineGroup.switchArr_toStr(giftArr0,true);
         if(giftStr0 == "无")
         {
            giftStr0 = "";
         }
         txt2 += giftStr0;
         this._txt2.htmlText = txt2;
         this._btn.visible = false;
         this.no_btn.visible = false;
      }
      
      public function inData_byData(data0:AchievementOneData) : *
      {
         var d0:AchievementOneDefine = data0.getDefine();
         this.inData_byDefine(d0);
         var txt0:String = "";
         txt0 += StringToDefine.getFontColor("目标：","#00FFFF") + d0.info;
         if(data0.now != "")
         {
            if(d0.getProgressType() == "stateNumberType")
            {
               txt0 += "\n" + StringToDefine.getFontColor("进度：","#00FFFF") + d0.getProgress(Game.gameData.getOneData_byType(d0.type));
            }
            else
            {
               txt0 += "\n" + StringToDefine.getFontColor("进度：","#00FFFF") + d0.getProgress(data0.now);
            }
         }
         else
         {
            txt0 += "\n" + StringToDefine.getFontColor("完成时间：","#FFFF00") + data0.completeTime;
         }
         this._txt1.htmlText = txt0;
         if(d0.honor == "" && d0.giftArr.length == 0 && d0.acValue <= 0)
         {
            this._btn.visible = false;
            this.no_btn.visible = false;
         }
         else
         {
            this._btn.visible = !data0.haveGiftB;
            this.no_btn.visible = !this._btn.visible;
         }
      }
   }
}

