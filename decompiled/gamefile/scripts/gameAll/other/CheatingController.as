package gameAll.other
{
   import UI.exchange.Douwa_Exchange_API;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import gameAll.data.CarItemsData;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.car.CarDataCreator;
   import gameAll.data.weekExtra.WeekExtraOneData;
   import gameAll.define.liveness.LivenessTaskDefine;
   import gameAll.facebook.fb_Save_api;
   
   public class CheatingController
   {
      
      internal var cheatingStr:String = "";
      
      internal var unlockB:Boolean = false;
      
      public var nowMcoinInB:Boolean = false;
      
      public var checkZuobi:Boolean = true;
      
      public var douwa_api:Douwa_Exchange_API = new Douwa_Exchange_API();
      
      public var fb_api:fb_Save_api = new fb_Save_api();
      
      public var now_t:int = 0;
      
      public var max_t:int = 1800;
      
      public var jumpNum0:int = 0;
      
      public var jumpNum400:int = 0;
      
      public var jumpNum200:int = 0;
      
      public var prevPoint:Point = new Point();
      
      public function CheatingController()
      {
         super();
      }
      
      public function cheating(event:KeyboardEvent) : *
      {
         if(this.cheatingStr.length > 40)
         {
            this.cheatingStr = this.cheatingStr.substr(1);
         }
         if(event.keyCode == 32)
         {
            this.cheatingByStr(this.cheatingStr);
            this.cheatingStr = "";
         }
         else
         {
            this.cheatingStr += String.fromCharCode(event.keyCode);
         }
      }
      
      public function cheatingByStr(str0:String) : *
      {
         var ii:* = undefined;
         var xx11:Number = NaN;
         var da0098:CarItemsData = null;
         var arr_showpay:Array = null;
         var diff00:int = 0;
         var arr4:Array = null;
         var i:int = 0;
         var arr100:Array = null;
         var n:* = undefined;
         var i9:int = 0;
         var arr102:Array = null;
         var n102:* = undefined;
         var i90:int = 0;
         var d009:LivenessTaskDefine = null;
         var str002:String = null;
         var value002:Number = NaN;
         var d001:* = undefined;
         var d002:WeekExtraOneData = null;
         var arr004:Array = null;
         var chip_name1:String = null;
         var chip_d1:GoodsItemsData = null;
         var dddd1:* = undefined;
         var dddd2:* = undefined;
         var namestr:String = null;
         var crystalName:String = null;
         var GD:GameData = Game.gameData;
         if(Game.gameDefine != null)
         {
            if(!Game.gameDefine.getTestB() && !this.unlockB && str0.indexOf("WHOSYOUERDADDY") == -1)
            {
               return;
            }
            var value0:int = 0;
            if(str0.indexOf("COIN") >= 0)
            {
               value0 = int(str0.split("COIN")[1]);
               if(value0 > 0)
               {
                  trace("加金币：" + value0);
                  Game.gameData.addCoin(value0);
                  Game.uiGroup.shopUI.fleshPrice();
               }
            }
            else if(str0.indexOf("HIDELOADER") >= 0)
            {
               Game.uiGroup.loadingUI.hide();
               Game.loadingUI.hide();
            }
            else if(str0.indexOf("NEWTEST") >= 0)
            {
               value0 = int(str0.split("NEWTEST")[1]);
               xx11 = 0;
               if(value0 == 0)
               {
                  GD.levelsLock = [31,31,1,1,1];
                  GD.knowingData.levelsLock = [16,15,0,0];
                  GD.ghostData.levelsLock = [1,0,0,0];
                  GD.passData.setScore(70,5,0,"");
                  GD.passData.setScore(71,16,1,"");
                  GD.passData.setScore(80,7,0,"knowing");
                  GD.passData.setScore(81,1,2,"knowing");
                  GD.passData.setScore(90,1,0,"ghost");
                  GD.passData.setScore(91,4,1,"ghost");
                  GD.newLevelData.switchData(GD.levelsLock,GD.knowingData.levelsLock,GD.ghostData.levelsLock,GD.passData.OBJ);
                  xx11 = 0;
               }
               else if(value0 == 1)
               {
                  xx11 = 1;
               }
            }
            else if(str0.indexOf("ADDARMS") >= 0)
            {
               Game.gameData.armsItems.addItems("lightKnife");
            }
            else if(str0.indexOf("ADDKAISA") >= 0)
            {
               Game.gameData.armsItems.addItems("kaisazhilei_lv1");
            }
            else if(str0.indexOf("ADDCAR") >= 0)
            {
               da0098 = Game.gameData.carItems.addItems("jiadihuanzhanche");
               CarDataCreator.setCustomData(da0098);
            }
            else if(str0.indexOf("ADDAIDECARD") >= 0)
            {
               Game.gameData.propsItems.addItems("aide_card",10);
            }
            else if(str0.indexOf("SETVIP") >= 0)
            {
               value0 = int(str0.split("SETVIP")[1]);
               Game.gameData.vipData.setVip("vipCard_" + value0);
            }
            else if(str0.indexOf("SHOWMAIN") >= 0)
            {
               Game.uiGroup.show("");
               Game.uiGroup._changeUI.visible = true;
               Game.uiGroup._changeUI.fleshData();
            }
            else if(str0.indexOf("SHOWSEVER") >= 0)
            {
               Game.uiGroup.show("");
               Game.uiGroup.serverUI.show();
            }
            else if(str0.indexOf("ADDWEEKTASKNUM") >= 0)
            {
               value0 = int(str0.split("ADDWEEKTASKNUM")[1]);
               if(value0 > 0)
               {
                  trace("作弊添加怪物数量：" + value0);
                  Game.gameData.weekTaskData.addKillNum(value0);
               }
            }
            else if(str0.indexOf("SETEXP") >= 0)
            {
               value0 = int(str0.split("SETEXP")[1]);
               if(value0 > 0)
               {
                  Game.gameData.nowExp = value0;
               }
            }
            else if(str0.indexOf("SHOWWEEKTASK") < 0)
            {
               if(str0.indexOf("ADDCHIPBAG") >= 0)
               {
                  Game.gameData.propsItems.addItems("chipBag20",10);
                  Game.gameData.propsItems.addItems("chipBag40",10);
                  Game.gameData.propsItems.addItems("chipBag60",10);
                  Game.gameData.propsItems.addItems("chipBag80",10);
                  Game.gameData.propsItems.addItems("chipBag100",10);
               }
               else if(str0.indexOf("NEWWEEK") >= 0)
               {
                  Game.gameData.weekTaskData.newWeekCtrl();
               }
               else if(str0.indexOf("SHOWLOGIN") >= 0)
               {
                  Game.save_api.showLogPanel();
               }
               else if(str0.indexOf("ISLOGIN") >= 0)
               {
                  Game.testText.addTestText("当前是否登录：" + Game.getIsLoginB());
               }
               else if(str0.indexOf("HEROAI") < 0)
               {
                  if(str0.indexOf("ADDMONEY") >= 0)
                  {
                     value0 = int(str0.split("ADDMONEY")[1]);
                     if(value0 > 0)
                     {
                        if(Boolean(Game.serviceHold))
                        {
                           Game.payController.payMoneyVar.money = value0;
                           Game.payController.payCtrl("incMoney");
                           Game.uiGroup.shopUI.fleshPrice();
                           this.nowMcoinInB = false;
                        }
                        else
                        {
                           Game.payController.nowMCoin = value0;
                           Game.gameData.MCoin = value0;
                           Game.uiGroup.shopUI.fleshPrice();
                        }
                     }
                  }
                  else if(str0.indexOf("INCMONEY") >= 0)
                  {
                     value0 = int(str0.split("INCMONEY")[1]);
                     if(value0 > 0)
                     {
                        Game.payController.payMoneyVar.money = value0;
                        Game.payController.payCtrl("incMoney");
                        Game.uiGroup.shopUI.fleshPrice();
                        this.nowMcoinInB = true;
                     }
                  }
                  else if(str0.indexOf("DECMONEY") >= 0)
                  {
                     value0 = int(str0.split("DECMONEY")[1]);
                     if(value0 > 0)
                     {
                        Game.payController.payMoneyVar.money = value0;
                        Game.payController.payCtrl("DECMoney");
                        Game.uiGroup.shopUI.fleshPrice();
                     }
                  }
                  else if(str0.indexOf("ADDSIGN") >= 0)
                  {
                     value0 = int(str0.split("ADDSIGN")[1]);
                     if(value0 > 0)
                     {
                        Game.uiGroup.dailySignUI.addSign(value0);
                     }
                  }
                  else if(str0.indexOf("SHOWFACE") >= 0)
                  {
                     Game.uiGroup.show("fase");
                  }
                  else if(str0.indexOf("SHOWPAY") >= 0)
                  {
                     arr_showpay = Game.uiGroup.highUI.verticalLabel.arr;
                     arr_showpay[arr_showpay.length - 1].visible = true;
                  }
                  else if(str0.indexOf("SHOWGAMING") >= 0)
                  {
                     Game.uiGroup.show("resumeGame");
                  }
                  else if(str0.indexOf("XIAOFEI") >= 0)
                  {
                     Game.payController2.payCtrl("getTotalPaied");
                  }
                  else if(str0.indexOf("CHONGZHI") >= 0)
                  {
                     Game.payController2.payCtrl("getTotalRecharged");
                  }
                  else if(str0.indexOf("EXPLORE") >= 0)
                  {
                     Game.uiGroup.show("explore");
                  }
                  else if(str0.indexOf("EXCHANGE") >= 0)
                  {
                     Game.uiGroup.show("exchange");
                  }
                  else if(str0.indexOf("GAMEWIN") >= 0)
                  {
                     Game.uiGroup.show("gameWin");
                  }
                  else if(str0.indexOf("GAMEFAIL") >= 0)
                  {
                     Game.uiGroup.show("gameFail");
                  }
                  else if(str0.indexOf("FLESHTASK") >= 0)
                  {
                     Game.uiGroup.mainUI.taskUI.affterFleshList2();
                  }
                  else if(str0.indexOf("CHOOSEROLE") >= 0)
                  {
                     Game.uiGroup.show("createRole");
                  }
                  else if(str0.indexOf("LEVEL") >= 0)
                  {
                     value0 = int(str0.split("LEVEL")[1]);
                     if(value0 > 0)
                     {
                        diff00 = int(value0 / 100);
                        Game.gameData.newLevelData["p" + (diff00 + 1)].lockNum = value0 % 100;
                        Game.uiGroup.chooseLevelUI.fleshLock();
                     }
                  }
                  else if(str0.indexOf("LV") >= 0)
                  {
                     value0 = int(str0.split("LV")[1]);
                     if(value0 > 0)
                     {
                        Game.gameData.level = value0 - 1;
                        Game.gameData.setValue_byLevel();
                     }
                     else
                     {
                        ++Game.gameData.level;
                        Game.gameData.setValue_byLevel();
                     }
                     if(Game.gameData.score < 99999999)
                     {
                        Game.gameData.addScore(99999999);
                     }
                  }
                  else if(str0.indexOf("SETSCORE") >= 0)
                  {
                     value0 = int(str0.split("SETSCORE")[1]);
                     if(value0 > 0)
                     {
                        Game.gameData.score = value0;
                     }
                  }
                  else if(str0.indexOf("SETLLSCORE") >= 0)
                  {
                     value0 = int(str0.split("SETLLSCORE")[1]);
                     if(value0 > 0)
                     {
                        Game.uiGroup.chooseLevelUI.setNowStar(value0);
                        Game.uiGroup.chooseLevelUI.fleshData();
                     }
                  }
                  else if(str0.indexOf("NOZUOBI") >= 0)
                  {
                     Game.gameData.isZuobi = false;
                     Game.gameData.testRankZuobiB = false;
                     Game.uiGroup.saveData();
                     this.checkZuobi = false;
                     Game.uiGroup.checkTip.hide();
                  }
                  else if(str0.indexOf("NOCHECK") >= 0)
                  {
                     this.checkZuobi = false;
                     Game.uiGroup.checkTip.hide();
                  }
                  else if(str0.indexOf("ISZUOBI") >= 0)
                  {
                     Game.gameData.isZuobi = false;
                     Game.gameData.testRankZuobiB = false;
                  }
                  else if(str0.indexOf("TIME2") >= 0)
                  {
                     value0 = int(str0.split("TIME2")[1]);
                     Game.testTimeAdjust = value0;
                     Game.testText.addTestText("Game.testTimeAdjust:" + Game.testTimeAdjust);
                  }
                  else if(str0.indexOf("TIMEF2") >= 0)
                  {
                     value0 = int(str0.split("TIMEF2")[1]);
                     Game.testTimeAdjust = -value0;
                     Game.testText.addTestText("Game.testTimeAdjust:" + Game.testTimeAdjust);
                  }
                  else if(str0.indexOf("SKILL") >= 0)
                  {
                     value0 = int(str0.split("SKILL")[1]);
                     arr4 = [value0,value0,value0,value0,value0];
                     Game.gameData.playerData.setFullSkillArr(arr4);
                     Game.eventGroup.fleshSkill();
                  }
                  else if(str0.indexOf("ADDACHIEVE") >= 0)
                  {
                     value0 = int(str0.split("ADDACHIEVE")[1]);
                     if(value0 > 0)
                     {
                        Game.gameData.addAchieve(value0);
                        Game.uiGroup.rankUI.fleshData();
                     }
                  }
                  else if(str0.indexOf("UNLOCKALL") >= 0)
                  {
                     Game.gameData.armsItems.armsState = ["","","","","",""];
                     Game.gameData.subItems.armsState = ["","","","","","","",""];
                     Game.uiGroup.changeUI.fleshAll();
                  }
                  else if(str0.indexOf("UNLOCK33") < 0)
                  {
                     if(str0.indexOf("WANGYING") < 0)
                     {
                        if(str0.indexOf("SHABI") < 0)
                        {
                           if(str0.indexOf("RANK") >= 0)
                           {
                              value0 = int(str0.split("RANK")[1]);
                              if(value0 > 0)
                              {
                                 Game.gameData.rankLevel = value0 - 1;
                                 Game.gameData.fleshExp_Achieve();
                                 Game.gameData.rankAdd.upDataInitAll();
                              }
                              else
                              {
                                 ++Game.gameData.rankLevel;
                                 Game.gameData.fleshExp_Achieve();
                                 Game.gameData.rankAdd.upDataInitAll();
                              }
                           }
                           else if(str0.indexOf("MENU") >= 0)
                           {
                              Game.uiGroup.leftUI.showBtn();
                           }
                           else if(str0.indexOf("SHAOBAI") >= 0)
                           {
                              this.cheatingByStr("LEVEL6");
                              this.cheatingByStr("WANGYING");
                           }
                           else if(str0.indexOf("CLEAR") >= 0)
                           {
                              Game.uiGroup.clearData();
                           }
                           else if(str0.indexOf("ADDKILLNUM") >= 0)
                           {
                              value0 = int(str0.split("ADDKILLNUM")[1]);
                              if(Game.gameData.taskData.nowTask.state != "no")
                              {
                                 for(i = 0; i < value0; i++)
                                 {
                                    Game.gameData.taskData.nowTask.addKillNum();
                                 }
                              }
                              else
                              {
                                 Game.gameData.challengeTaskData.completeNowTask();
                              }
                           }
                           else if(str0.indexOf("ADDALLTRAIN") >= 0)
                           {
                              value0 = int(str0.split("ADDALLTRAIN")[1]);
                              if(value0 > 1)
                              {
                                 Game.gameData.playerData.allAdd.levelUp(value0);
                                 Game.uiGroup.researchUI.playerBox.fleshAll();
                              }
                           }
                           else if(str0.indexOf("SETALLTRAIN") >= 0)
                           {
                              value0 = int(str0.split("SETALLTRAIN")[1]);
                              if(value0 >= 0)
                              {
                                 Game.gameData.playerData.allAdd.setLevel(value0);
                                 Game.uiGroup.researchUI.playerBox.fleshAll();
                              }
                           }
                           else if(str0.indexOf("UNLOCKBAG") >= 0)
                           {
                              value0 = int(str0.split("UNLOCKBAG")[1]);
                              if(value0 > 0)
                              {
                                 Game.gameData.materialsItems.bagMaxNum += value0;
                                 Game.uiGroup.changeUI.materialsUI.fleshAll();
                              }
                           }
                           else if(str0.indexOf("ADDCRY") >= 0)
                           {
                              value0 = int(str0.split("ADDCRY")[1]);
                              if(value0 == 1)
                              {
                                 Game.gameData.materialsItems.addItems("green_crystal_2");
                              }
                              else if(value0 == 2)
                              {
                                 Game.gameData.materialsItems.addItems("red_crystal_1");
                              }
                              else if(value0 == 3)
                              {
                                 Game.gameData.materialsItems.addItems("yellow_crystal_3");
                              }
                              else if(value0 == 4)
                              {
                                 Game.gameData.materialsItems.addItems("purple_crystal_4");
                              }
                           }
                           else if(str0.indexOf("TESTPAY") >= 0)
                           {
                              value0 = int(str0.split("TESTPAY")[1]);
                              if(value0 >= 0)
                              {
                                 Game.payController.payMoneySuccess(value0);
                              }
                           }
                           else if(str0.indexOf("ADDXZ") >= 0)
                           {
                              value0 = int(str0.split("ADDXZ")[1]);
                              if(value0 > 0)
                              {
                                 Game.gameData.propsItems.addItems("justice_badge",value0);
                              }
                           }
                           else if(str0.indexOf("ADDX") >= 0)
                           {
                              value0 = int(str0.split("ADDX")[1]);
                              if(value0 >= 0)
                              {
                                 Game.gameData.materialsItems.addItems("superalloy_X",value0);
                                 Game.uiGroup.changeUI.materialsUI.fleshAll();
                              }
                           }
                           else if(str0.indexOf("TUTORIAL") >= 0)
                           {
                              Game.uiGroup.show("gameWin");
                              Game.uiGroup.tutorialUI.toTutorial();
                           }
                           else if(str0.indexOf("JIANM") >= 0)
                           {
                              value0 = int(str0.split("JIANM")[1]);
                              Game.payController.beforeMCoin -= value0;
                           }
                           else if(str0.indexOf("FIRSTTIMEDATA") >= 0)
                           {
                              Game.gameData.rankAdd.firstTimeDate.decDay();
                              Game.gameData.rankAdd.getLoginGiftTime.inData_byObj(Game.gameData.rankAdd.firstTimeDate);
                           }
                           else if(str0.indexOf("DELALL") >= 0)
                           {
                              Game.gameData.materialsItems.delAll();
                              Game.uiGroup.changeUI.materialsUI.fleshAll();
                              Game.gameData.propsItems.delAll();
                              Game.uiGroup.changeUI.propsUI.fleshAll();
                           }
                           else if(str0.indexOf("ADDCAILIAO") >= 0)
                           {
                              arr100 = ["buncher","boom","thorn"];
                              for(n in arr100)
                              {
                                 for(i9 = 1; i9 <= 5; i9++)
                                 {
                                    Game.gameData.materialsItems.addItems(arr100[n] + "_" + i9,4000);
                                 }
                              }
                              Game.gameData.materialsItems.addItems("superalloy",9000);
                              Game.gameData.materialsItems.addItems("superalloy_Z",4000);
                              Game.gameData.materialsItems.addItems("superalloy_X",4000);
                              Game.gameData.materialsItems.addItems("superalloy_Y",4000);
                              Game.gameData.propsItems.addItems("superalloyStone",100);
                           }
                           else if(str0.indexOf("ADDJINGTI") >= 0)
                           {
                              value0 = int(str0.split("ADDJINGTI")[1]);
                              arr102 = ["red","green","yellow","purple"];
                              for(n102 in arr102)
                              {
                                 for(i90 = 1; i90 <= 8; i90++)
                                 {
                                    Game.gameData.materialsItems.addItems(arr102[n102] + "_crystal_" + i90,value0);
                                 }
                              }
                           }
                           else if(str0.indexOf("NIUBI") >= 0)
                           {
                              this.niubiSave2();
                           }
                           else if(str0.indexOf("CESHI") >= 0)
                           {
                              Game.gameData.subItems.addItems("killPig_lv1");
                           }
                           else if(str0.indexOf("ADDLIGHT") >= 0)
                           {
                              trace("");
                              Game.gameData.groupData.setLight(true);
                           }
                           else if(str0.indexOf("DELLIGHT") >= 0)
                           {
                              Game.gameData.groupData.setLight(false);
                           }
                           else if(str0.indexOf("NEWDAY") >= 0)
                           {
                              Game.gameData.newDayCtrl();
                           }
                           else if(str0.indexOf("ADDLIVENESS") >= 0)
                           {
                              value0 = int(str0.split("ADDLIVENESS")[1]);
                              if(value0 >= 0)
                              {
                                 Game.gameData.livenessData.addValue(value0);
                              }
                           }
                           else if(str0.indexOf("ADDLIVETASK") >= 0)
                           {
                              value0 = int(str0.split("ADDLIVETASK")[1]);
                              if(value0 >= 0)
                              {
                                 d009 = Game.gameDefine.liveness.taskArr[value0];
                                 if(d009 is LivenessTaskDefine)
                                 {
                                    Game.gameData.livenessData.addTaskNum(d009.id);
                                 }
                              }
                              Game.uiGroup.mainUI.livenessUI.fleshData();
                           }
                           else if(str0.indexOf("ADDZHANDOU") >= 0)
                           {
                              value0 = int(str0.split("ADDZHANDOU")[1]);
                              Game.gameData.propsItems.addItems("drop_box",value0);
                              Game.gameData.propsItems.addItems("drop_box_2",value0);
                              Game.gameData.propsItems.addItems("drop_box_3",value0);
                              Game.gameData.propsItems.addItems("disassemble_2",value0);
                              Game.gameData.propsItems.addItems("disassemble_3",value0);
                           }
                           else if(str0.indexOf("HIGHTEST") >= 0)
                           {
                              value0 = int(str0.split("HIGHTEST")[1]);
                              Game.high_api.test(value0);
                           }
                           else if(str0.indexOf("SETBOSSLIFE") >= 0)
                           {
                              str002 = str0.split("SETBOSSLIFE")[1];
                              value002 = Number(str002.split("A")[1]);
                              value0 = int(str002.split("A")[0]);
                              d001 = Game.gameData.weekExtraData;
                              d002 = Game.gameData.weekExtraData.arr[value0 - 1];
                              if(d002 is WeekExtraOneData)
                              {
                                 d002.nowLife = value002;
                                 Game.testText.addTestText("把玩家副本：" + value0 + "，Boss血量改为：" + value002);
                              }
                              else
                              {
                                 Game.testText.addTestText("玩家副本不存在数据：" + value0);
                              }
                           }
                           else if(str0.indexOf("INITWEEKEXTRA") >= 0)
                           {
                              Game.gameData.weekExtraData.init();
                           }
                           else if(str0.indexOf("GETMAXARMS") >= 0)
                           {
                              trace("获得最牛逼的武器：" + Game.gameData.getNiubiArms("arms").name);
                           }
                           else if(str0.indexOf("DELEXTRASCORE") >= 0)
                           {
                              Game.gameData.extraData.initScore();
                           }
                           else if(str0.indexOf("DELHIGHSCORE") >= 0)
                           {
                              Game.high_api.clearScoreB = !Game.high_api.clearScoreB;
                           }
                           else if(str0.indexOf("SETARENASCORE") >= 0)
                           {
                              value0 = int(str0.split("SETARENASCORE")[1]);
                              Game.testText.addTestText("作弊码：SETARENASCORE：" + value0);
                              Game.gameData.arenaData.score = value0;
                           }
                           else if(str0.indexOf("ADDSUIBIAN") >= 0)
                           {
                              value0 = int(str0.split("ADDSUIBIAN")[1]);
                              if(value0 > 0)
                              {
                                 Game.gameData.materialsItems.addItems("arms_fragment",value0);
                                 Game.gameData.materialsItems.addItems("shell_fragment",value0);
                                 Game.gameData.materialsItems.addItems("heart_fragment",value0);
                                 Game.gameData.propsItems.addItems("justice_badge",value0);
                                 Game.gameData.collectTaskData.setNum(value0);
                                 Game.uiGroup.mainUI.taskUI.collectUI.fleshData();
                              }
                           }
                           else if(str0.indexOf("SETBEFOREMONEY") >= 0)
                           {
                              value0 = int(str0.split("SETBEFOREMONEY")[1]);
                              if(value0 > 0)
                              {
                                 Game.gameData.backstageMCoin = value0;
                              }
                           }
                           else if(str0.indexOf("DELBEFOREARENASCORE") >= 0)
                           {
                              Game.gameData.arenaData.beforeScore = 0;
                           }
                           else if(str0.indexOf("SHOWBEFOREARENASCORE") >= 0)
                           {
                              Game.testText.addTestText("玩家修改之前的竞技场积分：" + Game.gameData.arenaData.beforeScore);
                           }
                           else if(str0.indexOf("DOUWA") >= 0)
                           {
                              this.douwa_api.startExchange(Game.gameData.uid,"dfefgds");
                           }
                           else if(str0.indexOf("CONTINUE") >= 0)
                           {
                              Game.uiGroup.show("startGame");
                              Game.uiGroup.mainUI.startGettingPan();
                           }
                           else if(str0.indexOf("DELFOREVER") >= 0)
                           {
                              Game.gameData.foreverDefence = 0;
                              Game.gameData.foreverLife = 0;
                           }
                           else if(str0.indexOf("SHOWFOREVER") >= 0)
                           {
                              Game.testText.addTestText("永久防御:" + Game.gameData.foreverDefence);
                              Game.testText.addTestText("永久生命:" + Game.gameData.foreverLife);
                           }
                           else if(str0.indexOf("FB1") >= 0)
                           {
                              this.fb_api.save(new GameData());
                           }
                           else if(str0.indexOf("FB2") >= 0)
                           {
                              this.fb_api.getSave();
                           }
                           else if(str0.indexOf("ADDCHIP") >= 0)
                           {
                              Game.gameData.materialsItems.addItems("white_chip");
                              Game.gameData.materialsItems.addItems("blue_chip");
                              Game.gameData.materialsItems.addItems("yellow_chip");
                              Game.gameData.materialsItems.addItems("orange_chip");
                              Game.gameData.materialsItems.addItems("green_chip");
                           }
                           else if(str0.indexOf("ADDPURPLECHIP") >= 0)
                           {
                              arr004 = ["kuang","nu"];
                              for(ii in arr004)
                              {
                                 chip_name1 = arr004[ii] + "_purple_chip";
                                 chip_d1 = Game.gameData.materialsItems.addItems(chip_name1);
                                 chip_d1.addArr = Game.gameDefine.purpleChip.getAddArr(chip_name1);
                                 chip_d1.affixLevel = 79;
                              }
                           }
                           else if(str0.indexOf("ADDARENAHONOR") >= 0)
                           {
                              value0 = int(str0.split("ADDARENAHONOR")[1]);
                              dddd1 = Game.gameDefine.honor.getExtraDefine("arena_" + value0);
                              Game.gameData.honorData.addHonorDefine(dddd1);
                           }
                           else if(str0.indexOf("ADDDARENHONOR") >= 0)
                           {
                              value0 = int(str0.split("ADDDARENHONOR")[1]);
                              dddd2 = Game.gameDefine.honor.getExtraDefine("fighting_" + value0);
                              Game.gameData.honorData.addHonorDefine(dddd2);
                           }
                           else if(str0.indexOf("ADDBAZHUHONOR") >= 0)
                           {
                              Game.gameData.honorData.addHonorDefine(Game.gameDefine.honor.getExtraDefine("king_0"));
                           }
                           else if(str0.indexOf("ADDSTARHONOR") >= 0)
                           {
                              Game.gameData.honorData.addHonorDefine(Game.gameDefine.honor.getExtraDefine("star_0"));
                           }
                           else if(str0.indexOf("ADDZHANGSHEN") >= 0)
                           {
                              Game.gameData.carItems.addItems("purplex6");
                           }
                           else if(str0.indexOf("AC") >= 0)
                           {
                              Game.uiGroup.show("achievement");
                           }
                           else if(str0.indexOf("SHOUCHONG") >= 0)
                           {
                              Game.uiGroup.mainUI.firstPayUI.getFirstGift();
                           }
                           else if(str0.indexOf("VICRYSTAL") >= 0)
                           {
                              namestr = "";
                              switch(int(str0.split("VICRYSTAL")[1]))
                              {
                                 case 1:
                                    namestr = "purple";
                                    break;
                                 case 2:
                                    namestr = "green";
                                    break;
                                 case 3:
                                    namestr = "red";
                                    break;
                                 case 4:
                                    namestr = "yellow";
                              }
                              if(namestr != "")
                              {
                                 crystalName = "materials,\t\t" + namestr + "_crystal_vip,\t\t\t1";
                                 Game.uiGroup.addGift_byArr([crystalName]);
                              }
                           }
                        }
                     }
                  }
               }
            }
            return;
         }
      }
      
      public function levelUp(level0:int = 0) : *
      {
      }
      
      public function niubiSave(e:*) : *
      {
      }
      
      public function niubiSave2(e:* = null) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var carArr:Array = null;
         var i:* = undefined;
         this.cheatingByStr("COIN9999999999");
         Game.gameData.levelsLock = [31,31,31,31];
         Game.gameData.knowingData.levelsLock = [31,31,1,0];
         Game.gameData.ghostData.levelsLock = [1,0,0,0];
         this.cheatingByStr("LV69");
         this.cheatingByStr("SKILL12");
         this.cheatingByStr("RANK15");
         this.cheatingByStr("ADDMONEY10000");
         this.cheatingByStr("UNLOCKALL");
         var armsArr:Array = ["plasma_lv4","charged_lv4","lightning_lv4","etcg_lv4","wave_lv4"];
         var subArr:Array = ["chipped_lv4","hotline_lv4","lightningBall_lv4","cutter_lv4"];
         for(n in armsArr)
         {
            Game.gameData.armsItems.addArmsToEquip(armsArr[n]);
         }
         for(m in subArr)
         {
            Game.gameData.subItems.addArmsToEquip(subArr[m]);
         }
         this.cheatingByStr("ADDALLTRAIN100");
         carArr = ["glimpse2"];
         for(i in carArr)
         {
            Game.gameData.carItems.addItems(carArr[i]);
         }
         Game.gameData.carItems.addArmsToEquip("angelWings");
         this.cheatingByStr("ADDCAILIAO");
         this.cheatingByStr("ADDCAILIAO");
         Game.gameData.propsItems.addItems("disassemble",1000);
         Game.gameData.newDayCtrl();
         Game.uiGroup.carShow.copyAll();
         Game.gameData.fleshAdd_byItems();
      }
      
      public function checkNobodyTimer() : *
      {
         ++this.now_t;
         if(this.now_t > this.max_t)
         {
            this.now_t = 0;
            this.jumpNum0 = 0;
            this.jumpNum400 = 0;
            this.jumpNum200 = 0;
         }
         var p0:Point = new Point(Game.gameSprite.mouseX,Game.gameSprite.mouseY);
         var cx:int = Point.distance(p0,this.prevPoint);
         if(cx == 0)
         {
            ++this.jumpNum0;
         }
         else if(cx > 400)
         {
            ++this.jumpNum400;
         }
         else if(cx > 200)
         {
            ++this.jumpNum200;
         }
         if(this.jumpNum400 > 10)
         {
            Game.uiGroup.showZuobile("疑似挂机！请重新刷新页面！","疑似挂机！请刷新页面！");
         }
         this.prevPoint.x = p0.x;
         this.prevPoint.y = p0.y;
      }
   }
}

