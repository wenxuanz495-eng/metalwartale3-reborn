package gameAll.data.weekExtra
{
   import data.StringDate;
   import gameAll.define.WeekExtraOneDefine;
   
   public class WeekExtraData
   {
      
      public static var VERSION:Number = 2.8;
      
      public var arr:Array = [];
      
      public var saveDataVersion:Number = 1.11;
      
      public var weekFleshDate:String = "";
      
      public function WeekExtraData()
      {
         super();
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var d0:WeekExtraOneDefine = null;
         var data0:WeekExtraOneData = null;
         this.arr.length = 0;
         var darr:Array = Game.gameDefine.weekExtra.arr;
         for(n in darr)
         {
            d0 = darr[n];
            data0 = new WeekExtraOneData();
            data0.id = d0.id;
            data0.nowLife = d0.maxLife;
            data0.fleshDefine();
            this.arr.push(data0);
         }
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var darr:Array = null;
         var i:* = undefined;
         var data0:WeekExtraOneData = null;
         Game.testText.addTestText("WeekExtraData.inData_byObj");
         var pro_arr:Array = ["saveDataVersion"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         if(this.saveDataVersion < VERSION)
         {
            this.saveDataVersion = VERSION;
            this.init();
         }
         else
         {
            darr = Game.gameDefine.weekExtra.arr;
            for(i in darr)
            {
               data0 = new WeekExtraOneData();
               this.arr[i] = data0;
               if(obj.arr.length >= i + 1)
               {
                  data0.inData_byObj(obj.arr[i]);
               }
               else
               {
                  data0.id = darr[i].id;
                  data0.nowLife = darr[i].maxLife;
               }
               data0.fleshDefine();
            }
         }
         if(!obj.hasOwnProperty("weekFleshDate"))
         {
            this.weekFleshDate = "";
         }
         else
         {
            this.weekFleshDate = obj.weekFleshDate;
         }
      }
      
      public function newDayCtrl() : *
      {
         var cd0:int = 0;
         var nd0:StringDate = Game.severTime.nowTime;
         var d0:StringDate = new StringDate();
         if(this.weekFleshDate == "")
         {
            this.weekFleshDate = nd0.getStr();
         }
         d0.inData_byStr(this.weekFleshDate);
         if(nd0.fullYear >= 2013)
         {
            cd0 = -nd0.compareDate(d0);
            Game.testText.addTestText("newDayCtrl:天数相差：" + cd0);
            if(cd0 >= 7)
            {
               this.init();
               this.weekFleshDate = nd0.getStr();
            }
         }
      }
      
      public function setNowExtraState(bb0:Boolean) : *
      {
         this.getNowData().winB = bb0;
         this.getNowData().readyAt = new Date().time + 1800000;
      }
      
      public function getNowData() : WeekExtraOneData
      {
         var level0:int = Game.gameData.nowGameLevel;
         return this.arr[level0];
      }
      
      public function getUnlockArr() : Array
      {
         var n:* = undefined;
         var data0:WeekExtraOneData = null;
         var level0:int = 0;
         var arr0:Array = [];
         for(n in this.arr)
         {
            data0 = this.arr[n];
            if(data0.winB && data0.readyAt > 0 && new Date().time >= data0.readyAt)
            {
               data0.winB = false;
               data0.readyAt = 0;
               data0.nowLife = data0.define.maxLife;
            }
            level0 = this.getMustLevel(n);
            if(level0 > Game.gameData.level)
            {
               arr0.push(0);
            }
            else if(data0.winB || new Date().time < data0.readyAt)
            {
               arr0.push(2);
            }
            else
            {
               arr0.push(1);
            }
         }
         return arr0;
      }
      
      public function getMustLevel(index0:int) : int
      {
         return Game.gameDefine.weekExtra.getMustLevel(index0);
      }
      
      public function getCooldownSeconds(index0:int) : int
      {
         var data0:WeekExtraOneData = this.arr[index0];
         if(data0 == null)
         {
            return 0;
         }
         return Math.max(0,Math.ceil((data0.readyAt - new Date().time) / 1000));
      }
   }
}

