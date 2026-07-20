package UI.gift
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import gameAll.data.ArmsItemsData;
   import goods.GoodsDefine;
   import goods.TurnTableData;
   
   public class ViewGameTurntable extends Sprite
   {
      
      private static var _instance:ViewGameTurntable = null;
      
      private static const MAIN_NAME:String = "UITurntable";
      
      public var mc_panel:MovieClip;
      
      public var txt_has:TextField;
      
      public var return_btn:SimpleButton;
      
      private var _startTime:int = 0;
      
      private var _lastTime:int = 0;
      
      private var BiscCount:int = 12;
      
      private var _isStartRoll:Boolean = false;
      
      private var _nowCount:int = 0;
      
      private var _allCount:int = 0;
      
      private var _startSpeed:int = 0;
      
      private var ASpeed:int = 0;
      
      private const FinalTime:int = 500;
      
      private var BisRollCount:int = 5;
      
      private var _receiveID:int = -1;
      
      private var _subArr:Array = ["鞭炮新春黄金版"];
      
      private var showInfo:String = "";
      
      public function ViewGameTurntable()
      {
         super();
      }
      
      private function init() : Boolean
      {
         var gamedata:TurnTableData = Game.turnTableDefineGroup.GetGameTurnData();
         var itemArr:Array = gamedata.GoodArr;
         this.setItemIcon(itemArr);
         var len:int = int(itemArr.length);
         var i:int = 0;
         for(var j:int = 0; j < len; j++)
         {
         }
         (this["mc_panel"]["mc_start"] as SimpleButton).filters = [];
         (this["mc_panel"]["mc_start"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onStartClick);
         this.return_btn.addEventListener(MouseEvent.CLICK,this.close);
         var hasc:int = 1 - Game.gameData.giftData.GetTurntableCount();
         this.txt_has.text = hasc + "次";
         return true;
      }
      
      private function addIcon(param0:DisplayObjectContainer, param1:String) : void
      {
         var gic:BitmapData = Game.swfLoaderManager.getResource("itemsUI",param1);
         if(gic == null)
         {
            return;
         }
         var bit:Bitmap = new Bitmap(gic);
         bit.width /= 0.77;
         bit.height /= 0.77;
         bit.width /= 0.77;
         bit.height /= 0.77;
         bit.x = -((bit.width - 70) / 2);
         bit.y = -((bit.height - 70) / 2);
         bit.smoothing = true;
         param0.addChild(bit);
      }
      
      protected function onAgain(event:MouseEvent) : void
      {
         (this["mc_win"] as MovieClip).visible = false;
      }
      
      private function setItemIcon(itemArr:Array) : void
      {
         var nI:int = 0;
         var len:int = int(itemArr.length);
         for(var i:int = 0; i < len; i++)
         {
            nI = i + 1;
         }
      }
      
      protected function onStartClick(event:MouseEvent) : void
      {
         var gstr:String = null;
         var strarr:Array = null;
         var rate:Number = NaN;
         var ran:Number = NaN;
         var isHas:Boolean = false;
         var naxStr:String = null;
         var maxrate:Number = NaN;
         var ra:int = 0;
         var gd2:GoodsDefine = null;
         var aid0:ArmsItemsData = null;
         var gift0:Array = null;
         var g0:Array = null;
         var gd0:GoodsDefine = null;
         var gd:GoodsDefine = null;
         var hasc1:int = 1 - Game.gameData.giftData.GetTurntableCount();
         if(hasc1 <= 0)
         {
            Game.uiGroup.checkTip.showCheck2("您今日抽奖机会已经用完,明天再来吧!",1);
            return;
         }
         (this["mc_panel"]["mc_start"] as SimpleButton).mouseEnabled = false;
         (this["mc_panel"]["mc_pointer"] as Sprite).rotation = 0;
         this._startTime = 0;
         this._lastTime = 0;
         this.BiscCount = 12;
         this._isStartRoll = false;
         this._nowCount = 0;
         this._allCount = 0;
         this._startSpeed = 0;
         this.ASpeed = 0;
         this.BisRollCount = 5;
         this._receiveID = -1;
         for(var i:int = 0; i < 8; i++)
         {
         }
         var gamedata:TurnTableData = Game.turnTableDefineGroup.GetGameTurnData();
         var itemArr:Array = gamedata.GoodArr;
         var maxRateId:int = 0;
         for(var j:int = 0; j < itemArr.length; j++)
         {
            gstr = itemArr[j];
            strarr = gstr.split("|");
            rate = Number(strarr[1]) / 1000;
            ran = Math.random();
            isHas = false;
            if(ran <= rate && !isHas)
            {
               maxRateId = j;
               break;
            }
            naxStr = itemArr[maxRateId];
            maxrate = Number(naxStr.split("|")[1]) / 1000;
            if(maxrate < rate)
            {
               maxRateId = j;
            }
         }
         this.CallBackStart(maxRateId);
         var tstr:String = itemArr[maxRateId];
         var nowStr:Array = tstr.split("|");
         if(nowStr[0] == "武器礼包")
         {
            ra = int(this._subArr.length * Math.random());
            gd2 = Game.goodsDefineGroup.GetGoodsByName(this._subArr[ra]);
            aid0 = Game.gameData.subItems.getItemsByBase(gd2.id.split("_")[0],false);
            if(aid0 is ArmsItemsData)
            {
               isHas = true;
               this.showInfo = this._subArr[ra] + "只能兑换一次";
            }
            else
            {
               this.showInfo = "恭喜你获得了" + this._subArr[ra] + "!";
               Game.uiGroup.addGift_byArr([gd2],true,-1,false);
            }
         }
         else if(nowStr[0] == "材料礼包")
         {
            gift0 = Game.gameDefine.rankGiftDefine.getRanMaterial(50);
            g0 = Game.goodsDefineGroup.getArr_byStrArr(gift0,Game.gameData.level,true);
            gd0 = g0[int(g0.length * Math.random())];
            this.showInfo = "恭喜你你获得了：" + Game.goodsDefineGroup.switchArr_toStr([gd0],true) + "。";
            Game.uiGroup.addGift_byArr([gd0],true,Game.gameData.level,false);
         }
         else
         {
            gd = Game.goodsDefineGroup.GetGoodsByName(nowStr[0]);
            if(Boolean(gd))
            {
               if(gd.type == "material" || gd.type == "crystal" || gd.type == "chip")
               {
                  gd.type = "materials";
               }
               if(gd.type == "card")
               {
                  gd.type = "props";
               }
            }
            gd.num = int(nowStr[2]);
            Game.uiGroup.addGift_byArr([gd],true,-1,false);
            this.showInfo = "恭喜你获得了" + gd.num + "个" + nowStr[0];
         }
         Game.gameData.giftData.AddTurntable();
         var hasc:int = 1 - Game.gameData.giftData.GetTurntableCount();
         this.txt_has.text = hasc + "次";
         Game.uiGroup.saveDataNoUI();
      }
      
      protected function onCloseClick(event:MouseEvent) : void
      {
         event.currentTarget.removeEventListener(MouseEvent.CLICK,this.onCloseClick);
         if(Boolean(this["mc_panel"]["mc_contain_" + (this._receiveID + 1)]) && Boolean(this["mc_panel"]["mc_contain_" + (this._receiveID + 1)]["mc_img"]))
         {
         }
      }
      
      public function CallBackStart(locID:int) : void
      {
         trace("随机到:",locID + 1);
         this._receiveID = locID;
         this._allCount = (this.BisRollCount * this.BiscCount + locID) * (360 / this.BiscCount) * 10000;
         this.ASpeed = -1 * 2 * this._allCount / this.FinalTime / this.FinalTime;
         this._startSpeed = -1 * this.ASpeed * this.FinalTime;
         this.TurnControl();
      }
      
      private function TurnControl() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onTurnFrame);
         this._isStartRoll = true;
         this._startTime = getTimer();
         this._lastTime = this._startTime;
         this._nowCount = 0;
      }
      
      protected function onTurnFrame(event:Event) : void
      {
         var pastTime:uint = (getTimer() - this._lastTime) / 10;
         if(this._startSpeed + this.ASpeed * pastTime <= 0)
         {
            this._nowCount = this._allCount;
         }
         else
         {
            this._nowCount = (this._startSpeed + (this._startSpeed + this.ASpeed * pastTime)) / 2 * pastTime;
         }
         if(this._nowCount >= this._allCount)
         {
            this._nowCount = this._allCount;
            this._isStartRoll = false;
            this.luckOver();
         }
         this.doTurn();
      }
      
      private function luckOver() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onTurnFrame);
         Game.uiGroup.checkTip.showCheck2(this.showInfo,1);
         trace("抽奖到位:",this._nowCount);
         (this["mc_panel"]["mc_start"] as SimpleButton).mouseEnabled = true;
      }
      
      private function doTurn() : void
      {
         (this["mc_panel"]["mc_pointer"] as Sprite).rotation = this._nowCount / 10000;
      }
      
      private function ClearItem() : void
      {
         var len:int = this.BiscCount;
         for(var i:int = 1; i <= len; i++)
         {
            (this["mc_panel"]["mc_contain_" + i]["txt_name"] as TextField).text = "";
         }
      }
      
      public function show() : void
      {
         this.init();
         this.visible = true;
      }
      
      protected function onBack(event:MouseEvent) : void
      {
         (this["mc_tips"] as MovieClip).visible = false;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function close(e:* = null) : *
      {
         this.hide();
      }
      
      public function Release() : void
      {
      }
   }
}

class LuckGoodData
{
   
   public var ID:int = 0;
   
   public var Name:String = "";
   
   public var Desc:String = "";
   
   public function LuckGoodData()
   {
      super();
   }
}
