package ctrl4399.view.components.sortlist
{
   import ctrl4399.strconst.AllConst;
   import flash.display.Sprite;
   import org.heaven.impl.tot.Singleton;
   
   public class SelfItem extends Sprite
   {
      
      private var listBg:*;
      
      private var myUID:String = "";
      
      public function SelfItem()
      {
         super();
         var _loc1_:Class = Singleton.getClass(AllConst.SPC_SListSelf);
         this.listBg = new _loc1_();
         this.listBg.txtIndex.mouseEnabled = false;
         this.listBg.txtFrom.mouseEnabled = false;
         this.listBg.txtName.mouseEnabled = false;
         this.listBg.txtScore.mouseEnabled = false;
         this.addChild(this.listBg);
      }
      
      public function showData(param1:Array, param2:int = 0) : void
      {
         if(param1)
         {
            this.listBg.head.visible = true;
            this.setHead(param1[0]);
            this.listBg.txtIndex.text = param2;
            this.listBg.txtName.text = param1[1];
            this.listBg.txtFrom.text = "来自" + param1[3];
            this.listBg.txtScore.text = param1[2] + "分";
         }
      }
      
      public function clearData() : void
      {
         this.listBg.head.visible = false;
         this.listBg.txtIndex.text = "";
         this.listBg.txtFrom.text = "";
         this.listBg.txtName.text = "";
         this.listBg.txtScore.text = "";
      }
      
      public function setHead(param1:String) : void
      {
         if(this.myUID != param1)
         {
            this.myUID = param1;
            this.listBg.head["source"] = this.smallPortrait(param1);
         }
      }
      
      private function smallPortrait(param1:String) : String
      {
         return "https://a.img4399.com/" + (param1 == null ? "0" : param1) + "/small";
      }
   }
}

