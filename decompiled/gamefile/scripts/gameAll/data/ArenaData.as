package gameAll.data
{
   import data.TextWay;
   import gameAll.high.HighArena_All;
   import gameAll.high.HighArena_ExtraData;
   
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

      public var botReadyAt:Array = [];

      public static const LOCAL_BOT_COUNT:int = 15;

      public static const LOCAL_BOT_COOLDOWN:Number = 900000;
      
      public function ArenaData()
      {
         super();
         this.maxNum = 15;
         this.nickname = "无";
         this.arival = null;
         this.nowRank = 0;
         this.autoFightingB = false;
         this.initBotCooldowns();
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
         this.initBotCooldowns();
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
         this.loadBotCooldowns(obj);
      }

      private function initBotCooldowns() : *
      {
         this.botReadyAt = [];
         for(var i:int = 0; i < LOCAL_BOT_COUNT; i++)
         {
            this.botReadyAt.push(0);
         }
      }

      private function loadBotCooldowns(obj:Object) : *
      {
         var source:* = obj.hasOwnProperty("botReadyAt") ? obj.botReadyAt : null;
         this.initBotCooldowns();
         if(source == null)
         {
            return;
         }
         for(var i:int = 0; i < LOCAL_BOT_COUNT; i++)
         {
            if(source[i] != null)
            {
               this.botReadyAt[i] = Number(source[i]);
            }
         }
      }

      public function getLocalBotIndex(userName:String) : int
      {
         var prefix:String = "local_arena_bot_";
         if(userName == null || userName.indexOf(prefix) != 0)
         {
            return -1;
         }
         var index0:int = int(userName.substr(prefix.length));
         if(index0 < 0 || index0 >= LOCAL_BOT_COUNT)
         {
            return -1;
         }
         return index0;
      }

      public function getBotCooldown(userName:String) : Number
      {
         var index0:int = this.getLocalBotIndex(userName);
         if(index0 < 0)
         {
            return 0;
         }
         var remain:Number = Number(this.botReadyAt[index0]) - new Date().time;
         return remain > 0 ? remain : 0;
      }

      public function startCurrentBotCooldown() : *
      {
         if(!(this.arival is HighArena_All))
         {
            return;
         }
         var index0:int = this.getLocalBotIndex(this.arival.userName);
         if(index0 >= 0)
         {
            this.botReadyAt[index0] = new Date().time + LOCAL_BOT_COOLDOWN;
         }
      }

      public function getLocalOpponents() : Array
      {
         var names:Array = ["铁拳教官","荒原猎手","疾风游骑","重甲卫士","电弧先锋","赤焰追猎","寒霜守望","雷鸣战将","钢铁壁垒","幻影刀锋","熔火统领","深空巡猎","审判之矛","不朽堡垒","竞技场冠军"];
         // The arena portrait clip has no s15 frame. Using it lets the battle
         // start behind a loading overlay when the 15th local bot is selected.
         var heads:Array = ["s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11","s12","s13","s14","s14"];
         var base:HighArena_ExtraData = Game.gameData.getHighArena_ExtraData();
         var result:Array = [];
         if(base == null)
         {
            base = new HighArena_ExtraData();
         }
         var arms0:Array = base.arms != null && base.arms.length > 0 ? base.arms : ["soya_lv1"];
         var sub0:Array = base.sub != null && base.sub.length > 0 ? base.sub : ["highEnergy_lv2"];
         var car0:String = base.car != null && base.car != "" ? base.car : "beetle";
         for(var i:int = 0; i < LOCAL_BOT_COUNT; i++)
         {
            var d0:HighArena_All = new HighArena_All();
            var extra0:HighArena_ExtraData = new HighArena_ExtraData();
            var scale0:Number = 1 - i * 0.01;
            d0.rank = i + 1;
            d0.score = Math.max(1,Math.round(this.score + (7 - i) * 80));
            d0.userName = "local_arena_bot_" + i;
            extra0.name = names[i];
            extra0.lv = Math.max(1,Game.gameData.level + 1 + int((7 - i) / 3));
            extra0.head = heads[i];
            extra0.group = "本地竞技联盟";
            extra0.life = Math.max(200,Math.round(base.life * scale0));
            extra0.defence = Math.max(0,Math.round(base.defence * scale0));
            extra0.dps = Math.max(100,Math.round(base.dps * scale0));
            extra0.skill = base.skill != null ? base.skill.concat() : [11,12,10];
            extra0.arms = arms0.concat();
            extra0.sub = sub0.concat();
            extra0.car = car0;
            d0.extra = extra0;
            result.push(d0.getObj());
         }
         return result;
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

