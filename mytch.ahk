#Persistent
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

TargetImages := ["mytchcomp.png", "legend.png"]
RerollButton := "reroll.png" 
SleepDelay := 500
Confidence := 80 


LeftRegion := [620, 575, 955, 800]   
RightRegion := [960, 575, 1400, 1300] 


F1:: 
    Loop {
        RerollUntilTarget(RightRegion)
        RerollUntilTarget(LeftRegion)
    }
Return

B::ExitApp 


RerollUntilTarget(region) {
    global TargetImages, RerollButton, SleepDelay, Confidence
    
    Loop {

        for index, target in TargetImages {
            if ImageSearchFound(target, region) {
                return 
            }
        }

        if ImageSearchClick(RerollButton, region) {
            Sleep, SleepDelay
        } else {
            return
        }
    }
}

ImageSearchFound(img, region) {
    global Confidence
    CoordMode, Pixel, Screen
    ImageSearch, FoundX, FoundY, region[1], region[2], region[3], region[4], *%Confidence% %img%
    return (ErrorLevel = 0)
}

ImageSearchClick(img, region) {
    global Confidence
    CoordMode, Pixel, Screen
    ImageSearch, FoundX, FoundY, region[1], region[2], region[3], region[4], *%Confidence% %img%
    if (ErrorLevel = 0) {
        Click, %FoundX%, %FoundY%
        MouseMove, FoundX, FoundY-50, 2
        return true
    }
    return false
}
