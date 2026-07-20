package gameAll
{
   import gameAll.define.OneTaskDefine;
   import gameAll.level.LevelsDefine;
   
   public class TaskCreater
   {
      
      public var taskArr:Array = [];
      
      public function TaskCreater()
      {
         super();
      }
      
      public function fleshList() : *
      {
         var n:* = undefined;
         var td0:OneTaskDefine = null;
         var level0:LevelsDefine = null;
         this.taskArr.length = 0;
         var heroLevel0:int = Game.gameData.level;
         trace("根据人物等级刷新5个任务======================:");
         var arr0:Array = Game.LG.filter.getLevelArr_byLessLv(heroLevel0 + 1,5);
         for(n in arr0)
         {
            td0 = new OneTaskDefine();
            level0 = arr0[n];
            td0.enemyName = "电锯机器人";
            td0.levelName = level0.name;
            td0.targetDiff = 0;
            td0.targetLevel = level0.getNowLevelIndex();
            td0.taskLevel = level0.enemyLv;
            td0.maxNum = 80;
            if(Math.random() >= 0.95)
            {
               td0.starLevel = 1;
            }
            td0.fleshAllGift();
            td0.index = n;
            this.taskArr.push(td0);
         }
      }
      
      public function getTaskArrCopy() : Array
      {
         var n:* = undefined;
         var td0:OneTaskDefine = null;
         var arr0:Array = [];
         for(n in this.taskArr)
         {
            td0 = this.taskArr[n];
            arr0.push(td0.copy());
         }
         return arr0;
      }
      
      private function getEnemyList(xml0:*) : Array
      {
         var n:* = undefined;
         var oneEvent:* = undefined;
         var order0:* = undefined;
         var m:* = undefined;
         var i:* = undefined;
         var unit0:* = undefined;
         var name0:String = null;
         var arr0:Array = [];
         for(n in xml0)
         {
            oneEvent = xml0[n];
            if(String(oneEvent.@id).indexOf("enemy") >= 0)
            {
               order0 = oneEvent.order;
               for(m in order0)
               {
                  for(i in order0[m].unit)
                  {
                     unit0 = order0[m].unit[i];
                     name0 = String(unit0);
                     if(String(unit0.@type) == "" && name0.indexOf("提示") == -1 && name0.indexOf("自爆蜘蛛机") == -1 && name0.indexOf("巨型压路机") == -1 && name0.indexOf("指针") == -1 && arr0.indexOf(name0) == -1)
                     {
                        arr0.push(name0);
                     }
                  }
               }
            }
         }
         return arr0;
      }
   }
}

