package gs
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.utils.*;
   
   public class TweenLite
   {
      
      public static var overwriteManager:Object;
      
      protected static var _curTime:uint;
      
      private static var _classInitted:Boolean;
      
      private static var _listening:Boolean;
      
      public static var version:Number = 8.15;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      protected static var _all:Dictionary = new Dictionary();
      
      private static var _sprite:Sprite = new Sprite();
      
      private static var _timer:Timer = new Timer(2000);
      
      public var duration:Number;
      
      public var vars:Object;
      
      public var delay:Number;
      
      public var startTime:int;
      
      public var initTime:int;
      
      public var tweens:Array;
      
      public var target:Object;
      
      protected var _active:Boolean;
      
      protected var _subTweens:Array;
      
      protected var _hst:Boolean;
      
      protected var _hasUpdate:Boolean;
      
      protected var _isDisplayObject:Boolean;
      
      protected var _initted:Boolean;
      
      protected var _timeScale:Number;
      
      public function TweenLite($target:Object, $duration:Number, $vars:Object)
      {
         var v:* = undefined;
         super();
         if($target == null)
         {
            return;
         }
         if(!_classInitted)
         {
            _curTime = getTimer();
            _sprite.addEventListener(Event.ENTER_FRAME,executeAll);
            if(overwriteManager == null)
            {
               overwriteManager = {
                  "mode":1,
                  "enabled":false
               };
            }
            _classInitted = true;
         }
         this.vars = $vars;
         this.duration = $duration || 0.001;
         this.delay = Number($vars.delay) || 0;
         this._timeScale = Number($vars.timeScale) || 1;
         this._active = $duration == 0 && this.delay == 0;
         this.target = $target;
         this._isDisplayObject = $target is DisplayObject;
         if(!(this.vars.ease is Function))
         {
            this.vars.ease = defaultEase;
         }
         if(this.vars.easeParams != null)
         {
            this.vars.proxiedEase = this.vars.ease;
            this.vars.ease = this.easeProxy;
         }
         if(!isNaN(Number(this.vars.autoAlpha)))
         {
            this.vars.alpha = Number(this.vars.autoAlpha);
            this.vars.visible = this.vars.alpha > 0;
         }
         this.tweens = [];
         this._subTweens = [];
         this._hst = this._initted = false;
         this.initTime = _curTime;
         this.startTime = this.initTime + this.delay * 1000;
         var mode:int = $vars.overwrite == undefined || !overwriteManager.enabled && $vars.overwrite > 1 ? int(overwriteManager.mode) : int($vars.overwrite);
         if(_all[$target] == undefined || $target != null && mode == 1)
         {
            delete _all[$target];
            _all[$target] = new Dictionary(true);
         }
         else if(mode > 1 && this.delay == 0)
         {
            overwriteManager.manageOverwrites(this,_all[$target]);
         }
         _all[$target][this] = this;
         if(this.vars.runBackwards == true && this.vars.renderOnStart != true || this._active)
         {
            this.initTweenVals();
            if(this._active)
            {
               this.render(this.startTime + 1);
            }
            else
            {
               this.render(this.startTime);
            }
            v = this.vars.visible;
            if(this.vars.isTV == true)
            {
               v = this.vars.exposedProps.visible;
            }
            if(v != null && this.vars.runBackwards == true && this._isDisplayObject)
            {
               this.target.visible = Boolean(v);
            }
         }
         if(!_listening && !this._active)
         {
            _timer.addEventListener("timer",killGarbage);
            _timer.start();
            _listening = true;
         }
      }
      
      public static function to($target:Object, $duration:Number, $vars:Object) : TweenLite
      {
         return new TweenLite($target,$duration,$vars);
      }
      
      public static function from($target:Object, $duration:Number, $vars:Object) : TweenLite
      {
         $vars.runBackwards = true;
         return new TweenLite($target,$duration,$vars);
      }
      
      public static function delayedCall($delay:Number, $onComplete:Function, $onCompleteParams:Array = null) : TweenLite
      {
         return new TweenLite($onComplete,0,{
            "delay":$delay,
            "onComplete":$onComplete,
            "onCompleteParams":$onCompleteParams,
            "overwrite":0
         });
      }
      
      public static function executeAll($e:Event = null) : void
      {
         var a:Dictionary = null;
         var p:Object = null;
         var tw:Object = null;
         var t:uint = _curTime = getTimer();
         if(_listening)
         {
            a = _all;
            for each(p in a)
            {
               for(tw in p)
               {
                  if(p[tw] != undefined && Boolean(p[tw].active))
                  {
                     p[tw].render(t);
                  }
               }
            }
         }
      }
      
      public static function removeTween($t:TweenLite = null) : void
      {
         if($t != null && _all[$t.target] != undefined)
         {
            _all[$t.target][$t] = null;
            delete _all[$t.target][$t];
         }
      }
      
      public static function killTweensOf($tg:Object = null, $complete:Boolean = false) : void
      {
         var o:Object = null;
         var tw:* = undefined;
         if($tg != null && _all[$tg] != undefined)
         {
            if($complete)
            {
               o = _all[$tg];
               for(tw in o)
               {
                  o[tw].complete(false);
               }
            }
            delete _all[$tg];
         }
      }
      
      public static function killGarbage($e:TimerEvent) : void
      {
         var found:Boolean = false;
         var p:Object = null;
         var twp:Object = null;
         var tw:Object = null;
         var tg_cnt:uint = 0;
         for(p in _all)
         {
            found = false;
            var _loc9_:int = 0;
            var _loc10_:* = _all[p];
            for(twp in _loc10_)
            {
               found = true;
            }
            if(!found)
            {
               delete _all[p];
            }
            else
            {
               tg_cnt++;
            }
         }
         if(tg_cnt == 0)
         {
            _timer.removeEventListener("timer",killGarbage);
            _timer.stop();
            _listening = false;
         }
      }
      
      public static function easeOut($t:Number, $b:Number, $c:Number, $d:Number) : Number
      {
         return -$c * ($t = $t / $d) * ($t - 2) + $b;
      }
      
      public static function tintProxy($o:Object) : void
      {
         var n:Number = Number($o.target.progress);
         var r:Number = 1 - n;
         var sc:Object = $o.info.color;
         var ec:Object = $o.info.endColor;
         $o.info.target.transform.colorTransform = new ColorTransform(sc.redMultiplier * r + ec.redMultiplier * n,sc.greenMultiplier * r + ec.greenMultiplier * n,sc.blueMultiplier * r + ec.blueMultiplier * n,sc.alphaMultiplier * r + ec.alphaMultiplier * n,sc.redOffset * r + ec.redOffset * n,sc.greenOffset * r + ec.greenOffset * n,sc.blueOffset * r + ec.blueOffset * n,sc.alphaOffset * r + ec.alphaOffset * n);
      }
      
      public static function frameProxy($o:Object) : void
      {
         $o.info.target.gotoAndStop(Math.round($o.target.frame));
      }
      
      public static function volumeProxy($o:Object) : void
      {
         $o.info.target.soundTransform = $o.target;
      }
      
      public function initTweenVals($hrp:Boolean = false, $reservedProps:String = "") : void
      {
         var p:String = null;
         var i:int = 0;
         var endArray:Array = null;
         var clr:ColorTransform = null;
         var endClr:ColorTransform = null;
         var tp:Object = null;
         var v:Object = this.vars;
         if(v.isTV == true)
         {
            v = v.exposedProps;
         }
         if(!$hrp && this.delay != 0 && Boolean(overwriteManager.enabled))
         {
            overwriteManager.manageOverwrites(this,_all[this.target]);
         }
         if(this.target is Array)
         {
            endArray = this.vars.endArray || [];
            for(i = 0; i < endArray.length; i++)
            {
               if(this.target[i] != endArray[i] && this.target[i] != undefined)
               {
                  this.tweens[this.tweens.length] = {
                     "o":this.target,
                     "p":i.toString(),
                     "s":this.target[i],
                     "c":endArray[i] - this.target[i],
                     "name":i.toString()
                  };
               }
            }
         }
         else
         {
            if((typeof v.tint != "undefined" || this.vars.removeTint == true) && this._isDisplayObject)
            {
               clr = this.target.transform.colorTransform;
               endClr = new ColorTransform();
               if(v.alpha != undefined)
               {
                  endClr.alphaMultiplier = v.alpha;
                  delete v.alpha;
               }
               else
               {
                  endClr.alphaMultiplier = this.target.alpha;
               }
               if(this.vars.removeTint != true && (v.tint != null && v.tint != "" || v.tint == 0))
               {
                  endClr.color = v.tint;
               }
               this.addSubTween("tint",tintProxy,{"progress":0},{"progress":1},{
                  "target":this.target,
                  "color":clr,
                  "endColor":endClr
               });
            }
            if(v.frame != null && this._isDisplayObject)
            {
               this.addSubTween("frame",frameProxy,{"frame":this.target.currentFrame},{"frame":v.frame},{"target":this.target});
            }
            if(!isNaN(this.vars.volume) && this.target.hasOwnProperty("soundTransform"))
            {
               this.addSubTween("volume",volumeProxy,this.target.soundTransform,{"volume":this.vars.volume},{"target":this.target});
            }
            for(p in v)
            {
               if(!(p == "ease" || p == "delay" || p == "overwrite" || p == "onComplete" || p == "onCompleteParams" || p == "runBackwards" || p == "visible" || p == "autoOverwrite" || p == "persist" || p == "onUpdate" || p == "onUpdateParams" || p == "autoAlpha" || p == "timeScale" || p == "onStart" || p == "onStartParams" || p == "renderOnStart" || p == "proxiedEase" || p == "easeParams" || $hrp && $reservedProps.indexOf(" " + p + " ") != -1))
               {
                  if(!(this._isDisplayObject && (p == "tint" || p == "removeTint" || p == "frame")) && !(p == "volume" && this.target.hasOwnProperty("soundTransform")))
                  {
                     if(typeof v[p] == "number")
                     {
                        this.tweens[this.tweens.length] = {
                           "o":this.target,
                           "p":p,
                           "s":this.target[p],
                           "c":v[p] - this.target[p],
                           "name":p
                        };
                     }
                     else
                     {
                        this.tweens[this.tweens.length] = {
                           "o":this.target,
                           "p":p,
                           "s":this.target[p],
                           "c":Number(v[p]),
                           "name":p
                        };
                     }
                  }
               }
            }
         }
         if(this.vars.runBackwards == true)
         {
            for(i = this.tweens.length - 1; i > -1; i--)
            {
               tp = this.tweens[i];
               tp.s += tp.c;
               tp.c *= -1;
            }
         }
         if(v.visible == true && this._isDisplayObject)
         {
            this.target.visible = true;
         }
         if(this.vars.onUpdate != null)
         {
            this._hasUpdate = true;
         }
         this._initted = true;
      }
      
      protected function addSubTween($name:String, $proxy:Function, $target:Object, $props:Object, $info:Object = null) : void
      {
         var p:String = null;
         var sub:Object = {
            "name":$name,
            "proxy":$proxy,
            "target":$target,
            "info":$info
         };
         this._subTweens[this._subTweens.length] = sub;
         for(p in $props)
         {
            if(typeof $props[p] == "number")
            {
               this.tweens[this.tweens.length] = {
                  "o":$target,
                  "p":p,
                  "s":$target[p],
                  "c":$props[p] - $target[p],
                  "sub":sub,
                  "name":$name
               };
            }
            else
            {
               this.tweens[this.tweens.length] = {
                  "o":$target,
                  "p":p,
                  "s":$target[p],
                  "c":Number($props[p]),
                  "sub":sub,
                  "name":$name
               };
            }
         }
         this._hst = true;
      }
      
      public function render($t:uint) : void
      {
         var factor:Number = NaN;
         var tp:Object = null;
         var i:int = 0;
         var time:Number = ($t - this.startTime) / 1000;
         if(time >= this.duration)
         {
            time = this.duration;
            factor = 1;
         }
         else
         {
            factor = Number(this.vars.ease(time,0,1,this.duration));
         }
         for(i = this.tweens.length - 1; i > -1; i--)
         {
            tp = this.tweens[i];
            tp.o[tp.p] = tp.s + factor * tp.c;
         }
         if(this._hst)
         {
            for(i = this._subTweens.length - 1; i > -1; i--)
            {
               this._subTweens[i].proxy(this._subTweens[i]);
            }
         }
         if(this._hasUpdate)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(time == this.duration)
         {
            this.complete(true);
         }
      }
      
      public function complete($skipRender:Boolean = false) : void
      {
         if(!$skipRender)
         {
            if(!this._initted)
            {
               this.initTweenVals();
            }
            this.startTime = _curTime - this.duration * 1000 / this._timeScale;
            this.render(_curTime);
            return;
         }
         if(this.vars.visible != undefined && this._isDisplayObject)
         {
            if(!isNaN(this.vars.autoAlpha) && this.target.alpha == 0)
            {
               this.target.visible = false;
            }
            else if(this.vars.runBackwards != true)
            {
               this.target.visible = this.vars.visible;
            }
         }
         if(this.vars.persist != true)
         {
            removeTween(this);
         }
         if(this.vars.onComplete != null)
         {
            this.vars.onComplete.apply(null,this.vars.onCompleteParams);
         }
      }
      
      public function killVars($vars:Object) : void
      {
         if(Boolean(overwriteManager.enabled))
         {
            overwriteManager.killVars($vars,this.vars,this.tweens,this._subTweens,[]);
         }
      }
      
      protected function easeProxy($t:Number, $b:Number, $c:Number, $d:Number) : Number
      {
         return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
      }
      
      public function get active() : Boolean
      {
         if(this._active)
         {
            return true;
         }
         if(_curTime >= this.startTime)
         {
            this._active = true;
            if(!this._initted)
            {
               this.initTweenVals();
            }
            else if(this.vars.visible != undefined && this._isDisplayObject)
            {
               this.target.visible = true;
            }
            if(this.vars.onStart != null)
            {
               this.vars.onStart.apply(null,this.vars.onStartParams);
            }
            if(this.duration == 0.001)
            {
               this.startTime -= 1;
            }
            return true;
         }
         return false;
      }
   }
}

