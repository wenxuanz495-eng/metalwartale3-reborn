package gameAll
{
   import UI.TestTextUI;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gameAll.data.GameData;
   import unit4399.PreventCF;
   import unit4399.events.PayEvent;
   
   public class PayController
   {
      
      public var payMoneyVar:PayMoneyVar = PayMoneyVar.getInstance();
      
      public var connectB:Boolean = false;
      
      public var isNormal:Boolean = false;
      
      public var yesFun:Function = null;
      
      public var noFun:Function = null;
      
      public var timer:Timer = new Timer(200000);
      
      public var nowMCoin:int = 0;
      
      public var changeUIB:Boolean = false;
      
      public var pcf:PreventCF = PreventCF.getInstance();
      
      public var nowRecharged:int = 0;
      
      public var noMultipleFun:Function;
      
      public function PayController()
      {
         super();
         this.timer.addEventListener(TimerEvent.TIMER,this.timer20);
         this.beforeMCoin = 0;
         this.totalRecharged = 0;
      }
      
      public function init() : *
      {
         this.yesFun = null;
         this.noFun = null;
         this.timer.stop();
         this.connectB = false;
         this.isNormal = false;
      }
      
      public function decMCoin(value0:Number, _yesFun:Function = null, _noFun:Function = null) : *
      {
         if(Game.save_api.isLocal())
         {
            if(Game.gameData.MCoin >= value0)
            {
               Game.gameData.MCoin -= value0;
               this.nowMCoin = Game.gameData.MCoin;
               if(_yesFun is Function)
               {
                  _yesFun();
               }
               Game.uiGroup.saveDataNoUI();
            }
            else if(_noFun is Function)
            {
               if(_noFun.length > 0)
               {
                  _noFun("M币不足！");
               }
               else
               {
                  _noFun();
               }
            }
            else
            {
               Game.uiGroup.checkTip.showCheck2("M币不足！",2,null,null,2);
            }
            return;
         }
         if(!this.connectB)
         {
            this.yesFun = _yesFun;
            this.noFun = _noFun;
            this.payMoneyVar.money = value0;
            Game.uiGroup.loadingUI.show();
            this.getStoreState(this.affter_decMCoin);
         }
      }
      
      private function affter_decMCoin() : *
      {
         this.startUseApi();
         this.payCtrl("decMoney");
      }
      
      public function getMCoin() : *
      {
         this.changeUIB = true;
         this.yesFun = this.payMoneySuccess;
         this.noFun = null;
         this.startUseApi();
         this.beforeMCoin = Game.gameData.MCoin;
         this.payCtrl("getBalance");
      }
      
      public function getTotalRecharged(_yesFun:Function = null, _noFun:Function = null) : *
      {
         if(Boolean(Game.serviceHold))
         {
            this.yesFun = _yesFun;
            this.noFun = _noFun;
            this.startUseApi();
            this.payCtrl("getTotalRecharged");
         }
         else
         {
            this.yesFun = _yesFun;
            this.doYesFun();
         }
      }
      
      public function getTrueTotalRecharged() : Number
      {
         var mc0:int = Game.gameData.backstageMCoin;
         if(mc0 > 0)
         {
            return this.totalRecharged - mc0;
         }
         return this.totalRecharged;
      }
      
      public function set totalRecharged(value0:Number) : *
      {
         this.pcf.setAttribute("totalRecharged",value0);
      }
      
      public function get totalRecharged() : Number
      {
         return this.pcf.getAttribute("totalRecharged");
      }
      
      public function set beforeMCoin(value0:Number) : *
      {
         this.pcf.setAttribute("beforeMCoin",value0);
      }
      
      public function get beforeMCoin() : Number
      {
         return this.pcf.getAttribute("beforeMCoin");
      }
      
      public function get serviceHold() : *
      {
         return Game.serviceHold;
      }
      
      public function get testText() : TestTextUI
      {
         return Game.testText;
      }
      
      public function fleshMCoin(mcoin0:Number = -1) : *
      {
         if(mcoin0 != -1)
         {
            this.nowMCoin = mcoin0;
         }
         Game.gameData.MCoin = this.nowMCoin;
      }
      
      public function openPayLink() : *
      {
         this.payMoneyVar.money = 100;
         Game.uiGroup.checkTip.showCheck2("请务必在充值完毕后点击确定，否则你将得不到额外的功勋奖励。",2,this.getMCoin);
         this.payCtrl("payMoney");
      }
      
      public function payMoneySuccess(testNum0:int = -1) : *
      {
         Game.uiGroup.loadingUI.hide();
         var cMCoin:int = this.nowMCoin - this.beforeMCoin;
         if(testNum0 >= 0)
         {
            cMCoin = testNum0;
         }
         Game.testText.addTestText("nowMCoin：" + this.nowMCoin + "  beforeMCoin：" + this.beforeMCoin);
         if(cMCoin > 0)
         {
            Game.testText.addTestText("增加功勋：" + 10 * cMCoin);
            Game.gameData.addAchieve(10 * cMCoin);
            Game.uiGroup.rankUI.fleshData();
         }
         var str0:String = Game.gameData.giftData.inData_onePay(cMCoin);
         if(str0 != "")
         {
         }
         Game.uiGroup.shopUI.fleshPrice();
         Game.uiGroup.researchUI.playerBox.fleshAll();
         this.connectB = false;
      }
      
      public function gotoOnePay(e:* = null) : *
      {
         var index0:int = Game.gameData.giftData.nowGetIndex;
         if(index0 >= 0)
         {
            Game.uiGroup.mainUI.allGiftUI.pay2UI.chooseLabel(index0);
         }
      }
      
      public function payMoneyFail() : *
      {
         Game.uiGroup.loadingUI.hide();
         Game.uiGroup.checkTip.showCheck2("充值失败！",2,null,null,2);
         this.connectB = false;
      }
      
      public function timer20(e:*) : *
      {
      }
      
      public function doYesFun() : *
      {
         if(this.yesFun is Function)
         {
            this.yesFun();
         }
         this.useApiComplete();
      }
      
      public function doNoFun(str0:String = "") : *
      {
         if(this.noFun is Function)
         {
            this.noFun();
         }
         if(str0 == "")
         {
            str0 = "出现错误，未能完成操作。";
         }
         Game.uiGroup.checkTip.showCheck2(str0,2,null,null,2);
         this.useApiComplete();
      }
      
      public function startUseApi() : *
      {
         Game.uiGroup.loadingUI.show();
         this.connectB = true;
         this.timer.start();
      }
      
      public function useApiComplete() : *
      {
         if(Game.getIsLoginB() || !Game.serviceHold)
         {
            Game.uiGroup.loadingUI.hide();
         }
         this.connectB = false;
         this.timer.stop();
         this.changeUIB = false;
         this.yesFun = null;
         this.noFun = null;
      }
      
      public function paiedMoneyZuobi(num0:int) : *
      {
         var m00:int = 0;
         var m_add0:int = 0;
         var max000:int = 0;
         var GD:GameData = Game.gameData;
         if(num0 < 250)
         {
         }
         var allM:int = this.getMust_M();
         if(num0 < allM / 2)
         {
         }
         Game.testText.addTestText("游戏中的消费品总额为：" + allM);
         var baseS0:int = 0;
         if(Game.gameData.arenaData.beforeScore == 0)
         {
            m00 = (num0 - allM) / 10;
            if(m00 < 0)
            {
               m00 = 0;
            }
            else if(m00 > 2000)
            {
               m00 /= 3;
            }
            m_add0 = m00 / 10 * 3;
            baseS0 = (6 * 15 + m_add0) * 20;
            max000 = 4000;
            if(num0 > 19999)
            {
               max000 = 4000;
            }
            else if(num0 > 2999)
            {
               max000 = 3500;
            }
            else
            {
               max000 = 3000;
            }
            if(baseS0 > max000)
            {
               baseS0 = max000;
            }
            if(Game.gameData.arenaData.score > baseS0)
            {
               Game.gameData.arenaData.score = baseS0;
            }
            Game.testText.addTestText("获得最高可能获得的竞技场分数：" + baseS0);
            Game.gameData.arenaData.beforeScore = Game.gameData.arenaData.score;
         }
      }
      
      public function getMust_M() : int
      {
         var allM:int = 0;
         var m001:int = Game.goodsDefineGroup.zuobi_findArms();
         var m002:int = Game.goodsDefineGroup.zuobi_findSub();
         var m003:int = 0;
         var m004:int = Game.gameData.armsItems.getMust_M(Game.gameDefine.armsMust.MCoin_arr);
         var m005:int = Game.gameData.subItems.getMust_M(Game.gameDefine.subMust.MCoin_arr);
         allM += m001 + m002 + m003 + m004 + m005;
         var ynum:int = 0;
         allM += int(ynum / 4 * 6);
         var cnum:int = Game.gameData.propsItems.getNumByBase("disassemble");
         cnum = (cnum - 200) * 5;
         if(cnum < 0)
         {
            cnum = 0;
         }
         allM += cnum;
         var all_train_M:Number = Game.gameDefine.getAllTrainCoinNum_M(Game.gameData.playerData.allAdd.level) / 4;
         allM += all_train_M;
         Game.testText.addTestText("主武器所需M币：" + m001);
         Game.testText.addTestText("副武器所需M币：" + m002);
         Game.testText.addTestText("车身所需M币：" + m003);
         Game.testText.addTestText("主武器位置开启所需M币：" + m004);
         Game.testText.addTestText("副武器位置开启所需M币：" + m005);
         Game.testText.addTestText("超合金Y所需M币：" + ynum);
         Game.testText.addTestText("拆解器所需M币：" + cnum);
         Game.testText.addTestText("全能训练所需M币：" + all_train_M);
         return allM;
      }
      
      public function affter_getTotalRecharged() : *
      {
         if(Game.gameData.level <= 0 && (Game.nowSaveIndex == 0 || Game.nowSaveIndex == 1))
         {
            Game.gameData.backstageMCoin = this.totalRecharged;
         }
         if(Game.uiGroup.newVB)
         {
            Game.gameData.rankAdd.oldRecharged2 = this.getTrueTotalRecharged();
            Game.gameData.rankAdd.oldRecharged = this.getTrueTotalRecharged();
            this.nowRecharged = 0;
            Game.uiGroup.newVB = false;
         }
         else
         {
            this.nowRecharged = this.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged;
         }
         if(Game.gameData.rankAdd.oldRecharged_1 == -1 && Game.gameData.rankAdd.oldRecharged2_1 == -1)
         {
            Game.gameData.rankAdd.oldRecharged2_1 = this.getTrueTotalRecharged();
            Game.gameData.rankAdd.oldRecharged_1 = this.getTrueTotalRecharged();
         }
      }
      
      public function payCtrl(str0:String, noCompleteB:Boolean = false) : *
      {
         Game.testText.addTestText("<<<<<<<<< 发送支付命令：" + str0 + "conectB:" + this.connectB);
         if(Boolean(this.serviceHold))
         {
            if(str0 == "showLogPanel")
            {
               this.serviceHold.showLogPanel();
            }
            else if(str0 == "incMoney")
            {
               this.serviceHold.incMoney_As3(this.payMoneyVar);
            }
            else if(str0 == "decMoney")
            {
               this.serviceHold.decMoney_As3(this.payMoneyVar);
            }
            else if(str0 == "getBalance")
            {
               this.serviceHold.getBalance();
            }
            else if(str0 == "payMoney")
            {
               this.serviceHold.payMoney_As3(this.payMoneyVar);
            }
            else if(str0 == "getTotalPaied")
            {
               this.serviceHold.getTotalPaiedFun();
            }
            else if(str0 == "getTotalRecharged")
            {
               this.serviceHold.getTotalRechargedFun();
            }
            else if(str0 == "")
            {
            }
         }
         else if(!noCompleteB)
         {
            if(str0 == "getBalance")
            {
               this.nowMCoin = Game.gameData.MCoin;
               this.fleshMCoin();
               this.doYesFun();
            }
            else if(str0 == "getTotalPaied" || str0 == "getTotalRecharged")
            {
               this.doYesFun();
            }
            else
            {
               this.doNoFun("离线模式不支持此在线支付操作。");
            }
         }
      }
      
      public function onPayEventHandler(e:PayEvent) : void
      {
         var pay0:Number = NaN;
         var pay2:Number = NaN;
         this.testText.addTestText(String("支付事件类型--------->" + e.type + "  e.data is Boolean------>" + (e.data is Boolean)));
         var balance0:int = -1;
         var doFunType:int = 0;
         var saveB:Boolean = false;
         switch(e.type)
         {
            case "logsuccess":
               this.testText.addTestText("登录成功------>uid:" + e.data.uid + "  name:" + e.data.name);
               break;
            case "usePayApi":
               this.testText.addTestText("可以正常使用支付API");
               this.isNormal = true;
               Game.payController2.isNormal = this.isNormal;
               this.payCtrl("getBalance",true);
               break;
            case "incMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  this.testText.addTestText("增加游戏币后的余额为：" + e.data.balance);
                  balance0 = int(e.data.balance);
                  if(!Game.cheating.nowMcoinInB)
                  {
                     Game.gameData.backstageMCoin += this.payMoneyVar.money;
                  }
                  else
                  {
                     Game.cheating.nowMcoinInB = false;
                  }
                  Game.testText.addTestText("存档内排除累计充值数：" + Game.gameData.backstageMCoin);
                  doFunType = 1;
                  break;
               }
               this.testText.addTestText("增加游戏币错误！");
               doFunType = 2;
               break;
            case "decMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  this.testText.addTestText("减少游戏币后的余额为：" + e.data.balance);
                  balance0 = int(e.data.balance);
                  doFunType = 1;
                  saveB = true;
                  break;
               }
               this.testText.addTestText("减少游戏币错误！");
               doFunType = 2;
               break;
            case "getMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  this.testText.addTestText("获取游戏币余额为：" + e.data.balance);
                  balance0 = int(e.data.balance);
                  if(this.changeUIB)
                  {
                     doFunType = 1;
                  }
                  break;
               }
               this.testText.addTestText("获取游戏币余额错误！");
               if(this.changeUIB)
               {
                  doFunType = 2;
               }
               break;
            case "payMoney":
               this.testText.addTestText("充值游戏币失败");
               this.payMoneyFail();
               break;
            case "paiedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  this.testText.addTestText("获取累积消费的游戏币为：" + e.data.balance);
                  this.paiedMoneyZuobi(e.data.balance);
                  break;
               }
               this.testText.addTestText("获取累积消费的游戏币错误！");
               break;
            case "rechargedMoney":
               if(e.data !== null && !(e.data is Boolean))
               {
                  this.testText.addTestText("获取累积充值的游戏币为：" + e.data.balance);
                  this.totalRecharged = e.data.balance;
                  this.affter_getTotalRecharged();
                  doFunType = 1;
                  pay0 = this.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged2_1;
                  pay2 = this.getTrueTotalRecharged() - Game.gameData.rankAdd.oldRecharged_1;
                  if(pay0 == pay2)
                  {
                     this.testText.addTestText("玩具充值总数为：" + pay0);
                  }
                  else
                  {
                     this.testText.addTestText("玩具充值总数异常：N1: " + pay2 + " N2:" + pay0);
                  }
                  break;
               }
               this.testText.addTestText("获取累积充值的游戏币错误！");
               doFunType = 2;
               break;
            case "payError":
               if(e.data == null)
               {
                  break;
               }
               this.testText.addTestText("使用支付接口其他错误----->" + e.data.info);
               doFunType = 2;
         }
         if(this.isNormal)
         {
            if(balance0 >= 0)
            {
               this.nowMCoin = balance0;
               this.fleshMCoin();
            }
            if(doFunType == 1)
            {
               this.testText.addTestText("doFunType：" + doFunType + "   执行 doYesFun()");
               this.doYesFun();
            }
            else if(doFunType == 2)
            {
               this.testText.addTestText("doFunType：" + doFunType + "   执行 doNoFun()");
               this.doNoFun();
            }
         }
         this.connectB = false;
         if(saveB)
         {
            Game.uiGroup.saveDataNoUI();
         }
      }
      
      public function getStoreState(yesFun0:Function = null) : *
      {
         this.noMultipleFun = yesFun0;
         if(Boolean(this.serviceHold))
         {
            this.serviceHold.getStoreState();
         }
         else if(this.noMultipleFun is Function)
         {
            this.noMultipleFun();
            this.noMultipleFun = null;
         }
      }
      
      public function multipleErrorHandler(evt:Event = null) : void
      {
         Game.uiGroup.loadingUI.visible = false;
         Game.loadingUI.visible = false;
         Game.eventGroup.clearAllCtrl();
         Game.uiGroup.checkTip.showCheck2("游戏多开，不能完成此操作！请重新登录。");
         trace("游戏多开了！");
      }
      
      public function getStoreStateHandler(evt:DataEvent) : void
      {
         Game.testText.addTestText("多开状态检测：" + evt.data);
         if(int(evt.data) == 0)
         {
            this.multipleErrorHandler();
         }
         else if(int(evt.data) == -3)
         {
            Game.uiGroup.checkTip.showCheck2("当前游戏账号不是最新的游戏账号,请重新登陆。");
         }
         else if(this.noMultipleFun is Function)
         {
            this.noMultipleFun();
            this.noMultipleFun = null;
         }
      }
   }
}

