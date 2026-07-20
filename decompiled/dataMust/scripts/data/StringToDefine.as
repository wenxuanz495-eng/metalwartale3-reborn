package data
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class StringToDefine
   {
      
      public function StringToDefine()
      {
         super();
      }
      
      public static function getTimeStr(param1:Number) : String
      {
         var _loc2_:int = int(param1 / 3600);
         var _loc3_:int = int((param1 - _loc2_ * 3600) / 60);
         var _loc4_:int = int(param1 % 60);
         return to2(_loc2_) + ":" + to2(_loc3_) + ":" + to2(_loc4_);
      }
      
      public static function to2(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return String(param1);
      }
      
      public static function getFontColor(param1:String, param2:String = "#999999") : String
      {
         return "<font color=\'" + param2 + "\'>" + param1 + "</font>";
      }
      
      public static function getPro_byArr(param1:Array) : int
      {
         var _loc4_:* = undefined;
         var _loc2_:Number = Math.random();
         var _loc3_:Number = 0;
         for(_loc4_ in param1)
         {
            _loc3_ += param1[_loc4_];
            if(_loc2_ < _loc3_)
            {
               return _loc4_;
            }
         }
         return param1.length - 1;
      }
      
      public static function getPro_byArr2(param1:Array) : int
      {
         var _loc4_:* = undefined;
         var _loc5_:Number = NaN;
         var _loc2_:Number = Math.random();
         var _loc3_:Number = 0;
         for(_loc4_ in param1)
         {
            _loc3_ += param1[_loc4_];
         }
         _loc5_ = 0;
         for(_loc4_ in param1)
         {
            _loc5_ += param1[_loc4_];
            if(_loc2_ < _loc5_ / _loc3_)
            {
               return _loc4_;
            }
         }
         return param1.length - 1;
      }
      
      public static function deductArr(param1:Array, param2:Array) : Array
      {
         var _loc4_:* = undefined;
         var _loc3_:Array = [];
         for(_loc4_ in param1)
         {
            if(param2.indexOf(param1[_loc4_]) == -1)
            {
               _loc3_.push(param1[_loc4_]);
            }
         }
         return _loc3_;
      }
      
      public static function copyArray(param1:Array) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function getRect(param1:String) : Rectangle
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:Rectangle = new Rectangle();
         _loc3_.x = Number(_loc2_[0]);
         _loc3_.y = Number(_loc2_[1]);
         _loc3_.width = Number(_loc2_[2]);
         _loc3_.height = Number(_loc2_[3]);
         return _loc3_;
      }
      
      public static function getLine(param1:String) : Lines
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:Lines = new Lines();
         _loc3_.x = Number(_loc2_[0]);
         _loc3_.y = Number(_loc2_[1]);
         _loc3_.ra = Number(_loc2_[2]) / 180 * Math.PI;
         _loc3_.w = Number(_loc2_[3]);
         if(_loc2_.length >= 5)
         {
            _loc3_.len = Number(_loc2_[4]);
         }
         return _loc3_;
      }
      
      public static function getPoint(param1:String) : Point
      {
         var _loc2_:Array = param1.split(",");
         var _loc3_:Point = new Point();
         _loc3_.x = _loc2_[0];
         _loc3_.y = _loc2_[1];
         return _loc3_;
      }
      
      public static function flipRect_Y(param1:Rectangle) : *
      {
         var _loc2_:Rectangle = param1;
         _loc2_.x = -(_loc2_.width + _loc2_.x);
      }
      
      public static function getDecimalPoint1(param1:Number) : *
      {
         return int(param1 * 10) / 10;
      }
      
      public static function xmlToArr(param1:*) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_.push(String(param1[_loc3_]));
         }
         return _loc2_;
      }
      
      public static function xmlToRectArr(param1:*) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc2_.push(getRect(String(param1[_loc3_])));
         }
         return _loc2_;
      }
      
      public static function getBmp(param1:DisplayObject) : BitmapData
      {
         var _loc2_:Rectangle = param1.getRect(param1);
         var _loc3_:Matrix = new Matrix();
         _loc3_.tx = -_loc2_.x;
         _loc3_.ty = -_loc2_.y;
         var _loc4_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc4_.draw(param1,_loc3_);
         return _loc4_;
      }
      
      public static function halfPrice(param1:Number, param2:Number) : Number
      {
         if(param1 >= 0 && param1 < 1)
         {
            if(param2 == 1)
            {
               param1 = 0;
            }
            else if(param2 == 2)
            {
               param1 = 0.5;
            }
            else
            {
               param1 = 0.3;
            }
         }
         return param1;
      }
      
      public static function replaceStr(param1:String, param2:String, param3:String) : String
      {
         while(param1.indexOf(param2) >= 0)
         {
            param1 = param1.replace(param2,param3);
         }
         return param1;
      }
   }
}

