package UI.research
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.label.LabelCtrl;
   import body.skill.OneLevelSkillDefine;
   import body.skill.SkillDefine;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsDataGroup;
   import gameAll.data.TrainAddData;
   
   public class PlayerTrainUI extends Sprite
   {
      
      public var GD:GameData;
      
      public var materialsItems:GoodsItemsDataGroup;
      
      public var title_txt:TextField;
      
      public var name_txt:TextField;
      
      public var name_txt2:TextField;
      
      public var mustLevel_txt:TextField;
      
      public var GCoin_txt:TextField;
      
      public var nowGCoin_txt:TextField;
      
      public var icon_mc:Sprite;
      
      public var no_1:Sprite;
      
      public var no_3:Sprite;
      
      public var condition_icon1:MovieClip;
      
      public var condition_icon3:MovieClip;
      
      public var _btn:SimpleButton;
      
      public var titleArr:Array;
      
      public var titleArr2:Array;
      
      public var trainNameArr:Array;
      
      public var nowData:* = null;
      
      public var nowDefine:SkillDefine = null;
      
      public var nowNewLabel:MoreStateButton = null;
      
      public var mustGorM_txt:TextField;
      
      public var gotoShop_btn:SimpleButton;
      
      public var pay_btn:SimpleButton;
      
      public var quickUpgrade100_btn:SimpleButton;
      
      public var quickUpgrade200_btn:SimpleButton;
      
      public var label_mc:*;
      
      public var labelCtrl:LabelCtrl;

      private var pendingAllTrainNum:int = 0;

      private var pendingAllTrainCost:Number = 0;

      private var pendingAllTrainStartLevel:int = 0;

      private var pendingTrainData:TrainAddData = null;

      private var pendingTrainCurrency:String = "G币";

      private var pendingSkillDefine:SkillDefine = null;

      private var pendingSkillStartLevel:int = 0;

      private var pendingSkillNum:int = 0;

      private var pendingSkillGCost:Number = 0;

      private var pendingSkillMCost:Number = 0;
      
      public function PlayerTrainUI()
      {
         this.titleArr = ["火箭推进器","反重力装置","等离子护盾","体能训练","射击训练","控制训练","防御训练","全能训练"];
         this.titleArr2 = ["主武器攻击","副武器攻击","耐久","防御","全属性"];
         this.trainNameArr = ["attack","sub","life","defence","all"];
         this.labelCtrl = new LabelCtrl();
          super();
          // 反重力装置(jump)升级入口修复:
          // 时间轴资源中 jump 技能对应的可视技能图标按钮是 label_mc 内位于 (0,0) 的
          // 未命名六边形按钮(左列第一个槽位);触发按键 jump_btn(48x17 小方块)位于屏幕外 (-243)。
          // 做法:不移动、不改名任何按钮,只在 labelCtrl 的按钮数组里把 jump 位置的引用
          // 从屏幕外的 jump_btn 替换为 (0,0) 的可视技能图标按钮,并显式传入 label 数组,
          // 使技能图标本身可点击打开反重力装置升级界面(点击后高亮也会正确落在该图标上)。
          var jumpIcon0:* = null;
          var btnCount:int = this.label_mc.numChildren;
          var i0:int = 0;
          while(i0 < btnCount)
          {
             var b0:* = this.label_mc.getChildAt(i0);
             if(b0 is SimpleButton && b0.x == 0 && b0.y == 0)
             {
                jumpIcon0 = b0;
                break;
             }
             i0++;
          }
          // 升级按钮的原版规格是84x76，内部图块约为68x62。把战斗HUD中的jump帧
          // 按这个规格拉伸并居中，再用内六边形裁切；外框仍由原版按钮时间轴绘制。
          if(jumpIcon0 != null)
          {
             try
             {
                var skillIcon0:* = Game.swfLoaderManager.getResource("ui","UI.gaming.SkillIcon");
                if(skillIcon0 != null && skillIcon0.icon != null)
                {
                   var iconView0:MovieClip = skillIcon0.icon as MovieClip;
                   var iconHolder0:Sprite = new Sprite();
                   iconView0.gotoAndStop("jump");
                   iconHolder0.addChild(iconView0);
                   var rawBounds0:Rectangle = iconView0.getBounds(iconHolder0);
                   iconView0.scaleX *= 68 / rawBounds0.width;
                   iconView0.scaleY *= 62 / rawBounds0.height;
                   var fittedBounds0:Rectangle = iconView0.getBounds(iconHolder0);
                   iconView0.x += 8 - fittedBounds0.x;
                   iconView0.y += 7 - fittedBounds0.y;
                   iconHolder0.x = jumpIcon0.x;
                   iconHolder0.y = jumpIcon0.y;
                   iconHolder0.mouseEnabled = false;
                   iconHolder0.mouseChildren = false;
                   this.label_mc.addChild(iconHolder0);

                   var iconMask0:Shape = new Shape();
                   iconMask0.graphics.beginFill(16777215,1);
                   iconMask0.graphics.moveTo(24,7);
                   iconMask0.graphics.lineTo(60,7);
                   iconMask0.graphics.lineTo(78,38);
                   iconMask0.graphics.lineTo(60,69);
                   iconMask0.graphics.lineTo(24,69);
                   iconMask0.graphics.lineTo(6,38);
                   iconMask0.graphics.lineTo(24,7);
                   iconMask0.graphics.endFill();
                   iconMask0.x = jumpIcon0.x;
                   iconMask0.y = jumpIcon0.y;
                   this.label_mc.addChild(iconMask0);
                   iconHolder0.mask = iconMask0;
                }
             }
             catch(error:Error)
             {
             }
          }
          var btnArr:Array = [this.label_mc.attack_btn,this.label_mc.sub_btn,this.label_mc.life_btn,this.label_mc.defence_btn,this.label_mc.all_btn,this.label_mc.rocket_btn,this.label_mc.jump_btn,this.label_mc.plasma_btn,this.label_mc.lighting_btn,this.label_mc.change_btn];
          var labelArr:Array = ["attack","sub","life","defence","all","rocket","jump","plasma","lighting","change"];
          if(jumpIcon0 != null)
          {
             btnArr[6] = jumpIcon0;
          }
          // PlayerTrainUI450.swf 把整组技能图片烘焙在一个大 Shape 中，其中反重力图片
          // 位于 label_mc 上方约 260 像素。窗口被全屏填充后，这块越界内容会泄漏到界面
          // 左上方。给 label_mc 增加只覆盖正常按钮区的遮罩，保留槽位内的新图标，同时
          // 裁掉资源中原本越界的反重力图片和测试按钮。
          var labelMask0:Shape = new Shape();
          labelMask0.graphics.beginFill(16777215,1);
          labelMask0.graphics.drawRect(-40,-40,950,400);
          labelMask0.graphics.endFill();
          labelMask0.x = this.label_mc.x;
          labelMask0.y = this.label_mc.y;
          this.addChild(labelMask0);
          this.label_mc.mask = labelMask0;
          this.labelCtrl.inData(btnArr,this.label_mc.light_sp,labelArr);
          this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.label_mc.mouseEnabled = false;
         this.quickUpgrade100_btn.visible = false;
         this.quickUpgrade200_btn.visible = false;
         this.quickUpgrade100_btn.addEventListener(MouseEvent.CLICK,this.quickUpgrade);
         this.quickUpgrade200_btn.addEventListener(MouseEvent.CLICK,this.quickUpgrade);
         this.gotoShop_btn.visible = false;
         this.pay_btn.visible = false;
         this.pay_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.pay);
         this.gotoShop_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.gotoPropsShop);
         this.mustGorM_txt.text = "需要消耗的G币";
         this.no_3.visible = false;
         this.icon_mc.visible = false;
         this.condition_icon1.stop();
         this.condition_icon3.stop();
         this._btn.addEventListener(MouseEvent.CLICK,this.btnClick);
         this.label_mc.lighting_btn.addEventListener(MouseEvent.MOUSE_OVER,this.btnOver);
         this.label_mc.lighting_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut);
         this.label_mc.change_btn.addEventListener(MouseEvent.MOUSE_OVER,this.btnOver);
         this.label_mc.change_btn.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut);
      }
      
       public function init() : *
       {
          this.GD = Game.gameData;
          this.materialsItems = this.GD.materialsItems;
       }
      
      public function gotoShop(e:*) : *
      {
         Game.uiGroup.gotoShop("props");
      }
      
      public function fleshAll() : *
      {
         trace("训练与技能刷新。");
         this.trainOne_byIndex(this.labelCtrl.nowIndex);
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.trainOne(this.labelCtrl.nowLabel);
      }
      
      public function btnClick(event:MouseEvent) : *
      {
         var mcoin0:int = 0;
         if(Boolean(this.nowData))
         {
            if(this.nowData is TrainAddData)
            {
               Game.uiGroup.checkTip.showNumberInput(this.getTrainInputText(TrainAddData(this.nowData)),"1",this.prepareAllTrain,null,8);
               return;
            }
            if(this.nowDefine is SkillDefine)
            {
               Game.uiGroup.checkTip.showNumberInput(this.getSkillInputText(this.nowDefine),"1",this.prepareSkillBatch,null,3);
               return;
            }
            mcoin0 = 0;
            if(this.nowData is TrainAddData)
            {
               mcoin0 = int(this.nowData.MCoin);
            }
            else
            {
               mcoin0 = int(this.nowData.mustMcoin);
            }
            if(mcoin0 > 0)
            {
               Game.payController.decMCoin(mcoin0,this.upgradeComplete);
            }
            else
            {
               this.upgradeComplete();
            }
         }
      }

      private function getTrainInputText(add0:TrainAddData) : String
      {
         var currency0:String = add0.type == "all" ? "M币" : "G币";
         var cost0:Number = add0.level < add0.maxLevel ? this.getTrainBatchCost(add0.level,1,add0.type) : 0;
         return "输入" + add0.cnName + "要提升的等级数：\n当前 " + add0.level + " 级，最高 " + add0.maxLevel + " 级。\n提升 1 级需要 " + cost0 + " " + currency0 + "。";
      }

      private function getSkillInputText(skill0:SkillDefine) : String
      {
         var level0:int = this.GD.playerData.getSkillLevel(skill0.name);
         var cost0:Object = this.getSkillBatchCost(skill0,level0,1);
         var costText0:String = "0 G币";
         if(Number(cost0.MCoin) > 0)
         {
            costText0 = cost0.MCoin + " M币";
         }
         else if(Number(cost0.GCoin) > 0)
         {
            costText0 = cost0.GCoin + " G币";
         }
         return "输入" + skill0.cnName + "要提升的等级数：\n当前 " + level0 + " 级，最高 " + skill0.maxLevel + " 级。\n提升 1 级需要 " + costText0 + "。";
      }

      private function prepareAllTrain() : *
      {
         var add0:TrainAddData = this.nowData as TrainAddData;
         if(add0 == null)
         {
            return;
         }
         var num0:int = int(Game.uiGroup.checkTip.input_txt.text);
         var remain0:int = add0.maxLevel - add0.level;
         if(num0 < 1)
         {
            Game.uiGroup.checkTip.showCheck2("请输入大于 0 的等级数。",2);
            return;
         }
         if(num0 > remain0)
         {
            Game.uiGroup.checkTip.showCheck2("最多还能提升 " + remain0 + " 级。",2);
            return;
         }
         var needPlayerLevel0:int = Game.gameDefine.getTrainLevelNum(add0.level + num0 - 1,add0.type);
         if(this.GD.level + 1 < needPlayerLevel0)
         {
            Game.uiGroup.checkTip.showCheck2("提升到目标等级需要玩家达到 " + needPlayerLevel0 + " 级。",2);
            return;
         }
         this.pendingAllTrainNum = num0;
         this.pendingAllTrainStartLevel = add0.level;
         this.pendingTrainData = add0;
         this.pendingTrainCurrency = add0.type == "all" ? "M币" : "G币";
         this.pendingAllTrainCost = this.getTrainBatchCost(add0.level,num0,add0.type);
         Game.uiGroup.checkTip.showCheck2(add0.cnName + "将从 " + add0.level + " 级提升到 " + (add0.level + num0) + " 级。\n目标要求玩家达到 " + needPlayerLevel0 + " 级。\n共需要 " + this.pendingAllTrainCost + " " + this.pendingTrainCurrency + "，确定升级吗？",1,this.confirmAllTrain);
      }

      private function getTrainBatchCost(startLevel0:int, num0:int, type0:String) : Number
      {
         var cost0:Number = 0;
         var endLevel0:int = startLevel0 + num0;
         if(type0 != "all")
         {
            var normalLevel0:int = startLevel0;
            while(normalLevel0 < endLevel0)
            {
               cost0 += Game.gameDefine.getTrainCoinNum(normalLevel0);
               normalLevel0++;
            }
            return cost0;
         }
         var normalEnd0:int = Math.min(endLevel0,500);
         var i:int = startLevel0;
         while(i < normalEnd0)
         {
            cost0 += Game.gameDefine.getTrainCoinNum_M(i,"all");
            i++;
         }
         if(endLevel0 > 500)
         {
            cost0 += (endLevel0 - Math.max(startLevel0,500)) * 1000;
         }
         return cost0;
      }

      private function confirmAllTrain() : *
      {
         var add0:TrainAddData = this.pendingTrainData;
         if(add0 == null)
         {
            return;
         }
         if(add0.level != this.pendingAllTrainStartLevel || this.pendingAllTrainNum < 1)
         {
            Game.uiGroup.checkTip.showCheck2("训练等级已经变化，请重新输入。",2);
            return;
         }
         this.pendingAllTrainCost = this.getTrainBatchCost(add0.level,this.pendingAllTrainNum,add0.type);
         if(add0.type == "all" && this.pendingAllTrainCost > this.GD.MCoin)
         {
            Game.uiGroup.checkTip.showCheck2("M币不足，需要 " + this.pendingAllTrainCost + " M币。",2);
            return;
         }
         if(add0.type != "all" && this.pendingAllTrainCost > this.GD.GCoin)
         {
            Game.uiGroup.checkTip.showCheck2("G币不足，需要 " + this.pendingAllTrainCost + " G币。",2);
            return;
         }
         if(add0.type == "all")
         {
            Game.payController.decMCoin(this.pendingAllTrainCost,this.completeAllTrain,this.affter_m_buyCheck2);
         }
         else
         {
            this.GD.addCoin(-this.pendingAllTrainCost);
            this.completeAllTrain();
         }
      }

      private function completeAllTrain() : *
      {
         var add0:TrainAddData = this.pendingTrainData;
         if(add0 == null)
         {
            return;
         }
         var num0:int = this.pendingAllTrainNum;
         add0.levelUp(num0);
         this.pendingAllTrainNum = 0;
         this.pendingTrainData = null;
         Game.uiGroup.checkTip.showTip(add0.cnName + "成功提升 " + num0 + " 级！",1);
         Game.eventGroup.fleshSkill();
         Game.uiGroup.carShow.copyAll();
         Game.SG.playSound("upgradeArms");
         this.fleshAll();
      }

      private function prepareSkillBatch() : *
      {
         var skill0:SkillDefine = this.nowDefine as SkillDefine;
         if(skill0 == null)
         {
            return;
         }
         var startLevel0:int = this.GD.playerData.getSkillLevel(skill0.name);
         var num0:int = int(Game.uiGroup.checkTip.input_txt.text);
         var remain0:int = skill0.maxLevel - startLevel0;
         if(num0 < 1)
         {
            Game.uiGroup.checkTip.showCheck2("请输入大于 0 的等级数。",2);
            return;
         }
         if(num0 > remain0)
         {
            Game.uiGroup.checkTip.showCheck2("最多还能提升 " + remain0 + " 级。",2);
            return;
         }
         var cost0:Object = this.getSkillBatchCost(skill0,startLevel0,num0);
         if(this.GD.level + 1 < int(cost0.mustLevel))
         {
            Game.uiGroup.checkTip.showCheck2("提升到目标等级需要玩家达到 " + cost0.mustLevel + " 级。",2);
            return;
         }
         this.pendingSkillDefine = skill0;
         this.pendingSkillStartLevel = startLevel0;
         this.pendingSkillNum = num0;
         this.pendingSkillGCost = Number(cost0.GCoin);
         this.pendingSkillMCost = Number(cost0.MCoin);
         var costText0:String = "";
         if(this.pendingSkillGCost > 0)
         {
            costText0 = this.pendingSkillGCost + " G币";
         }
         if(this.pendingSkillMCost > 0)
         {
            costText0 += (costText0 == "" ? "" : "，") + this.pendingSkillMCost + " M币";
         }
         if(costText0 == "")
         {
            costText0 = "0 G币";
         }
         Game.uiGroup.checkTip.showCheck2(skill0.cnName + "将从 " + startLevel0 + " 级提升到 " + (startLevel0 + num0) + " 级。\n目标要求玩家达到 " + cost0.mustLevel + " 级。\n共需要 " + costText0 + "，确定升级吗？",1,this.confirmSkillBatch);
      }

      private function getSkillBatchCost(skill0:SkillDefine, startLevel0:int, num0:int) : Object
      {
         var result0:Object = {
            "GCoin":0,
            "MCoin":0,
            "mustLevel":1
         };
         var i:int = startLevel0;
         var target0:OneLevelSkillDefine = null;
         while(i < startLevel0 + num0)
         {
            target0 = skill0.getLevel(i + 1);
            if(target0 != null)
            {
               if(target0.mustMcoin > 0)
               {
                  result0.MCoin += target0.mustMcoin;
               }
               else
               {
                  result0.GCoin += target0.mustGcoin;
               }
               if(target0.mustLevel > result0.mustLevel)
               {
                  result0.mustLevel = target0.mustLevel;
               }
            }
            i++;
         }
         return result0;
      }

      private function confirmSkillBatch() : *
      {
         var skill0:SkillDefine = this.pendingSkillDefine;
         if(skill0 == null || this.pendingSkillNum < 1)
         {
            return;
         }
         var nowLevel0:int = this.GD.playerData.getSkillLevel(skill0.name);
         if(nowLevel0 != this.pendingSkillStartLevel)
         {
            Game.uiGroup.checkTip.showCheck2("技能等级已经变化，请重新输入。",2);
            return;
         }
         var cost0:Object = this.getSkillBatchCost(skill0,nowLevel0,this.pendingSkillNum);
         this.pendingSkillGCost = Number(cost0.GCoin);
         this.pendingSkillMCost = Number(cost0.MCoin);
         if(this.GD.level + 1 < int(cost0.mustLevel))
         {
            Game.uiGroup.checkTip.showCheck2("玩家等级不足，需要达到 " + cost0.mustLevel + " 级。",2);
            return;
         }
         if(this.pendingSkillGCost > this.GD.GCoin)
         {
            Game.uiGroup.checkTip.showCheck2("G币不足，需要 " + this.pendingSkillGCost + " G币。",2);
            return;
         }
         if(this.pendingSkillMCost > this.GD.MCoin)
         {
            Game.uiGroup.checkTip.showCheck2("M币不足，需要 " + this.pendingSkillMCost + " M币。",2);
            return;
         }
         if(this.pendingSkillMCost > 0)
         {
            Game.payController.decMCoin(this.pendingSkillMCost,this.completeSkillBatch,this.affter_m_buyCheck2);
         }
         else
         {
            this.completeSkillBatch();
         }
      }

      private function completeSkillBatch() : *
      {
         var skill0:SkillDefine = this.pendingSkillDefine;
         if(skill0 == null)
         {
            return;
         }
         if(this.pendingSkillGCost > 0)
         {
            this.GD.addCoin(-this.pendingSkillGCost);
         }
         var num0:int = this.pendingSkillNum;
         var i:int = 0;
         while(i < num0)
         {
            this.GD.playerData.skillLevelUp(skill0.name);
            i++;
         }
         this.pendingSkillDefine = null;
         this.pendingSkillNum = 0;
         Game.uiGroup.checkTip.showTip(skill0.cnName + "成功提升 " + num0 + " 级！",1);
         Game.eventGroup.fleshSkill();
         Game.uiGroup.carShow.copyAll();
         Game.SG.playSound("upgradeArms");
         this.fleshAll();
      }
      
      public function btnOver(e:*) : *
      {
         Game.uiGroup.infoTip.visible = true;
         var p0:Point = e.target.localToGlobal(new Point());
         Game.uiGroup.infoTip.x = p0.x + e.target.width;
         Game.uiGroup.infoTip.y = p0.y;
         var text0:String = "";
         if(e.target.name == "lighting_btn")
         {
            text0 = "由处于低轨道的卫星控制云层，产生瞬时的闪电攻击地面上的所有目标。闪电伤害为你战斗力的一定倍数。";
         }
         else
         {
            text0 = "由小型原能魔方驱动，可以让战车瞬间变成强大的机甲战士，并获得特殊的攻击能力。机甲战士的攻击力是你战斗力的一定倍数。";
         }
         Game.uiGroup.infoTip.showText(text0,180);
      }
      
      public function btnOut(e:*) : *
      {
         Game.uiGroup.infoTip.visible = false;
      }
      
      public function quickUpgrade(e:* = null) : *
      {
         if(Boolean(this.nowData))
         {
            if(e.target.name == "quickUpgrade100_btn")
            {
               Game.payController.decMCoin(100,this.upgradeComplete_noUseUp,this.affter_m_buyCheck2);
            }
            else if(e.target.name == "quickUpgrade200_btn")
            {
               Game.payController.decMCoin(200,this.upgradeComplete_noUseUp,this.affter_m_buyCheck2);
            }
         }
      }
      
      public function affter_m_buyCheck2() : *
      {
         Game.uiGroup.checkTip.showCheck2("M币不足！",2);
      }
      
      public function upgradeComplete() : *
      {
         var mcoin0:int = 0;
         var gcoin0:int = 0;
         if(Boolean(this.nowData))
         {
            mcoin0 = 0;
            gcoin0 = 0;
            if(this.nowData is TrainAddData)
            {
               gcoin0 = int(this.nowData.GCoin);
               mcoin0 = int(this.nowData.MCoin);
            }
            else
            {
               gcoin0 = int(this.nowData.mustGcoin);
               mcoin0 = int(this.nowData.mustMcoin);
            }
            if(mcoin0 <= 0)
            {
               this.GD.addCoin(-gcoin0);
            }
         }
         this.upgradeComplete_noUseUp();
      }
      
      private function upgradeComplete_noUseUp() : *
      {
         if(Boolean(this.nowData))
         {
            if(this.nowData is TrainAddData)
            {
               this.nowData.levelUp();
            }
            else
            {
               this.GD.playerData.skillLevelUp(this.nowDefine.name);
            }
            Game.uiGroup.checkTip.showTip("升级成功！",1);
            Game.eventGroup.fleshSkill();
            Game.uiGroup.carShow.copyAll();
            Game.SG.playSound("upgradeArms");
            this.fleshAll();
         }
      }
      
      public function trainOne_byIndex(num:int) : *
      {
         var str0:String = this.labelCtrl.label_arr[num];
         this.trainOne(str0);
      }
      
      public function changeGorM(bb:Boolean = true) : *
      {
         if(bb)
         {
            this.mustGorM_txt.text = "需要消耗的G币";
            this.mustGorM_txt.textColor = 16777215;
            this.GCoin_txt.textColor = 16777215;
         }
         else
         {
            this.mustGorM_txt.text = "需要消耗的M币";
            this.mustGorM_txt.textColor = 16776960;
            this.GCoin_txt.textColor = 16776960;
         }
      }
      
      public function trainOne(str0:String) : *
      {
         this.labelCtrl.setChoose_byLabel(str0);
         this.quickUpgrade100_btn.visible = false;
         this.quickUpgrade200_btn.visible = false;
         var d0:SkillDefine = Game.defineGroup.skill.getDefine(str0);
         if(Boolean(d0))
         {
            this.trainSkill(str0);
         }
         else
         {
            this.trainTrain(str0);
         }
      }
      
      public function trainSkill(str0:String) : *
      {
         var coin0:int = 0;
         var d0:SkillDefine = Game.defineGroup.skill.getDefine(str0);
         var level0:int = this.GD.playerData.getSkillLevel(str0);
         var l_d0:OneLevelSkillDefine = d0.getLevel(level0);
         var n_d0:OneLevelSkillDefine = d0.getLevel(level0 + 1);
         this.nowData = l_d0;
         this.nowDefine = d0;
         if(level0 > 0)
         {
            this.title_txt.text = d0.cnName + level0 + "级";
         }
         else
         {
            this.title_txt.text = d0.cnName;
         }
         this.name_txt.text = level0 + "";
         this.name_txt.htmlText = d0.getEffectDescribe_level(level0);
         this.name_txt2.htmlText = d0.getEffectDescribe_level(level0 + 1);
         var maxLevelB:Boolean = level0 >= d0.maxLevel;
         var mustLevelB:Boolean = true;
         var coinB:Boolean = true;
         var m_d0:OneLevelSkillDefine = l_d0;
         if(Boolean(n_d0))
         {
            m_d0 = n_d0;
         }
         var mustLevel:int = m_d0.mustLevel;
         this.mustLevel_txt.text = mustLevel + "";
         mustLevelB = this.GD.level + 1 >= mustLevel;
         this.gotoShop_btn.visible = false;
         this.pay_btn.visible = false;
         if(m_d0.mustMcoin > 0)
         {
            this.changeGorM(false);
            coin0 = m_d0.mustMcoin;
            if(coin0 > this.GD.MCoin)
            {
               coinB = false;
               this.pay_btn.visible = true;
            }
            this.nowGCoin_txt.text = "当前M币：" + this.GD.MCoin;
         }
         else
         {
            this.changeGorM();
            coin0 = m_d0.mustGcoin;
            if(coin0 > this.GD.GCoin)
            {
               coinB = false;
               this.gotoShop_btn.visible = true;
            }
            this.nowGCoin_txt.text = "当前G币：" + this.GD.GCoin;
         }
         if(coin0 <= 0)
         {
            this.no_1.visible = true;
            this.GCoin_txt.visible = false;
         }
         else
         {
            this.no_1.visible = false;
            this.GCoin_txt.visible = true;
            this.GCoin_txt.text = coin0 + "";
         }
         if(mustLevelB)
         {
            this.condition_icon3.gotoAndStop(1);
         }
         else
         {
            this.condition_icon3.gotoAndStop(2);
         }
         if(coinB)
         {
            this.condition_icon1.gotoAndStop(1);
         }
         else
         {
            this.condition_icon1.gotoAndStop(2);
         }
         if(coinB && mustLevelB && !maxLevelB || Game.getTest())
         {
            this._btn.mouseEnabled = true;
            this._btn.alpha = 1;
         }
         else
         {
            this._btn.mouseEnabled = false;
            this._btn.alpha = 0.4;
         }
      }
      
      public function trainTrain(str0:String) : *
      {
         var coin0:int = 0;
         var add0:TrainAddData = this.GD.playerData[str0 + "Add"];
         this.nowData = add0;
         this.title_txt.text = add0.cnName;
         if(add0.cnName == "全能训练")
         {
            this.title_txt.text += add0.level + "级";
         }
         this.icon_mc.visible = false;
         var nameStr0:String = this.titleArr2[this.trainNameArr.indexOf(str0)];
         this.name_txt.text = nameStr0 + "加成" + add0.getPer() + "%";
         this.name_txt2.text = nameStr0 + "加成" + add0.getNextPer() + "%";
         var maxLevelB:Boolean = true;
         if(add0.level >= add0.maxLevel)
         {
            maxLevelB = false;
            this.name_txt2.text = "已升至最高等级";
         }
         else
         {
            maxLevelB = true;
         }
         var mustLevelB:Boolean = true;
         var mustLevel:int = add0.mustLevel;
         this.mustLevel_txt.text = mustLevel + "";
         if(this.GD.level + 1 >= mustLevel)
         {
            this.condition_icon3.gotoAndStop(1);
         }
         else
         {
            this.condition_icon3.gotoAndStop(2);
            mustLevelB = false;
         }
         this.gotoShop_btn.visible = false;
         this.pay_btn.visible = false;
         var coinB:Boolean = true;
         if(add0.MCoin > 0)
         {
            this.changeGorM(false);
            coin0 = add0.MCoin;
            if(coin0 > this.GD.MCoin)
            {
               coinB = false;
               this.pay_btn.visible = true;
            }
            this.nowGCoin_txt.text = "当前M币：" + this.GD.MCoin;
         }
         else
         {
            this.changeGorM();
            coin0 = add0.GCoin;
            if(coin0 > this.GD.GCoin)
            {
               coinB = false;
               this.gotoShop_btn.visible = true;
            }
            this.nowGCoin_txt.text = "当前G币：" + this.GD.GCoin;
         }
         if(coin0 <= 0)
         {
            this.no_1.visible = true;
            this.GCoin_txt.visible = false;
         }
         else
         {
            this.no_1.visible = false;
            this.GCoin_txt.visible = true;
            this.GCoin_txt.text = coin0 + "";
         }
         if(coinB)
         {
            this.condition_icon1.gotoAndStop(1);
         }
         else
         {
            this.condition_icon1.gotoAndStop(2);
         }
         if(coinB && mustLevelB && maxLevelB)
         {
            this._btn.mouseEnabled = true;
            this._btn.alpha = 1;
         }
         else
         {
            this._btn.mouseEnabled = false;
            this._btn.alpha = 0.4;
         }
      }
   }
}

