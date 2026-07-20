package gameAll.sensitive
{
   public class SensitiveWords
   {
      
      public var arr:Array = [];
      
      public function SensitiveWords()
      {
         super();
      }
      
      public function init(xml0:XML) : *
      {
         var n:* = undefined;
         var xml1:* = xml0.item;
         for(n in xml1)
         {
            this.arr.push(String(xml1[n]));
         }
      }
      
      public function encode(str0:String) : String
      {
         var n:* = undefined;
         var str1:String = null;
         for(n in this.arr)
         {
            str1 = this.arr[n];
            if(str0 == str1)
            {
               return "***";
            }
            if(str0.length >= str1.length)
            {
               while(str0.indexOf(str1) >= 0)
               {
                  str0 = str0.replace(str1,"*");
               }
            }
         }
         return str0;
      }
      
      public function replaceStr(str0:String, s0:String, s1:String) : String
      {
         while(str0.indexOf(s0) >= 0)
         {
            str0 = str0.replace(s0,s1);
         }
         return str0;
      }
   }
}

