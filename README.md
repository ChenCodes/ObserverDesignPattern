##Swift Design Pattern of the Day - Observer Pattern - 6/24/16

Recently I ran into a problem in my Tapstr game code. After having to deal with constraints for the app, I had my original game code become split up between two Viewcontroller files, one which was a container controller for another that was the child view. Now, when I updated the score within the child view, I needed to reflect that change in the container controller. At first, I tried doing ViewController(), but the problem as a result of this was that I ended up getting an error saying that an optional that had been unwrapped was nil. The explanation for this is that the original instance being instantiated was forgetten as doing ViewController() creates a class instance, and thus the UILabel was nil for that. 


So, what was the fix?

Observer design patterns.
This strategy allows the user to send a "notification" to as many Viewcontrollers as the user needs there to be. 

Here is the process flow:
First define a struct with a static variable that we will need to use to refer to later on when sending out the request. 

Next, we'll need to define a variable that becomes an instance of NSNotificationCenter object.
>>let notificationCtr = NSNotificationCenter.defaultCenter()

After that, we'll go into the viewDidLoad method. Using an instance of NSNotificationCenter that we just defined in the step above, we'll need to add some "observers". The parameters that are passed in includes: self(as this is the object sending out the notification), selector: (what function method we will call as a result of this notification being executed), name: (this will be the variable from our struct that we just created, the reason we need a specific name is that there is the possibility of different notifications being sent out. Finally the last parameter is object: (self)
Explanation below:
>>Here's a short example:
>>We have viewcontrollers 1, 2, 3, and 4. When a button from 1 is pressed, we want just 2 to be notified. When a button from 3 is pressed, we only want 4 to be notified. Instead of creating a new struct for these two possible notifications, what we can do instead is create two variables within the same struct: static let notif1 = "NOTIFICATION1"   and also static let notif2 = "NOTIFICATION2". Thus, in the code for the viewcontrollers, we will pass in the appropriate name paramter depending on which notification we're trying to send out.

Continuing, we need to have an IBAction that determines when exactly the notification should be posted to the observing viewcontrollers.
Here is the code that needs to go in the IBAction:
>>notificationCtr.postNotificationName(MyNotifications.broadcast, object: self) 
What this code above does is that it ensures the the code in the viewDidLoad will be triggered. Since the parameter passed in is MyNotifications.broadcast, it eventually goes to the selector and calls that method.

Now, we have to actually define our selector method.
>>func notifyObservers() {
>>myLabel.text = "I got notified"
>>}
This means that our current label will be set to the string "I got notified".

Finally, let's move on to the other viewcontroller.

Here, we need to put in the code for viewDidLoad():
>>override func viewDidLoad() {
>>super.viewDidLoad()
>>notificationCtr.addObserver(self, selector: "notifyObservers", name: MyNotifications.broadcast, object: nil)
>>}

This ensures that we did add this controller as one of the observers for the specified "MyNotifications.broadcast" notification.

Finally, the last thing we do is this(we need to define our selector method here as well):
>>func notifyObservers() {
>>myLabel.text = "I got notified"
>>}

Now, just build and run your project!

Happy coding!

To learn more, visit: https://www.youtube.com/watch?v=_zl_fLkZBQ0
