package image
{
   import body.image.SingleMovieclip;
   import flash.display.MovieClip;
   import net.SWFLoaderManager;
   
   public class BmpMovieClipManager
   {
      
      private var arr:Array = new Array();
      
      public function BmpMovieClipManager()
      {
         super();
      }
      
      public function addResource(mc0:MovieClip, father0:String, label0:String) : *
      {
         var bmc:BmpMovieClip = new BmpMovieClip(mc0);
         bmc.label = label0;
         bmc.father = father0;
         var sm0:SingleMovieclip = new SingleMovieclip(bmc,label0);
         this.arr.push(sm0);
      }
      
      public function batchAddResource(swfLM:SWFLoaderManager, father0:String, arr0:Array) : *
      {
         var n:* = undefined;
         var label0:String = null;
         var mc0:MovieClip = null;
         for(n in arr0)
         {
            label0 = arr0[n];
            mc0 = swfLM.getResource(father0,label0);
            if(mc0 is MovieClip)
            {
               this.addResource(mc0,father0,label0);
            }
         }
      }
      
      public function getSingleMovieclip(father0:String, label0:String) : SingleMovieclip
      {
         var n:* = undefined;
         var smc0:SingleMovieclip = null;
         var la_arr:Array = label0.split("/");
         if(la_arr.length == 2)
         {
            father0 = la_arr[0];
            label0 = la_arr[1];
         }
         var smc:SingleMovieclip = null;
         for(n in this.arr)
         {
            smc0 = this.arr[n];
            if(smc0.mc.label == label0 && smc0.mc.father == father0)
            {
               return new SingleMovieclip(smc0.mc.copy(),label0,father0);
            }
         }
         return smc;
      }
      
      public function delResource() : *
      {
      }
      
      public function getMemorys() : Number
      {
         var n:* = undefined;
         var mm:Number = 0;
         for(n in this.arr)
         {
            mm += this.arr[n].mc.getMemorys();
         }
         return mm;
      }
   }
}

