package gameAll.data.challenge
{
   import data.TextWay;
   
   public class ChallengeTaskDefine
   {
      
      public static var diffStr:Array = ["普通难度","噩梦难度","地狱难度","炼狱难度"];
      
      public static var pageStr:Array = ["南部战争","决战先知","幽灵行动"];
      
      public static var pageName:Array = ["","knowing","ghost"];
      
      public var index:int = 0;
      
      public var enemyName:String = "";
      
      public var state:String = "no";
      
      public var time:int = 0;
      
      public var noDieB:Boolean = false;
      
      public var targetDiff:int = 0;
      
      private var _targetLevel:String = "0";
      
      public var giftArr:Array = [];
      
      public function ChallengeTaskDefine()
      {
         super();
      }
      
      public function inData_byStr(param1:String) : *
      {
         var _loc2_:Array = TextWay.delChat(param1).split(",");
         trace(_loc2_);
         this.enemyName = String(_loc2_[0]);
         this.targetDiff = int(_loc2_[1]);
         this.targetLevel = int(_loc2_[2]);
         this.time = int(_loc2_[3]);
         this.noDieB = Boolean(int(_loc2_[4]));
      }
      
      public function inData_byObj(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc2_:Array = ["index","enemyName","time","noDieB","targetDiff","targetLevel"];
         for(_loc3_ in _loc2_)
         {
            _loc5_ = _loc2_[_loc3_];
            this[_loc5_] = param1[_loc5_];
         }
         this.giftArr.length = 0;
         for(_loc4_ in param1.giftArr)
         {
            this.giftArr[_loc4_] = param1.giftArr[_loc4_];
         }
      }
      
      public function get targetLevel() : int
      {
         return int(TextWay.getText(this._targetLevel));
      }
      
      public function set targetLevel(param1:int) : *
      {
         this._targetLevel = TextWay.toCode(String(param1));
      }
      
      public function getDiffString() : String
      {
         return diffStr[this.targetDiff % 4];
      }
      
      public function getPageString() : String
      {
         return pageStr[int(this.targetDiff / 4)];
      }
      
      public function getPageName() : String
      {
         return pageName[int(this.targetDiff / 4)];
      }
      
      public function getNowB() : Boolean
      {
         if(this.state == "no" || this.state == "over")
         {
            return false;
         }
         return true;
      }
      
      public function getRequest() : String
      {
         if(this.time > 0)
         {
            return this.getTime() + "内完成";
         }
         if(this.noDieB)
         {
            return "不允许死亡";
         }
         return "";
      }
      
      public function getGiftArr() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Array = [];
         for(_loc2_ in this.giftArr)
         {
            _loc1_.push(TextWay.getText(this.giftArr[_loc2_]));
         }
         return _loc1_;
      }
      
      public function getTitle() : String
      {
         return "击杀" + this.enemyName;
      }
      
      public function getTime() : String
      {
         if(this.time < 120)
         {
            return this.time + "秒";
         }
         return int(this.time / 60) + "分钟";
      }
   }
}

