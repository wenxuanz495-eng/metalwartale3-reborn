package gameAll.data
{
   import data.TextWay;
   
   public class TrainAddData
   {
      
      public var skillName:String = "jump";
      
      public var cnName:String = "";
      
      public var type:String = "normal";
      
      public var _value:Number = 0;
      
      public var _level:String = "0";
      
      public var maxLevel:int = 10000000;
      
      public var mustLevel:int = 2;
      
      private var _GCoin:Number = 100;
      
      private var _MCoin:int = 100;
      
      private var _items:Array = [];
      
      public var upgradeB:Boolean = false;
      
      public var d_value:int = 0;
      
      public var baseItems:String = "";
      
      public function TrainAddData()
      {
         super();
      }
      
      public function inData_byObj(obj:*) : *
      {
         this._value = obj._value;
         this.level = obj.level;
         this.fleshMustLevel();
      }
      
      public function init() : *
      {
         this.level = 0;
         this._value = 0;
         this.fleshMustLevel();
      }
      
      public function getPer() : Number
      {
         if(this.value > 1)
         {
            return int(this.value * 100);
         }
         return int(this.value * 1000) / 10;
      }
      
      public function getNextPer() : Number
      {
         if(this.value > 1)
         {
            return int((this.value + 0.02) * 100);
         }
         return int((this.value + 0.02) * 1000) / 10;
      }
      
      public function fleshMustLevel() : *
      {
         if(this.upgradeB)
         {
            this.mustLevel = Game.gameDefine.getTrainLevelNum(this.level,this.type);
         }
         else
         {
            this.mustLevel = Game.gameDefine.getSkillLevelNum(this.level,this.skillName);
            this.mustLevel += this.d_value;
         }
         if(this.mustLevel < 1)
         {
            this.mustLevel = 1;
         }
      }
      
      public function levelUp(num0:int = 1) : *
      {
         this.level += num0;
         if(this.type == "all")
         {
            this._value += 37 * 2 * num0;
         }
         else
         {
            this._value += 37 * 2 * num0;
         }
         this.fleshMustLevel();
      }
      
      public function get value() : Number
      {
         return this._value / 37 / 100;
      }
      
      public function get GCoin() : int
      {
         if(this.upgradeB)
         {
            return Game.gameDefine.getTrainCoinNum(this.level);
         }
         return Game.gameDefine.getSkillCoinNum(this.level,this.skillName);
      }
      
      public function get MCoin() : int
      {
         if(this.upgradeB)
         {
            return Game.gameDefine.getTrainCoinNum_M(this.level,this.type);
         }
         return 0;
      }
      
      public function set GCoin(num0:int) : *
      {
         this._GCoin = num0;
      }
      
      public function get items() : Array
      {
         var num0:int = 0;
         if(this.upgradeB)
         {
            num0 = Game.gameDefine.getTrainItemsNum(this.level);
            if(num0 == 0)
            {
               return [];
            }
            return [this.baseItems + "_num" + num0];
         }
         return this._items;
      }
      
      public function set items(arr0:Array) : *
      {
         this._items = arr0;
      }
      
      public function getTrainB() : int
      {
         if(this.level >= Game.gameData.level)
         {
            return 1;
         }
         return 0;
      }
      
      public function get level() : int
      {
         return int(TextWay.getText(this._level));
      }
      
      public function set level(v0:int) : *
      {
         this._level = TextWay.toCode(String(v0));
      }
      
      public function setLevel(lv0:int) : *
      {
         this.level = lv0;
         this._value = 37 * 2 * this.level;
         this.fleshMustLevel();
      }
      
      public function isZuobi() : Boolean
      {
         return false;
      }
   }
}

