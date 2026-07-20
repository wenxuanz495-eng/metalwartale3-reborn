package gameAll.order
{
   import body.enemy.EnemyHeroBody;
   import bodyGroup.BodyGroup;
   import data.StringToDefine;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gameAll.level.extra.VipExtraLevel;
   
   public class EventOrderDefine
   {
      
      public var enabled:Boolean = true;
      
      public var fatherID:String = "";
      
      private var BG:BodyGroup;
      
      public var middlePoint:Point = new Point();
      
      public var unitArr:Array = [];
      
      public var pArr:Array = [];
      
      public var timeRange:Point;
      
      public var loopB:Boolean = false;
      
      public var orderArr:Array = [];
      
      public var orderIndex:int = 0;
      
      public var now_t:Number = 0;
      
      private var interval:Number = 0;
      
      private var totalNum:int = 0;
      
      private var fps:Number = 0.16666666666666666;
      
      private var have_t:int = 5;
      
      public function EventOrderDefine()
      {
         super();
         this.BG = Game.BG;
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var len0:int = 0;
         var m:int = 0;
         var m2:* = undefined;
         var loopStr:String = null;
         var unit:EventOrderUnit = null;
         var index00:int = 0;
         var p0:Point = null;
         var order2:Array = [];
         var units:* = xml0.unit;
         for(n in units)
         {
            unit = new EventOrderUnit();
            unit.inData_byXML(units[n]);
            order2.push(unit);
         }
         len0 = int(order2.length);
         for(m = 0; m < len0; m++)
         {
            index00 = int(Math.random() * order2.length);
            this.unitArr.push(order2[index00]);
            order2.splice(index00,1);
         }
         var pp:* = xml0.position;
         for(m2 in pp)
         {
            p0 = StringToDefine.getPoint(pp[m2]);
            this.pArr.push(p0);
         }
         this.timeRange = StringToDefine.getPoint(xml0.timeRange);
         loopStr = String(xml0.loopB);
         if(loopStr == "")
         {
            this.loopB = false;
         }
         else
         {
            this.loopB = true;
         }
      }
      
      public function init() : *
      {
         var n:* = undefined;
         var m:int = 0;
         var eo:EventOrder = null;
         var minU:EventOrderUnit = null;
         for(n in this.unitArr)
         {
            this.totalNum += this.unitArr[n].number;
         }
         this.interval = this.timeRange.length / this.totalNum;
         for(m = 0; m < this.totalNum; m++)
         {
            eo = new EventOrder();
            minU = this.getRateMin();
            ++minU.showNum;
            eo.inData_byOrder(minU);
            eo.position = this.pArr[int(Math.random() * this.pArr.length)];
            eo.time = this.timeRange.x + this.interval * m;
            this.orderArr.push(eo);
         }
         this.initAll();
      }
      
      private function getRateMin() : EventOrderUnit
      {
         var n:* = undefined;
         var eou:EventOrderUnit = null;
         var min:Number = 2;
         var minN:int = -1;
         for(n in this.unitArr)
         {
            eou = this.unitArr[n];
            if(eou.rate < min)
            {
               minN = n;
               min = eou.rate;
            }
         }
         return this.unitArr[minN];
      }
      
      public function initAll() : *
      {
         this.enabled = true;
         this.orderIndex = 0;
         this.now_t = 0;
         this.have_t = 5;
         this.fps = 1 / 6;
      }
      
      public function getEndB() : Boolean
      {
         return this.orderIndex > this.orderArr.length - 1;
      }
      
      public function stop() : *
      {
         this.orderIndex = this.orderArr.length;
         this.loopB = false;
      }
      
      public function pause() : *
      {
         this.enabled = false;
      }
      
      public function resume() : *
      {
         this.enabled = true;
      }
      
      public function noEnemyPan() : *
      {
         var num0:int = 0;
         if(this.orderIndex == 1)
         {
            this.gotoNextEnemyNum(5);
         }
         else if(this.orderIndex > 5)
         {
            if(!Game.LG.level.bossShowB)
            {
               if(this.have_t <= 0)
               {
                  this.have_t = 3;
                  num0 = this.BG.getHurtEnemyNum();
                  if(num0 <= 2)
                  {
                     this.gotoNextEnemyNum(8);
                     this.fps *= 2;
                  }
               }
               else
               {
                  --this.have_t;
               }
            }
         }
      }
      
      public function gotoNextEnemy() : *
      {
         this.gotoNextEnemyNum(1);
      }
      
      public function gotoNextEnemyNum(num0:int) : *
      {
         var xindex:int = this.orderIndex + num0;
         if(xindex > this.orderArr.length - 1)
         {
            xindex = this.orderArr.length - 1;
         }
         var eo:EventOrder = this.orderArr[xindex];
         if(this.now_t < eo.time)
         {
            this.now_t = eo.time;
         }
      }
      
      public function happen() : *
      {
         var eo:EventOrder = null;
         var str3:String = null;
         var str44:String = null;
         var str4:String = null;
         var strArr4:Array = null;
         if(this.enabled)
         {
            if(this.orderIndex <= this.orderArr.length - 1)
            {
               this.now_t += this.fps;
               this.noEnemyPan();
               eo = this.orderArr[this.orderIndex];
               if(eo.name == "地面自动炮台" || eo.name == "警报塔" || eo.name == "防御激光炮")
               {
                  ++this.orderIndex;
                  return;
               }
               if(eo.name.indexOf("提示：") >= 0)
               {
                  ++this.orderIndex;
                  str3 = eo.name.replace("提示：","");
                  Game.dialogboxGroup.showGameTip(str3);
                  return;
               }
               if(eo.name.indexOf("文字：") >= 0)
               {
                  ++this.orderIndex;
                  str44 = eo.name.replace("文字：","");
                  Game.dialogboxGroup.showGameTip(str44,5,true);
                  return;
               }
               if(eo.name.indexOf("指针：") >= 0)
               {
                  ++this.orderIndex;
                  str4 = eo.name.replace("指针：","");
                  strArr4 = str4.split(",");
                  Game.dialogboxGroup.showSkillTip(strArr4[0],new Point(int(strArr4[1]),int(strArr4[2])),Number(strArr4[3]));
                  return;
               }
               if(this.now_t >= eo.time)
               {
                  this.doOrder(eo);
                  ++this.orderIndex;
                  if(this.getEndB() && this.loopB)
                  {
                     this.initAll();
                  }
               }
            }
            else if(this.loopB)
            {
               this.initAll();
            }
         }
      }
      
      public function doOrder(eo:EventOrder) : *
      {
         var rect0:Rectangle = null;
         var rect1:Rectangle = null;
         var minX0:int = 0;
         var maxX0:int = 0;
         var b0:* = this.BG.getUnit(eo.name);
         if(b0 == null)
         {
            return;
         }
         b0.type = eo.type;
         b0.define.superNum = eo.superNum;
         b0.define.dialogue = eo.dialogue;
         b0.define.firstDialogue = eo.firstDialogue;
         b0.define.trueName = eo.trueName;
         if(eo.trueName != "")
         {
            if(b0 is EnemyHeroBody)
            {
               b0.define.name = eo.trueName;
            }
         }
         b0.define.eventOrderDefineGroupID = this.fatherID;
         var xx0:int = eo.position.x + Game.oneScene.getPositionMiddle().x;
         if(Game.LG.level is VipExtraLevel)
         {
            rect0 = Game.oneScene.moveRectArr2[0];
            rect1 = Game.oneScene.moveRectArr2[1];
            minX0 = 0;
            maxX0 = 0;
            if(Boolean(rect0))
            {
               minX0 = rect0.x + rect0.width + 1000;
            }
            else
            {
               minX0 = Game.oneScene.viewRangeRect2.x + 1000;
            }
            if(Boolean(rect1))
            {
               maxX0 = rect1.x - 1000;
            }
            else
            {
               maxX0 = Game.oneScene.viewRangeRect2.x + Game.oneScene.viewRangeRect2.width - 1000;
            }
            if(xx0 < minX0)
            {
               xx0 = minX0;
            }
            else if(xx0 > maxX0)
            {
               xx0 = maxX0;
            }
         }
         trace("-----------------xx0:" + xx0);
         b0.x = xx0;
         var ymin:int = Game.BGHit.getMinY(xx0) - 50;
         var pp0:Point = b0.define.airRange;
         if(pp0 is Point)
         {
            b0.y = eo.position.y + ymin + pp0.x + (pp0.y - pp0.x) * Math.random();
         }
         else
         {
            b0.y = eo.position.y + ymin;
         }
         if(b0.type == "boss")
         {
            b0.ai.attackBody(this.BG.hero);
         }
         else
         {
            b0.ai.attackBody(this.BG.heroCar_arr[int(this.BG.heroCar_arr.length * Math.random())]);
         }
         if(eo.life_0 > 0)
         {
            b0.define.fleshAll_by(eo.life_0,eo.exp_0,eo.coin_0,eo.hurt_0,true);
         }
         b0.define.dropItemsArr = eo.dropItemsArr;
         Game.eventGroup.bodyAdd(b0,eo.level);
      }
      
      public function doAllOrder() : *
      {
         var n:* = undefined;
         var eo:EventOrder = null;
         for(n in this.orderArr)
         {
            eo = this.orderArr[this.orderIndex];
            this.doOrder(eo);
         }
      }
   }
}

