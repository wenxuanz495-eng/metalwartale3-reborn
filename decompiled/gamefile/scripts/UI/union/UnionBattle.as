package UI.union
{
   import UI.change.CarItemsTip;
   import UI.dialog.ItemsTipbox;
   import com.adobe.serialization.json.JSON2;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import items.ItemsDefine;
   
   public class UnionBattle
   {
      
      private const UnionFightCountiD:int = 0;
      
      private const CITYTASKID:Array = [0,22,23,24,25,26];
      
      private const RANKID:int = 921;
      
      private const UNIONCANFIGHT:int = 30;
      
      private const CITYVARID:Array = [this.UNIONCANFIGHT,31,32,33,34,35];
      
      private var CITYARR:Array = [null,new CCityData(1,"北美",3,"未占领",-1,0,["props,GCoin_card_4,3","props,achieve_card_3,6","props,justice_badge,60","props,justice2_badge,30","materials,superalloy_X,300","props,superalloyStone,10"]),new CCityData(2,"欧洲",4,"未占领",-1,0,["props,GCoin_card_4,4","props,achieve_card_3,8","props,justice_badge,80","props,justice2_badge,40","materials,superalloy_X,400","props,superalloyStone,10"]),new CCityData(3,"亚洲",5,"未占领",-1,0,["props,GCoin_card_4,8","props,achieve_card_3,10","props,justice_badge,100","props,justice2_badge,50","materials,superalloy_X,500","props,superalloyStone,20"]),new CCityData(4,"南美",2,"未占领",-1,0,["props,GCoin_card_4,2","props,achieve_card_3,4","props,justice_badge,40","props,justice2_badge,20","materials,superalloy_X,200","props,superalloyStone,5"]),new CCityData(5,"非洲",1,"未占领",-1,0,["props,GCoin_card_4,1","props,achieve_card_3,2","props,justice_badge,20","props,justice2_badge,10","materials,superalloy_X,100","props,superalloyStone,5"])];
      
      private var _cityId:int = 1;
      
      private var _isGetRanked:Boolean = false;
      
      private var _unionFightNum:int = 0;
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      private var tip_mc:CarItemsTip = null;
      
      private var tipBox:ItemsTipbox = null;
      
      public function UnionBattle(mc0:UnionUI, mc1:MovieClip, mc3:CarItemsTip, mc4:ItemsTipbox)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
         this.tip_mc = mc3;
         this.tipBox = mc4;
      }
      
      public function Init() : void
      {
         var i:int;
         var jumfun:Function = function():void
         {
            father.InitBox(1);
         };
         if(!this.father.IsHasUnion && !Game.getTest())
         {
            Game.uiGroup.checkTip.showCheck2("您还没有加入任何公会,请先加入公会!",2,jumfun);
            return;
         }
         this.mc_box.gotoAndStop(6);
         this.mc_box["btn_getPrize"].alpha = 0.3;
         this.mc_box["btn_getPrize"].mouseEnabled = false;
         this.mc_box["btn_fight"].addEventListener(MouseEvent.CLICK,this.onClick);
         this.mc_box["btn_getPrize"].addEventListener(MouseEvent.CLICK,this.onClick);
         this.mc_box.mc_help.addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
         this.mc_box.mc_help.addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
         for(i = 1; i < 6; i++)
         {
            this.mc_box["btn_city_" + i].gotoAndStop(1);
            this.mc_box["btn_city_" + i].buttonMode = true;
            this.mc_box["btn_city_" + i].addEventListener(MouseEvent.CLICK,this.onClick);
         }
         this.setCurrentCity();
         Game.high_api.getRankListsData(this.RANKID,10,1,this.getRankOver);
         Game.union_api.getVariables(Game.nowSaveIndex,this.CITYVARID,this.getVarOver);
      }
      
      private function getIdByIndex(id:int, arr:Array) : int
      {
         for(var i:int = 0; i < arr.length; i++)
         {
            if(arr[i] == id)
            {
               return i;
            }
         }
         return -1;
      }
      
      private function getVarOver(dataAry:Array) : void
      {
         var tmpObj:Object = null;
         var locid:int = 0;
         var ccd:CCityData = null;
         if(dataAry == null || dataAry.lengthdddd == 0)
         {
            return;
         }
         for(var j:int = 0; j < dataAry.length; j++)
         {
            tmpObj = dataAry[j];
            if(tmpObj != null)
            {
               locid = this.getIdByIndex(tmpObj.id,this.CITYVARID);
               ccd = this.CITYARR[locid];
               if(locid == 0)
               {
                  this._unionFightNum = tmpObj.value;
               }
               if(Boolean(ccd))
               {
                  ccd.Score = tmpObj.value;
               }
            }
         }
         this.setCurrentCity();
      }
      
      private function getVarOver2(dataAry:Array) : void
      {
         var tmpObj:Object = null;
         var locid:int = 0;
         var ccd:CCityData = null;
         var ntime:Number = NaN;
         var obj:Object = null;
         if(dataAry == null || dataAry.length == 0)
         {
            return;
         }
         for(var j:int = 0; j < dataAry.length; j++)
         {
            tmpObj = dataAry[j];
            locid = this.getIdByIndex(tmpObj.id,this.CITYVARID);
            ccd = this.CITYARR[locid];
            if(!(ccd == null && locid == 0))
            {
               ccd.Score = tmpObj.value;
               if(Boolean(locid == this._cityId && ccd.Score <= 0 && this._unionFightNum > 0) && Boolean(ccd) && ccd.UnionId < 0)
               {
                  ntime = new Date().time;
                  ccd.Score = 0;
                  trace("被占领");
                  obj = {};
                  obj.rId = this.RANKID;
                  obj.score = this._cityId;
                  obj.extra = JSON2.encode({
                     "UnionName":this.father.MyUnionName,
                     "UnionId":this.father.MyUnionID,
                     "FightFlag":ntime
                  });
                  ccd.UnionId = this.father.MyUnionID;
                  ccd.UnionName = this.father.MyUnionName;
                  ccd.FightFlag = ntime;
                  Game.high_api.submitScoreToRankLists([obj],null,null);
               }
            }
         }
      }
      
      private function getRankOver2(dataAry:Array) : void
      {
         var tmpObj:Object = null;
         var unionObj:Object = null;
         var isgeted:Boolean = false;
         var cd:CCityData = this.CITYARR[this._cityId];
         for(var j:int = 0; j < dataAry.length; j++)
         {
            tmpObj = dataAry[j];
            unionObj = JSON2.decode(tmpObj.extra);
            if(tmpObj.score == cd.Id)
            {
               cd.UnionName = unionObj.UnionName;
               cd.UnionId = unionObj.UnionId;
               cd.FightFlag = unionObj.FightFlag;
               if(this.father.MyUnionID == cd.UnionId)
               {
                  isgeted = Game.gameData.giftData.GetUnionFightGeted(cd.FightFlag + "");
                  cd.CanPrize = !isgeted;
               }
               return;
            }
         }
         this.setCurrentCity();
         Game.union_api.getVariables(Game.nowSaveIndex,this.CITYVARID,this.getVarOver2);
      }
      
      private function dovarover(istrue:Boolean) : void
      {
         Game.high_api.getRankListsData(this.RANKID,10,1,this.getRankOver2);
      }
      
      public function FisCityFight() : void
      {
         if(Game.gameData.isZuobi)
         {
            return;
         }
         var id:int = int(this.CITYTASKID[this._cityId]);
         var ccd:CCityData = this.CITYARR[this._cityId];
         Game.gameData.giftData.AddUnionCityFightId(id);
         Game.union_api.doVariable(Game.nowSaveIndex,this.CITYVARID[0]);
         Game.union_api.doVariable(Game.nowSaveIndex,this.CITYVARID[this._cityId],this.dovarover);
      }
      
      private function getRankOver(dataAry:Array) : void
      {
         var cd:CCityData = null;
         var j:int = 0;
         var tmpObj:Object = null;
         var unionObj:Object = null;
         var isgeted:Boolean = false;
         (this.CITYARR[1] as CCityData).UnionId = -1;
         (this.CITYARR[1] as CCityData).UnionName = "未占领";
         (this.CITYARR[2] as CCityData).UnionId = -1;
         (this.CITYARR[2] as CCityData).UnionName = "未占领";
         (this.CITYARR[3] as CCityData).UnionId = -1;
         (this.CITYARR[3] as CCityData).UnionName = "未占领";
         (this.CITYARR[4] as CCityData).UnionId = -1;
         (this.CITYARR[4] as CCityData).UnionName = "未占领";
         (this.CITYARR[5] as CCityData).UnionId = -1;
         (this.CITYARR[5] as CCityData).UnionName = "未占领";
         if(dataAry == null || dataAry.length == 0)
         {
            return;
         }
         for(var i:int = 1; i < this.CITYARR.length; i++)
         {
            cd = this.CITYARR[i];
            for(j = 0; j < dataAry.length; j++)
            {
               tmpObj = dataAry[j];
               unionObj = JSON2.decode(tmpObj.extra);
               if(tmpObj.score == cd.Id)
               {
                  cd.UnionName = unionObj.UnionName;
                  cd.UnionId = unionObj.UnionId;
                  cd.FightFlag = unionObj.FightFlag;
                  if(this.father.MyUnionID == cd.UnionId)
                  {
                     isgeted = Game.gameData.giftData.GetUnionFightGeted(cd.FightFlag + "");
                     cd.CanPrize = !isgeted;
                  }
               }
            }
         }
         this.setCurrentCity();
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var citydat:CCityData = null;
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         if(name.indexOf("btn_city_") >= 0)
         {
            for(i = 1; i < 6; i++)
            {
               this.mc_box["btn_city_" + i].gotoAndStop(1);
            }
            this._cityId = int(name.split("_")[2]);
            this.setCurrentCity();
            return;
         }
         switch(name)
         {
            case "btn_fight":
               citydat = this.CITYARR[this._cityId];
               Game.eventGroup.chosenLevel(citydat.LevelId,"union");
               break;
            case "btn_getPrize":
               citydat = this.CITYARR[this._cityId];
               Game.gameData.giftData.AddUnionFightPrize(citydat.FightFlag + "");
               Game.uiGroup.addGift_byArr(citydat.PrizeArr,false,1,true);
               citydat.CanPrize = false;
               Game.uiGroup.saveDataNoUI();
               this.Init();
         }
      }
      
      private function setIconAndText(iconStr:String, txtStr:String, arr:Array) : void
      {
         var prizestr:String = null;
         var prizeID:String = null;
         var itemdefine:ItemsDefine = null;
         for(var i:int = 0; i < 6; i++)
         {
            (this.mc_box[txtStr + (i + 1)] as TextField).text = "";
            this.addIcon(this.mc_box[iconStr + (i + 1)],"");
            if(Boolean(arr) && Boolean(arr[i]))
            {
               prizestr = arr[i];
               prizeID = prizestr.split(",")[1];
               itemdefine = Game.itemsDefineGroup.getDefine(prizeID);
               this.addIcon(this.mc_box[iconStr + (i + 1)],itemdefine.imgLabel);
               (this.mc_box[txtStr + (i + 1)] as TextField).text = prizestr.split(",")[2];
               this.mc_box[iconStr + (i + 1)]["edata"] = itemdefine;
               this.mc_box[iconStr + (i + 1)].addEventListener(MouseEvent.MOUSE_OVER,this.onItemOver);
               this.mc_box[iconStr + (i + 1)].addEventListener(MouseEvent.MOUSE_OUT,this.onItemOut);
            }
         }
      }
      
      private function addIcon(mccontains:DisplayObjectContainer, imgLabel:String) : void
      {
         var bit:Bitmap = null;
         if(mccontains == null)
         {
            return;
         }
         while(mccontains.numChildren > 0)
         {
            mccontains.removeChildAt(0);
         }
         if(imgLabel == "")
         {
            return;
         }
         var temp:* = Game.swfLoaderManager.getResource("",imgLabel);
         if(temp == null)
         {
            return;
         }
         var mc:MovieClip = null;
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         mccontains.addChild(mc);
      }
      
      private function setCurrentCity() : void
      {
         var uf:int = 0;
         var sc:int = 0;
         var citydat:CCityData = this.CITYARR[this._cityId];
         var taskid:int = int(this.CITYTASKID[this._cityId]);
         if(citydat == null)
         {
            return;
         }
         if(this.mc_box.currentFrame != 6)
         {
            return;
         }
         this.mc_box["txt_name"].text = citydat.Name;
         this.mc_box["btn_city_" + this._cityId].gotoAndStop(2);
         if(citydat.UnionId < 0)
         {
            uf = this._unionFightNum;
            sc = citydat.Score;
            if(uf < 0)
            {
               uf = 0;
            }
            if(sc < 0)
            {
               sc = 0;
            }
            this.mc_box["txt_unionnum"].text = "" + uf;
            this.mc_box["txt_unionname"].text = "未占领";
            this.mc_box["txt_score"].text = "还剩" + sc + "次攻下该战区";
         }
         else
         {
            this.mc_box["txt_unionnum"].text = "0";
            this.mc_box["txt_unionname"].text = citydat.UnionName;
            this.mc_box["txt_score"].text = "被" + citydat.UnionName + "公会占领";
         }
         var fighted:Boolean = false;
         var hascount:int = 1 - Game.gameData.giftData.GetUnionCityFightID(taskid);
         if(hascount < 0)
         {
            hascount = 0;
         }
         if(citydat.UnionId < 0 && hascount > 0 && this._unionFightNum > 0)
         {
            this.mc_box["btn_fight"].alpha = 1;
            this.mc_box["btn_fight"].mouseEnabled = true;
         }
         else
         {
            this.mc_box["btn_fight"].alpha = 0.3;
            if(!Game.getTest())
            {
               this.mc_box["btn_fight"].mouseEnabled = false;
            }
         }
         if(citydat.CanPrize)
         {
            this.mc_box["btn_getPrize"].alpha = 1;
            this.mc_box["btn_getPrize"].mouseEnabled = true;
         }
         else
         {
            this.mc_box["btn_getPrize"].alpha = 0.3;
            this.mc_box["btn_getPrize"].mouseEnabled = false;
         }
         this.mc_box["txt_num"].text = hascount + "";
         this.setIconAndText("mc_icon2_","txt_icon2_",this.CITYARR[this._cityId].PrizeArr);
      }
      
      protected function onItemOver(event:MouseEvent) : void
      {
         var mc:MovieClip = event.currentTarget as MovieClip;
         if(mc.name == "mc_help")
         {
            this.tip_mc.title_txt.text = "玩法说明";
            this.tip_mc.txt.text = "1、 点击战区挑战战区守卫者，成功击败守卫者后可以为公会增加1点对应战区积分\n" + "2、 玩家每天可以向所有战区发动攻击；同一个战区，玩家每天只能成功攻击1次，多次成功攻击公会积分不会增加\n" + "3、 第一个积分到达60分的公会就可以占领这个战区\n" + "4、 每个公会每天可以在所有战区获得的积分总和上限是50分\n" + "5、 战区的占领状态会在7天后重置\n" + "6、 公会在对应战区的积分会在7天后重置\n" + "7、 在挑战战区守卫者时死亡无法使用复活石\n" + "8、 新加入公会的玩家24小时才能在公会战中改变积分\n" + "9、 涉嫌修改的玩家无法改变公会积分";
            this.tipBox.showDialog(this.tip_mc,event.currentTarget,event.currentTarget.x,event.currentTarget.y);
            return;
         }
         if(mc == null || mc.edata == null)
         {
            return;
         }
         var ed:ItemsDefine = mc["edata"];
         if(ed == null)
         {
            return;
         }
         this.tip_mc.title_txt.text = ed.cnName;
         this.tip_mc.txt.htmlText = ed.description;
         this.tipBox.showDialog(this.tip_mc,event.currentTarget,event.currentTarget.x,event.currentTarget.y);
      }
      
      public function onItemOut(event:*) : *
      {
         this.tipBox.hide();
      }
      
      public function Release() : void
      {
      }
   }
}

class CCityData
{
   
   public var Id:int = 0;
   
   public var Name:String = "";
   
   public var UnionName:String = "";
   
   public var UnionId:int = -1;
   
   public var Score:int = 0;
   
   public var CanPrize:Boolean = false;
   
   public var PrizeArr:Array = null;
   
   public var FightFlag:Number = 0;
   
   public var LevelId:int = 1;
   
   public function CCityData(id:int, name:String, levelid:int, unionname:String, unionid:int, score:int, prizearr:Array)
   {
      super();
      this.Id = id;
      this.LevelId = levelid;
      this.Name = name;
      this.UnionName = unionname;
      this.UnionId = unionid;
      this.Score = score;
      this.PrizeArr = prizearr;
   }
}
