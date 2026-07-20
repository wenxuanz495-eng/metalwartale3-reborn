package ctrl4399.view.components.sortlist
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.strconst.AllConst;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import frame4399.simplePureMvc.core.Facade;
   import org.heaven.impl.tot.Singleton;
   
   public class ListItem extends Sprite
   {
      
      private var _facade:Facade = Facade.getInstance();
      
      private var listBg:*;
      
      private var myUID:String = "";
      
      public var uid:String;
      
      private var _headPicContent:Sprite;
      
      private var txtColorArr:Array = [];
      
      public function ListItem()
      {
         super();
         this.uid = "";
         var _loc1_:Class = Singleton.getClass(AllConst.SPC_SListOther);
         this.listBg = new _loc1_();
         this.listBg.txtIndex.mouseEnabled = false;
         this.listBg.txtFrom.mouseEnabled = false;
         this.listBg.txtName.mouseEnabled = false;
         this.listBg.txtScore.mouseEnabled = false;
         this.txtColorArr.push(this.listBg.txtIndex.textColor);
         this.txtColorArr.push(this.listBg.txtFrom.textColor);
         this.txtColorArr.push(this.listBg.txtName.textColor);
         this.txtColorArr.push(this.listBg.txtScore.textColor);
         this._headPicContent = this.listBg["picContent"] as Sprite;
         this.addChild(this.listBg);
      }
      
      private function get mainProxy() : MainProxy
      {
         return this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      public function showData(param1:Array) : void
      {
         if(param1)
         {
            if(param1[0] == this.mainProxy.userID)
            {
               this.listBg.txtFrom.textColor = 3381504;
               this.listBg.txtName.textColor = 3381504;
               this.listBg.txtScore.textColor = 3381504;
            }
            else
            {
               this.listBg.txtFrom.textColor = this.txtColorArr[1];
               this.listBg.txtName.textColor = this.txtColorArr[2];
               this.listBg.txtScore.textColor = this.txtColorArr[3];
            }
            trace("data = " + param1);
            this.listBg.txtIndex.text = "";
            this.listBg.txtFrom.text = "";
            this.listBg.txtName.text = "";
            this.listBg.txtScore.text = "";
            if(param1[5] != null && param1[5] != undefined)
            {
               this.listBg.txtIndex.text = param1[5];
            }
            if(param1[1] != null && param1[1] != undefined)
            {
               this.listBg.txtName.text = param1[1];
            }
            if(param1[3] != null && param1[3] != undefined)
            {
               this.listBg.txtFrom.text = "来自" + param1[3];
            }
            if(param1[2] != null && param1[2] != undefined)
            {
               this.listBg.txtScore.text = param1[2] + "分";
            }
         }
         else
         {
            trace("$$$$$$$$$$$$$$$$$$$$");
         }
      }
      
      public function clearData() : void
      {
         if(this._headPicContent != null)
         {
            while(this._headPicContent.numChildren > 0)
            {
               this._headPicContent.removeChildAt(0);
            }
         }
         this.listBg.txtIndex.text = "";
         this.listBg.txtFrom.text = "";
         this.listBg.txtName.text = "";
         this.listBg.txtScore.text = "";
      }
      
      public function upDataPic(param1:DisplayObject) : void
      {
         if(this._headPicContent != null)
         {
            if(param1 == null)
            {
               return;
            }
            param1.width = 37;
            param1.height = 37;
            while(this._headPicContent.numChildren > 0)
            {
               this._headPicContent.removeChildAt(0);
            }
            this._headPicContent.addChild(param1);
         }
      }
   }
}

