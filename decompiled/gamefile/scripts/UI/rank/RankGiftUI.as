package UI.rank
{
   import UI.items.ItemsBox;
   import UI.items.ItemsIcon;
   import UI.login.HeadBtn;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import goods.GoodsDefine;
   
   public class RankGiftUI extends Sprite
   {
      
      public var return_btn:SimpleButton;
      
      public var head_btn:HeadBtn = new HeadBtn();
      
      public var name_txt:TextField;
      
      public var nowRank_txt:TextField;
      
      public var getGift_btn:SimpleButton;
      
      public var nextRank_txt:TextField;
      
      public var pay_btn:SimpleButton;
      
      public var tip1_txt:TextField;
      
      public var tip2_txt:TextField;
      
      public var nowBox:ItemsBox = new ItemsBox();
      
      public var nextBox:ItemsBox = new ItemsBox();
      
      public function RankGiftUI()
      {
         super();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
         addChild(this.head_btn);
         this.head_btn.x = 198;
         this.head_btn.y = 107;
         addChild(this.nowBox);
         this.nowBox.setLabelClass(ItemsIcon);
         this.nowBox.setNum(3,2,211,120);
         this.nowBox.x = 216;
         this.nowBox.y = 242;
         addChild(this.nextBox);
         this.nextBox.setLabelClass(ItemsIcon);
         this.nextBox.setNum(3,2,211,120);
         this.nextBox.x = 527;
         this.nextBox.y = 242;
         this.getGift_btn.addEventListener(MouseEvent.CLICK,this.getGift);
         this.pay_btn.addEventListener(MouseEvent.CLICK,this.pay);
      }
      
      public function fleshData() : *
      {
         var g0:Array = null;
         var gift2:Array = null;
         var g2:Array = null;
         var GD:GameData = Game.gameData;
         this.name_txt.text = GD.playerName;
         this.head_btn.setText(GD.headLabel);
         this.nowRank_txt.text = "你的军衔：" + GD.playerRank;
         var nameArr0:Array = Game.gameDefine.rankNameArr;
         var nextName0:String = "";
         if(GD.rankLevel >= nameArr0.length - 1)
         {
            this.nextRank_txt.text = "没有下一级军衔了";
         }
         else
         {
            nextName0 = Game.gameDefine.rankNameArr[GD.rankLevel + 1];
            this.nextRank_txt.text = "下一级军衔：" + nextName0;
         }
         var gift0:Array = Game.gameDefine.rankGiftDefine.getGift(GD.rankLevel);
         if(gift0.length > 0)
         {
            g0 = Game.goodsDefineGroup.getArr_byStrArr(gift0,GD.level,true);
            this.nowBox.inData_byGoodsDefineArr(g0,true);
            this.nowBox.arr[1].showRandomB = false;
            this.nowBox.visible = true;
            this.tip1_txt.text = "你可以随机获取下列物品中的一个";
         }
         else
         {
            this.nowBox.visible = false;
            this.tip1_txt.text = "只有少尉以上军衔才拥有军衔奖励";
         }
         if(nextName0 != "")
         {
            gift2 = Game.gameDefine.rankGiftDefine.getGift(GD.rankLevel + 1);
            if(gift2.length > 0)
            {
               g2 = Game.goodsDefineGroup.getArr_byStrArr(gift2,GD.level,true);
               this.nextBox.inData_byGoodsDefineArr(g2,true);
               this.nextBox.arr[1].showRandomB = false;
               this.nextBox.visible = true;
               this.tip2_txt.text = "下级军衔礼包可随机获得的物品";
            }
            else
            {
               this.nextBox.visible = false;
               this.tip2_txt.text = "只有少尉以上军衔才拥有军衔奖励";
            }
         }
         else
         {
            this.nextBox.visible = false;
         }
         if(GD.rankAdd.rankGiftB || !this.nowBox.visible)
         {
            this.getGift_btn.mouseEnabled = false;
            this.getGift_btn.alpha = 0.4;
         }
         else
         {
            this.getGift_btn.mouseEnabled = true;
            this.getGift_btn.alpha = 1;
         }
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
      
      public function pay(e:* = null) : *
      {
         Game.uiGroup.pay();
      }
      
      public function getGift(e:* = null) : *
      {
         var GD:GameData = Game.gameData;
         if(GD.materialsItems.getSurplus() < 1)
         {
            Game.uiGroup.checkTip.showCheck2("材料背包必须有至少1个空位，才能领取奖励。",2,null,null,2);
            return;
         }
         var gift0:Array = Game.gameDefine.rankGiftDefine.getGift(GD.rankLevel);
         var g0:Array = Game.goodsDefineGroup.getArr_byStrArr(gift0,GD.level,true);
         var gd0:GoodsDefine = g0[int(g0.length * Math.random())];
         var str0:String = "你获得了：" + Game.goodsDefineGroup.switchArr_toStr([gd0],true) + "。";
         Game.uiGroup.checkTip.showCheck2(str0,2);
         Game.uiGroup.addGift_byArr([gd0],true,GD.level,false);
         Game.SG.playSound("upgradeArms");
         trace("领取礼物！");
         Game.gameData.rankAdd.rankGiftB = true;
         this.fleshData();
         Game.uiGroup.saveDataNoUI();
      }
   }
}

