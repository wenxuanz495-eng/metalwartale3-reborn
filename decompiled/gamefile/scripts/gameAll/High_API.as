package gameAll
{
   import com.adobe.serialization.json.JSON2;
   import unit4399.events.RankListEvent;
   
   public class High_API
   {
      
      public var clearScoreB:Boolean = false;
      
      public var ID1:int = 160;
      
      private var submitScore_yesFun:Function = null;
      
      private var submitScore_noFun:Function = null;
      
      private var getRankLists_yesFun:Function = null;
      
      private var getRankLists_noFun:Function = null;
      
      private var getRankListByOwn_yesFun:Function = null;
      
      private var getRankListByOwn_noFun:Function = null;
      
      public function High_API()
      {
         super();
      }
      
      public function test(value0:int) : *
      {
         this.getRankListByOwn(142,Game.nowSaveIndex,10);
      }
      
      public function submitScoreToRankLists(rankInfoAry:Array, _yesFun:Function = null, _noFun:Function = null) : *
      {
         var n:* = undefined;
         if(Boolean(Game.serviceHold))
         {
            this.submitScore_yesFun = _yesFun;
            this.submitScore_noFun = _noFun;
            Game.testText.addTestText("submitScoreToRankLists===========================");
            for(n in rankInfoAry)
            {
               if(rankInfoAry[n].score < 0)
               {
                  rankInfoAry[n].score = 1;
               }
               else if(rankInfoAry[n].score > 2147483600)
               {
                  rankInfoAry[n].score = 1;
               }
            }
            Game.serviceHold.submitScoreToRankLists(Game.nowSaveIndex,rankInfoAry);
         }
         else if(_noFun is Function)
         {
            _noFun();
         }
      }
      
      public function submitScoreToRankListsSilent(rankInfoAry:Array) : void
      {
         var objCoin:Object = null;
         var objAchieve:Object = null;
         var objX:Object = null;
         var objY:Object = null;
         var objLevel:Object = null;
         rankInfoAry = [];
         if(Boolean(Game.serviceHold))
         {
            Game.testText.addTestText("submitSilentToRankLists===========================");
            objCoin = {};
            objCoin.rId = 691;
            objCoin.score = Game.gameData.GCoin;
            objAchieve = {};
            objAchieve.rId = 692;
            objAchieve.score = Game.gameData.allAchieve;
            objAchieve.extra = "军衔等级:" + Game.gameData.rankLevel + "所需功勋:" + Game.gameDefine.getAllAchieve(Game.gameData.rankLevel);
            objX = {};
            objX.rId = 693;
            objX.score = Game.gameData.materialsItems.getNumByBase("superalloy_X");
            objY = {};
            objY.rId = 694;
            objY.score = Game.gameData.materialsItems.getNumByBase("superalloy_Y");
            objLevel = {};
            objLevel.rId = 695;
            objLevel.score = Game.gameData.getNowLevelUnlock();
            objAchieve.extra = "当前难度:" + Game.gameData.nowDifficult;
            rankInfoAry.push(objCoin);
            rankInfoAry.push(objAchieve);
            rankInfoAry.push(objX);
            rankInfoAry.push(objY);
            rankInfoAry.push(objLevel);
            Game.serviceHold.submitScoreToRankLists(Game.nowSaveIndex,rankInfoAry);
         }
      }
      
      private function decodeSumitScoreInfo(dataAry:Array) : void
      {
         var i:* = undefined;
         var tmpObj:Object = null;
         var str:String = null;
         if(dataAry == null || dataAry.length == 0)
         {
            Game.testText.addTestText("没有数据,返回结果有问题！");
            if(this.submitScore_noFun is Function)
            {
               this.submitScore_noFun();
            }
            return;
         }
         for(i in dataAry)
         {
            tmpObj = dataAry[i];
            str = "第" + (i + 1) + "条数据。排行榜ID：" + tmpObj.rId + "，信息码值：" + tmpObj.code + "\n";
            if(tmpObj.code == "10000")
            {
               str += "当前排名:" + tmpObj.curRank + ",当前分数：" + tmpObj.curScore + ",上一局排名：" + tmpObj.lastRank + ",上一局分数：" + tmpObj.lastScore + "\n";
               if(this.submitScore_yesFun is Function)
               {
                  this.submitScore_yesFun(tmpObj);
               }
            }
            else
            {
               if(this.submitScore_noFun is Function)
               {
                  this.submitScore_noFun();
               }
               str += "该排行榜提交的分数出问题了。信息：" + tmpObj.message + "\n";
               Game.testText.addTestText(str);
            }
         }
      }
      
      public function getRankListByOwn(rankListId:uint, idx:uint, rankNum:uint, _yesFun:Function = null, _noFun:Function = null) : *
      {
         if(Boolean(Game.serviceHold))
         {
            this.getRankListByOwn_yesFun = _yesFun;
            this.getRankListByOwn_noFun = _noFun;
            Game.serviceHold.getRankListByOwn(rankListId,idx,rankNum);
         }
         else if(_noFun is Function)
         {
            _noFun();
         }
      }
      
      private function decodeRankListByOwnInfo(dataAry:Array) : void
      {
         var i:* = undefined;
         var tmpObj:Object = null;
         var str00:* = undefined;
         var str:String = null;
         if(dataAry == null || dataAry.length == 0)
         {
            if(this.getRankListByOwn_yesFun is Function)
            {
               this.getRankListByOwn_yesFun([]);
            }
            return;
         }
         if(this.getRankListByOwn_yesFun is Function)
         {
            this.getRankListByOwn_yesFun(dataAry);
         }
         for(i in dataAry)
         {
            tmpObj = dataAry[i];
            str00 = JSON2.decode(String(tmpObj.extra));
            if(Boolean(str00.hasOwnProperty("subArr")))
            {
               str00 = String(str00.subArr);
            }
            str = "第" + (i + 1) + "条数据。存档索引：" + tmpObj.index + ",用户id:" + tmpObj.uId + ",用户名：" + tmpObj.userName + ",分数：" + tmpObj.score + ",排名：" + tmpObj.rank + ",来自：" + tmpObj.area + ",\n扩展信息：" + tmpObj.extra + "\n" + "extra：" + str00;
         }
      }
      
      public function getRankListsData(rankListId:uint, pageSize:uint, pageNum:uint, _yesFun:Function = null, _noFun:Function = null) : *
      {
         if(Boolean(Game.serviceHold))
         {
            this.getRankLists_yesFun = _yesFun;
            this.getRankLists_noFun = _noFun;
            Game.serviceHold.getRankListsData(rankListId,pageSize,pageNum);
         }
         else if(_noFun is Function)
         {
            _noFun();
         }
      }
      
      private function decodeRankListInfo(dataAry:Array) : void
      {
         var i:* = undefined;
         var tmpObj:Object = null;
         var str00:* = undefined;
         var str:String = null;
         if(dataAry == null || dataAry.length == 0)
         {
            if(this.getRankLists_yesFun is Function)
            {
               this.getRankLists_yesFun([]);
            }
            return;
         }
         if(this.getRankLists_yesFun is Function)
         {
            this.getRankLists_yesFun(dataAry);
         }
         for(i in dataAry)
         {
            tmpObj = dataAry[i];
            if(String(tmpObj.extra).indexOf("{") >= 0)
            {
               str00 = JSON2.decode(String(tmpObj.extra));
               if(Boolean(str00.hasOwnProperty("subArr")))
               {
                  str00 = String(str00.subArr);
               }
               str = "第" + (i + 1) + "条数据。存档索引：" + tmpObj.index + ",用户id:" + tmpObj.uId + ",用户名：" + tmpObj.userName + ",分数：" + tmpObj.score + ",排名：" + tmpObj.rank + ",来自：" + tmpObj.area + ",\n扩展信息：" + tmpObj.extra + "\n" + "extra：" + str00;
            }
         }
      }
      
      public function onRankListErrorHandler(evt:RankListEvent) : void
      {
         var obj:Object = evt.data;
         var str:String = "apiFlag:" + obj.apiName + "   errorCode:" + obj.code + "   message:" + obj.message;
         switch(obj.apiName)
         {
            case "2":
               if(this.getRankListByOwn_noFun is Function)
               {
                  this.getRankListByOwn_noFun();
               }
               break;
            case "4":
               if(this.getRankLists_noFun is Function)
               {
                  this.getRankLists_noFun();
               }
               break;
            case "3":
               if(this.submitScore_noFun is Function)
               {
                  this.submitScore_noFun();
               }
         }
      }
      
      public function onRankListSuccessHandler(evt:RankListEvent) : void
      {
         var obj:Object = evt.data;
         var data:* = obj.data;
         switch(obj.apiName)
         {
            case "1":
            case "2":
               this.decodeRankListByOwnInfo(data);
               break;
            case "4":
               this.decodeRankListInfo(data);
               break;
            case "3":
               this.decodeSumitScoreInfo(data);
               break;
            case "5":
               this.decodeUserData(data);
         }
      }
      
      private function decodeUserData(dataObj:Object) : void
      {
         if(dataObj == null)
         {
            return;
         }
         var str:String = "存档索引：" + dataObj.index + "\n标题:" + dataObj.title + "\n数据：" + dataObj.data + "\n存档时间：" + dataObj.datetime + "\n";
      }
   }
}

