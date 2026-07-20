package gameAll.data
{
   import data.TextWay;
   
   public class GroupData
   {
      
      public static var VERSION:Number = 1.39;
      
      public var name:String = "无";
      
      public var saveDataVersion:Number = 1.18;
      
      private var _score:String = "";
      
      public var lightVersion:Number = 0;
      
      public var zuobiNumber:Number = 1;
      
      public var zuobiNumber4:int = 4;
      
      public var zuobiNumber2:int = 2;
      
      public function GroupData()
      {
         super();
         this.score = 0;
      }
      
      public function init() : *
      {
         this.name = "无";
         this.saveDataVersion = VERSION;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["name","saveDataVersion"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         if(obj.hasOwnProperty("score"))
         {
            this.score = obj.score;
            this.lightVersion = obj.lightVersion;
         }
         else
         {
            this.score = 0;
            this.lightVersion = 0;
         }
      }
      
      public function getLightB() : Boolean
      {
         return this.lightVersion == VERSION;
      }
      
      public function setLight(bb:Boolean) : *
      {
         if(bb)
         {
            this.lightVersion = VERSION;
         }
         else
         {
            this.lightVersion = 0;
         }
      }
      
      public function set score(value0:Number) : *
      {
         this._score = TextWay.toCode(String(value0));
      }
      
      public function get score() : Number
      {
         return Number(TextWay.getText(this._score));
      }
      
      public function isZuobi() : Boolean
      {
         if(this.zuobiNumber != int("1") || this.zuobiNumber2 != int("2") || this.zuobiNumber4 != int("4"))
         {
            return true;
         }
         return false;
      }
   }
}

