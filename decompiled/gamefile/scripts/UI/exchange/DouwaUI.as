package UI.exchange
{
   import com.adobe.serialization.json.JSON2;
   import data.TextWay;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class DouwaUI extends Sprite
   {
      
      public var code_txt:TextField;
      
      public var _btn:SimpleButton;
      
      public var goto_btn:SimpleButton;
      
      public var goto_btn2:SimpleButton;
      
      public var goto_btn3:SimpleButton;
      
      public var goto_btn4:SimpleButton;
      
      public var return_btn:SimpleButton;
      
      public var api:Douwa_Exchange_API = new Douwa_Exchange_API();

      private static const SUPPORT_URL:String = "https://ifdian.net/a/369158QW";

      private var supportPanel:Sprite;

      private var supportQR:Sprite;

      private var supportTitle:TextField;

      private var supportLink:TextField;

      private var supportLoader:Loader;
      
      public function DouwaUI()
      {
         super();
         this.disableCodeControls();
         this.showSupportPanel();
         this.return_btn.addEventListener(MouseEvent.CLICK,this.hide);
      }

      private function showSupportPanel() : void
      {
         this.hideLegacyText(this);
         this._btn.visible = false;
         this.goto_btn.visible = false;
         this.goto_btn2.visible = false;
         this.goto_btn3.visible = false;
         this.goto_btn4.visible = false;
         this.code_txt.visible = false;

         this.supportPanel = new Sprite();
         this.supportPanel.graphics.beginFill(16,0.97);
         this.supportPanel.graphics.lineStyle(1,3381759,0.9);
         this.supportPanel.graphics.drawRect(180,60,590,420);
         this.supportPanel.graphics.endFill();
         addChild(this.supportPanel);

         this.supportTitle = new TextField();
         this.supportTitle.defaultTextFormat = new TextFormat("SimSun",24,16763904,true,null,null,null,null,"center");
         this.supportTitle.text = "感谢赞助";
         this.supportTitle.x = 225;
         this.supportTitle.y = 62;
         this.supportTitle.width = 500;
         this.supportTitle.height = 36;
         this.supportTitle.selectable = false;
         this.supportTitle.mouseEnabled = false;
         addChild(this.supportTitle);

         this.supportQR = new Sprite();
         this.supportQR.x = 340;
         this.supportQR.y = 95;
         addChild(this.supportQR);

         this.supportLink = new TextField();
         this.supportLink.defaultTextFormat = new TextFormat("SimSun",16,6750207,true,null,true,SUPPORT_URL,"_blank","center");
         this.supportLink.text = SUPPORT_URL;
         this.supportLink.x = 225;
         this.supportLink.y = 395;
         this.supportLink.width = 500;
         this.supportLink.height = 36;
         this.supportLink.selectable = false;
         this.supportLink.mouseEnabled = true;
         this.supportLink.addEventListener(MouseEvent.CLICK,this.openSupportLink);
         addChild(this.supportLink);

         this.supportLoader = new Loader();
         this.supportLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.supportImageLoaded);
         this.supportLoader.load(new URLRequest("ui/support/afdian-support.jpg"));
         if(this.return_btn != null && contains(this.return_btn))
         {
            setChildIndex(this.return_btn,numChildren - 1);
         }
      }

      private function hideLegacyText(container0:DisplayObjectContainer) : void
      {
         var i:int = 0;
         var child0:* = null;
         for(i = 0; i < container0.numChildren; i++)
         {
            child0 = container0.getChildAt(i);
            if(child0 is TextField)
            {
               child0.visible = false;
            }
            else if(child0 is DisplayObjectContainer)
            {
               this.hideLegacyText(child0 as DisplayObjectContainer);
            }
         }
      }

      private function supportImageLoaded(event:Event) : void
      {
         var source0:Bitmap = this.supportLoader.content as Bitmap;
         if(source0 == null)
         {
            return;
         }
         var crop0:BitmapData = new BitmapData(270,270,false,16777215);
         var matrix0:Matrix = new Matrix();
         matrix0.translate(-150,-75);
         crop0.draw(source0.bitmapData,matrix0);
         var qr0:Bitmap = new Bitmap(crop0);
         qr0.smoothing = false;
         this.supportQR.addChild(qr0);
      }

      private function openSupportLink(event:MouseEvent) : void
      {
         navigateToURL(new URLRequest(SUPPORT_URL),"_blank");
      }

      private function disableCodeControls() : *
      {
         var buttons:Array = [this._btn,this.goto_btn,this.goto_btn2,this.goto_btn3,this.goto_btn4];
         var button0:SimpleButton = null;
         this.code_txt.type = TextFieldType.DYNAMIC;
         this.code_txt.selectable = false;
         this.code_txt.mouseEnabled = false;
         this.code_txt.text = "离线版已禁用兑换码";
         for each(button0 in buttons)
         {
            button0.mouseEnabled = false;
            button0.alpha = 0.35;
         }
      }
      
      public function gotoClick(e:*) : *
      {
         navigateToURL(new URLRequest("http://my.4399.com/jifen/product-id-132"),"_blank");
      }
      
      public function gotoClick2(e:*) : *
      {
         navigateToURL(new URLRequest("http://my.4399.com/jifen/product-id-330"),"_blank");
      }
      
      public function gotoClick3(e:*) : *
      {
         navigateToURL(new URLRequest("http://my.4399.com/jifen/product-id-164"),"_blank");
      }
      
      public function gotoClick4(e:*) : *
      {
         navigateToURL(new URLRequest("http://my.4399.com/jifen/product-id-209"),"_blank");
      }
      
      public function click(e:*) : *
      {
         Game.uiGroup.checkTip.showCheck2("离线版已禁用兑换码功能。",2);
      }
      
      public function morePan() : *
      {
         this.api.startExchange(Game.gameData.uid,TextWay.toHan(this.code_txt.text),this.yesFun,this.noFun);
         Game.uiGroup.loadingUI.show();
      }
      
      public function yesFun(data0:*) : *
      {
         Game.uiGroup.loadingUI.hide();
         var code0:int = int(JSON2.decode(data0).code);
         var result0:int = int(JSON2.decode(data0).result);
         var tipstr:String = "";
         Game.testText.addTestText("当前结果：" + result0);
         switch(code0)
         {
            case 99:
               tipstr = "未知错误！无法兑换！";
               break;
            case 100:
               if(result0 == 132)
               {
                  tipstr = "兑换成功！你获得了新手礼包！";
                  this.getGift();
               }
               else if(result0 == 330)
               {
                  tipstr = "兑换成功！你获得了新春礼包！";
                  this.getGift2();
               }
               else if(result0 == 164)
               {
                  tipstr = "兑换成功！你获得了周年礼包！";
                  this.getGift3();
               }
               else if(result0 == 209)
               {
                  tipstr = "兑换成功！你获得了双节礼包！";
                  this.getGift4();
               }
               break;
            case 101:
               tipstr = "参数错误！无法兑换！";
               break;
            case 102:
               tipstr = "兑换码不存在！无法兑换！";
               break;
            case 103:
               tipstr = "兑换码还没被兑换！";
               break;
            case 104:
               tipstr = "兑换码被使用过了！";
               break;
            case 105:
               tipstr = "兑换码只能被领取者使用！";
               break;
            case 106:
               tipstr = "该礼包已经兑换过了！";
               break;
            case 107:
               tipstr = "验证码失效！无法兑换！";
               break;
            case 108:
               tipstr = "兑换码失效！无法兑换！";
               break;
            case 109:
               tipstr = "激活失败！无法兑换！";
               break;
            case 110:
               tipstr = "您的账号今天已经使用过兑换码了，不能再使用了！";
         }
         Game.uiGroup.checkTip.showCheck2(tipstr,2);
      }
      
      public function noFun() : *
      {
         Game.uiGroup.loadingUI.hide();
         Game.uiGroup.checkTip.showCheck2("网络错误！",2);
      }
      
      public function getGift() : *
      {
         this.visible = false;
         Game.uiGroup.addGift_byArr(Game.gameDefine.gift.getDouwaGift(),true,-1,false);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.saveDataNoUI();
      }
      
      public function getGift2() : *
      {
         this.visible = false;
         Game.uiGroup.addGift_byArr(Game.gameDefine.gift.getDouwaGift2(),true,-1,false,true);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.saveDataNoUI();
      }
      
      public function getGift3() : *
      {
         this.visible = false;
         Game.uiGroup.addGift_byArr(Game.gameDefine.gift.getDouwaGift3(),true,-1,false,true);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.saveDataNoUI();
      }
      
      public function getGift4() : *
      {
         this.visible = false;
         var arr0:Array = [];
         arr0.push("GCoin,\t\t2000000,\t\t\t\t1");
         arr0.push("props,\t\texp_card_double,\t2");
         arr0.push("props,\t\texp_card_3,\t\t\t5");
         arr0.push("materials,\t\tred_crystal_7,\t\t\t2");
         Game.uiGroup.addGift_byArr(arr0,true,-1,false,true);
         Game.SG.playSound("upgradeArms");
         Game.uiGroup.saveDataNoUI("兑换码领取奖励");
      }
      
      public function hide(e:* = null) : *
      {
         visible = false;
      }
   }
}

