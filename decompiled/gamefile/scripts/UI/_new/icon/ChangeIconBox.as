package UI._new.icon
{
   import UI.label.NormalIconBox;
   import UI.page.PageBox;
   import gameAll.data.ArmsItemsDataGroup;
   
   public class ChangeIconBox extends NormalIconBox
   {
      
      public var type:String = "";
      
      public var dataType:String = "bag";
      
      public var allType:String = "";
      
      public var iconLabel:String = "";
      
      public var page:PageBox = new PageBox();
      
      public var dataGroup:* = null;
      
      public function ChangeIconBox()
      {
         super();
      }
      
      public function setDataGroup(dg0:*, type0:String, dataType0:String = "bag") : *
      {
         this.type = type0;
         this.dataType = dataType0;
         this.dataGroup = dg0;
         var num0:int = int(dg0.bagMaxNum);
         if(this.dataType == "equip")
         {
            num0 = int(dg0.equMaxNum);
         }
         var iconLabel0:String = type0 + "_icon";
         if(type0 == "arms" || type0 == "sub")
         {
            this.allType = "arms";
            if(dataType0 == "bag")
            {
               iconLabel0 = "arms_icon";
            }
            else
            {
               iconLabel0 = "armsEquip_icon";
            }
         }
         else if(type0 == "car")
         {
            this.allType = "car";
            iconLabel0 = "car_icon";
         }
         else
         {
            this.allType = "items";
            iconLabel0 = "items_icon";
         }
         this.iconLabel = iconLabel0;
         this.setTotalNum(num0,iconLabel0);
      }
      
      public function setTotalNum(num0:int, type0:String, nopage:Boolean = false) : *
      {
         var icon0:NormalAllIcon = null;
         var arr0:Array = [];
         var w0:int = 0;
         var h0:int = 0;
         for(var i:int = 0; i < num0; i++)
         {
            icon0 = new NormalAllIcon();
            icon0.setMaterial(type0);
            w0 = icon0.width;
            h0 = icon0.height;
            arr0.push(icon0);
         }
         inData_byArr(arr0);
         this.page.table = this;
         this.page.fleshByTable();
         addChild(this.page);
         this.page.x = (w0 * xNum + xGap * (xNum - 1)) / 2;
         if(nopage == false)
         {
            this.page.y = h0 * yNum + yGap * (yNum - 1) + 10;
         }
      }
      
      public function clearAllContext() : *
      {
         doFun("setState","blank");
      }
      
      public function fleshNewShow() : *
      {
         var n:* = undefined;
         var btn0:* = undefined;
         if(visible)
         {
            for(n in arr)
            {
               btn0 = arr[n];
               if(Boolean(btn0.hasOwnProperty("itemsData")))
               {
                  if(Boolean(btn0.itemsData))
                  {
                     if(Boolean(btn0.itemsData.hasOwnProperty("newB")))
                     {
                        btn0.itemsData.newB = false;
                     }
                  }
               }
            }
         }
      }
      
      public function fleshData(nopage:Boolean = false) : *
      {
         var n:* = undefined;
         var d0:* = undefined;
         var icon0:NormalAllIcon = null;
         var i:* = undefined;
         var icon1:NormalAllIcon = null;
         var lock_str0:String = null;
         var num0:int = int(this.dataGroup.bagMaxNum);
         if(this.dataType == "equip")
         {
            num0 = int(this.dataGroup.equMaxNum);
         }
         if(arr.length != num0)
         {
            clear();
            this.setTotalNum(num0,this.iconLabel,nopage);
         }
         this.clearAllContext();
         var dg:* = this.dataGroup;
         var arr0:Array = dg.arr;
         if(this.dataType == "equip")
         {
            arr0 = dg.equArr;
         }
         for(n in arr0)
         {
            d0 = arr0[n];
            icon0 = arr[d0.site];
            icon0.inData_byItemsData(d0);
         }
         if(dg is ArmsItemsDataGroup && this.dataType == "equip")
         {
            for(i in arr)
            {
               icon1 = arr[i];
               lock_str0 = dg.armsState[i];
               if(lock_str0 != "")
               {
                  icon1.setState("lock");
               }
            }
         }
      }
      
      public function fleshNum() : *
      {
         var n:* = undefined;
         for(n in arr)
         {
            arr[n].showNumEverB = true;
            arr[n].setNum(n + 1);
         }
      }
   }
}

