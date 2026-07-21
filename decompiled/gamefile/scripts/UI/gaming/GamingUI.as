package UI.gaming
{
   import UI.login.HeadBtn;
   import data.StringToDefine;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   import gameAll.data.GameData;
   import gameAll.data.challenge.ChallengeTaskDefine;
   import gameAll.data.collect.CollectTaskDefine;
   import gameAll.define.OneTaskDefine;
   import gs.TweenLite;
   import gs.easing.Back;
   import image.GameSprite;
   import net.SWFLoaderManager;
   
   public class GamingUI extends Sprite
   {
      
      public var nowSaveNum:int = 0;
      
      public var nowState:String = "";
      
      public var GD:GameData;
      
      private var _bossBarTarget:* = null;
      
      public var bossBarB:Boolean = false;
      
      public var w:Number = 950;
      
      public var h:Number = 560;
      
      public var swf:SWFLoaderManager;
      
      public var GS:GameSprite;
      
      public var _mc:*;
      
      public var _mc2:ArenaGamingUI;
      
      public var playerName_txt:TextField;
      
      public var head_btn:HeadBtn;
      
      public var time_txt:TextField;
      
      public var gcoin_txt:TextField;
      
      public var score_txt:TextField;
      
      public var hitRate_txt:TextField;
      
      public var hurtNum_txt:TextField;
      
      public var life_bar:LifeBar;
      
      public var energy_bar:LifeBar;
      
      public var exp_bar:LifeBar;
      
      public var boss_bar:LifeBar2;
      
      public var lv_txt:TextField;
      
      public var expTime_txt:TextField;
      
      public var testTxt:TextField;
      
      public var timeLimit_txt:TextField;
      
      public var task_mc:*;
      
      public var pointer:MovieClip;
      
      public var arms1:GamingArmsIcon;
      
      public var arms2:GamingArmsIcon;
      
      public var arms3:GamingArmsIcon;
      
      public var arms4:GamingArmsIcon;
      
      public var arms5:GamingArmsIcon;
      
      public var arms6:GamingArmsIcon;
      
      public var arms7:GamingArmsIcon;
      
      public var arms8:GamingArmsIcon;
      
      public var arms_icon:Array;
      
      public var arms_y:int = 0;
      
      public var testArr:Array = [];
      
      public var nowArmsType:Array = [3,0,0,0,0,0];
      
      public var skillBox:SkillIconBox;
      
      public function GamingUI()
      {
         super();
         this.w = Game.stageWidth;
         this.h = Game.stageHeight;
      }
      
      public function init() : *
      {
         var i:* = undefined;
         var n:* = undefined;
         var name_Arr:Array = ["playerName_txt","head_btn","time_txt","gcoin_txt","score_txt","hitRate_txt","hurtNum_txt","life_bar","energy_bar","exp_bar","boss_bar","lv_txt","expTime_txt","testTxt","timeLimit_txt","task_mc","pointer"];
         for(i in name_Arr)
         {
            this[name_Arr[i]] = this._mc[name_Arr[i]];
         }
         this._mc2.visible = false;
         this.pointer.stop();
         this.pointer.visible = true;
         this.GS = Game.gameSprite;
         this.GD = Game.gameData;
         this.pointer.mouseChildren = false;
         this.pointer.mouseEnabled = false;
         this.arms_icon = [this.arms1,this.arms2,this.arms3,this.arms4,this.arms5,this.arms6,this.arms7,this.arms8];
         for(n in this.arms_icon)
         {
            this.arms_icon[n].numTxt.text = String(n + 1);
            this.arms_icon[n].setType(this.nowArmsType[n]);
         }
         this.boss_bar.visible = false;
         this.head_btn.goLabel("over");
         this.head_btn.mouseEnabled = false;
         this.testTxt.visible = false;
         this.task_mc.visible = false;
         this.timeLimit_txt.visible = false;
         this.skillBox = new SkillIconBox();
         addChild(this.skillBox);
         this.skillBox.x = 227;
         this.skillBox.y = 470;
         this.arms_y = this.arms1.y;
      }
      
      public function showState(str0:String = "") : *
      {
         if(str0 == "")
         {
            this._mc.visible = true;
            this._mc2.visible = false;
         }
         else if(str0 == "arena")
         {
            this._mc.visible = false;
            this._mc2.visible = true;
         }
      }
      
      public function fleshNameAndHead() : *
      {
         this.playerName_txt.htmlText = "<font color=\'#FFFF00\'>" + this.GD.playerRank + "</font>  " + this.GD.playerName;
         this.head_btn.setText(this.GD.headLabel);
      }
      
      public function addTestText(str0:String) : *
      {
         var text2:String = null;
         var n:* = undefined;
         if(Game.gameDefine.getTestB())
         {
            this.testArr.unshift(str0);
            this.testArr.length = 20;
            text2 = "";
            for(n in this.testArr)
            {
               text2 = this.testArr[n] + "\n" + text2;
            }
            this.testTxt.text = text2;
         }
      }
      
      public function showTaskBox(str0:String = "") : *
      {
         this.task_mc.visible = true;
         if(str0 != "")
         {
            this.task_mc.txt.htmlText = str0;
         }
      }
      
      public function hideTaskBox() : *
      {
         this.task_mc.visible = false;
      }
      
      public function fleshTaskBox() : *
      {
         var td0:OneTaskDefine = Game.gameData.taskData.nowTask;
         var cd0:ChallengeTaskDefine = Game.gameData.challengeTaskData.nowTask;
         var cd2:CollectTaskDefine = Game.gameData.collectTaskData.nowTask;
         var cd3:CollectTaskDefine = Game.gameData.weekTaskData.nowTask;
         var str0:String = "";
         if(td0.state != "no")
         {
            str0 += td0.getDiffString() + "“" + this.getFontColor(td0.getLevelString(),"#33FF00") + "”";
            str0 += "\n击杀任意怪物";
            str0 += "\n已经击杀 " + this.getFontColor(td0.completeNum + "/" + td0.maxNum,"#33FF00") + " 只";
            if(td0.state == "complete")
            {
               str0 += this.getFontColor("（已完成）","#FFFF00");
            }
            this.showTaskBox(str0);
         }
         else if(cd0 is ChallengeTaskDefine)
         {
            str0 += cd0.getDiffString() + "“" + this.getFontColor(Game.LG.filter.getBeforeLevel(cd0.targetDiff,cd0.targetLevel).name,"#33FF00") + "”";
            str0 += "\n击杀目标“" + this.getFontColor(cd0.enemyName,"#33FF00") + "”";
            str0 += "\n" + this.getFontColor(cd0.getRequest(),"#FF66FF");
            if(cd0.state == "ing")
            {
               if(this.GD.challengeTaskData.getFail(cd0.index) == "timeout")
               {
                  str0 += this.getFontColor("（时间超出，未完成）","#FF0000");
               }
               else if(this.GD.challengeTaskData.getFail(cd0.index) == "died")
               {
                  str0 += this.getFontColor("（死亡一次，未完成）","#FF0000");
               }
               else
               {
                  str0 += this.getFontColor("（进行中……）","#33FF00");
               }
            }
            else if(cd0.state == "complete")
            {
               str0 += this.getFontColor("（已完成）","#FFFF00");
            }
            this.showTaskBox(str0);
         }
         else if(cd2 is CollectTaskDefine)
         {
            str0 += "“第六章-第九章”任意关卡";
            str0 += "\n收集“" + this.getFontColor(cd2.cnItems,"#FF66FF") + "”" + cd2.targetNum + "个\n";
            if(cd2.state == "ing")
            {
               str0 += this.getFontColor("（已收集" + this.GD.collectTaskData.nowNum + "个）","#33FF00");
            }
            else if(cd2.state == "complete")
            {
               str0 += this.getFontColor("（已完成）","#FFFF00");
            }
            this.showTaskBox(str0);
         }
         else if(cd3 is CollectTaskDefine)
         {
            str0 += "任意关卡";
            str0 += "\n杀死怪物" + cd3.targetNum + "个\n";
            if(cd3.state == "ing")
            {
               str0 += this.getFontColor("（已杀死" + this.GD.weekTaskData.nowNum + "个）","#33FF00");
            }
            else if(cd3.state == "complete")
            {
               str0 += this.getFontColor("（已完成）","#FFFF00");
            }
            this.showTaskBox(str0);
         }
         else
         {
            this.hideTaskBox();
         }
      }
      
      public function fleshBar() : *
      {
         var n:* = undefined;
         var id0:ArmsItemsData = null;
         var site0:int = 0;
         var icon0:GamingArmsIcon = null;
         this.GD.gameTime += 1 / 6;
         if(this.GD.gameTime >= (this.nowSaveNum + 1) * 10 * 60)
         {
            Game.eventGroup.weekExtraSave();
            Game.uiGroup.saveDataNoUI();
            ++this.nowSaveNum;
         }
         this.life_bar.inData(this.GD.nowLife,this.GD.maxLife);
         this.exp_bar.inData(this.GD.nowExp,this.GD.maxExp);
         this.gcoin_txt.text = String(this.GD.GCoin);
         this.score_txt.text = String(this.GD.score);
         this.time_txt.text = StringToDefine.getTimeStr(this.GD.gameTime);
         this.hitRate_txt.text = int(this.GD.hitBulletNum / this.GD.bulletNum * 1000) / 10 + " %";
         this.hurtNum_txt.text = int(this.GD.nowHurtNum) + "";
         var armsItems:ArmsItemsDataGroup = this.GD.armsItems;
         var arr0:Array = armsItems.equArr;
         for(n in arr0)
         {
            id0 = arr0[n];
            site0 = id0.site;
            icon0 = this.arms_icon[site0];
            icon0.setEnergy(id0.getEnergyPer());
         }
         if(Boolean(this.GD.nowArmsData))
         {
            this.energy_bar.inData(this.GD.nowArmsData.nowEnergy,this.GD.nowArmsData.maxEnergy);
         }
         else
         {
            this.energy_bar.inData(0,0);
         }
         if(this._bossBarTarget != null)
         {
            this.boss_bar.inData(this._bossBarTarget.define.nowLife,this._bossBarTarget.define.maxLife);
         }
         var bb0:Boolean = this.GD.challengeTaskData.timeTrigger(this.GD.gameTime);
         if(!bb0)
         {
            this.fleshTaskBox();
         }
         this._mc2.fleshBar();
      }
      
      private function getFontColor(str:String, _color1:String = "#999999") : String
      {
         return "<font color=\'" + _color1 + "\'>" + str + "</font>";
      }
      
      public function fleshArms() : *
      {
         var n:* = undefined;
         var icon0:GamingArmsIcon = null;
         var armsItems:ArmsItemsDataGroup = this.GD.armsItems;
         for(n in this.arms_icon)
         {
            icon0 = this.arms_icon[n];
            icon0.inData_byItems(armsItems.getEquipBySite(n));
            icon0.setState(armsItems.armsState[n]);
            icon0.showAlpha();
         }
         this.arms_icon[this.GD.nowArmsIndex].show();
         this.fleshTaskBox();
         this.timeLimit_txt.visible = false;
      }
      
      public function fleshShowArms() : *
      {
      }
      
      public function hideSkillIcon() : *
      {
         this.skillBox.y = 580;
      }
      
      public function showSkillIcon() : *
      {
         TweenLite.to(this.skillBox,0.5,{
            "y":486,
            "ease":Back.easeOut
         });
      }
      
      public function showArmsBar() : *
      {
         var n:* = undefined;
         var icon0:* = undefined;
         for(n in this.arms_icon)
         {
            icon0 = this.arms_icon[n];
            TweenLite.to(icon0,0.5,{
               "y":this.arms_y,
               "ease":Back.easeOut
            });
         }
      }
      
      public function hideArmsBar() : *
      {
         var n:* = undefined;
         var icon0:* = undefined;
         for(n in this.arms_icon)
         {
            icon0 = this.arms_icon[n];
            icon0.y = 580;
         }
      }
      
      public function showBossBar() : *
      {
         if(!this.bossBarB)
         {
            this.bossBarB = true;
            this.boss_bar.visible = true;
            this.boss_bar.y = -53.5;
            TweenLite.to(this.boss_bar,0.3,{
               "y":23.5,
               "ease":Back.easeOut
            });
         }
      }
      
      public function hideBossBar() : *
      {
         if(this.bossBarB)
         {
            this.bossBarB = false;
            TweenLite.to(this.boss_bar,0.3,{
               "y":-53.5,
               "ease":Back.easeIn
            });
         }
      }
      
      public function set bossBarTarget(b0:*) : *
      {
         var type0:int = 0;
         if(this._bossBarTarget != b0)
         {
            this._bossBarTarget = b0;
            if(this._bossBarTarget != null)
            {
               this.showBossBar();
               this.boss_bar.inData(this._bossBarTarget.define.nowLife,this._bossBarTarget.define.maxLife);
               type0 = 0;
               if(this._bossBarTarget.type == "super")
               {
                  type0 = 1;
               }
               else if(this._bossBarTarget.type == "champion")
               {
                  type0 = 2;
               }
               else if(this._bossBarTarget.type == "boss")
               {
                  type0 = 0;
               }
               this.boss_bar.unitName(this._bossBarTarget.define.name,type0,this._bossBarTarget.ai.skill.getCn());
            }
            else
            {
               this.hideBossBar();
            }
         }
      }
      
      public function get bossBarTarget() : *
      {
         return this._bossBarTarget;
      }
   }
}

