package UI.research
{
   import body.define.OneArmsDefine;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import gameAll.NormalMustDefine;
   import items.ItemsDefine;
   
   public class ArmsMustExchange
   {
      
      private var level:int = 0;
      
      private var Gcoin:Number = 0;
      
      private var itemsArr:Array = [];
      
      private var exp_btn:SimpleButton;
      
      private var coin_btn:SimpleButton;
      
      private var materials_btn:SimpleButton;
      
      public var aui:ArmsResearchUI;
      
      public var testB:Boolean = false;
      
      public function ArmsMustExchange()
      {
         super();
      }
      
      public function init(ui0:ArmsResearchUI) : *
      {
         this.aui = ui0;
         this.exp_btn = ui0.upgradeBox.need_mc.one_btn1;
         this.coin_btn = ui0.upgradeBox.need_mc.one_btn2;
         this.materials_btn = ui0.upgradeBox.need_mc.one_btn3;
         this.exp_btn.addEventListener(MouseEvent.CLICK,this.expClick);
         this.coin_btn.addEventListener(MouseEvent.CLICK,this.coinClick);
         this.materials_btn.addEventListener(MouseEvent.CLICK,this.materialsClick);
      }
      
      public function inData(d0:OneArmsDefine) : *
      {
         var str:String = null;
         this.level = d0.mustLevel - 1;
         this.Gcoin = d0.price;
         var arr0:Array = d0.mustItems;
         if(arr0.length > 0)
         {
            this.itemsArr = Game.itemsDefineGroup.getArr_byStrArr(arr0);
         }
         else
         {
            this.itemsArr = [];
         }
         var isnoExp:Boolean = false;
         var isxunzhang:Boolean = false;
         if(d0.mustArenaScore > 0)
         {
            isnoExp = true;
         }
         for(var i:int = 0; i < arr0.length; i++)
         {
            str = arr0[i];
            if(str.indexOf("justice_badge_num") >= 0 || str.indexOf("justice2_badge_num") >= 0)
            {
               isxunzhang = true;
            }
         }
         this.fleshBtn(isnoExp,isxunzhang);
      }
      
      private function fleshBtn(isnoexp:Boolean = false, isxunzhang:Boolean = false) : *
      {
         this.exp_btn.visible = false;
         this.coin_btn.visible = false;
         this.materials_btn.visible = this.getMaterials().length > 0;
         if(isxunzhang)
         {
            this.materials_btn.visible = false;
         }
      }
      
      private function fleshFun() : *
      {
         this.aui.chooseGradeArmsIcon();
         Game.SG.playSound("upgradeArms");
      }
      
      private function expClick(e:* = null) : *
      {
         var d0:NormalMustDefine = null;
         var m0:Number = this.getLevel_M();
         if(m0 > 0)
         {
            d0 = new NormalMustDefine();
            if(this.testB)
            {
               d0.GCoin = m0;
            }
            else
            {
               d0.MCoin = m0;
            }
            Game.uiGroup.checkTip.showMustCheck(d0,"人物等级直接升到" + (this.level + 1) + "级，需要",this.expClick_1);
         }
      }
      
      private function expClick_1() : *
      {
         if(this.testB)
         {
            this.expClick_2();
            return;
         }
         var m0:Number = this.getLevel_M();
         Game.payController.decMCoin(m0,this.expClick_2);
      }
      
      private function expClick_2() : *
      {
         Game.gameData.addExp(this.getExp());
         Game.uiGroup.checkTip.showTip("补充等级成功！",1);
         this.fleshFun();
      }
      
      private function getExp() : Number
      {
         var exp1:Number = NaN;
         var exp0:Number = NaN;
         var m_exp:Number = NaN;
         var lv0:int = Game.gameData.level;
         if(lv0 >= this.level)
         {
            return 0;
         }
         exp1 = Game.gameDefine.getAllExp(this.level);
         exp0 = Game.gameData.nowExp + Game.gameDefine.getAllExp(lv0);
         return exp1 - exp0;
      }
      
      private function getLevel_M() : int
      {
         var m0:Number = this.getExp() / 25000;
         if(m0 > 0 && m0 < 1)
         {
            m0 = 1;
         }
         else
         {
            m0 = Math.round(m0);
         }
         return m0;
      }
      
      private function coinClick(e:* = null) : *
      {
         var d0:NormalMustDefine = null;
         var m0:Number = this.getCoin_M();
         if(m0 > 0)
         {
            d0 = new NormalMustDefine();
            if(this.testB)
            {
               d0.GCoin = m0;
            }
            else
            {
               d0.MCoin = m0;
            }
            Game.uiGroup.checkTip.showMustCheck(d0,"补满 " + this.Gcoin + " G币，需要",this.coinClick_1);
         }
      }
      
      private function coinClick_1() : *
      {
         if(this.testB)
         {
            this.coinClick_2();
            return;
         }
         var m0:Number = this.getCoin_M();
         Game.payController.decMCoin(m0,this.coinClick_2);
      }
      
      private function coinClick_2() : *
      {
         Game.gameData.addCoin(this.getCoin());
         Game.uiGroup.checkTip.showTip("补充G币成功！",1);
         this.fleshFun();
      }
      
      private function getCoin() : Number
      {
         var coin0:int = Game.gameData.GCoin;
         if(coin0 >= this.Gcoin)
         {
            return 0;
         }
         return this.Gcoin - coin0;
      }
      
      private function getCoin_M() : int
      {
         var m0:Number = this.getCoin() / 50000;
         if(m0 > 0 && m0 < 1)
         {
            m0 = 1;
         }
         else
         {
            m0 = Math.round(m0);
         }
         return m0;
      }
      
      private function materialsClick(e:* = null) : *
      {
         var d0:NormalMustDefine = null;
         var m0:int = this.getMaterials_M();
         if(m0 > 0)
         {
            d0 = new NormalMustDefine();
            if(this.testB)
            {
               d0.GCoin = m0;
            }
            else
            {
               d0.MCoin = m0;
            }
            Game.uiGroup.checkTip.showMustCheck(d0,"补足当前所需材料，需要",this.materialsClick_1);
         }
      }
      
      private function materialsClick_1() : *
      {
         if(this.testB)
         {
            this.materialsClick_2();
            return;
         }
         var m0:int = this.getMaterials_M();
         Game.payController.decMCoin(m0,this.materialsClick_2);
      }
      
      private function materialsClick_2() : *
      {
         var n:* = undefined;
         var d0:ItemsDefine = null;
         var arr0:Array = this.getMaterials();
         for(n in arr0)
         {
            d0 = arr0[n];
            Game.gameData.materialsItems.addItemsDefine(d0,d0.nowNum);
         }
         Game.uiGroup.checkTip.showTip("补充材料成功！",1);
         this.fleshFun();
      }
      
      private function getMaterials() : Array
      {
         var n:* = undefined;
         var d0:ItemsDefine = null;
         var name0:String = null;
         var m0:int = 0;
         var m1:int = 0;
         var d2:ItemsDefine = null;
         var arr0:Array = [];
         for(n in this.itemsArr)
         {
            d0 = this.itemsArr[n];
            name0 = d0.name;
            m0 = d0.nowNum;
            m1 = Game.gameData.materialsItems.getNumByBase(name0);
            if(m1 < m0)
            {
               d2 = d0.copyAll();
               d2.nowNum = m0 - m1;
               arr0.push(d2);
            }
         }
         return arr0;
      }
      
      private function getMaterials_M() : int
      {
         var n:* = undefined;
         var d0:ItemsDefine = null;
         var m0:int = 0;
         var arr0:Array = this.getMaterials();
         for(n in arr0)
         {
            d0 = arr0[n];
            if(d0.name.indexOf("tuzhi_zhuanyipao2") >= 0)
            {
               m0 += 200 * d0.nowNum;
            }
            else if(d0.name == "superalloy")
            {
               m0 += 1 * d0.nowNum;
            }
            else if(d0.name == "xinchunsongfu")
            {
               m0 += 5 * d0.nowNum;
            }
            else if(d0.name == "laodongjie")
            {
               m0 += 5 * d0.nowNum;
            }
            else if(d0.name == "superalloy_Z")
            {
               m0 += 3 * d0.nowNum;
            }
            else if(d0.name == "superalloy_X")
            {
               m0 += Math.ceil(1.5 * d0.nowNum);
            }
            else if(d0.name == "superalloy_Y")
            {
               m0 += 10 * d0.nowNum;
            }
            else
            {
               m0 += Math.ceil(0.8 * d0.nowNum);
            }
         }
         return m0;
      }
   }
}

