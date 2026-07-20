package UI.top
{
   import UI.page.PageBox;
   import com.adobe.serialization.json.JSON2;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class HighBox extends Sprite
   {
      
      public var title_bar:HighBar = new HighBar();
      
      public var bar_arr:Array = [];
      
      public var pageBox:PageBox = new PageBox();
      
      public var name_arr:Array = [];
      
      public var title_arr:Array = [];
      
      public var id:int = 0;
      
      public var type:String = "top_dps";
      
      public var data_arr:Array = [];
      
      public var nowPage:int = 0;
      
      public var totalPage:int = 10;
      
      public var allScore:Number = 0;
      
      public var clickFun:Function = null;
      
      public function HighBox()
      {
         super();
         addChild(this.title_bar);
         addChild(this.pageBox);
         this.pageBox.x = 611;
         this.pageBox.y = 420;
         this.pageBox.maxPage = 5;
         this.pageBox.table = this;
         this.pageBox.fleshByTable(false);
      }
      
      public function setFace(titleName:String, barName:String, barX0:int, barY0:int, grap0:int, num0:int = 10) : *
      {
         var bar0:HighBar = null;
         this.title_bar.setFace(Game.swfLoaderManager.getResource("",titleName));
         for(var i:int = 0; i < num0; i++)
         {
            bar0 = new HighBar();
            bar0.setFace(Game.swfLoaderManager.getResource("",barName));
            bar0.x = barX0;
            bar0.y = barY0 + grap0 * i;
            bar0.setBack(i % 2 + 1);
            this.bar_arr.push(bar0);
            if(Boolean(bar0.light_mc))
            {
               bar0.light_mc.addEventListener(MouseEvent.MOUSE_OVER,this.btnOver);
               bar0.light_mc.addEventListener(MouseEvent.MOUSE_OUT,this.btnOut);
               bar0.light_mc.addEventListener(MouseEvent.MOUSE_MOVE,this.btnMove);
            }
            if(Boolean(bar0.view_btn))
            {
               bar0.view_btn.addEventListener(MouseEvent.CLICK,this.btnClick);
            }
            addChild(bar0);
         }
         bar0 = this.bar_arr[this.bar_arr.length - 1];
         this.pageBox.x = bar0.width / 2 + bar0.x;
         this.pageBox.y = bar0.y + bar0.height + 10;
      }
      
      public function setStyle(str0:String) : *
      {
         var n:* = undefined;
         var bar0:HighBar = null;
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            if(Boolean(bar0.view_btn))
            {
               if(str0 == "pk")
               {
                  bar0.view_btn.visible = true;
               }
               else
               {
                  bar0.view_btn.visible = false;
               }
            }
         }
      }
      
      public function setTitleContext(arr0:Array) : *
      {
         var n:* = undefined;
         var t0:TextField = null;
         for(n in arr0)
         {
            t0 = this["t" + (n + 1)];
            if(Boolean(t0))
            {
               t0.text = Game.sensitiveWords.encode(String(arr0[n]));
            }
            else
            {
               t0.text = "";
            }
         }
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var bar0:HighBar = null;
         var tmpObj:Object = null;
         var data_arr0:Array = null;
         this.fleshBaseData_byType();
         this.title_bar.setContext(this.title_arr);
         this.title_bar.setStyle("title");
         this.allScore = 0;
         for(n in this.bar_arr)
         {
            bar0 = this.bar_arr[n];
            tmpObj = this.data_arr[n];
            if(Boolean(tmpObj))
            {
               data_arr0 = Game.gameDefine.high.getBarData(tmpObj,this.name_arr);
               bar0.setContext(data_arr0);
               bar0.visible = true;
               bar0.obj = tmpObj;
               this.allScore += tmpObj.score;
            }
            else
            {
               bar0.visible = false;
            }
         }
      }
      
      public function fleshBaseData_byType() : *
      {
         var allObj0:Object = Game.gameDefine.high.getAllObj(this.type,Game.nowSaveIndex);
         this.id = allObj0.id;
         this.name_arr = allObj0.name_arr;
         this.title_arr = allObj0.title_arr;
      }
      
      public function showPage(index0:int) : *
      {
         this.nowPage = index0;
         if(this.type.indexOf("top_group") < 0)
         {
            Game.uiGroup.highUI.getRankList();
         }
         else
         {
            Game.uiGroup.newArenaUI.getRankList();
         }
      }
      
      public function btnOver(e:*) : *
      {
         var tip0:HighPlayerBox = null;
         var bar0:HighBar = e.target.parent.parent;
         var index0:int = this.bar_arr.indexOf(bar0);
         if(Boolean(bar0.light_mc))
         {
            bar0.light_mc.gotoAndStop(2);
         }
         if(Boolean(bar0) && this.data_arr.length > 0)
         {
            tip0 = Game.uiGroup.highUI.tip;
            if(this.type == "top_dps" || this.type.indexOf("top_group") >= 0)
            {
               tip0.visible = true;
               tip0.flesh_byData(JSON2.decode(this.data_arr[index0].extra));
            }
            else if(this.type == "top_arms" || this.type == "top_sub")
            {
               tip0.visible = true;
               tip0.flesh_byArms(JSON2.decode(this.data_arr[index0].extra).label);
               tip0.x = Game.gameSprite.mouseX - 10;
               tip0.y = Game.gameSprite.mouseY;
            }
            else
            {
               tip0.visible = false;
            }
            this.btnMove();
         }
      }
      
      public function btnOut(e:*) : *
      {
         var bar0:HighBar = e.target.parent.parent;
         var index0:int = this.bar_arr.indexOf(bar0);
         if(Boolean(bar0))
         {
            bar0.light_mc.gotoAndStop(1);
            Game.uiGroup.highUI.tip.visible = false;
         }
      }
      
      public function btnMove(e:* = null) : *
      {
         var tip0:HighPlayerBox = Game.uiGroup.highUI.tip;
         if(this.type == "top_dps" || this.type.indexOf("top_group") >= 0)
         {
            tip0.x = Game.gameSprite.mouseX - 100;
            tip0.y = Game.gameSprite.mouseY + 100;
         }
         else if(this.type == "top_arms" || this.type == "top_sub")
         {
            tip0.x = Game.gameSprite.mouseX - 10;
            tip0.y = Game.gameSprite.mouseY;
         }
      }
      
      public function btnClick(e:* = null) : *
      {
         var index0:int = this.bar_arr.indexOf(e.target.parent.parent);
         var obj0:* = this.data_arr[index0];
         if(this.clickFun is Function)
         {
            this.clickFun(obj0);
         }
      }
   }
}

