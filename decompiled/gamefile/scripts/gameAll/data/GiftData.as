package gameAll.data
{
   import data.TextWay;
   import flash.utils.getTimer;
   import goods.StarGiftData;
   
   public class GiftData
   {
      
      public static var VERSION:Number = 1.15;
      
      public var oneYuanB:Boolean = false;
      
      public var unlock_arr:Array = new Array();
      
      public var levelunlock_arr:Array = new Array();
      
      public var onePayArr:Array = [];
      
      public var nowGetIndex:int = -1;
      
      public var haveConB:Boolean = false;
      
      public var conClaimed:Array = [];
      
      public var pay29B:Boolean = false;
      
      public var nationalDayGiftB:Boolean = false;
      
      public var nationalDayPayB:Boolean = false;
      
      public var haveSuperNum:int = 0;
      
      private var _killAirshipNum:String = "0";
      
      private var _temp_killAirshipNum:String = "0";
      
      public var buchangB:Boolean = false;
      
      public var turntableflag:String = "";
      
      public var snowyuanshiflag:String = "";
      
      public var unioncontriG:String = "";
      
      public var unioncontriM:String = "";
      
      public var unioncontriGift:String = "";
      
      public var unionShoped:String = "";
      
      public var unionCityFighted:String = "";
      
      public var starShoped:String = "";
      
      public var growShoped:String = "";
      
      public var prize51:String = "";
      
      public var prize51_2:String = "";
      
      public var unionTask:String = "";
      
      public var unionTaskGeted:String = "";
      
      public var unionFightPrize:String = "";
      
      public var unionBuild:String = "";
      
      public var TechBuild:String = "";
      
      public var saveDataVersion:Number = 1.15;
      
      private var _initTimeZone:Number;
      
      public function GiftData()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.oneYuanB = false;
         var i:int = 0;
         while(i < 100)
         {
            this.unlock_arr[i] = 0;
            i++;
         }
         this.levelGiftInit();
         this.onePayInit();
         this.haveConB = false;
         this.conClaimed = [false,false,false,false,false,false,false,false,false,false,false,false];
         this.pay29B = false;
         this.nationalDayGiftB = false;
         this.nationalDayPayB = false;
         this.killAirshipNum = 0;
         this.haveSuperNum = 0;
         var initDate:Date = new Date();
         this._initTimeZone = initDate.timezoneOffset;
      }
      
      private function isNowVersion(obj:Object) : Boolean
      {
         if(!obj.hasOwnProperty("saveDataVersion"))
         {
            return false;
         }
         if(VERSION > obj.saveDataVersion)
         {
            return false;
         }
         return true;
      }
      
      public function onePayInit() : *
      {
         var i:int = 0;
         while(i < 100)
         {
            this.onePayArr[i] = 0;
            i++;
         }
      }
      
      public function levelGiftInit() : *
      {
         var i:int = 0;
         while(i < 100)
         {
            this.levelunlock_arr[i] = 0;
            i++;
         }
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var bb0:Boolean = false;
         var m:* = undefined;
         var pro0:String = null;
         var i:* = undefined;
         var pro_arr:Array = ["oneYuanB"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         bb0 = this.isNowVersion(obj);
         this.saveDataVersion = VERSION;
         for(m in this.unlock_arr)
         {
            if(obj.unlock_arr[m] == 1)
            {
               if(m >= 11)
               {
                  if(bb0)
                  {
                     this.unlock_arr[m] = 1;
                  }
                  else
                  {
                     this.unlock_arr[m] = 0;
                  }
               }
               else
               {
                  this.unlock_arr[m] = 1;
               }
            }
            else
            {
               this.unlock_arr[m] = 0;
            }
         }
         if(!obj.hasOwnProperty("levelunlock_arr"))
         {
            this.levelGiftInit();
         }
         else
         {
            for(m in this.levelunlock_arr)
            {
               if(obj.levelunlock_arr[m] == 1)
               {
                  this.levelunlock_arr[m] = 1;
               }
               else
               {
                  this.levelunlock_arr[m] = 0;
               }
            }
         }
         if(!obj.hasOwnProperty("onePayArr"))
         {
            this.onePayInit();
         }
         else
         {
            for(i in this.onePayArr)
            {
               if(obj.onePayArr[i] == 1)
               {
                  this.onePayArr[i] = 1;
               }
               else
               {
                  this.onePayArr[i] = 0;
               }
            }
         }
         if(!obj.hasOwnProperty("haveConB"))
         {
            this.haveConB = false;
         }
         else
         {
            this.haveConB = obj.haveConB;
         }
         if(obj.hasOwnProperty("conClaimed") && obj.conClaimed is Array)
         {
            this.conClaimed = obj.conClaimed.concat();
         }
         else
         {
            this.conClaimed = [false,false,false,false,false,false,false,false,false,false,false,false];
         }
         while(this.conClaimed.length < 12)
         {
            this.conClaimed.push(false);
         }
         if(!obj.hasOwnProperty("pay29B"))
         {
            this.pay29B = false;
         }
         else
         {
            this.pay29B = obj.pay29B;
         }
         if(!obj.hasOwnProperty("nationalDayGiftB"))
         {
            this.nationalDayGiftB = false;
            this.nationalDayPayB = false;
            this.killAirshipNum = 0;
         }
         else
         {
            this.nationalDayGiftB = obj.nationalDayGiftB;
            this.nationalDayPayB = obj.nationalDayPayB;
            this.killAirshipNum = obj.killAirshipNum;
         }
         Game.testText.addTestText("killAirshipNum:" + this.killAirshipNum);
         Game.testText.addTestText("temp_killAirshipNum:" + this.killAirshipNum);
         if(this.temp_killAirshipNum > 0)
         {
            this.killAirshipNum += this.temp_killAirshipNum;
            this.temp_killAirshipNum = 0;
         }
         Game.testText.addTestText("killAirshipNum:" + this.killAirshipNum);
         if(!obj.hasOwnProperty("haveSuperNum"))
         {
            this.haveSuperNum = 0;
         }
         else
         {
            this.haveSuperNum = obj.haveSuperNum;
         }
         if(!obj.hasOwnProperty("buchangB"))
         {
            this.buchangB = false;
         }
         else
         {
            this.buchangB = obj.buchangB;
         }
         if(!obj.hasOwnProperty("turntableflag"))
         {
            this.turntableflag = "";
         }
         else
         {
            this.turntableflag = obj.turntableflag;
         }
         if(!obj.hasOwnProperty("snowyuanshiflag"))
         {
            this.snowyuanshiflag = "";
         }
         else
         {
            this.snowyuanshiflag = obj.snowyuanshiflag;
         }
         if(!obj.hasOwnProperty("unioncontriG"))
         {
            this.unioncontriG = "";
         }
         else
         {
            this.unioncontriG = obj.unioncontriG;
         }
         if(!obj.hasOwnProperty("unioncontriM"))
         {
            this.unioncontriM = "";
         }
         else
         {
            this.unioncontriM = obj.unioncontriM;
         }
         if(!obj.hasOwnProperty("unionBuild"))
         {
            this.unionBuild = "";
         }
         else
         {
            this.unionBuild = obj.unionBuild;
         }
         if(!obj.hasOwnProperty("TechBuild"))
         {
            this.TechBuild = "";
         }
         else
         {
            this.TechBuild = obj.TechBuild;
         }
         if(!obj.hasOwnProperty("unioncontriGift"))
         {
            this.unioncontriGift = "";
         }
         else
         {
            this.unioncontriGift = obj.unioncontriGift;
         }
         if(!obj.hasOwnProperty("unionShoped"))
         {
            this.unionShoped = "";
         }
         else
         {
            this.unionShoped = obj.unionShoped;
         }
         if(!obj.hasOwnProperty("unionCityFighted"))
         {
            this.unionCityFighted = "";
         }
         else
         {
            this.unionCityFighted = obj.unionCityFighted;
         }
         if(!obj.hasOwnProperty("starShoped"))
         {
            this.starShoped = "";
         }
         else
         {
            this.starShoped = obj.starShoped;
         }
         if(!obj.hasOwnProperty("growShoped"))
         {
            this.growShoped = "";
         }
         else
         {
            this.growShoped = obj.growShoped;
         }
         if(!obj.hasOwnProperty("prize51"))
         {
            this.prize51 = "";
         }
         else
         {
            this.prize51 = obj.prize51;
         }
         if(!obj.hasOwnProperty("prize51_2"))
         {
            this.prize51_2 = "";
         }
         else
         {
            this.prize51_2 = obj.prize51_2;
         }
         if(!obj.hasOwnProperty("unionTask"))
         {
            this.unionTask = "";
         }
         else
         {
            this.unionTask = obj.unionTask;
         }
         if(!obj.hasOwnProperty("unionTaskGeted"))
         {
            this.unionTaskGeted = "";
         }
         else
         {
            this.unionTaskGeted = obj.unionTaskGeted;
         }
         if(!obj.hasOwnProperty("unionFightPrize"))
         {
            this.unionFightPrize = "";
         }
         else
         {
            this.unionFightPrize = obj.unionFightPrize;
         }
      }
      
      public function newDayCtrl() : *
      {
         this.oneYuanB = false;
      }
      
      public function getUnlock(index0:int) : int
      {
         return this.unlock_arr[index0];
      }
      
      public function setUnlock(index0:int) : *
      {
         this.unlock_arr[index0] = 1;
      }
      
      public function getLevelUnlock(index0:int) : int
      {
         return this.levelunlock_arr[index0];
      }
      
      public function AddTurntable() : void
      {
         var lastCount:int = Number(this.turntableflag.split("_")[1]);
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.turntableflag = ndate + getTimer() + "_" + ++lastCount;
      }
      
      public function GetTurntableCount() : int
      {
         var lastDataNum:Number = Number(this.turntableflag.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            return int(this.turntableflag.split("_")[1]);
         }
         this.turntableflag = nowData.getTime() + "_0";
         return 0;
      }
      
      public function AddSnowYuanshi() : void
      {
         var lastCount:int = Number(this.snowyuanshiflag.split("_")[1]);
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.snowyuanshiflag = ndate + getTimer() + "_" + ++lastCount;
      }
      
      public function GetSnowYuanshiCount() : int
      {
         var lastDataNum:Number = Number(this.snowyuanshiflag.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            return int(this.snowyuanshiflag.split("_")[1]);
         }
         this.snowyuanshiflag = nowData.getTime() + "_0";
         return 0;
      }
      
      public function AddUnionContriG() : void
      {
         var lastCount:int = Number(this.unioncontriG.split("_")[1]);
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unioncontriG = ndate + getTimer() + "_" + ++lastCount;
      }
      
      public function GetUnionContriG() : int
      {
         var lastDataNum:Number = Number(this.unioncontriG.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            return int(this.unioncontriG.split("_")[1]);
         }
         this.unioncontriG = nowData.getTime() + "_0";
         return 0;
      }
      
      public function AddUnionContriM() : void
      {
         var lastCount:int = Number(this.unioncontriM.split("_")[1]);
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unioncontriM = ndate + getTimer() + "_" + ++lastCount;
      }
      
      public function GetUnionContriM() : int
      {
         var lastDataNum:Number = Number(this.unioncontriM.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            return int(this.unioncontriM.split("_")[1]);
         }
         this.unioncontriM = nowData.getTime() + "_0";
         return 0;
      }
      
      public function AddUnionCityFightId(id:int) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var count:int = 0;
         var idstr:String = this.unionCityFighted.split("_")[1];
         var idArr:Array = idstr.split("|");
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            count = int(ids.split(":")[1]);
            if(idd == id)
            {
               count += 1;
               has = true;
               idArr[i] = idd + ":" + count;
            }
            i++;
         }
         if(has == false)
         {
            idArr.push(id + ":1");
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unionCityFighted = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetUnionCityFightID(id:int) : int
      {
         var idstr:String = null;
         var idArr:Array = null;
         var i:int = 0;
         var ids:String = null;
         var idd:int = 0;
         var lastDataNum:Number = Number(this.unionCityFighted.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            idstr = this.unionCityFighted.split("_")[1];
            idArr = idstr.split("|");
            i = 0;
            while(i < idArr.length)
            {
               ids = idArr[i];
               idd = int(ids.split(":")[0]);
               if(idd == id)
               {
                  return int(ids.split(":")[1]);
               }
               i++;
            }
            return 0;
         }
         this.unionCityFighted = nowData.getTime() + "_" + id + ":0";
         return 0;
      }
      
      public function AddUnionContriGift() : void
      {
         var lastCount:int = Number(this.unioncontriGift.split("_")[1]);
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unioncontriGift = ndate + getTimer() + "_" + ++lastCount;
      }
      
      public function GetUnionContriGift() : int
      {
         var lastDataNum:Number = Number(this.unioncontriGift.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            return int(this.unioncontriGift.split("_")[1]);
         }
         this.unioncontriGift = nowData.getTime() + "_0";
         return 0;
      }
      
      public function AddStarShopedByID(id:int) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var count:int = 0;
         var idstr:String = this.starShoped.split("_")[1];
         var idArr:Array = [];
         if(Boolean(idstr))
         {
            idArr = idstr.split("|");
         }
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            count = int(ids.split(":")[1]);
            if(idd == id)
            {
               count += 1;
               has = true;
               idArr[i] = idd + ":" + count;
            }
            i++;
         }
         if(has == false)
         {
            idArr.push(id + ":1");
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.starShoped = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetStarAdd() : AdditionalData
      {
         var ids:String = null;
         var idd:int = 0;
         var sd:StarGiftData = null;
         var j:int = 0;
         var adddstr:String = null;
         var adddname:String = null;
         var adddnum:Number = Number(NaN);
         var add:AdditionalData = new AdditionalData();
         var idstr:String = this.starShoped.split("_")[1];
         var idArr:Array = [];
         if(Boolean(idstr))
         {
            idArr = idstr.split("|");
         }
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            sd = Game.startGiftDefineGroup.GetOneGift(idd);
            j = 0;
            while(j < sd.AddArr.length)
            {
               adddstr = sd.AddArr[j];
               adddname = adddstr.split(",")[0];
               adddnum = Number(adddstr.split(",")[1]);
               add[adddname] += adddnum;
               j++;
            }
            i++;
         }
         return add;
      }
      
      public function GetStarShopedByID(id:int) : int
      {
         var ids:String = null;
         var idd:int = 0;
         var idstr:String = this.starShoped.split("_")[1];
         var idArr:Array = [];
         if(Boolean(idstr))
         {
            idArr = idstr.split("|");
         }
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            if(idd == id)
            {
               return int(ids.split(":")[1]);
            }
            i++;
         }
         return 0;
      }
      
      public function AddGrowShopedByID(id:int) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var count:int = 0;
         var idstr:String = this.growShoped.split("_")[1];
         var idArr:Array = [];
         if(Boolean(idstr))
         {
            idArr = idstr.split("|");
         }
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            count = int(ids.split(":")[1]);
            if(idd == id)
            {
               count += 1;
               has = true;
               idArr[i] = idd + ":" + count;
            }
            i++;
         }
         if(has == false)
         {
            idArr.push(id + ":1");
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.growShoped = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetGrowAdd() : AdditionalData
      {
         var ids:String = null;
         var idd:int = 0;
         var sd:StarGiftData = null;
         var j:int = 0;
         var adddstr:String = null;
         var adddname:String = null;
         var adddnum:Number = Number(NaN);
         var add:AdditionalData = new AdditionalData();
         var idstr:String = this.growShoped.split("_")[1];
         var idArr:Array = [];
         if(Boolean(idstr))
         {
            idArr = idstr.split("|");
         }
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            sd = Game.growGiftDefineGroup.GetOneGift(idd);
            j = 0;
            while(j < sd.AddArr.length)
            {
               adddstr = sd.AddArr[j];
               adddname = adddstr.split(",")[0];
               adddnum = Number(adddstr.split(",")[1]);
               add[adddname] += adddnum;
               j++;
            }
            i++;
         }
         return add;
      }
      
      public function GetGrowShopedByID(id:int) : int
      {
         var ids:String = null;
         var idd:int = 0;
         var idstr:String = this.growShoped.split("_")[1];
         var idArr:Array = [];
         if(Boolean(idstr))
         {
            idArr = idstr.split("|");
         }
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            if(idd == id)
            {
               return int(ids.split(":")[1]);
            }
            i++;
         }
         return 0;
      }
      
      public function AddUnionShopedByID(id:int) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var count:int = 0;
         var idstr:String = this.unionShoped.split("_")[1];
         var idArr:Array = idstr.split("|");
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            count = int(ids.split(":")[1]);
            if(idd == id)
            {
               count += 1;
               has = true;
               idArr[i] = idd + ":" + count;
            }
            i++;
         }
         if(has == false)
         {
            idArr.push(id + ":1");
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unionShoped = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetUnionShopedByID(id:int) : int
      {
         var idstr:String = null;
         var idArr:Array = null;
         var i:int = 0;
         var ids:String = null;
         var idd:int = 0;
         var lastDataNum:Number = Number(this.unionShoped.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            idstr = this.unionShoped.split("_")[1];
            idArr = idstr.split("|");
            i = 0;
            while(i < idArr.length)
            {
               ids = idArr[i];
               idd = int(ids.split(":")[0]);
               if(idd == id)
               {
                  return int(ids.split(":")[1]);
               }
               i++;
            }
            return 0;
         }
         this.unionShoped = nowData.getTime() + "_" + id + ":0";
         return 0;
      }
      
      public function AddPrize51ByID(id:int) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var count:int = 0;
         var idstr:String = this.prize51.split("_")[1];
         var idArr:Array = idstr.split("|");
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            count = int(ids.split(":")[1]);
            if(idd == id)
            {
               count += 1;
               has = true;
               idArr[i] = idd + ":" + count;
            }
            i++;
         }
         if(has == false)
         {
            idArr.push(id + ":1");
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.prize51 = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetPrize51ByID(id:int) : int
      {
         var idstr:String = null;
         var idArr:Array = null;
         var i:int = 0;
         var ids:String = null;
         var idd:int = 0;
         var lastDataNum:Number = Number(this.prize51.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            idstr = this.prize51.split("_")[1];
            idArr = idstr.split("|");
            i = 0;
            while(i < idArr.length)
            {
               ids = idArr[i];
               idd = int(ids.split(":")[0]);
               if(idd == id)
               {
                  return int(ids.split(":")[1]);
               }
               i++;
            }
            return 0;
         }
         this.prize51 = nowData.getTime() + "_" + id + ":0";
         return 0;
      }
      
      public function AddPrize51_2ByID(id:int) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var count:int = 0;
         var idstr:String = this.prize51_2;
         var idArr:Array = idstr.split("|");
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            count = int(ids.split(":")[1]);
            if(idd == id)
            {
               count += 1;
               has = true;
               idArr[i] = idd + ":" + count;
            }
            i++;
         }
         if(has == false)
         {
            idArr.push(id + ":1");
         }
         this.prize51_2 = idArr.join("|");
      }
      
      public function GetPrize51_2ByID(id:int) : int
      {
         var ids:String = null;
         var idd:int = 0;
         var idstr:String = this.prize51_2;
         var idArr:Array = idstr.split("|");
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            if(idd == id)
            {
               return int(ids.split(":")[1]);
            }
            i++;
         }
         return 0;
      }
      
      public function AddUnionBuildByID(id:int, isnormal:Boolean) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var normalcount:int = 0;
         var extracount:int = 0;
         var idstr:String = this.unionBuild.split("_")[1];
         var idArr:Array = idstr.split("|");
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            normalcount = int(ids.split(":")[1]);
            extracount = int(ids.split(":")[2]);
            if(idd == id)
            {
               if(isnormal)
               {
                  normalcount += 1;
               }
               else
               {
                  extracount += 1;
               }
               has = true;
               idArr[i] = idd + ":" + normalcount + ":" + extracount;
            }
            i++;
         }
         if(has == false)
         {
            if(isnormal)
            {
               idArr.push(id + ":1:0");
            }
            else
            {
               idArr.push(id + ":0:1");
            }
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unionBuild = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetUnionBuildByID(id:int, isnormal:Boolean) : int
      {
         var idstr:String = null;
         var idArr:Array = null;
         var i:int = 0;
         var ids:String = null;
         var idd:int = 0;
         var lastDataNum:Number = Number(this.unionBuild.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            idstr = this.unionBuild.split("_")[1];
            idArr = idstr.split("|");
            i = 0;
            while(i < idArr.length)
            {
               ids = idArr[i];
               idd = int(ids.split(":")[0]);
               if(idd == id)
               {
                  if(isnormal)
                  {
                     return int(ids.split(":")[1]);
                  }
                  return int(ids.split(":")[2]);
               }
               i++;
            }
            return 0;
         }
         this.unionBuild = nowData.getTime() + "_" + id + ":0:0";
         return 0;
      }
      
      public function AddTechBuildByID(id:int, isnormal:Boolean) : void
      {
         var ids:String = null;
         var idd:int = 0;
         var normalcount:int = 0;
         var extracount:int = 0;
         var idstr:String = this.TechBuild.split("_")[1];
         var idArr:Array = idstr.split("|");
         var has:Boolean = false;
         var i:int = 0;
         while(i < idArr.length)
         {
            ids = idArr[i];
            idd = int(ids.split(":")[0]);
            normalcount = int(ids.split(":")[1]);
            extracount = int(ids.split(":")[2]);
            if(idd == id)
            {
               if(isnormal)
               {
                  normalcount += 1;
               }
               else
               {
                  extracount += 1;
               }
               has = true;
               idArr[i] = idd + ":" + normalcount + ":" + extracount;
            }
            i++;
         }
         if(has == false)
         {
            if(isnormal)
            {
               idArr.push(id + ":1:0");
            }
            else
            {
               idArr.push(id + ":0:1");
            }
         }
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.TechBuild = ndate + getTimer() + "_" + idArr.join("|");
      }
      
      public function GetTechBuildByID(id:int, isnormal:Boolean) : int
      {
         var idstr:String = null;
         var idArr:Array = null;
         var i:int = 0;
         var ids:String = null;
         var idd:int = 0;
         var lastDataNum:Number = Number(this.TechBuild.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            idstr = this.TechBuild.split("_")[1];
            idArr = idstr.split("|");
            i = 0;
            while(i < idArr.length)
            {
               ids = idArr[i];
               idd = int(ids.split(":")[0]);
               if(idd == id)
               {
                  if(isnormal)
                  {
                     return int(ids.split(":")[1]);
                  }
                  return int(ids.split(":")[2]);
               }
               i++;
            }
            return 0;
         }
         this.TechBuild = nowData.getTime() + "_" + id + ":0:0";
         return 0;
      }
      
      public function SetUnionTaskState(id:int, state:int) : void
      {
         var oneUnion:String = null;
         var oneUnionArr:Array = null;
         var lastDataNum:Number = Number(this.unionTask.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         var has:Boolean = false;
         var unionstr:String = this.unionTask.split("_")[1];
         var unionArr:Array = unionstr.split("|");
         var i:int = 0;
         while(i < unionArr.length)
         {
            oneUnion = unionArr[i];
            oneUnionArr = oneUnion.split(":");
            if(int(oneUnionArr[0]) == id)
            {
               has = true;
               oneUnionArr[2] = state;
               unionArr[i] = oneUnionArr.join(":");
            }
            i++;
         }
         if(has == false)
         {
            unionArr.push(id + ":0:" + state);
         }
         this.unionTask = nowData.getTime() + "_" + unionArr.join("|");
      }
      
      public function AddUnionTaskGoal(id:int, num:int = 1) : void
      {
         var oneUnion:String = null;
         var oneUnionArr:Array = null;
         var lastDataNum:Number = Number(this.unionTask.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         var has:Boolean = false;
         var unionstr:String = this.unionTask.split("_")[1];
         var unionArr:Array = unionstr.split("|");
         var i:int = 0;
         while(i < unionArr.length)
         {
            oneUnion = unionArr[i];
            oneUnionArr = oneUnion.split(":");
            if(int(oneUnionArr[0]) == id)
            {
               has = true;
               oneUnionArr[1] = int(oneUnionArr[1]) + num;
               unionArr[i] = oneUnionArr.join(":");
            }
            i++;
         }
         if(has == false)
         {
            unionArr.push(id + ":" + num + ":1");
         }
         this.unionTask = nowData.getTime() + "_" + unionArr.join("|");
      }
      
      public function GetUnionTaskByID(id:int) : String
      {
         var unionstr:String = null;
         var unionArr:Array = null;
         var i:int = 0;
         var oneUnion:String = null;
         var oneUnionArr:Array = null;
         var lastDataNum:Number = Number(this.unionTask.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return "";
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            unionstr = this.unionTask.split("_")[1];
            unionArr = unionstr.split("|");
            i = 0;
            while(i < unionArr.length)
            {
               oneUnion = unionArr[i];
               oneUnionArr = oneUnion.split(":");
               if(int(oneUnionArr[0]) == id)
               {
                  return oneUnion;
               }
               i++;
            }
            return "";
         }
         this.unionTask = nowData.getTime() + "_1:0:0|2:0:0|3:0:0|4:0:0|5:0:0|6:0:0|7:0:0|8:0:0|9:0:0|10:0:0";
         return "";
      }
      
      public function getNowUnionTaskID() : int
      {
         var unionstr:String = null;
         var unionArr:Array = null;
         var i:int = 0;
         var oneUnion:String = null;
         var oneUnionArr:Array = null;
         var lastDataNum:Number = Number(this.unionTask.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return -1;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            unionstr = this.unionTask.split("_")[1];
            unionArr = unionstr.split("|");
            i = 0;
            while(i < unionArr.length)
            {
               oneUnion = unionArr[i];
               oneUnionArr = oneUnion.split(":");
               if(oneUnionArr[2] == 1 || oneUnionArr[2] == 0)
               {
                  return oneUnionArr[0];
               }
               i++;
            }
            if(unionArr.length > 0)
            {
               return -1;
            }
            return 1;
         }
         this.unionTask = nowData.getTime() + "_1:0:0|2:0:0|3:0:0|4:0:0|5:0:0|6:0:0|7:0:0|8:0:0|9:0:0|10:0:0";
         return 1;
      }
      
      public function AddUnionFightPrize(str:String) : void
      {
         this.unionFightPrize += str + "|";
      }
      
      public function GetUnionFightGeted(str:String) : Boolean
      {
         if(this.unionFightPrize.indexOf(str) >= 0)
         {
            return true;
         }
         return false;
      }
      
      public function AddUnionTaskGeted() : void
      {
         var lastCount:int = Number(this.unionTaskGeted.split("_")[1]);
         var ndate:Number = Game.timeDate.getSaveDate.getDateClass().getTime();
         this.unionTaskGeted = ndate + getTimer() + "_" + ++lastCount;
      }
      
      public function GetUnionTaskGeted() : int
      {
         var lastDataNum:Number = Number(this.unionTaskGeted.split("_")[0]);
         var lastDate:Date = new Date(lastDataNum);
         var nowDataNum:Number = Game.timeDate.getSaveDate.getDateClass().getTime() + getTimer();
         var nowData:Date = new Date(nowDataNum);
         if(this.checkIsCheat(lastDataNum,nowDataNum))
         {
            return 999;
         }
         if(nowData.month == lastDate.month && nowData.date == lastDate.date)
         {
            return int(this.unionTaskGeted.split("_")[1]);
         }
         this.unionTaskGeted = nowData.getTime() + "_0";
         return 0;
      }
      
      public function setLevelUnlock(index0:int) : *
      {
         this.levelunlock_arr[index0] = 1;
      }
      
      public function getOneUnlock(index0:int) : int
      {
         return this.onePayArr[index0];
      }
      
      public function setOneUnlock(index0:int) : *
      {
         this.onePayArr[index0] = 1;
      }
      
      public function getGiftOneUnlock(index0:int) : *
      {
         var num0:int = int(this.onePayArr[index0]);
         if(--num0 < 0)
         {
            num0 = 0;
         }
         this.onePayArr[index0] = num0;
      }
      
      public function inData_onePay(num0:int) : String
      {
         var n:* = undefined;
         var arr0:Array = Game.gameDefine.gift.onePay_arr;
         var index0:int = -1;
         var money0:int = 0;
         for(n in arr0)
         {
            if(num0 < arr0[n])
            {
               index0 = n - 1;
               break;
            }
            index0 = n;
         }
         if(index0 >= 0)
         {
            money0 = int(arr0[index0]);
            ++this.onePayArr[index0];
            this.nowGetIndex = index0;
            return "您获得了1个" + money0 + "M币的一次充值礼包。\n请到“充值活动”中领取。";
         }
         this.nowGetIndex = -1;
         return "";
      }
      
      public function checkIsCheat(n1:Number, n2:Number) : Boolean
      {
         if(n2 < n1)
         {
            return true;
         }
         var ndate:Date = new Date();
         if(this._initTimeZone == ndate.timezoneOffset)
         {
            return false;
         }
         return true;
      }
      
      public function get killAirshipNum() : int
      {
         return int(TextWay.getText(this._killAirshipNum));
      }
      
      public function set killAirshipNum(v0:int) : *
      {
         this._killAirshipNum = TextWay.toCode(String(v0));
      }
      
      public function get temp_killAirshipNum() : int
      {
         return int(TextWay.getText(this._temp_killAirshipNum));
      }
      
      public function set temp_killAirshipNum(v0:int) : *
      {
         this._temp_killAirshipNum = TextWay.toCode(String(v0));
      }
   }
}

