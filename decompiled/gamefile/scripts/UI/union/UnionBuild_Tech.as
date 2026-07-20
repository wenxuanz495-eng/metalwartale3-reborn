package UI.union
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class UnionBuild_Tech
   {
      
      private var _buildId:int = 0;
      
      private var _father:UnionUI;
      
      private var _build:UnionBuild;
      
      private var mc_box:MovieClip;
      
      private const BUILDVARID:Array = [37,38,39,40];
      
      private var BUILDARR:Array = null;
      
      public function UnionBuild_Tech(mc0:UnionUI, mc1:UnionBuild, mc_tech:MovieClip)
      {
         super();
         this._father = mc0;
         this._build = mc1;
         this.mc_box = mc_tech;
         this.BUILDARR = [new CBuildData(this.BUILDVARID[0],"射击训练"),new CBuildData(this.BUILDVARID[1],"体能训练"),new CBuildData(this.BUILDVARID[2],"防御训练"),new CBuildData(this.BUILDVARID[3],"控制训练")];
         mc_tech.btn_close.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function Show() : void
      {
         this.mc_box.visible = true;
      }
      
      public function Init() : void
      {
         this.mc_box["btn_normal"].alpha = 0.3;
         this.mc_box["btn_normal"].mouseEnabled = false;
         this.mc_box["btn_extra"].alpha = 0.3;
         this.mc_box["btn_extra"].mouseEnabled = false;
         this.mc_box["btn_normal"].addEventListener(MouseEvent.CLICK,this.onClick);
         this.mc_box["btn_extra"].addEventListener(MouseEvent.CLICK,this.onClick);
         for(var i:int = 0; i < 8; i++)
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
         var naarr:Array = null;
         var buildlevel:int = 0;
         var i:int = 0;
         var s1:int = 0;
         var citydat:CBuildData = null;
         var btn:DisplayObject = event.currentTarget as DisplayObject;
         var name:String = btn.name;
         if(name.indexOf("mc_build_") >= 0)
         {
            naarr = name.split("mc_build_");
            buildlevel = this._build.GetBuildLevel(0);
            if(int(naarr[1]) == 1 && buildlevel < 2)
            {
               Game.uiGroup.checkTip.showCheck2("公会科技建筑需要达到2级才能开启体能训练!",1);
               return;
            }
            if(int(naarr[1]) == 2 && buildlevel < 4)
            {
               Game.uiGroup.checkTip.showCheck2("公会科技建筑需要达到4级才能开启防御训练!",1);
               return;
            }
            if(int(naarr[1]) == 3 && buildlevel < 6)
            {
               Game.uiGroup.checkTip.showCheck2("公会科技建筑需要达到6级才能开启控制训练!",1);
               return;
            }
            for(i = 0; i < 9; i++)
            {
               if(Boolean(this.mc_box["mc_build_" + i]))
               {
                  this.mc_box["mc_build_" + i].gotoAndStop(1);
               }
            }
            this._buildId = naarr[1];
            this.setCurrentBuild();
            return;
         }
         switch(name)
         {
            case "btn_close":
               this._father.hideAllWindows();
               break;
            case "btn_extra":
               s1 = Game.gameData.materialsItems.getNumByBase("superalloy_Y");
               if(s1 < 2)
               {
                  Game.uiGroup.checkTip.showCheck2("您的升级材料不足,需要2个超合金Y!",1);
                  return;
               }
               citydat = this.BUILDARR[this._buildId];
               Game.gameData.materialsItems.useItemsNum("superalloy_Y",2);
               Game.gameData.giftData.AddTechBuildByID(citydat.Id,false);
               Game.uiGroup.addGift_byArr(citydat.ExtraPrizeArr,false,1,true);
               Game.union_api.doVariable(Game.nowSaveIndex,citydat.Id);
               Game.uiGroup.saveDataNoUI();
               this.Init();
               break;
            case "btn_normal":
               s1 = Game.gameData.materialsItems.getNumByBase("superalloy_X");
               if(s1 < 100)
               {
                  Game.uiGroup.checkTip.showCheck2("您的升级材料不足,需要100个超合金X!",1);
                  return;
               }
               citydat = this.BUILDARR[this._buildId];
               Game.gameData.materialsItems.useItemsNum("superalloy_X",100);
               Game.gameData.giftData.AddTechBuildByID(citydat.Id,true);
               Game.uiGroup.addGift_byArr(citydat.ExtraPrizeArr,false,1,true);
               Game.union_api.doVariable(Game.nowSaveIndex,citydat.Id);
               Game.uiGroup.saveDataNoUI();
               this.Init();
         }
      }
      
      public function getUnionAddByType(type:int = 0) : Number
      {
         return this.BUILDARR[type].Effect;
      }
      
      private function setCurrentBuild() : void
      {
         var citydat:CBuildData = this.BUILDARR[this._buildId];
         this.mc_box["mc_build_" + this._buildId].gotoAndStop(2);
         var normalcount:int = 1 - Game.gameData.giftData.GetTechBuildByID(citydat.Id,true);
         var extracount:int = 2 - Game.gameData.giftData.GetTechBuildByID(citydat.Id,false);
         var buildlevel:int = this._build.GetBuildLevel(0);
         var levelCan:Boolean = false;
         if(buildlevel * 10 < citydat.Level)
         {
            levelCan = false;
         }
         else
         {
            levelCan = true;
         }
         if(normalcount <= 0 || levelCan == false)
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
         if(extracount <= 0 || levelCan == false)
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
         this.mc_box["txt_skillname"].text = citydat.Name;
         this.mc_box["txt_skilllevel"].text = citydat.Level;
         this.mc_box["txt_skillnum"].text = citydat.Exp + "/" + citydat.NextExp;
         this.mc_box["txt_skilleffect"].text = citydat.Effect * 100 + "%";
         this.mc_box["txt_skillnexteffect"].text = citydat.NextEffect * 100 + "%";
         this.mc_box["txt_normalnum"].text = normalcount;
         this.mc_box["txt_extranum"].text = extracount;
      }
   }
}

