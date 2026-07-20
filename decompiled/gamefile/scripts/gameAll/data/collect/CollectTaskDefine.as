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
      
      public function inData_byStr(str0:String) : *
      {
         var arr1:Array = TextWay.delChat(str0).split(",");
         this.targetItems = String(arr1[0]);
         this.targetNum = int(arr1[1]);
         this.cnItems = String(arr1[2]);
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["index","targetItems","targetNum","cnItems"];
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
      
      public function get targetNum() : int
      {
         return int(TextWay.getText(this._targetNum));
      }
      
      public function set targetNum(v0:int) : *
      {
         this._targetNum = TextWay.toCode(String(v0));
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
         if(this.targetItems.indexOf("enemy") >= 0)
         {
            return this.cnItems;
         }
         return "收集：" + this.cnItems;
      }
   }
}

