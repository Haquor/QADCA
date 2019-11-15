/**
 * Example of QADCA class being implemented.
 * @author Haquor
 * @version 1.0
 */
class Main 
{
	public static function main(swfRoot:MovieClip):Void 
	{
		var gaiaID:Number = 12345;
		var userMessage:String = "Hello World!";
		
		var encrypted:String = QADCA.e0(gaiaID, userMessage);
		trace("Encrypt: " + encrypted);
		
		var decrypted:Array = QADCA.d0(gaiaID, encrypted);
		
		if (decrypted.b) {
			trace("Decrypt: " + decrypted.s);
		} else {
			trace("The message could not be decrypted.");
		}
	}
	
}