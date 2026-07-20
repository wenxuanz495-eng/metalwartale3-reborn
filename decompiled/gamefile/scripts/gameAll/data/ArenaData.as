package gameAll.data
{
   import data.TextWay;
   import gameAll.high.HighArena_All;
   
   public class ArenaData
   {
      
      public static var VERSION:Number = 4.7;
      
      public var saveDataVersion:Number = 1.18;
      
      public var _streakNum:String = "";
      
      public var _nickname:String = "";
      
      public var _score:String = "";
      
      public var _useNum:String = "";
      
      public var _maxNum:String = "";
      
      public var _buyNum:String = "";
      
      public var arival:HighArena_All = null;
      
      public var prevScore:Number = 0;
      
      public var nowRank:int = 0;
      
      public var autoFightingB:Boolean = false;
      
      public var beforeScore:int = 0;
      
      public function ArenaData()
      {
         super();
         this.maxNum = 15;
         this.nickname = "无";
         this.arival = null;
         this.nowRank = 0;
         this.autoFightingB = false;
      }
      
      public function init() : *
      {
         this.streakNum = 0;
         this.nickname = "无";
         this.score = 0;
         this.useNum = this.maxNum;
         this.buyNum = 0;
         this.arival = null;
         this.nowRank = 0;
         this.autoFightingB = false;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["streakNum","nickname","score","useNum","buyNum"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            if(obj[pro0] != null)
            {
               this[pro0] = obj[pro0];
            }
         }
         if(obj.hasOwnProperty("saveDataVersion"))
         {
            this.saveDataVersion = obj.saveDataVersion;
         }
         else
         {
            this.saveDataVersion = 1.18;
         }
         if(this.saveDataVersion < VERSION)
         {
            this.streakNum = 0;
            this.score = 0;
            this.saveDataVersion = VERSION;
         }
         if(obj.hasOwnProperty("beforeScore"))
         {
            this.beforeScore = obj.beforeScore;
         }
         else
         {
            this.beforeScore = 0;
         }
         this.nowRank = 0;
         this.autoFightingB = false;
      }
      
      public function newDayCtrl() : *
      {
         trace("newDayCtrl() 使用次数：" + this.maxNum);
         this.useNum = this.maxNum;
         this.buyNum = 0;
      }
      
      public function addScore(state0:String) : Number
      {
         var num0:Number = Game.gameDefine.high.countScore(state0,Game.gameData.getAllDps(),this.arival.extra.dps,this.nowRank,this.arival.rank,Game.gameData.maxLife,this.arival.extra.life);
         trace("获得竞技场积分：" + num0);
         this.score += num0;
         this.prevScore = num0;
         var achieve0:int = int(TextWay.getText("0005300048"));
         if(state0 == "win")
         {
            achieve0 = int(TextWay.getText("000490004800048"));
         }
         if(achieve0 < 500)
         {
            Game.gameData.addAchieve(achieve0);
         }
         return num0;
      }
      
      public function addStreakNum(num0:int) : *
      {
         if(num0 == 0)
         {
            this.streakNum = 0;
         }
         else
         {
            this.streakNum += num0;
         }
      }
      
      public function addUseNum() : *
      {
         this.useNum += 3;
         this.buyNum += 1;
      }
      
      public function reduceUseNum() : *
      {
         --this.useNum;
      }
      
      public function get score() : Number
      {
         return Number(TextWay.getText(this._score));
      }
      
      public function set score(v0:Number) : *
      {
         this._score = TextWay.toCode(String(v0));
      }
      
      public function get streakNum() : Number
      {
         return Number(TextWay.getText(this._streakNum));
      }
      
      public function set streakNum(v0:Number) : *
      {
         this._streakNum = TextWay.toCode(String(v0));
      }
      
      public function get buyNum() : Number
      {
         return Number(TextWay.getText(this._buyNum));
      }
      
      public function set buyNum(v0:Number) : *
      {
         this._buyNum = TextWay.toCode(String(v0));
      }
      
      public function get maxNum() : Number
      {
         return Number(TextWay.getText(this._maxNum));
      }
      
      public function set maxNum(v0:Number) : *
      {
         this._maxNum = TextWay.toCode(String(v0));
      }
      
      public function get useNum() : Number
      {
         return Number(TextWay.getText(this._useNum));
      }
      
      public function set useNum(v0:Number) : *
      {
         this._useNum = TextWay.toCode(String(v0));
      }
      
      public function get nickname() : String
      {
         return String(TextWay.getText(this._nickname));
      }
      
      public function set nickname(v0:String) : *
      {
         this._nickname = TextWay.toCode(String(v0));
      }
   }
}

