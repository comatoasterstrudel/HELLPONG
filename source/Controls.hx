package;

import flixel.FlxG;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

/**
 * class to handle control inputs
 */
class Controls {
    public static var controlsList:Array<String> = ['ACCEPT', 'BACK', 'CREDITS', 'LEFT', 'RIGHT', 'UP', 'DOWN', "LEFT2", "RIGHT2", "UP2", "DOWN2"];
    
    public static var keyboardControls:Map<String, Array<FlxKey>> = [
        'ACCEPT' => [SPACE],
        'BACK' => [ESCAPE],
        'CREDITS' => [CONTROL],
        'LEFT' => [A],
        'RIGHT' => [D],
        'UP' => [W],
        'DOWN' => [S],
        'LEFT2' => [LEFT],
        'RIGHT2' => [RIGHT],
        'UP2' => [UP],
        'DOWN2' => [DOWN],
    ];
    
    public static var gamepadControls:Map<String, Array<FlxGamepadInputID>> = [
        'ACCEPT' => [A],
        'BACK' => [B],
        'CREDITS' => [Y],
        'LEFT' => [LEFT_STICK_DIGITAL_LEFT],
        'RIGHT' => [LEFT_STICK_DIGITAL_RIGHT],
        'UP' => [LEFT_STICK_DIGITAL_UP],
        'DOWN' => [LEFT_STICK_DIGITAL_DOWN],
        'LEFT2' => [RIGHT_STICK_DIGITAL_LEFT],
        'RIGHT2' => [RIGHT_STICK_DIGITAL_RIGHT],
        'UP2' => [RIGHT_STICK_DIGITAL_UP],
        'DOWN2' => [RIGHT_STICK_DIGITAL_DOWN],
    ];
    
    /**
     * call this to see if a control is being pressed
     * @param name which control
     * @param type HOLD / RELEASE
     */
    public static function getControl(name:String, type:String):Bool{
        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
        
        if(gamepad != null){
            for(i in FlxG.gamepads.getActiveGamepads()){
                var gamepad:FlxGamepad = i;
                
                switch(type)
                {
                        case 'HOLD':
                            for(control in keyboardControls.get(name)){
                                if(FlxG.keys.anyPressed([control])) return true;
                            }    
                            
                            if(gamepad != null){
                                for(control in gamepadControls.get(name)){
                                    if(gamepad.anyPressed([control])) return true;
                                }   
                            }
                        case 'RELEASE':
                            for(control in keyboardControls.get(name)){
                                if(FlxG.keys.anyJustPressed([control])) return true;
                            }   
                            
                            if(gamepad != null){
                                for(control in gamepadControls.get(name)){
                                    if(gamepad.anyJustPressed([control])) return true;
                                }   
                            }
                }
        
                return false; 
            } 
            
        }

        switch(type)
        {
                case 'HOLD':
                    for(control in keyboardControls.get(name)){
                        if(FlxG.keys.anyPressed([control])) return true;
                    }    
                    
                    if(gamepad != null){
                        for(control in gamepadControls.get(name)){
                            if(gamepad.anyPressed([control])) return true;
                        }   
                    }
                case 'RELEASE':
                    for(control in keyboardControls.get(name)){
                        if(FlxG.keys.anyJustPressed([control])) return true;
                    }   
                    
                    if(gamepad != null){
                        for(control in gamepadControls.get(name)){
                            if(gamepad.anyJustPressed([control])) return true;
                        }   
                    }
        }
        
        return false;
    }
}
