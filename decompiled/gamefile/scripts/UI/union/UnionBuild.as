package UI.union
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class UnionBuild
   {
      
      private var _buildId:int = 0;
      
      private const OPNELEVEL:int = 3;
      
      private const BUILDVARID:Array = [36];
      
      private var father:UnionUI = null;
      
      private var mc_box:MovieClip = null;
      
      private var BUILDARR:Array = null;
      
      public function UnionBuild(mc0:UnionUI, mc1:MovieClip, mc_tech:MovieClip)
      {
         super();
         this.father = mc0;
         this.mc_box = mc1;
         this.BUILDARR = [new CBuildData(this.BUILDVARID[0],"科技院",new UnionBuild_Tech(mc0,this,mc_tech))];
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
         if(this.father.UnionLevel < this.OPNELEVEL && !Game.getTest())
         {
            Game.uiGroup.checkTip.showCheck2("公会需要达到" + this.OPNELEVEL + "级才能开启建筑功能!",2,jumfun);
            return;
         }
         this.mc_box.gotoAndStop(7);
         this.mc_box["btn_normal"].alpha = 0.3;
         this.mc_box["btn_normal"].mouseEnabled = false;
         this.mc_box["btn_extra"].alpha = 0.3;
         this.mc_box["btn_extra"].mouseEnabled = false;
         this.mc_box["btn_normal"].addEventListener(MouseEvent.CLICK,this.onClick);
         this.mc_box["btn_extra"].addEventListener(MouseEvent.CLICK,this.onClick);
         this.mc_box["btn_in"].addEventListener(MouseEvent.CLICK,this.onClick);
         for(i = 0; i < 8; i++)
         {
            if(Boolean(this.mc_box["mc_build_" + i]))
            {
               this.mc_box["mc_build_" + i].gotoAndStop(1);
               this.mc_box["mc_build_" + i].buttonMode = true;
               this.mc_box["mc_build_" + i].mouseChildren = false;
               this.mc_box["mc_build_" + i].addEventListener(MouseEvent.CLICK,this.onClick);
            }
         }
         this.setCurrentBuild();
         Game.union_api.getVariables(Game.nowSaveIndex,this.BUILDVARID,this.getVarOver);
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
         var ccd:CBuildData = null;
         if(dataAry == null || dataAry.lengthdddd == 0)
         {
            return;
         }
         for(var j:int = 0; j < dataAry.length; j++)
         {
            tmpObj = dataAry[j];
            if(tmpObj != null)
            {
               ccd = this.BUILDARR[this.getIdByIndex(tmpObj.id,this.BUILDVARID)];
               if(Boolean(ccd))
               {
                  ccd.Exp = tmpObj.value;
               }
            }
         }
         this.setCurrentBuild();
      }
      
      protected function onClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var naarr:Array = null;
         var citydat:CBuildData = null;
         var s1:int = 0;
         var s2:int = 0;
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         if(name.indexOf("mc_build_") >= 0)
         {
            for(i = 0; i < 9; i++)
            {
               if(Boolean(this.mc_box["mc_build_" + i]))
               {
                  this.mc_box["mc_build_" + i].gotoAndStop(1);
               }
            }
            naarr = name.split("mc_build_");
            this._buildId = naarr[1];
            this.setCurrentBuild();
            return;
         }
         switch(name)
         {
            case "btn_in":
               citydat = this.BUILDARR[this._buildId];
               citydat.CityUI.Show();
               citydat.CityUI.Init();
               break;
            case "btn_extra":
               s1 = Game.gameData.propsItems.getNumByBase("jianzhuling");
               if(s1 < 1)
               {
                  Game.uiGroup.checkTip.showCheck2("您的升级材料不足,需要1个建筑令!",1);
                  return;
               }
               citydat = this.BUILDARR[this._buildId];
               Game.gameData.propsItems.useItemsNum("jianzhuling",1);
               Game.gameData.giftData.AddUnionBuildByID(citydat.Id,false);
               Game.uiGroup.addGift_byArr(citydat.ExtraPrizeArr,false,1,true);
               Game.union_api.doVariable(Game.nowSaveIndex,citydat.Id);
               Game.uiGroup.saveDataNoUI();
               this.Init();
               break;
            case "btn_normal":
               s1 = Game.gameData.materialsItems.getNumByBase("superalloy");
               s2 = Game.gameData.materialsItems.getNumByBase("superalloy_Z");
               if(s1 < 100 || s2 < 50)
               {
                  Game.uiGroup.checkTip.showCheck2("您的升级材料不足,需要100个超合金和50个超合金Z!",1);
                  return;
               }
               citydat = this.BUILDARR[this._buildId];
               Game.gameData.materialsItems.useItemsNum("superalloy",100);
               Game.gameData.materialsItems.useItemsNum("superalloy_Z",50);
               Game.gameData.giftData.AddUnionBuildByID(citydat.Id,true);
               Game.uiGroup.addGift_byArr(citydat.NormalPrizeArr,false,1,true);
               Game.union_api.doVariable(Game.nowSaveIndex,citydat.Id);
               Game.uiGroup.saveDataNoUI();
               this.Init();
         }
      }
      
      private function setCurrentBuild() : void
      {
         var citydat:CBuildData = this.BUILDARR[this._buildId];
         this.mc_box["mc_build_" + this._buildId].gotoAndStop(2);
         var normalcount:int = 1 - Game.gameData.giftData.GetUnionBuildByID(citydat.Id,true);
         var extracount:int = 2 - Game.gameData.giftData.GetUnionBuildByID(citydat.Id,false);
         if(normalcount <= 0)
         {
            normalcount = 0;
            this.mc_box["btn_normal"].alpha = 0.3;
            this.mc_box["btn_normal"].mouseEnabled = false;
         }
         else
         {
            this.mc_box["btn_normal"].alpha = 1;
            this.mc_box["btn_normal"].mouseEnabled = true;
         }
         if(extracount <= 0)
         {
            extracount = 0;
            this.mc_box["btn_extra"].alpha = 0.3;
            this.mc_box["btn_extra"].mouseEnabled = false;
         }
         else
         {
            this.mc_box["btn_extra"].alpha = 1;
            this.mc_box["btn_extra"].mouseEnabled = true;
         }
         this.mc_box["txt_name"].text = citydat.Name;
         this.mc_box["txt_level"].text = citydat.Level;
         this.mc_box["txt_num"].text = citydat.Exp + "/" + citydat.NextExp;
         this.mc_box["txt_normalnum"].text = normalcount;
         this.mc_box["txt_extranum"].text = extracount;
      }
      
      public function InitBuildAdd() : void
      {
         this.BUILDARR[0].CityUI.Init();
      }
      
      public function GetBuildAddByType(type:int) : Number
      {
         return this.BUILDARR[0].CityUI.getUnionAddByType(type);
      }
      
      public function Release() : void
      {
      }
      
      public function GetBuildLevel(buildid:int) : int
      {
         return (this.BUILDARR[buildid] as CBuildData).Level;
      }
   }
}

class CBuildData
{
   
   public var Id:int = 0;
   
   public var Name:String = "";
   
   public var Exp:int = 0;
   
   public var CityUI:* = null;
   
   public var NormalPrizeArr:Array = ["props,justice2_badge,5"];
   
   public var ExtraPrizeArr:Array = ["props,justice2_badge,5"];
   
   public var LevelExpArr:Array = [0,300,900,2100,4500,9300,18900];
   
   public function CBuildData(id:int, name:String, cityui:*)
   {
      super();
      this.Id = id;
      this.Name = name;
      this.CityUI = cityui;
   }
   
   public function get Level() : int
   {
      var nowl:int = 0;
      for(var i:int = 0; i < this.LevelExpArr.length; i++)
      {
         if(this.Exp >= this.LevelExpArr[i])
         {
            nowl = i;
         }
      }
      return nowl;
   }
   
   public function get NextExp() : int
   {
      var nowl:int = 0;
      for(var i:int = 0; i < this.LevelExpArr.length; i++)
      {
         nowl = int(this.LevelExpArr[i]);
         if(this.Exp < this.LevelExpArr[i])
         {
            break;
         }
      }
      return nowl;
   }
}
