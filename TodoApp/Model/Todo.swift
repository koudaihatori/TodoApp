import UIKit

enum TodoPriority:Int {
    case Low = 0
    case Middle = 1
    case High = 2
}


class Todo: NSObject {
    var title = ""
    var descript = ""
    var priority:TodoPriority = .Low
}
