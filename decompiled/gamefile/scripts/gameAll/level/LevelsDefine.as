package gameAll.level
{
   import data.StringToDefine;
   import flash.geom.Point;
   import gameAll.order.EventOrderDefineGroup;
   import gameAll.order.StoryOrderDefineGroup;
   import gameAll.other.IDArea;
   import other.FunGroup;
   
   public class LevelsDefine extends FunGroup
   {
      
      public var xml:*;
      
      public var id:String = "";
      
      public var index:int = 0;
      
      public var name:String = "";
      
      public var packId:String = "p1";
      
      public var packName:String = "";
      
      public var musicLabel:String = "";
      
      public var father:String = "";
      
      public var sceneID:String = "";
      
      public var enemyLife_ra:Number = 1;
      
      public var enemyHurt_ra:Number = 1;
      
      public var enemyExp_ra:Number = 1;
      
      public var enemyCoin_ra:Number = 1;
      
      public var bornPoint:Point = new Point();
      
      public var exitPoint:Point = new Point();
      
      public var area:Array = [];
      
      public var eventOrder:Array = [];
      
      public var enemyNameArr:Array = [];
      
      public var enemyCnNameArr:Array = [];
      
      public var limitTime:Number = 0;
      
      public var timeOverOrder:String = "fail";
      
      public var timingText:String = "限时闯关@time";
      
      public var timeOverText:String = "时间到！闯关失败！";
      
      public var bossLifeArr:Array = [];
      
      public var bossAttackTurn:Array = [];
      
      public var bossAttackHurt:Array = [];
      
      public var levelsLevel:Array = [];
      
      public var enemyLv:int = 0;
      
      public var storyOrder:StoryOrderDefineGroup = new StoryOrderDefineGroup();
      
      public function LevelsDefine()
      {
         super();
      }
      
      public function getNowLevelIndex() : int
      {
         var arr0:Array = this.id.split("-");
         var arr2:Array = Game.gameData.changeToNewLevel((arr0[1] - 1) * 4,this.index);
         return arr2[1];
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var fstr:String = null;
         var f0:int = 0;
         var tt2:String = null;
         var tt3:String = null;
         var bx0:* = undefined;
         this.xml = xml0;
         this.id = String(xml0.@id);
         this.index = int(this.id.split("-")[2]);
         this.name = String(xml0.child("name"));
         this.father = xml0.father;
         this.sceneID = xml0.scene;
         this.musicLabel = String(xml0.loopMusic);
         if(this.musicLabel == "")
         {
            this.musicLabel = "enemy_coming2";
         }
         this.bornPoint = StringToDefine.getPoint(xml0.bornPoint);
         if(Game.gameDefine.gameLevelTest == 0)
         {
            this.exitPoint = StringToDefine.getPoint(xml0.exitPoint);
         }
         else
         {
            this.exitPoint = new Point(this.bornPoint.x + 400,this.bornPoint.y);
         }
         if(xml0.enemyLife_ra.length() > 0)
         {
            this.enemyLife_ra = Number(xml0.enemyLife_ra);
         }
         if(xml0.enemyExp_ra.length() > 0)
         {
            this.enemyExp_ra = Number(xml0.enemyExp_ra);
         }
         if(xml0.enemyHurt_ra.length() > 0)
         {
            this.enemyHurt_ra = Number(xml0.enemyHurt_ra);
         }
         if(xml0.enemyCoin_ra.length() > 0)
         {
            this.enemyCoin_ra = Number(xml0.enemyCoin_ra);
         }
         this.enemyNameArr.length = 0;
         var xmlStr:String = xml0.toString();
         var nameArr:Array = Game.defineGroup.enemyNameList;
         for(n in nameArr)
         {
            fstr = nameArr[n][0];
            f0 = xmlStr.indexOf(">" + fstr + "<");
            if(f0 >= 0)
            {
               this.enemyCnNameArr.push(nameArr[n][0]);
               this.enemyNameArr.push(nameArr[n][1]);
            }
         }
         if(xml0.limitTime.length() > 0)
         {
            this.limitTime = Number(xml0.limitTime.@time) * 60;
            this.timeOverOrder = String(xml0.limitTime.@overOrder);
            tt2 = String(xml0.limitTime.@timingText);
            tt3 = String(xml0.limitTime.@overText);
            if(tt2 != "")
            {
               this.timingText = tt2;
            }
            if(tt3 != "")
            {
               this.timeOverText = tt3;
            }
         }
         if(xml0.boss.length() > 0)
         {
            bx0 = xml0.boss;
            if(bx0.life.length() > 0)
            {
               this.bossLifeArr = String(bx0.life).split(",");
            }
            if(bx0.attackTurn.length() > 0)
            {
               this.bossAttackTurn = String(bx0.attackTurn).split(",");
            }
            if(bx0.attackHurt.length() > 0)
            {
               this.bossAttackHurt = String(bx0.attackHurt).split(",");
            }
         }
         this.enemyLv = int(xml0.enemyLv) - 1;
         if(xml0.enemyLv.length() > 1)
         {
            throw new Error("level.xml里关卡“" + this.name + "”的enemyLv参数不能超过1个。");
         }
         if(xml0.enemyLv.length() == 0)
         {
            if(this.id.indexOf("1-") == 0 && this.id.indexOf("999") == -1)
            {
               throw new Error("level.xml里关卡“" + this.name + "”没有enemyLv参数。");
            }
         }
      }
      
      public function reloadXML() : *
      {
         this.inData_byXML(this.xml);
      }
      
      public function inAreaData(xml0:XML) : *
      {
         var n:* = undefined;
         var area1:IDArea = null;
         var e_arr:* = undefined;
         var m:* = undefined;
         var area0:IDArea = null;
         var eo:EventOrderDefineGroup = null;
         this.area.length = 0;
         this.eventOrder.length = 0;
         var area_arr:* = xml0.area;
         for(n in area_arr)
         {
            area0 = new IDArea();
            area0.inData_byString(area_arr[n]);
            area0.id = area_arr[n].@id;
            this.area.push(area0);
         }
         area1 = new IDArea();
         area1.id = "exit";
         area1.x = this.exitPoint.x - 130;
         area1.y = this.exitPoint.y - 1080;
         area1.width = 260;
         area1.height = 2600;
         this.area.push(area1);
         e_arr = xml0.oneEvent;
         for(m in e_arr)
         {
            eo = new EventOrderDefineGroup();
            eo.inData_byXML(e_arr[m]);
            this.eventOrder.push(eo);
         }
         this.storyOrder.inData_byXML(xml0);
      }
   }
}

