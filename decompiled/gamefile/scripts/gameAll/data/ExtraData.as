package gameAll.data
{
   import data.StringToDefine;
   import data.TextWay;
   import gameAll.NormalMustDefine;
   
   public class ExtraData
   {
      
      public static var maxLevel:int = 45;
      
      public var diffUnlock:Array = [1,0,0,0];
      
      public var score_arr:Array = [];
      
      public var nowDiff:int = 0;
      
      public var allState:Array = [];
      
      public var buyNum:int = 0;
      
      private var _juneB:String = "";
      
      private var _maxJuneNum:String = TextWay.toCode("5");
      
      public var saveDataVersion:Number = 1.38;
      
      public function ExtraData()
      {
         super();
         this.init();
         this.initState();
         this.juneB = this.maxJuneNum;
      }
      
      public function getEnabledNum() : int
      {
         var m:* = undefined;
         var in0:int = 0;
         var num0:int = 0;
         for(m in this.allState[0])
         {
            in0 = int(this.allState[0][m]);
            if(in0 == 1 && m + 1 <= maxLevel)
            {
               num0++;
            }
         }
         return num0;
      }
      
      public function init() : *
      {
         this.nowDiff = 0;
         for(var i:int = 0; i < 4; i++)
         {
            this.allState[i] = new Array(100);
         }
         this.diffUnlock = [1,0,0,0];
         this.initScore();
      }
      
      public function initScore() : *
      {
         this.score_arr = [];
         for(var i:int = 0; i < maxLevel; i++)
         {
            this.score_arr.push(TextWay.toCode("0"));
         }
      }
      
      public function initState() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         for(n in this.allState)
         {
            for(m in this.allState[n])
            {
               this.allState[n][m] = 0;
            }
         }
      }
      
      public function setScore(index0:int, score0:int) : *
      {
         this.score_arr[index0] = TextWay.toCode(String(score0));
      }
      
      public function getScore(index0:int) : int
      {
         return int(TextWay.getText(this.score_arr[index0]));
      }
      
      public function getAllScore() : int
      {
         var n:* = undefined;
         var score0:int = 0;
         for(n in this.score_arr)
         {
            score0 += this.getScore(n);
         }
         return score0;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var i:* = undefined;
         var pro_arr:Array = ["diffUnlock","nowDiff","buyNum"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         if(!obj.hasOwnProperty("score_arr"))
         {
            this.initScore();
         }
         else
         {
            this.initScore();
            for(i in obj.score_arr)
            {
               this.score_arr[i] = obj.score_arr[i];
            }
         }
         if(!obj.hasOwnProperty("saveDataVersion"))
         {
            this.initState();
            this.initScore();
            this.saveDataVersion = 1.2;
         }
         else if(this.saveDataVersion > obj.saveDataVersion)
         {
            this.initState();
            this.initScore();
         }
         else
         {
            this.allState = StringToDefine.copyArray(obj.allState);
         }
         if(!obj.hasOwnProperty("juneB"))
         {
            this.juneB = this.maxJuneNum;
         }
         else
         {
            this.juneB = obj.juneB;
         }
      }
      
      public function newDayCtrl() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         for(n in this.allState)
         {
            for(m in this.allState[n])
            {
               this.allState[n][m] = 0;
            }
         }
         this.fleshUnlock();
         this.buyNum = 0;
         this.juneB = this.maxJuneNum;
      }
      
      public function fleshUnlock() : *
      {
         var sta0:int = 0;
         var mustLevel0:int = 0;
         var lv0:int = Game.gameData.level;
         for(var i:int = 0; i < maxLevel; i++)
         {
            sta0 = int(this.allState[this.nowDiff][i]);
            mustLevel0 = this.getMustLevel(this.nowDiff,i);
            if(lv0 < mustLevel0)
            {
               sta0 = 0;
            }
            else if(sta0 == 0)
            {
               sta0 = 1;
            }
            this.allState[this.nowDiff][i] = sta0;
         }
      }
      
      public function getNowExtraState() : int
      {
         var level0:int = Game.gameData.nowGameLevel;
         return this.allState[this.nowDiff][level0];
      }
      
      public function setNowExtraState(num0:int) : *
      {
         var level0:int = Game.gameData.nowGameLevel;
         this.allState[this.nowDiff][level0] = num0;
      }
      
      public function getMustLevel(diff0:int, level0:int) : int
      {
         return Game.gameDefine.extra.getMustLevel(diff0,level0);
      }
      
      public function getEnemyLevel() : int
      {
         var level0:int = Game.gameData.nowGameLevel;
         return this.getMustLevel(this.nowDiff,level0);
      }
      
      public function getGiftArr() : Array
      {
         var level0:int = Game.gameData.nowGameLevel;
         return Game.gameDefine.extra.getGift(this.nowDiff,level0);
      }
      
      public function getRestart_M() : NormalMustDefine
      {
         var nmd0:NormalMustDefine = new NormalMustDefine();
         nmd0.MCoin = 0;
         return nmd0;
      }
      
      public function get juneB() : int
      {
         return Number(TextWay.getText(this._juneB));
      }
      
      public function get maxJuneNum() : int
      {
         return int(TextWay.getText(this._maxJuneNum));
      }
      
      public function set juneB(v0:int) : *
      {
         this._juneB = TextWay.toCode(String(v0));
      }
   }
}

