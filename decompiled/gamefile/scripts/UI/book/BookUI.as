package UI.book
{
   import UI.ClickEvent;
   import UI.button.MoreStateButton;
   import UI.button.SountoScrollBar;
   import UI.label.LabelBox;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BookUI extends Sprite
   {
      
      public var switchLabel:LabelBox;
      
      public var labelArr:Array;
      
      public var enemyBox:*;
      
      public var eBtnArr:Array;
      
      public var enemyContent:MovieClip;
      
      public var sBar1:SountoScrollBar;
      
      public var enemyIcon_sp:Sprite;
      
      public var skillBox:*;
      
      public var sBar2:SountoScrollBar;
      
      public var skillContent:Sprite;
      
      public var armsBox:*;
      
      public var sBar4:SountoScrollBar;
      
      public var armsContent:*;
      
      public var historyBox:*;
      
      public var hBtnArr:Array;
      
      public var historyContent:MovieClip;
      
      public var sBar3:SountoScrollBar;
      
      public var choose_mc:Sprite;
      
      public function BookUI()
      {
         var btn2:SimpleButton = null;
         var btn0:EnemyButton = null;
         this.switchLabel = new LabelBox();
         this.labelArr = ["机器人大全","精英怪技能介绍","超合金编年史","武器特性介绍","攻防系统介绍"];
         this.eBtnArr = [];
         this.sBar1 = new SountoScrollBar();
         this.enemyIcon_sp = new Sprite();
         this.sBar2 = new SountoScrollBar();
         this.sBar4 = new SountoScrollBar();
         this.hBtnArr = [];
         this.sBar3 = new SountoScrollBar();
         super();
         this.enemyContent = this.enemyBox.enemyContent;
         this.sBar1.x = 927 - 5;
         this.sBar1.y = 56 + 5;
         this.enemyBox.addChild(this.enemyIcon_sp);
         this.enemyBox.addChild(this.sBar1);
         this.enemyIcon_sp.mask = this.enemyBox.mask_mc;
         this.skillContent = this.skillBox.content;
         this.armsContent = this.armsBox.content;
         this.sBar2.x = 926 - 3;
         this.sBar2.y = 111 + 5;
         this.sBar2.setTarget(this.skillContent);
         this.sBar2.setHigh(347);
         this.skillBox.addChild(this.sBar2);
         this.skillContent.mask = this.skillBox.mask_mc;
         this.sBar4.x = 926 - 3;
         this.sBar4.y = 111 + 5;
         this.sBar4.setTarget(this.armsContent);
         this.sBar4.setHigh(347);
         this.armsBox.addChild(this.sBar4);
         this.armsContent.mask = this.armsBox.mask_mc;
         this.historyContent = this.historyBox.content;
         for(var i:int = 0; i < 6; i++)
         {
            this.hBtnArr.push(this.historyBox.getChildByName("b" + (i + 1)));
            btn2 = this.hBtnArr[i];
            btn2.addEventListener(MouseEvent.CLICK,this.historyClick);
         }
         this.choose_mc = this.historyBox.choose_mc;
         this.sBar3.x = 926 - 3;
         this.sBar3.y = 194 + 5;
         this.sBar3.setTarget(this.historyContent);
         this.sBar3.setHigh(267 - 5);
         this.historyBox.addChild(this.sBar3);
         this.showHistory(0);
         this.switchLabel.setLabelClass(MoreStateButton);
         this.switchLabel.addLabel(this.labelArr,48 * this.labelArr.length,false,"group");
         addChild(this.switchLabel);
         this.switchLabel.x = 148;
         this.switchLabel.y = 56;
         this.switchLabel.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         var nameArr:Array = ["悬浮自动激光炮台A型","悬浮自动激光炮台B型","电锯机器人","自爆蜘蛛机","游隼战机","天隼战机","地面自动防御炮台","鸵鸟战机","追踪者","超级追踪者","原子塔","碾压者","巨型压路机","悬浮自动钻头","超级自动钻头","蓝光飞碟","蜘蛛炮台","切割者","冲刺者","冲锋坦克","女妖战机","攻城坦克","飞轮机器人","铁鸦背叛者","铁鸦战队队长","铁鸦战队指挥官","突击者","强袭者","杀戮者","仲裁者","剑装审判者","炮装审判者","判决者","拦截机1号","红蛛杀手","拦截机2号","大天使","钢铁暴牛兽","红色破袭者","月面观察者","月面陆基激光炮","战虎掠夺者","悬浮A1机器人","战虎杀戮者","绿魔","赤钢","热破","阿尔西","闪电","镇压者"];
         nameArr = nameArr.concat(["猎隼战机","警报塔","圣堂战机","小型压路机","狂热者","先知"]);
         nameArr = nameArr.concat(["虎鲨坦克","渗透者","旋翼飞机","SAX-15D攻击机器人","防卫卫星","防御激光炮","入侵者","掠食者","机械路霸","暴君","隐刀"]);
         nameArr = nameArr.concat(["SAX-DJ机器人","投掷者","巡天者","雷霆","旋风战机","闪电坦克","黑暗剑装审判者","猛犸战神"]);
         nameArr = nameArr.concat(["风暴战神","领域守卫官","机械剑齿虎","凯斯特推土机","风暴战士","风暴勇士","激光战神苏拉"]);
         nameArr.reverse();
         var num0:int = int(nameArr.length);
         for(var n:int = 0; n < num0; n++)
         {
            btn0 = new EnemyButton();
            btn0.setText(nameArr[n]);
            btn0.x = 330 + 52 * (n % 11);
            btn0.y = 88 + 52 * int(n / 11);
            this.enemyIcon_sp.addChild(btn0);
            btn0.addEventListener(MouseEvent.CLICK,this.enemyIconClick);
            this.eBtnArr.push(btn0);
         }
         this.sBar1.setTarget(this.enemyIcon_sp);
         this.sBar1.setHigh(this.enemyBox.mask_mc.height - 10);
         this.enemyContent.stop();
         this.eBtnArr[0].setState(1);
         this.enemyContent.gotoAndStop(nameArr[0]);
         this.showBox("机器人大全");
      }
      
      public function historyClick(e:*) : *
      {
         var num0:int = int(e.target.name.substr(1)) - 1;
         this.showHistory(num0);
      }
      
      public function showHistory(num0:int) : *
      {
         var btn2:SimpleButton = this.hBtnArr[num0];
         this.choose_mc.x = btn2.x;
         this.choose_mc.y = btn2.y;
         this.historyContent.gotoAndStop(num0 + 1);
         this.sBar3.setTarget(this.historyContent,false);
         this.sBar3.setPer(0);
      }
      
      public function enemyIconClick(e:*) : *
      {
         var n:* = undefined;
         var btn0:EnemyButton = null;
         var label0:String = e.target.text;
         for(n in this.eBtnArr)
         {
            btn0 = this.eBtnArr[n];
            btn0.setState(0);
         }
         e.target.setState(1);
         this.enemyContent.gotoAndStop(label0);
      }
      
      public function labelClick(event:ClickEvent) : *
      {
         this.switchLabel.showState(event.index);
         this.showBox(this.switchLabel.nowLabel);
      }
      
      public function showBox(str:String) : *
      {
         this.enemyBox.visible = false;
         this.skillBox.visible = false;
         this.armsBox.visible = false;
         this.historyBox.visible = false;
         if(str == "机器人大全")
         {
            this.enemyBox.visible = true;
         }
         else if(str == "精英怪技能介绍")
         {
            this.skillBox.visible = true;
         }
         else if(str == "超合金编年史")
         {
            this.historyBox.visible = true;
         }
         else if(str == "武器特性介绍")
         {
            this.armsBox.visible = true;
            this.armsContent.gotoAndStop("arms");
            this.armsBox.txt.text = str;
            this.sBar4.setPer(0);
            this.sBar4.setTarget(this.armsContent,false);
         }
         else if(str == "攻防系统介绍")
         {
            this.armsBox.visible = true;
            this.armsContent.gotoAndStop("ad");
            this.armsBox.txt.text = str;
            this.sBar4.setPer(0);
            this.sBar4.setTarget(this.armsContent,false);
         }
         trace(this.sBar2.mask + "   " + this.sBar2.parent.mask);
      }
   }
}

