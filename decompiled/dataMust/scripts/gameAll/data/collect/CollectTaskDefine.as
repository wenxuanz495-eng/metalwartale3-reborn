package gameAll.data.collect
{
   import data.TextWay;
   
   public class CollectTaskDefine
   {
      
      public var index:int = 0;
      
      public var state:String = "no";
      
      public var targetItems:String = "";
      
      public var cnItems:String = "";
      
      public var _targetNum:String = "0";
      
      public var giftArr:Array = [];
      
      public function CollectTaskDefine()
      {
         super();
      }
      
      public function inData_byStr(param1:String) : *
      {
         var _loc2_:Array = TextWay.delChat(param1).split(",");
         this.targetItems = String(_loc2_[0]);
         this.targetNum = int(_loc2_[1]);
         this.cnItems = String(_loc2_[2]);
      }
      
      public function inData_byObj(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc2_:Array = ["index","targetItems","targetNum","cnItems"];
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
      
      public function get targetNum() : int
      {
         return int(TextWay.getText(this._targetNum));
      }
      
      public function set targetNum(param1:int) : *
      {
         this._targetNum = TextWay.toCode(String(param1));
      }
      
      public function getNowB() : Boolean
      {
         if(this.state == "no" || this.state == "over")
         {
            return false;
         }
         return true;
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
         if(this.targetItems.indexOf("enemy") >= 0)
         {
            return this.cnItems;
         }
         return "收集：" + this.cnItems;
      }
   }
}

