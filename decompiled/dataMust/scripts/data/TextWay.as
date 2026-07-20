package data
{
   public class TextWay
   {
      
      public function TextWay()
      {
         super();
      }
      
      public static function getFeng(param1:String, param2:String) : Array
      {
         var _loc3_:String = param1;
         var _loc4_:int = param2.length;
         var _loc5_:Array = new Array();
         var _loc6_:int = _loc3_.indexOf(param2);
         var _loc7_:int = 0;
         while(_loc6_ >= 0 || _loc7_ > 10000)
         {
            _loc5_[_loc7_] = _loc3_.substr(0,_loc6_);
            _loc7_++;
            _loc3_ = _loc3_.substr(_loc6_ + _loc4_);
            _loc6_ = _loc3_.indexOf(param2);
         }
         _loc5_.push(_loc3_);
         return _loc5_;
      }
      
      public static function toHan(param1:String) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc2_:String = param1;
         var _loc3_:Array = [" ","-","_","·",".",",","。","，"];
         for(_loc4_ in _loc3_)
         {
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = 0;
            do
            {
               _loc6_++;
               _loc2_ = _loc2_.replace(_loc5_,"");
            }
            while(_loc2_.indexOf(_loc5_) >= 0 && _loc6_ < 100);
         }
         return _loc2_;
      }
      
      public static function delCharArr(param1:String, param2:Array) : String
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:String = param1;
         for(_loc4_ in param2)
         {
            _loc5_ = param2[_loc4_];
            _loc6_ = 0;
            do
            {
               _loc6_++;
               _loc3_ = _loc3_.replace(_loc5_,"");
            }
            while(_loc3_.indexOf(_loc5_) >= 0 && _loc6_ < 10000);
         }
         return _loc3_;
      }
      
      public static function delChat(param1:String) : String
      {
         return TextWay.delCharArr(param1,["\n","\f","\r","\t"]);
      }
      
      public static function getText(param1:String) : String
      {
         var _loc6_:String = null;
         var _loc2_:String = "";
         var _loc3_:Array = new Array();
         var _loc4_:int = int(param1.length / 5);
         var _loc5_:int = 0;
         while(_loc5_ <= _loc4_ - 1)
         {
            _loc6_ = param1.substr(_loc5_ * 5,5);
            _loc3_[_loc5_] = String.fromCharCode(int(_loc6_));
            _loc2_ += _loc3_[_loc5_];
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function toCode(param1:String) : String
      {
         var _loc6_:String = null;
         var _loc2_:String = "";
         var _loc3_:Array = new Array();
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ <= _loc4_ - 1)
         {
            _loc6_ = param1.substr(_loc5_,1);
            _loc3_[_loc5_] = String(_loc6_.charCodeAt());
            _loc3_[_loc5_] = to5(_loc3_[_loc5_]);
            _loc2_ += _loc3_[_loc5_];
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function toNumCode(param1:String) : Number
      {
         var _loc6_:String = null;
         var _loc2_:Number = 0;
         var _loc3_:Array = new Array();
         var _loc4_:int = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ <= _loc4_ - 1)
         {
            _loc6_ = param1.substr(_loc5_,1);
            _loc3_[_loc5_] = _loc6_.charCodeAt();
            _loc2_ += _loc3_[_loc5_];
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function to5(param1:String) : String
      {
         var _loc2_:String = null;
         if(param1.length == 0)
         {
            _loc2_ = "00000" + param1;
         }
         else if(param1.length == 4)
         {
            _loc2_ = "0" + param1;
         }
         else if(param1.length == 3)
         {
            _loc2_ = "00" + param1;
         }
         else if(param1.length == 2)
         {
            _loc2_ = "000" + param1;
         }
         else if(param1.length == 1)
         {
            _loc2_ = "0000" + param1;
         }
         else
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public static function toNum(param1:String, param2:int) : String
      {
         var _loc3_:int = param1.length;
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ <= param2 - _loc3_ - 1)
         {
            _loc4_ += "0";
            _loc5_++;
         }
         return _loc4_ + param1;
      }
      
      public static function moveTo(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         while(_loc3_ < param1.length)
         {
            _loc2_ += String.fromCharCode(param1.charCodeAt(_loc3_) + 10);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function reductFrom(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         while(_loc3_ < param1.length)
         {
            _loc2_ += String.fromCharCode(param1.charCodeAt(_loc3_) - 10);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function numTo(param1:Number) : String
      {
         param1 *= 14;
         return moveTo(String(param1));
      }
      
      public static function numFrom(param1:String) : Number
      {
         return Number(reductFrom(param1)) / 14;
      }
   }
}

