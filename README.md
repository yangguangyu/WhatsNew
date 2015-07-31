####What's New: Version Notification System by Dave Levy
#Overview
The What's New version notification system is a simple way for apps to add brief notification alerts when a new version of their app is installed.  The first time What's New detects a new version is launched, the user is presented with a brief description of brand new features.  The app developer can choose to either present this information via a live webpage,  or from a simple string included in their app.  What's New is coded in Swift and can also be used in Swift-bridged Objective C projects.
   
# Instructions   
**If porting WhatsNew SIMPLE ALERT code into an existing Objective C project that has Swift bridging...**
 >1. Bring WhatsNewController.swift and VersionChecker.swift into your current X-Code project.
 >2. Modify alertMessage text and paste this code into your ViewWillAppear section in your Initial View Controller.
```
WhatsNewController *whatsNew = [[WhatsNewController alloc]init];
//(paste any customizations here)
whatsNew.appViewController = self;
whatsNew.alertMessage = [NSString stringWithFormat:@"-Feature one. \n-Feature two. \n-Feature three."]; //edit text
[whatsNew displayFromStringIfNecessary];
```

----------------------------------

**If porting WhatsNew WEBPAGE POP-OUT ALERT  or EMBEDDED ALERT code into an existing Objective C project that has Swift bridging...**
>1. Bring WhatsNewController.swift, VersionChecker.swift, and WhatsNew.storyboard into your current X-Code project.
>2. Modify alertPageURL text and paste this code into your ViewWillAppear section in your Initial View Controller.
```
WhatsNewController *whatsNew = [[WhatsNewController alloc]init];
//(paste any customizations here)
whatsNew.alertPageURL = [NSURL URLWithString:@"http://www.infusionsoft.com"]; //edit url
whatsNew.appViewController = self;
[whatsNew displayFromURLIfNeccessaryInsideApp:true];
//edit true or false
```
-------------------------------------

**If porting WhatsNew WEBPAGE POP-OUT or EMBEDDED ALERT code into an existing Swift project...**
>1. Bring WhatsNewController.swift, VersionChecker.swift, and WhatsNew.storyboard into your current X-Code project.
>2. Modify alertPageURL text and paste this code into your ViewWillAppear section in your Initial View Controller.
```
let whatsNewController = WhatsNewController()
//(paste any customizations here)
whatsNewController.appViewController = (self)
whatsNewController.alertPageURL = NSURL(string: "https://en.wikipedia.org/wiki/Pug") //edit url
        whatsNewController.displayFromURLIfNeccessaryInsideApp(true) //edit true or false
```
----------------------------------
**If porting WhatsNew SIMPLE ALERT code into an existing Swift project...**
> 1. Bring WhatsNewController.swift and VersionChecker.swift into your current X-Code project.
>2. Modify alertMessage text and paste this code into your ViewWillAppear section in your Initial View Controller.
```
let whatsNewController = WhatsNewController()
//(paste any customizations here)
whatsNewController.appViewController = (self)
whatsNewController.alertMessage = "-Feature one. \n-Feature two. \n-Feature three."
whatsNewController.displayFromStringIfNecessary()
```
-----------------------------
**TIPS**

 - In regards to displayFromURLIfNeccessaryInsideApp you can either pop
   out a Safari window by using
   displayFromURLIfNeccessaryInsideApp:false,  or you can embed the
   webpage inside our custom ViewController with
   displayFromURLIfNeccessaryInsideApp:true.  Either option requires
   that you designate an whatsNewController.alertPageURL which is the
   webpage containing all of your version details.
 - For simple text alerts, edit the "whatsNewController.alertMessage"
   which will provide the user with details regarding your new app's
   version. If you decide not to include a
   "whatsNewController.alertMessage", the user will be alerted that a
   new version has been installed, without any details.
 - Alerts for each version will only happen once, the first time the app
   is launched.
-----------------------------
**CUSTOMIZATIONS**

**First Run:**  The first time a user launches your App you can send them a simple alert, otherwise no notifications will occur on first launch.  To send them a custom alert message paste and modify this code below let whatsNewController = 

    WhatsNewController(). 
    whatsNewController.showOnFirstLaunch = true
    whatsNewController.firstRunOk = "Sounds good."
    whatsNewController.firstRunTitle = "Welcome to Happy Pugs!"
    whatsNewController.firstRunMessage = "Hey, thanks for trying out Happy Pugs!"

**Customized Text:**   You can change any of the standard text in the What's New alerts.  Here are the variables you can edit...  

    whatsNewController.alertOk = "Yep"
    whatsNewController.alertNoThanks = "Nope"
    whatsNewController.alertUpdatedToVersion = "Presenting Version "
    whatsNewController.alertWouldYouLikeToSeeWhatsNew = "Want to see what is new?"
    
**Customized Design:**  You can make minor modifications to the design such as button color and page flip animation.  

    whatsNewController.customModalTransition = UIModalTransitionStyle.PartialCurl
    whatsNewController.customButtonColor = UIColor.yellowColor()
    whatsNewController.customBackgroundColor = UIColor.redColor()

