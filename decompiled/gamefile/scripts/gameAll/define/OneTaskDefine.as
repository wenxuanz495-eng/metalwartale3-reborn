package gameAll.define
{
   import data.TextWay;
   
   public class OneTaskDefine
   {
      
      public static var diffStr:Array = ["普通难度","噩梦难度","地狱难度","炼狱难度"];
      
      public static var pageStr:Array = ["自由之心","月球危机"];
      
      public static var pageName:Array = ["p1","p2"];
      
      private var _completeNum:String = "0";
      
      private var _starLevel:String = "0";
      
      public var state:String = "no";
      
      public var _taskLevel:String = "";
      
      public var index:int = 0;
      
      public var levelName:String = "";
      
      public var starNum:int = 0;
      
      public var targetDiff:int = 0;
      
      public var giftArr:Array = [];
      
      private var _maxNum:String = "0";
      
      private var _enemyName:String = "";
      
      private var _targetLevel:String = "0";
      
      public function OneTaskDefine()
      {
         super();
         this.init();
      }
      
      public function init() : *
      {
         this.taskLevel = 0;
         this.completeNum = 0;
         this.starLevel = 0;
         this.state = "no";
         this.starNum = 2;
         this.maxNum = 10;
         this.targetLevel = 0;
         this.giftArr = [];
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["completeNum","starLevel","state","taskLevel","levelName","index","starNum","targetDiff","maxNum","enemyName","targetLevel"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.starNum = 0;
         this.giftArr.length = 0;
         for(m in obj.giftArr)
         {
            this.giftArr[m] = obj.giftArr[m];
         }
      }
      
      public function copy() : OneTaskDefine
      {
         var td0:OneTaskDefine = new OneTaskDefine();
         td0.inData_byObj(this);
         return td0;
      }
      
      public function fleshAllGift() : *
      {
         var type0:String = "soldier";
         if(this.isSuperB())
         {
            type0 = "super";
         }
         var color0:String = this.getCrystalColor();
         this.giftArr = Game.gameDefine.getTaskGiftArr(this.taskLevel,this.starLevel,type0,color0);
      }
      
      public function getCrystalColor() : String
      {
         var n:* = undefined;
         var str0:String = null;
         var f0:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = this.giftArr;
         for(n in _loc5_)
         {
            str0 = this.giftArr[n];
            f0 = str0.indexOf("_crystal");
            return str0.substring(0,f0 - 1);
         }
         return "";
      }
      
      public function isSuperB() : Boolean
      {
         if(this.enemyName == "精英怪")
         {
            return true;
         }
         return false;
      }
      
      public function getDiffString() : String
      {
         return diffStr[this.targetDiff % 4];
      }
      
      public function getPageString() : String
      {
         if(this.taskLevel >= 80)
         {
            return pageStr[1];
         }
         return pageStr[int(this.targetDiff / 4)];
      }
      
      public function getPageName() : String
      {
         if(this.taskLevel >= 70)
         {
            return pageName[1];
         }
         return pageName[int(this.targetDiff / 4)];
      }
      
      public function getLevelString() : String
      {
         return this.levelName.replace(" ","");
      }
      
      public function addKillNum() : *
      {
         if(this.state == "ing")
         {
            ++this.completeNum;
            if(this.completeNum >= this.getAllNum())
            {
               this.completeNum = this.getAllNum();
               this.state = "complete";
               Game.uiGroup.saveDataNoUI();
            }
         }
      }
      
      public function getAllNum() : int
      {
         return this.maxNum;
      }
      
      public function get maxNum() : int
      {
         return int(TextWay.getText(this._maxNum));
      }
      
      public function set maxNum(v0:int) : *
      {
         this._maxNum = TextWay.toCode(String(v0));
      }
      
      public function get targetLevel() : int
      {
         return int(TextWay.getText(this._targetLevel));
      }
      
      public function set targetLevel(v0:int) : *
      {
         this._targetLevel = TextWay.toCode(String(v0));
      }
      
      public function get enemyName() : String
      {
         return TextWay.getText(this._enemyName);
      }
      
      public function set enemyName(str0:String) : *
      {
         this._enemyName = TextWay.toCode(str0);
      }
      
      public function get completeNum() : int
      {
         return int(TextWay.getText(this._completeNum));
      }
      
      public function set completeNum(v0:int) : *
      {
         this._completeNum = TextWay.toCode(String(v0));
      }
      
      public function get starLevel() : int
      {
         return int(TextWay.getText(this._starLevel));
      }
      
      public function set starLevel(v0:int) : *
      {
         this._starLevel = TextWay.toCode(String(v0));
      }
      
      public function get taskLevel() : int
      {
         return int(TextWay.getText(this._taskLevel));
      }
      
      public function set taskLevel(v0:int) : *
      {
         this._taskLevel = TextWay.toCode(String(v0));
      }
      
      public function toString() : String
      {
         var n:* = undefined;
         var pro0:String = null;
         var str0:String = "";
         var pro_arr:Array = ["index","targetDiff","targetLevel","enemyName","maxNum","starNum","giftArr"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            str0 += pro0 + ":" + this[pro0] + ",";
         }
         return str0;
      }
   }
}

