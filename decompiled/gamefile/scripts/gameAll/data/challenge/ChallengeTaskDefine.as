package gameAll.data.challenge
{
   import data.TextWay;
   
   public class ChallengeTaskDefine
   {
      
      public static var diffStr:Array = ["普通难度","噩梦难度","地狱难度","炼狱难度"];
      
      public static var pageStr:Array = ["自由之心","月球危机"];
      
      public static var pageName:Array = ["p1","p2"];
      
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
      
      public function inData_byStr(str0:String) : *
      {
         var arr1:Array = TextWay.delChat(str0).split(",");
         trace(arr1);
         this.enemyName = String(arr1[0]);
         this.targetDiff = int(arr1[1]);
         this.targetLevel = int(arr1[2]);
         this.time = int(arr1[3]);
         this.noDieB = Boolean(int(arr1[4]));
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["index","enemyName","time","noDieB","targetDiff","targetLevel"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.giftArr.length = 0;
         for(m in obj.giftArr)
         {
            this.giftArr[m] = obj.giftArr[m];
         }
      }
      
      public function get targetLevel() : int
      {
         return int(TextWay.getText(this._targetLevel));
      }
      
      public function set targetLevel(v0:int) : *
      {
         this._targetLevel = TextWay.toCode(String(v0));
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
            return "无";
         }
         return "";
      }
      
      public function getGiftArr() : Array
      {
         var n:* = undefined;
         var arr0:Array = [];
         for(n in this.giftArr)
         {
            arr0.push(TextWay.getText(this.giftArr[n]));
         }
         return arr0;
      }
      
      public function getTitle() : String
      {
         return "挑战：" + this.enemyName;
      }
      
      public function getTime() : String
      {
         if(this.time < 120)
         {
            return this.time + "秒";
         }
         return int(this.time / 60) + "分钟";
      }
      
      public function getNewDefine() : ChallengeTaskDefine
      {
         var d0:ChallengeTaskDefine = new ChallengeTaskDefine();
         var arr0:Array = Game.gameData.changeToNewLevel(this.targetDiff,this.targetLevel);
         d0.targetDiff = arr0[2];
         d0.targetLevel = arr0[1];
         return d0;
      }
   }
}

