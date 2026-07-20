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
      
      public static function getTimeStr(time0:Number) : String
      {
         var _hour:int = int(time0 / 3600);
         var _miu:int = int((time0 - _hour * 3600) / 60);
         var _sec:int = int(time0 % 60);
         return to2(_hour) + ":" + to2(_miu) + ":" + to2(_sec);
      }
      
      public static function to2(num:int) : String
      {
         if(num < 10)
         {
            return "0" + num;
         }
         return String(num);
      }
      
      public static function getFontColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public static function getPro_byArr(arr0:Array) : int
      {
         var n:* = undefined;
         var ran0:Number = Math.random();
         var num0:Number = 0;
         for(n in arr0)
         {
            num0 += arr0[n];
            if(ran0 < num0)
            {
               return n;
            }
         }
         return arr0.length - 1;
      }
      
      public static function getPro_byArr2(arr0:Array) : int
      {
         var n:* = undefined;
         var num0:Number = NaN;
         var ran0:Number = Math.random();
         var max0:Number = 0;
         for(n in arr0)
         {
            max0 += arr0[n];
         }
         num0 = 0;
         for(n in arr0)
         {
            num0 += arr0[n];
            if(ran0 < num0 / max0)
            {
               return n;
            }
         }
         return arr0.length - 1;
      }
      
      public static function getBaifen(v0:Number) : String
      {
         return Number(Number(v0 * 100).toFixed(1)) + "%";
      }
      
      public static function deductArr(arr0:Array, arr1:Array) : Array
      {
         var n:* = undefined;
         var arr2:Array = [];
         for(n in arr0)
         {
            if(arr1.indexOf(arr0[n]) == -1)
            {
               arr2.push(arr0[n]);
            }
         }
         return arr2;
      }
      
      public static function copyArray(arr0:Array) : *
      {
         var data0:ByteArray = new ByteArray();
         data0.writeObject(arr0);
         data0.position = 0;
         return data0.readObject();
      }
      
      public static function getRect(str:String) : Rectangle
      {
         var hitr:Array = str.split(",");
         var hurtRect:Rectangle = new Rectangle();
         hurtRect.x = Number(hitr[0]);
         hurtRect.y = Number(hitr[1]);
         hurtRect.width = Number(hitr[2]);
         hurtRect.height = Number(hitr[3]);
         return hurtRect;
      }
      
      public static function getLine(str:String) : Lines
      {
         var hitr:Array = str.split(",");
         var l0:Lines = new Lines();
         l0.x = Number(hitr[0]);
         l0.y = Number(hitr[1]);
         l0.ra = Number(hitr[2]) / 180 * Math.PI;
         l0.w = Number(hitr[3]);
         if(hitr.length >= 5)
         {
            l0.len = Number(hitr[4]);
         }
         return l0;
      }
      
      public static function getPoint(str:String) : Point
      {
         var shootp:Array = str.split(",");
         var shootPoint:Point = new Point();
         shootPoint.x = shootp[0];
         shootPoint.y = shootp[1];
         return shootPoint;
      }
      
      public static function flipRect_Y(rect:Rectangle) : *
      {
         var r0:Rectangle = rect;
         r0.x = -(r0.width + r0.x);
      }
      
      public static function getDecimalPoint1(num0:Number) : *
      {
         return int(num0 * 10) / 10;
      }
      
      public static function xmlToArr(xml:*) : Array
      {
         var n:* = undefined;
         var arr:Array = [];
         for(n in xml)
         {
            arr.push(String(xml[n]));
         }
         return arr;
      }
      
      public static function xmlToRectArr(xml:*) : Array
      {
         var n:* = undefined;
         var arr:Array = [];
         for(n in xml)
         {
            arr.push(getRect(String(xml[n])));
         }
         return arr;
      }
      
      public static function getBmp(mc:DisplayObject) : BitmapData
      {
         var rect0:Rectangle = mc.getRect(mc);
         var mix:Matrix = new Matrix();
         mix.tx = -rect0.x;
         mix.ty = -rect0.y;
         var bmp0:BitmapData = new BitmapData(rect0.width,rect0.height,true,0);
         bmp0.draw(mc,mix);
         return bmp0;
      }
      
      public static function halfPrice(discount0:Number, price0:Number) : Number
      {
         if(discount0 >= 0 && discount0 < 1)
         {
            if(price0 == 1)
            {
               discount0 = 0;
            }
            else if(price0 == 2)
            {
               discount0 = 0.5;
            }
            else
            {
               discount0 = 0.3;
            }
         }
         return discount0;
      }
      
      public static function replaceStr(str0:String, s0:String, s1:String) : String
      {
         while(str0.indexOf(s0) >= 0)
         {
            str0 = str0.replace(s0,s1);
         }
         return str0;
      }
      
      public static function rectIsNaN(rect0:Rectangle) : Boolean
      {
         if(Boolean(rect0))
         {
            if(isNaN(rect0.x))
            {
               return true;
            }
            if(isNaN(rect0.y))
            {
               return true;
            }
            if(isNaN(rect0.width))
            {
               return true;
            }
            if(isNaN(rect0.height))
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      public static function rectArrIsNaN(arr0:Array) : Boolean
      {
         var n:* = undefined;
         var rect0:Rectangle = null;
         for(n in arr0)
         {
            rect0 = arr0[0];
            if(rectIsNaN(rect0))
            {
               return true;
            }
         }
         return false;
      }
   }
}

