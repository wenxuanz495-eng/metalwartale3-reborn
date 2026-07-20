package data
{
   public class TextWay
   {
      
      public function TextWay()
      {
         super();
      }
      
      public static function getFeng(s:String, feng:String) : Array
      {
         var str:String = s;
         var len:int = feng.length;
         var arr:Array = new Array();
         var findZ:int = str.indexOf(feng);
         var nn:int = 0;
         while(findZ >= 0 || nn > 10000)
         {
            arr[nn] = str.substr(0,findZ);
            nn++;
            str = str.substr(findZ + len);
            findZ = str.indexOf(feng);
         }
         arr.push(str);
         return arr;
      }
      
      public static function toHan(in_name:String) : String
      {
         var n:* = undefined;
         var cc:String = null;
         var num0:int = 0;
         var n0:String = in_name;
         var clearArr:Array = [" ","-","_","·",".",",","。","，"];
         for(n in clearArr)
         {
            cc = clearArr[n];
            num0 = 0;
            do
            {
               num0++;
               n0 = n0.replace(cc,"");
            }
            while(n0.indexOf(cc) >= 0 && num0 < 100);
         }
         return n0;
      }
      
      public static function delCharArr(in_name:String, clearArr:Array) : String
      {
         var n:* = undefined;
         var cc:String = null;
         var num0:int = 0;
         var n0:String = in_name;
         for(n in clearArr)
         {
            cc = clearArr[n];
            num0 = 0;
            do
            {
               num0++;
               n0 = n0.replace(cc,"");
            }
            while(n0.indexOf(cc) >= 0 && num0 < 10000);
         }
         return n0;
      }
      
      public static function delChat(str0:String) : String
      {
         return TextWay.delCharArr(str0,["\n","\f","\r","\t"]);
      }
      
      public static function getText(str:String) : String
      {
         var ss:String = null;
         var str2:String = "";
         var arr:Array = new Array();
         var len:int = int(str.length / 5);
         for(var n:int = 0; n <= len - 1; n++)
         {
            ss = str.substr(n * 5,5);
            arr[n] = String.fromCharCode(int(ss));
            str2 += arr[n];
         }
         return str2;
      }
      
      public static function toCode(str:String) : String
      {
         var ss:String = null;
         var str2:String = "";
         var arr:Array = new Array();
         var len:int = str.length;
         for(var n:int = 0; n <= len - 1; n++)
         {
            ss = str.substr(n,1);
            arr[n] = String(ss.charCodeAt());
            arr[n] = to5(arr[n]);
            str2 += arr[n];
         }
         return str2;
      }
      
      public static function toNumCode(str:String) : Number
      {
         var ss:String = null;
         var str2:Number = 0;
         var arr:Array = new Array();
         var len:int = str.length;
         for(var n:int = 0; n <= len - 1; n++)
         {
            ss = str.substr(n,1);
            arr[n] = ss.charCodeAt();
            str2 += arr[n];
         }
         return str2;
      }
      
      public static function to5(str:String) : String
      {
         var ss:String = null;
         if(str.length == 0)
         {
            ss = "00000" + str;
         }
         else if(str.length == 4)
         {
            ss = "0" + str;
         }
         else if(str.length == 3)
         {
            ss = "00" + str;
         }
         else if(str.length == 2)
         {
            ss = "000" + str;
         }
         else if(str.length == 1)
         {
            ss = "0000" + str;
         }
         else
         {
            ss = str;
         }
         return ss;
      }
      
      public static function toNum(str:String, num:int) : String
      {
         var len:int = str.length;
         var add:String = "";
         for(var n:int = 0; n <= num - len - 1; n++)
         {
            add += "0";
         }
         return add + str;
      }
      
      public static function moveTo(str0:String) : String
      {
         var n:int = 0;
         for(var str2:String = ""; n < str0.length; )
         {
            str2 += String.fromCharCode(str0.charCodeAt(n) + 10);
            n++;
         }
         return str2;
      }
      
      public static function reductFrom(str0:String) : String
      {
         var n:int = 0;
         for(var str2:String = ""; n < str0.length; )
         {
            str2 += String.fromCharCode(str0.charCodeAt(n) - 10);
            n++;
         }
         return str2;
      }
      
      public static function numTo(num0:Number) : String
      {
         num0 *= 14;
         return moveTo(String(num0));
      }
      
      public static function numFrom(str0:String) : Number
      {
         return Number(reductFrom(str0)) / 14;
      }
      
      public static function xmlToNumberArr(str0:String) : Array
      {
         var n:* = undefined;
         str0 = delChat(str0);
         var arr:Array = [];
         var arr1:Array = str0.split(",");
         for(n in arr1)
         {
            arr.push(Number(arr1[n]));
         }
         return arr;
      }
   }
}

