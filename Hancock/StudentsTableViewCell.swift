
import UIKit

class StudentsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var stuCurrentBook: UILabel!
    @IBOutlet weak var stuCurrentChp: UILabel!
    @IBOutlet weak var stuCurCompletion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
