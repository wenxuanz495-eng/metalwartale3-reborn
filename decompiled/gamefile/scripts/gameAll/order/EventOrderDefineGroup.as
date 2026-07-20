package gameAll.order
{
   import flash.geom.Point;
   import gameAll.other.IDArea;
   
   public class EventOrderDefineGroup
   {
      
      public var index:int = 0;
      
      public var id:String = "";
      
      public var lockWidth:int = 600;
      
      public var lockWidth2:int = 600;
      
      public var order:Array = [];
      
      public var orderIndex:int = 0;
      
      public var enabled:Boolean = false;
      
      public function EventOrderDefineGroup()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var or:EventOrderDefine = null;
         this.index = int(xml0.@index);
         this.id = String(xml0.@id);
         this.lockWidth = int(xml0.@lockWidth);
         this.lockWidth2 = int(xml0.@lockWidth2);
         if(this.lockWidth == 0)
         {
            this.lockWidth = 600;
         }
         var order2:Array = [];
         var orders:* = xml0.order;
         for(n in orders)
         {
            or = new EventOrderDefine();
            or.inData_byXML(orders[n]);
            or.fatherID = this.id;
            or.init();
            this.order.push(or);
         }
         this.initAll();
      }
      
      public function inMiddlePoint(x0:Number, y0:Number) : *
      {
         var n:* = undefined;
         var or:EventOrderDefine = null;
         for(n in this.order)
         {
            or = this.order[n];
            or.middlePoint.x = x0;
            or.middlePoint.y = y0;
         }
      }
      
      public function getNow() : EventOrderDefine
      {
         if(this.order.length > 0)
         {
            return this.order[this.orderIndex];
         }
         return null;
      }
      
      public function initAll() : *
      {
         var n:* = undefined;
         var order0:EventOrderDefine = null;
         this.orderIndex = 0;
         for(n in this.order)
         {
            order0 = this.order[n];
            order0.initAll();
         }
      }
      
      public function killLoop() : *
      {
         var n:* = undefined;
         var order0:EventOrderDefine = null;
         for(n in this.order)
         {
            order0 = this.order[n];
            order0.stop();
         }
      }
      
      public function pause() : *
      {
         var eo:EventOrderDefine = this.getNow();
         if(eo != null)
         {
            eo.pause();
            trace("发兵暂停！！！：" + eo.fatherID);
         }
      }
      
      public function resume() : *
      {
         var eo:EventOrderDefine = this.getNow();
         if(eo != null)
         {
            eo.resume();
            trace("发兵继续-----：" + eo.fatherID);
         }
      }
      
      public function gotoNextEnemy() : *
      {
         var eo:EventOrderDefine = this.getNow();
         if(eo != null)
         {
            eo.gotoNextEnemy();
         }
      }
      
      public function doAllOrder() : *
      {
         var n:* = undefined;
         var order0:EventOrderDefine = null;
         for(n in this.order)
         {
            order0 = this.order[n];
            order0.doAllOrder();
         }
      }
      
      public function addRegularUnit(ar0:IDArea) : *
      {
         var n:* = undefined;
         var or:EventOrderDefine = null;
         var p0:Point = null;
         var m:* = undefined;
         var eo:EventOrderUnit = null;
         var i:int = 0;
         var ranX:int = 0;
         var b0:* = undefined;
         var parr:Array = [500,300,400,200,100];
         for(n in this.order)
         {
            or = this.order[n];
            trace("order.orderArr:" + or.orderArr.length);
            p0 = ar0.point;
            for(m in or.unitArr)
            {
               eo = or.unitArr[m];
               if(eo.name == "地面自动炮台" || eo.name == "警报塔" || eo.name == "防御激光炮")
               {
                  while(i < eo.number)
                  {
                     ranX = p0.x + parr[i % parr.length] + (0.5 * Math.random() - 1) * 160;
                     b0 = Game.BG.getUnit(eo.name);
                     b0.x = ranX;
                     b0.y = Game.BGHit.getMinY(ranX) - 20;
                     Game.eventGroup.bodyAdd(b0,eo.level);
                     i++;
                  }
               }
            }
         }
      }
      
      public function happen() : *
      {
         var order0:EventOrderDefine = null;
         if(this.enabled)
         {
            if(this.orderIndex <= this.order.length - 1)
            {
               order0 = this.order[this.orderIndex];
               if(!order0.getEndB())
               {
                  order0.happen();
               }
               else
               {
                  ++this.orderIndex;
               }
            }
            else
            {
               this.enabled = false;
            }
         }
      }
   }
}

