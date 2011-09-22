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
			if (CameraRoll.supportsBrowseForImage) // We're on mobile
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
				if (File.userDirectory.resolvePath("Pictures").exists) // Mac
				{
					picDirectory = File.userDirectory.resolvePath("Pictures");
				}
				else // Windows
				{
					picDirectory = File.userDirectory.resolvePath("My Pictures");
				}
				picDirectory.browseForOpen("Choose a picture");
			}
		}
	}
}