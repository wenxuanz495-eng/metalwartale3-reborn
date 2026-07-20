package body.motion
{
   import flash.geom.Rectangle;
   
   public class BodyDofGroup
   {
      
      public var dof:Array = [new BodyDof(0),new BodyDof(1),new BodyDof(2),new BodyDof(3)];
      
      public function BodyDofGroup()
      {
         super();
      }
      
      public static function hitRect(BB:Rectangle, ZZ:Rectangle, in_type:int = 1, vx:Number = 0, vy:Number = 0) : Array
      {
         var cx:Number = NaN;
         var cy:Number = NaN;
         var dof0:Array = [new BodyDof(0),new BodyDof(1),new BodyDof(2),new BodyDof(3)];
         var JJ:Rectangle = BB.intersection(ZZ);
         if(!(JJ.width <= 1 && JJ.height <= 1))
         {
            cx = JJ.x + JJ.width / 2 - BB.x - BB.width / 2;
            cy = JJ.y + JJ.height / 2 - BB.y - BB.height / 2;
            if(JJ.width > JJ.height)
            {
               if(cy < 0)
               {
                  dof0[0].type = in_type;
                  dof0[0].back = JJ.height;
                  dof0[0].first = JJ.x - BB.x;
                  dof0[0].long = JJ.width;
               }
               else
               {
                  dof0[1].type = in_type;
                  dof0[1].back = JJ.height;
                  dof0[1].first = JJ.x - BB.x;
                  dof0[1].long = JJ.width;
                  dof0[1].vx = vx;
                  dof0[1].vy = vy;
               }
            }
            else if(JJ.width < JJ.height)
            {
               if(cx < 0)
               {
                  dof0[2].type = in_type;
                  dof0[2].back = JJ.width;
                  dof0[2].first = JJ.y - BB.y;
                  dof0[2].long = JJ.height;
               }
               else
               {
                  dof0[3].type = in_type;
                  dof0[3].back = JJ.width;
                  dof0[3].first = JJ.y - BB.y;
                  dof0[3].long = JJ.height;
               }
            }
         }
         return dof0;
      }
      
      public static function hitRect2(BB:Rectangle, ZZ:Rectangle, in_type1:int = 1, in_type2:int = 1) : Object
      {
         var cx:Number = NaN;
         var cy:Number = NaN;
         var dof0:Array = [new BodyDof(0),new BodyDof(1),new BodyDof(2),new BodyDof(3)];
         var dof1:Array = [new BodyDof(0),new BodyDof(1),new BodyDof(2),new BodyDof(3)];
         var JJ:Rectangle = BB.intersection(ZZ);
         if(!(JJ.width <= 1 && JJ.height <= 1))
         {
            cx = JJ.x + JJ.width / 2 - BB.x - BB.width / 2;
            cy = JJ.y + JJ.height / 2 - BB.y - BB.height / 2;
            if(JJ.width > JJ.height)
            {
               if(cy < 0)
               {
                  dof0[0].type = in_type2;
                  dof0[0].back = JJ.height;
                  dof0[0].first = JJ.x - BB.x;
                  dof0[0].long = JJ.width;
                  dof1[1].setDof(dof0[0]);
                  dof1[1].type = in_type1;
               }
               else
               {
                  dof0[1].type = in_type2;
                  dof0[1].back = JJ.height;
                  dof0[1].first = JJ.x - BB.x;
                  dof0[1].long = JJ.width;
                  dof1[0].setDof(dof0[1]);
                  dof1[0].type = in_type1;
               }
            }
            else if(JJ.width < JJ.height)
            {
               if(cx < 0)
               {
                  dof0[2].type = in_type2;
                  dof0[2].back = JJ.width;
                  dof0[2].first = JJ.y - BB.y;
                  dof0[2].long = JJ.height;
                  dof1[3].setDof(dof0[2]);
                  dof1[3].type = in_type1;
               }
               else
               {
                  dof0[3].type = in_type2;
                  dof0[3].back = JJ.width;
                  dof0[3].first = JJ.y - BB.y;
                  dof0[3].long = JJ.height;
                  dof1[2].setDof(dof0[3]);
                  dof1[2].type = in_type1;
               }
            }
         }
         var obj0:Object = new Object();
         obj0.BB = dof0;
         obj0.ZZ = dof1;
         return obj0;
      }
      
      public function initData() : *
      {
         var n:* = undefined;
         for(n in this.dof)
         {
            this.dof[n].init();
         }
      }
      
      public function setDataArr(xdof:Array) : *
      {
         var n:* = undefined;
         for(n in this.dof)
         {
            this.dof[n].setDof(xdof[n]);
         }
      }
      
      public function inDataArr(xdof:Array) : *
      {
         var n:* = undefined;
         for(n in this.dof)
         {
            this.dof[n].inDof(xdof[n]);
         }
      }
      
      public function setData(xdof:BodyDofGroup) : *
      {
         var n:* = undefined;
         for(n in xdof.dof)
         {
            this.dof[n].setDof(xdof.dof[n]);
         }
      }
      
      public function inData(xdof:BodyDofGroup) : *
      {
         var n:* = undefined;
         for(n in xdof.dof)
         {
            this.dof[n].inDof(xdof.dof[n]);
         }
      }
      
      public function hitRectInData(BB:Rectangle, ZZ:Rectangle) : *
      {
         this.inDataArr(hitRect(BB,ZZ));
      }
   }
}

