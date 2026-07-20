package hit
{
   import data.Maths;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HitIO
   {
      
      public function HitIO()
      {
         super();
      }
      
      public static function hit(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number, w2:Number, h2:Number) : Boolean
      {
         var bb:Boolean = false;
         var lx:* = x1 - (x2 + w2);
         var rx:* = x2 - (x1 + w1);
         var uy:* = y1 - (y2 + h2);
         var dy:* = y2 - (y1 + h1);
         if(lx < 0 && rx < 0 && (uy < 0 && dy < 0))
         {
            bb = true;
         }
         return bb;
      }
      
      public static function hitRect(rect0:Rectangle, rect1:Rectangle) : Boolean
      {
         return hit(rect0.x,rect0.y,rect0.width,rect0.height,rect1.x,rect1.y,rect1.width,rect1.height);
      }
      
      public static function hitPoint(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number) : Boolean
      {
         var bb:Boolean = false;
         var bx:Boolean = x2 >= x1 && x2 <= x1 + w1;
         var by:Boolean = y2 >= y1 && y2 <= y1 + h1;
         if(bx && by)
         {
            bb = true;
         }
         return bb;
      }
      
      public static function RectArr2_point(arr0:Array, rect1:Rectangle) : Point
      {
         var n:* = undefined;
         var rect0:Rectangle = null;
         var bb:Boolean = false;
         var cx:Number = NaN;
         var xx0:Number = NaN;
         for(n in arr0)
         {
            rect0 = arr0[n];
            bb = hit(rect0.x,rect0.y,rect0.width,rect0.height,rect1.x,rect1.y,rect1.width,rect1.height);
            if(bb)
            {
               cx = (rect0.x + rect0.width / 2 + (rect1.x + rect1.width / 2)) / 2;
               xx0 = cx;
               if(cx < rect1.x)
               {
                  xx0 = rect1.x;
               }
               else if(cx > rect1.right)
               {
                  xx0 = rect1.right;
               }
               return new Point(xx0,rect1.y + rect1.height / 2);
            }
         }
         return null;
      }
      
      public static function hitRectPoint(rect:Rectangle, x2:Number, y2:Number) : Boolean
      {
         return hitPoint(rect.x,rect.y,rect.width,rect.height,x2,y2);
      }
      
      public static function hitRectPoint_ra(rect:Rectangle, x2:Number, y2:Number) : Number
      {
         var ctop:Number = NaN;
         var cdown:Number = NaN;
         var cleft:Number = NaN;
         var cRight:Number = NaN;
         var num:Array = null;
         var min:Number = NaN;
         var minNum:int = 0;
         var n:* = undefined;
         var bb:Boolean = hitPoint(rect.x,rect.y,rect.width,rect.height,x2,y2);
         if(bb)
         {
            ctop = Math.abs(y2 - rect.y);
            cdown = Math.abs(y2 - rect.y - rect.height);
            cleft = Math.abs(x2 - rect.x);
            cRight = Math.abs(x2 - rect.x - rect.width);
            num = [cRight,cdown,cleft,ctop];
            min = 1000000;
            minNum = -1;
            for(n in num)
            {
               if(num[n] <= min)
               {
                  min = Number(num[n]);
                  minNum = n;
               }
            }
            return Math.PI / 2 * minNum;
         }
         return -1000;
      }
      
      public static function hitCirclePoint(x1:Number, y1:Number, d1:Number, x2:Number, y2:Number) : Boolean
      {
         var bb:Boolean = false;
         var d0:Number = Maths.Long(x1 - x2,y1 - y2);
         if(d0 <= d1)
         {
            bb = true;
         }
         return bb;
      }
      
      public static function hitCirclePoint_ra(x1:Number, y1:Number, d1:Number, x2:Number, y2:Number) : Number
      {
         var ra:Number = -1000;
         var d0:Number = Maths.Long(x1 - x2,y1 - y2);
         if(d0 <= d1)
         {
            ra = Math.atan2(y2 - y1,x2 - x1);
         }
         return ra;
      }
      
      public static function hitRectArrPoint(arr0:Array, x2:Number, y2:Number) : Boolean
      {
         var n:* = undefined;
         var rect:Rectangle = null;
         var bb:Boolean = false;
         for(n in arr0)
         {
            rect = arr0[n];
            bb = hitPoint(rect.x,rect.y,rect.width,rect.height,x2,y2);
            if(bb)
            {
               return true;
            }
         }
         return bb;
      }
      
      public static function hitRectArrRect(arr0:Array, x2:Number, y2:Number, w2:Number, h2:Number) : Boolean
      {
         var n:* = undefined;
         var rect:Rectangle = null;
         var bb:Boolean = false;
         for(n in arr0)
         {
            rect = arr0[n];
            bb = hit(rect.x,rect.y,rect.width,rect.height,x2,y2,w2,h2);
            if(bb)
            {
               return true;
            }
         }
         return bb;
      }
      
      public static function hitRAR_ra(arr0:Array, x2:Number, y2:Number, w2:Number, h2:Number) : Number
      {
         var n:* = undefined;
         var rect:Rectangle = null;
         var bb:Boolean = false;
         var ra:Number = -1000;
         for(n in arr0)
         {
            rect = arr0[n];
            bb = hit(rect.x,rect.y,rect.width,rect.height,x2,y2,w2,h2);
            if(bb)
            {
               return Math.atan2(x2 + w2 / 2 - rect.x - rect.width / 2,y2 + h2 / 2 - rect.y - rect.height / 2);
            }
         }
         return ra;
      }
      
      public static function hitCircleLine(x1:Number, y1:Number, d1:Number, x2:Number, y2:Number, ra:Number) : Point
      {
         var cy0:Number = NaN;
         var cx00:Number = NaN;
         var p1:Point = null;
         var p2:Point = null;
         var cx0:Number = NaN;
         var cy00:Number = NaN;
         var p3:Point = null;
         var p4:Point = null;
         var ra0:Number = (ra / Math.PI * 180 + 3600) % 360;
         var p0:Point = null;
         if(ra0 == 0 || ra0 == 180)
         {
            cy0 = Math.abs(y1 - y2);
            if(cy0 <= d1)
            {
               cx00 = Math.abs(Math.sin(Math.acos(cy0 / d1))) * d1;
               p1 = new Point(x1 - cx00,y2);
               p2 = new Point(x1 + cx00,y2);
               if(ra0 == 0)
               {
                  if(x2 <= p1.x)
                  {
                     return p1;
                  }
                  if(x2 > p1.x && x2 < p2.x)
                  {
                     return new Point(x2,y2);
                  }
                  return null;
               }
               if(ra0 == 180)
               {
                  if(x2 <= p1.x)
                  {
                     return null;
                  }
                  if(x2 > p1.x && x2 < p2.x)
                  {
                     return new Point(x2,y2);
                  }
                  return p2;
               }
            }
         }
         else if(ra0 == 90 || ra0 == 270)
         {
            cx0 = Math.abs(x1 - x2);
            if(cx0 <= d1)
            {
               cy00 = Math.abs(Math.sin(Math.acos(cx0 / d1))) * d1;
               p3 = new Point(x2,y1 - cy00);
               p4 = new Point(x2,y1 + cy00);
               if(ra0 == 90)
               {
                  if(y2 <= p3.y)
                  {
                     return p3;
                  }
                  if(y2 > p3.y && y2 < p4.y)
                  {
                     return new Point(x2,y2);
                  }
                  return null;
               }
               if(ra0 == 270)
               {
                  if(y2 <= p3.y)
                  {
                     return null;
                  }
                  if(y2 > p3.y && y2 < p4.y)
                  {
                     return new Point(x2,y2);
                  }
                  return p4;
               }
            }
         }
         return p0;
      }
      
      public static function hitRectLine(rect:Rectangle, x2:Number, y2:Number, ra:Number) : Point
      {
         var ra0:Number = (ra / Math.PI * 180 + 3600) % 360;
         var p0:Point = null;
         var bb:Boolean = false;
         if(ra0 == 0)
         {
            if(y2 >= rect.y && y2 <= rect.y + rect.height && x2 <= rect.x)
            {
               return new Point(rect.x,y2);
            }
         }
         else if(ra0 == 90)
         {
            if(x2 >= rect.x && x2 <= rect.x + rect.width && y2 <= rect.y + rect.height)
            {
               return new Point(x2,rect.y);
            }
         }
         else if(ra0 == 180)
         {
            if(y2 >= rect.y && y2 <= rect.y + rect.height && x2 >= rect.x + rect.width)
            {
               return new Point(rect.x + rect.width,y2);
            }
         }
         else if(ra0 == 270)
         {
            if(x2 >= rect.x && x2 <= rect.x + rect.width && y2 >= rect.y)
            {
               return new Point(x2,rect.y + rect.height);
            }
         }
         return p0;
      }
      
      public static function hitRectLine2(rect:Rectangle, x2:Number, y2:Number, ra:Number, w0:Number, len:int = 800) : Point
      {
         var loopNum:int = 0;
         var cos0:Number = NaN;
         var sin0:Number = NaN;
         var n:int = 0;
         var x3:Number = NaN;
         var y3:Number = NaN;
         var bb:* = undefined;
         var ra0:Number = (ra / Math.PI * 180 + 3600) % 360;
         var w1:Number = w0 / 2;
         var p0:Point = null;
         if(ra0 == 0)
         {
            if(y2 + w1 >= rect.y && y2 - w1 <= rect.y + rect.height && x2 <= rect.x)
            {
               return new Point(rect.x,y2);
            }
         }
         else if(ra0 == 90)
         {
            if(x2 + w1 >= rect.x && x2 - w1 <= rect.x + rect.width && y2 <= rect.y + rect.height)
            {
               return new Point(x2,rect.y);
            }
         }
         else if(ra0 == 180)
         {
            if(y2 + w1 >= rect.y && y2 - w1 <= rect.y + rect.height && x2 >= rect.x + rect.width)
            {
               return new Point(rect.x + rect.width,y2);
            }
         }
         else
         {
            if(ra0 != 270)
            {
               if(w1 < 5)
               {
                  loopNum = len / 10;
                  cos0 = Math.cos(ra) * 5;
                  sin0 = Math.sin(ra) * 5;
               }
               else
               {
                  loopNum = len / w0;
                  cos0 = Math.cos(ra) * w0;
                  sin0 = Math.sin(ra) * w0;
               }
               while(true)
               {
                  if(n < loopNum)
                  {
                     x3 = x2 + cos0 * n - w1;
                     y3 = y2 + sin0 * n - w1;
                     bb = hit(rect.x,rect.y,rect.width,rect.height,x3,y3,w0,w0);
                     if(Boolean(bb))
                     {
                        break;
                     }
                     n++;
                     continue;
                  }
               }
               return new Point(x2 + cos0 * n,y2 + sin0 * n);
            }
            if(x2 + w1 >= rect.x && x2 - w1 <= rect.x + rect.width && y2 >= rect.y)
            {
               return new Point(x2,rect.y + rect.height);
            }
         }
         return p0;
      }
      
      public static function hitRectArrLine2(arr0:Array, x2:Number, y2:Number, ra:Number, w0:Number, len:int = 800) : Point
      {
         var p1:Point = null;
         var n1:* = undefined;
         var rect1:Rectangle = null;
         var np1:Point = null;
         var p2:Point = null;
         var n2:* = undefined;
         var rect2:Rectangle = null;
         var np2:Point = null;
         var p3:Point = null;
         var n3:* = undefined;
         var rect3:Rectangle = null;
         var np3:Point = null;
         var p4:Point = null;
         var n4:* = undefined;
         var rect4:Rectangle = null;
         var np4:Point = null;
         var loopNum:int = 0;
         var cos0:Number = NaN;
         var sin0:Number = NaN;
         var n:int = 0;
         var x3:Number = NaN;
         var y3:Number = NaN;
         var n7:* = undefined;
         var rect7:Rectangle = null;
         var bb:* = undefined;
         var ra0:Number = (ra / Math.PI * 180 + 3600) % 360;
         var w1:Number = w0 / 2;
         var p0:Point = null;
         if(ra0 == 0)
         {
            p1 = null;
            for(n1 in arr0)
            {
               rect1 = arr0[n1];
               if(y2 + w1 >= rect1.y && y2 - w1 <= rect1.y + rect1.height && x2 <= rect1.x)
               {
                  np1 = new Point(rect1.x,y2);
                  if(p1 is Point)
                  {
                     if(p1.x > np1.x)
                     {
                        p1 = np1;
                     }
                  }
                  else
                  {
                     p1 = np1;
                  }
               }
            }
            return p1;
         }
         if(ra0 == 90)
         {
            p2 = null;
            for(n2 in arr0)
            {
               rect2 = arr0[n2];
               if(x2 + w1 >= rect2.x && x2 - w1 <= rect2.x + rect2.width && y2 <= rect2.y + rect2.height)
               {
                  np2 = new Point(x2,rect2.y);
                  if(p2 is Point)
                  {
                     if(p2.y > np2.y)
                     {
                        p2 = np2;
                     }
                  }
                  else
                  {
                     p2 = np2;
                  }
               }
            }
            return p2;
         }
         if(ra0 == 180)
         {
            p3 = null;
            for(n3 in arr0)
            {
               rect3 = arr0[n3];
               if(y2 + w1 >= rect3.y && y2 - w1 <= rect3.y + rect3.height && x2 >= rect3.x + rect3.width)
               {
                  np3 = new Point(rect3.x + rect3.width,y2);
                  if(p3 is Point)
                  {
                     if(p3.x < np3.x)
                     {
                        p3 = np3;
                     }
                  }
                  else
                  {
                     p3 = np3;
                  }
               }
            }
            return p3;
         }
         if(ra0 == 270)
         {
            p4 = null;
            for(n4 in arr0)
            {
               rect4 = arr0[n4];
               if(x2 + w1 >= rect4.x && x2 - w1 <= rect4.x + rect4.width && y2 >= rect4.y)
               {
                  np4 = new Point(x2,rect4.y + rect4.height);
                  if(p4 is Point)
                  {
                     if(p4.y < np4.y)
                     {
                        p4 = np4;
                     }
                  }
                  else
                  {
                     p4 = np4;
                  }
               }
            }
            return p4;
         }
         if(w1 < 5)
         {
            loopNum = len / 10;
            cos0 = Math.cos(ra) * 5;
            sin0 = Math.sin(ra) * 5;
         }
         else
         {
            loopNum = len / w0;
            cos0 = Math.cos(ra) * w0;
            sin0 = Math.sin(ra) * w0;
         }
         while(n < loopNum)
         {
            x3 = x2 + cos0 * n - w1;
            y3 = y2 + sin0 * n - w1;
            for(n7 in arr0)
            {
               rect7 = arr0[n7];
               bb = hit(rect7.x,rect7.y,rect7.width,rect7.height,x3,y3,w0,w0);
               if(Boolean(bb))
               {
                  return new Point(x2 + cos0 * n,y2 + sin0 * n);
               }
            }
            n++;
         }
         return p0;
      }
      
      public static function hitRectArrLaser2(arr2:Array, x2:Number, y2:Number, ra:Number, w0:Number) : Object
      {
         var m:* = undefined;
         var arr9:Array = null;
         var m2:* = undefined;
         var arr0:Array = null;
         var n1:* = undefined;
         var rect1:Rectangle = null;
         var np1:Point = null;
         var p2:Point = null;
         var n2:* = undefined;
         var rect2:Rectangle = null;
         var np2:Point = null;
         var p3:Point = null;
         var n3:* = undefined;
         var rect3:Rectangle = null;
         var np3:Point = null;
         var p4:Point = null;
         var n4:* = undefined;
         var rect4:Rectangle = null;
         var np4:Point = null;
         var len:int = 0;
         var loopNum:int = 0;
         var cos0:Number = NaN;
         var sin0:Number = NaN;
         var n:int = 0;
         var x3:Number = NaN;
         var y3:Number = NaN;
         var m9:* = undefined;
         var arr99:Array = null;
         var m29:* = undefined;
         var arr90:Array = null;
         var n9:* = undefined;
         var rect7:Rectangle = null;
         var bb:* = undefined;
         var obj:Object = new Object();
         var ra0:Number = (ra / Math.PI * 180 + 3600) % 360;
         var w1:Number = w0 / 2;
         var p0:Point = null;
         var p1:Point = null;
         var b0:* = null;
         var num1:int = -1;
         var num2:int = -1;
         var lnum:int = 0;
         if(ra0 % 90 == 0)
         {
            for(m in arr2)
            {
               arr9 = arr2[m];
               for(m2 in arr9)
               {
                  if(arr9[m2].hitHurtB > 0)
                  {
                     break;
                  }
                  arr0 = arr9[m2].AAHD.hurtRectArr;
                  if(ra0 == 0)
                  {
                     for(n1 in arr0)
                     {
                        rect1 = arr0[n1];
                        if(y2 + w1 >= rect1.y && y2 - w1 <= rect1.y + rect1.height && x2 <= rect1.x)
                        {
                           np1 = new Point(rect1.x,y2);
                           lnum++;
                           if(p1 is Point)
                           {
                              if(p1.x > np1.x)
                              {
                                 p1 = np1;
                                 num1 = m;
                                 num2 = m2;
                              }
                           }
                           else
                           {
                              p1 = np1;
                              num1 = m;
                              num2 = m2;
                           }
                        }
                     }
                  }
                  else if(ra0 == 90)
                  {
                     p2 = p1;
                     for(n2 in arr0)
                     {
                        rect2 = arr0[n2];
                        if(x2 + w1 >= rect2.x && x2 - w1 <= rect2.x + rect2.width && y2 <= rect2.y + rect2.height)
                        {
                           np2 = new Point(x2,rect2.y);
                           if(p2 is Point)
                           {
                              if(p2.y > np2.y)
                              {
                                 p2 = np2;
                                 num1 = m;
                                 num2 = m2;
                              }
                           }
                           else
                           {
                              p2 = np2;
                              num1 = m;
                              num2 = m2;
                           }
                        }
                     }
                     p1 = p2;
                  }
                  else if(ra0 == 180)
                  {
                     p3 = p1;
                     for(n3 in arr0)
                     {
                        rect3 = arr0[n3];
                        if(y2 + w1 >= rect3.y && y2 - w1 <= rect3.y + rect3.height && x2 >= rect3.x + rect3.width)
                        {
                           np3 = new Point(rect3.x + rect3.width,y2);
                           lnum++;
                           if(p3 is Point)
                           {
                              if(p3.x < np3.x)
                              {
                                 p3 = np3;
                                 num1 = m;
                                 num2 = m2;
                              }
                           }
                           else
                           {
                              p3 = np3;
                              num1 = m;
                              num2 = m2;
                           }
                        }
                     }
                     p1 = p3;
                  }
                  else if(ra0 == 270)
                  {
                     p4 = p1;
                     for(n4 in arr0)
                     {
                        rect4 = arr0[n4];
                        if(x2 + w1 >= rect4.x && x2 - w1 <= rect4.x + rect4.width && y2 >= rect4.y)
                        {
                           np4 = new Point(x2,rect4.y + rect4.height);
                           if(p4 is Point)
                           {
                              if(p4.y < np4.y)
                              {
                                 p4 = np4;
                                 num1 = m;
                                 num2 = m2;
                              }
                           }
                           else
                           {
                              p4 = np4;
                              num1 = m;
                              num2 = m2;
                           }
                        }
                     }
                     p1 = p4;
                  }
               }
            }
         }
         else
         {
            len = 800;
            if(w1 < 10)
            {
               loopNum = len / 20;
               cos0 = Math.cos(ra) * 5;
               sin0 = Math.sin(ra) * 5;
            }
            else
            {
               loopNum = len / w0;
               cos0 = Math.cos(ra) * w0;
               sin0 = Math.sin(ra) * w0;
            }
            while(n < loopNum)
            {
               x3 = x2 + cos0 * n - w1;
               y3 = y2 + sin0 * n - w1;
               for(m9 in arr2)
               {
                  arr99 = arr2[m9];
                  for(m29 in arr99)
                  {
                     arr90 = arr99[m29].AAHD.hurtRectArr;
                     for(n9 in arr90)
                     {
                        rect7 = arr90[n9];
                        bb = hit(rect7.x,rect7.y,rect7.width,rect7.height,x3,y3,w0,w0);
                        lnum++;
                        if(Boolean(bb))
                        {
                           p1 = new Point(x2 + cos0 * n,y2 + sin0 * n);
                           obj.point = p1;
                           obj.b0 = arr99[m29];
                           return obj;
                        }
                     }
                  }
               }
               n++;
            }
         }
         obj.point = p1;
         if(p1 is Point)
         {
            obj.b0 = arr2[num1][num2];
         }
         return obj;
      }
   }
}

