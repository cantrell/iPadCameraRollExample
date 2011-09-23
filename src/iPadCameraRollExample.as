//  Adobe(R) Systems Incorporated Source Code License Agreement
//  Copyright(c) 2006-2010 Adobe Systems Incorporated. All rights reserved.
//	
//  Please read this Source Code License Agreement carefully before using
//  the source code.
//	
//  Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive, 
//  no-charge, royalty-free, irrevocable copyright license, to reproduce,
//  prepare derivative works of, publicly display, publicly perform, and
//  distribute this source code and such derivative works in source or 
//  object code form without any attribution requirements.    
//	
//  The name "Adobe Systems Incorporated" must not be used to endorse or promote products
//  derived from the source code without prior written permission.
//	
//  You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
//  against any loss, damage, claims or lawsuits, including attorney's 
//  fees that arise or result from your use or distribution of the source 
//  code.
//  
//  THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT 
//  ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
//  BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
//  FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  ALSO, THERE IS NO WARRANTY OF 
//  NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT.  IN NO EVENT SHALL ADOBE 
//  OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR 
//  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import flash.media.CameraRollBrowseOptions;
	
	public class iPadCameraRollExample extends Sprite
	{
		
		private static const PADDING:uint = 12;
		private static const BUTTON_LABEL:String = "Open Photo Picker";
		
		public function iPadCameraRollExample()
		{
			super();
			
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE, doLayout);
		}
		
		private function doLayout(e:Event):void
		{
			this.removeChildren();
			
			var topLeft:Button = new Button(BUTTON_LABEL);
			topLeft.x = PADDING; topLeft.y = PADDING;
			topLeft.addEventListener(MouseEvent.CLICK, onOpenPhotoPicker);
			this.addChild(topLeft);
			
			var topRight:Button = new Button(BUTTON_LABEL);
			topRight.x = this.stage.stageWidth - topRight.width - PADDING; topRight.y = PADDING;
			topRight.addEventListener(MouseEvent.CLICK, onOpenPhotoPicker);
			this.addChild(topRight);
			
			var bottomRight:Button = new Button(BUTTON_LABEL);
			bottomRight.x = this.stage.stageWidth - bottomRight.width - PADDING; bottomRight.y = this.stage.stageHeight - bottomRight.height - PADDING;
			bottomRight.addEventListener(MouseEvent.CLICK, onOpenPhotoPicker);
			this.addChild(bottomRight);

			var bottomLeft:Button = new Button(BUTTON_LABEL);
			bottomLeft.x = PADDING; bottomLeft.y = this.stage.stageHeight - bottomLeft.height - PADDING;
			bottomLeft.addEventListener(MouseEvent.CLICK, onOpenPhotoPicker);
			this.addChild(bottomLeft);

			var center:Button = new Button(BUTTON_LABEL);
			center.x = (this.stage.stageWidth / 2) - (center.width / 2); center.y = (this.stage.stageHeight / 2) - (center.height/ 2);
			center.addEventListener(MouseEvent.CLICK, onOpenPhotoPicker);
			this.addChild(center);
		}
		
		private function onOpenPhotoPicker(e:MouseEvent):void
		{
			// We're on mobile. Should work well for phones and tablets.
			if (CameraRoll.supportsBrowseForImage)
			{
				var crOpts:CameraRollBrowseOptions = new CameraRollBrowseOptions();
				crOpts.height = this.stage.stageHeight / 3;
				crOpts.width = this.stage.stageWidth / 3;
				crOpts.origin = new Rectangle(e.target.x, e.target.y, e.target.width, e.target.height);
				var cr:CameraRoll = new CameraRoll();
				cr.browseForImage(crOpts);
			}
			else // We're on the desktop
			{
				var picDirectory:File;
				if (File.userDirectory.resolvePath("Pictures").exists)
				{
					picDirectory = File.userDirectory.resolvePath("Pictures");
				}
				else if (File.userDirectory.resolvePath("My Pictures").exists)
				{
					picDirectory = File.userDirectory.resolvePath("My Pictures");
				}
				else
				{
					picDirectory = File.userDirectory;
				}
				picDirectory.browseForOpen("Choose a picture");
			}
		}
	}
}