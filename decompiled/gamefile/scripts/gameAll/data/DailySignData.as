package gameAll.data
{
   import data.TextWay;
   
   public class DailySignData
   {
      
      public var signArr:Array = [];
      
      public var giftGetArr:Array = [];
      
      public function DailySignData()
      {
         super();
      }
      
      public function init() : *
      {
         this.signArr.length = 0;
         this.giftGetArr.length = 0;
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = [];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.signArr = this.copyArray(obj.signArr);
         this.giftGetArr = this.copyArray(obj.giftGetArr);
      }
      
      public function addSign(str0:String) : *
      {
         var str1:String = TextWay.toCode(str0);
         if(this.signArr.indexOf(str1) == -1)
         {
            this.signArr.push(str1);
         }
         trace("signArr:\n" + this.getSignArr());
      }
      
      public function getGift(num0:int) : *
      {
         var str1:String = TextWay.toCode(String(num0));
         if(this.giftGetArr.indexOf(str1) == -1)
         {
            this.giftGetArr.push(str1);
         }
         trace("giftArr:\n" + this.getGiftGetArr());
      }
      
      public function getSignArr() : Array
      {
         return this.dencodeArray(this.signArr);
      }
      
      public function getGiftGetArr() : Array
      {
         return this.dencodeArray(this.giftGetArr);
      }
      
      private function dencodeArray(arr0:Array) : Array
      {
         var n:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            arr1.push(TextWay.getText(arr0[n]));
         }
         return arr1;
      }
      
      private function copyArray(arr0:Array) : Array
      {
         var n:* = undefined;
         var xx0:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            xx0 = arr0[n];
            if(xx0 is String || xx0 is int || xx0 is Number)
            {
               arr1.push(xx0);
            }
            else if(Boolean(xx0.hasOwnProperty("clone")))
            {
               arr1.push(xx0.clone());
            }
         }
         return arr1;
      }
   }
}

