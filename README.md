MNGesturePassword
==============

iOS手势密码实现 Swift3

## Usage

```
class ViewController: UIViewController, MNGesturePasswordDelegate {

    var gesture: MNGesturePassword!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let configure = MNGesturePasswordConfigure.defaultConfigure()
        gesture = MNGesturePassword(delegate: self, configure: configure)
        view.backgroundColor = UIColor.darkGray
        let gestureView = gesture.gestureView
        view.addSubview(gestureView)
        let dWidth = UIScreen.main.bounds.size.width
        let dHeight = UIScreen.main.bounds.size.height
        gestureView.frame = CGRect(x: 0, y: (dHeight - dWidth) / 2, width: dWidth, height: dHeight)
    }

    // MARK: - MNGesturePasswordDelegate
    func gesturePasswordOnGestured(gesturePassword: MNGesturePassword, password: String) {
        print("手势密码\(password)")
        if password == "012" {
            gesture.showErrorView()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: { 
                self.gesture.resetView()
            })
        } else if password == "345" {
            gesture.showSuccessView()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                self.gesture.resetView()
            })
        } else {
            self.gesture.resetView()
        }
    }

}



```
