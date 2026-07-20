package sound
{
   import flash.media.Sound;
   
   public class SoundGroup
   {
      
      public var arr:Array = [];
      
      public var arr2:Array = [];
      
      public function SoundGroup()
      {
         super();
      }
      
      public function addSoundList(labelArr:Array) : *
      {
         var n:* = undefined;
         var label0:String = null;
         for(n in labelArr)
         {
            label0 = labelArr[n];
            this.addSound(Game.swfLoaderManager.getResource("sound",label0),label0);
         }
      }
      
      public function addMusicList(labelArr:Array) : *
      {
         var n:* = undefined;
         var label0:String = null;
         for(n in labelArr)
         {
            label0 = labelArr[n];
            this.addMusic(Game.swfLoaderManager.getResource("sound",label0),label0);
         }
      }
      
      public function addSound(_sound:Sound, _label:String) : *
      {
         var s0:OneSound = new OneSound(_sound,_label);
         this.arr.push(s0);
      }
      
      public function playSound(_label:String) : *
      {
         var s0:OneSound = this.getSound(_label);
         if(s0 is OneSound)
         {
            s0.play();
         }
      }
      
      public function getSound(_label:String) : OneSound
      {
         var n:* = undefined;
         var s0:OneSound = null;
         for(n in this.arr)
         {
            s0 = this.arr[n];
            if(s0.label == _label)
            {
               return s0;
            }
         }
         trace("没找到音效：" + _label);
         return null;
      }
      
      public function addMusic(_sound:Sound, _label:String) : *
      {
         var s0:OneMusic = new OneMusic(_sound,_label);
         this.arr2.push(s0);
      }
      
      public function playMusic(_label:String) : OneMusic
      {
         var s0:OneMusic = this.getMusic(_label);
         if(s0 is OneMusic)
         {
            s0.play();
            return s0;
         }
         return null;
      }
      
      public function stopMusic(_label:String) : *
      {
         var s0:OneMusic = this.getMusic(_label);
         if(s0 is OneMusic)
         {
            s0.stop();
         }
      }
      
      public function getMusic(_label:String) : OneMusic
      {
         var n:* = undefined;
         var s0:OneMusic = null;
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            if(s0.label == _label)
            {
               return s0;
            }
         }
         trace("没找到音效：" + _label);
         return null;
      }
      
      public function stopAllMusic() : *
      {
         var n:* = undefined;
         var s0:OneMusic = null;
         for(n in this.arr2)
         {
            s0 = this.arr2[n];
            s0.stop();
         }
      }
   }
}