class CBuildData
{
   
   public var Id:int = 0;
   
   public var Name:String = "";
   
   public var Exp:int = 0;
   
   public var NormalPrizeArr:Array = ["props,justice2_badge,5"];
   
   public var ExtraPrizeArr:Array = ["props,justice2_badge,5"];
   
   public var LevelExpArr:Array = null;
   
   public var EffectArr:Array = null;
   
   public function CBuildData(id:int, name:String)
   {
      super();
      this.Id = id;
      this.Name = name;
      this.EffectArr = [0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.11,0.12,0.13,0.14,0.15,0.16,0.17,0.18,0.19,0.2,0.21,0.22,0.23,0.24,0.25,0.26,0.27,0.28,0.29,0.3,0.31,0.32,0.33,0.34,0.35,0.36,0.37,0.38,0.39,0.4,0.41,0.42,0.43,0.44,0.45,0.46,0.47,0.48,0.49,0.5,0.51,0.52,0.53,0.54,0.55,0.56,0.57,0.58,0.59,0.6];
      this.LevelExpArr = [0,12,26,42,60,80,102,126,152,180,210,242,276,312,350,390,432,476,522,570,620,672,726,782,840,900,962,1026,1092,1160,1230,1302,1376,1452,1530,1610,1692,1776,1862,1950,2040,2132,2226,2322,2420,2520,2622,2726,2832,2940,3050,3162,3276,3392,3510,3630,3752,3876,4002,4130,4260];
   }
   
   public function get Effect() : Number
   {
      if(this.EffectArr[this.Level] != null)
      {
         return this.EffectArr[this.Level];
      }
      return 0;
   }
   
   public function get NextEffect() : Number
   {
      if(this.Level + 1 >= this.EffectArr.length)
      {
         return this.Effect;
      }
      if(this.EffectArr[this.Level + 1] != null)
      {
         return this.EffectArr[this.Level + 1];
      }
      return 0;
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
