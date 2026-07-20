package gameAll.data
{
   import gameAll.define.SpecialExtraOneDefine;
   
   public class SpecialExtraData
   {
      
      public var arr:Array = [];
      
      public var readyAt:Array = [];
      
      public function SpecialExtraData()
      {
         super();
      }
      
      public function getEnabledNum() : int
      {
         var n:* = undefined;
         var data0:SpecialExtraOneDefine = null;
         var level0:int = 0;
         var num0:int = 0;
         for(n in this.arr)
         {
            data0 = this.arr[n];
            level0 = this.getMustLevel(n);
            if(level0 <= Game.gameData.level)
            {
               if(data0.nowNum > 0)
               {
                  num0++;
               }
            }
         }
         return num0;
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var d0:SpecialExtraOneDefine = null;
         var data0:SpecialExtraOneDefine = null;
         this.arr.length = 0;
         this.readyAt = [];
         var darr:Array = Game.gameDefine.specialExtra.arr;
         for(n in darr)
         {
            d0 = darr[n];
            data0 = new SpecialExtraOneDefine();
            data0.inData_byDefine(d0);
            this.arr.push(data0);
         }
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var darr:Array = null;
         var i:* = undefined;
         var pro0:String = null;
         var data0:SpecialExtraOneDefine = null;
         var d0:SpecialExtraOneDefine = null;
         var pro_arr:Array = [];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         darr = Game.gameDefine.specialExtra.arr;
         for(i in darr)
         {
            data0 = new SpecialExtraOneDefine();
            d0 = darr[i];
            data0.inData_byDefine(d0);
            if(obj.arr.length >= i + 1)
            {
               data0.nowNum = obj.arr[i].nowNum;
            }
            this.arr[i] = data0;
         }
         this.readyAt = obj.hasOwnProperty("readyAt") && obj.readyAt is Array ? obj.readyAt.concat() : [];
      }
      
      public function getNumArr() : Array
      {
         var n:* = undefined;
         var data0:SpecialExtraOneDefine = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            data0 = this.arr[n];
            arr0[n] = data0.nowNum;
         }
         return arr0;
      }
      
      public function getOneUseNum(index0:int) : int
      {
         var lock_arr:Array = this.getUnlockArr();
         var data0:SpecialExtraOneDefine = this.arr[index0];
         if(data0.nowNum > 0 && lock_arr[index0] == 1)
         {
            return 1;
         }
         return 0;
      }
      
      public function getUnlockArr() : Array
      {
         var n:* = undefined;
         var data0:SpecialExtraOneDefine = null;
         var level0:int = 0;
         var arr0:Array = [];
         for(n in this.arr)
         {
            data0 = this.arr[n];
            level0 = this.getMustLevel(n);
            if(level0 > Game.gameData.level)
            {
               arr0.push(0);
            }
            else
            {
               arr0.push(1);
            }
         }
         return arr0;
      }
      
      public function getNowData() : SpecialExtraOneDefine
      {
         var level0:int = Game.gameData.nowGameLevel;
         return this.arr[level0];
      }
      
      public function startCooldown() : *
      {
         this.readyAt[Game.gameData.nowGameLevel] = new Date().time + 900000;
      }
      
      public function getCooldownSeconds(index0:int) : int
      {
         var value0:Number = index0 < this.readyAt.length ? Number(this.readyAt[index0]) : 0;
         return Math.max(0,Math.ceil((value0 - new Date().time) / 1000));
      }
      
      public function useOneNowData(num0:int = 1) : *
      {
         var sd0:SpecialExtraOneDefine = this.getNowData();
         if(sd0 is SpecialExtraOneDefine)
         {
            sd0.nowNum -= num0;
            if(sd0.nowNum < 0)
            {
               sd0.nowNum = 0;
            }
         }
      }
      
      public function getNowNum() : int
      {
         var sd0:SpecialExtraOneDefine = this.getNowData();
         if(sd0 is SpecialExtraOneDefine)
         {
            return sd0.nowNum;
         }
         return 0;
      }
      
      public function newDayCtrl() : *
      {
         this.init();
      }
      
      public function getMustLevel(index0:int) : int
      {
         return Game.gameDefine.specialExtra.getMustLevel(index0);
      }
   }
}

