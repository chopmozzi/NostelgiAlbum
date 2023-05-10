import UIKit

class AlbumRenameViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var albumTextField: UITextField!
    @IBOutlet weak var wordCountLabel: UILabel!
    weak var shareVC: ShareViewController!
    
    var albumCoverName: String!
    var filePath: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumTextField.text = albumCoverName
        albumTextField.becomeFirstResponder()
        
        albumTextField.delegate = self
        wordCountLabel.text = "\(albumCoverName.count) / 10"
    }

    @IBAction func checkButton(_ sender: Any) {
        if albumTextField.text == "" {
            print("비어있습니다.")
        } else {
            shareVC.albumCoverName = albumTextField.text
            shareVC.editTitle.text = albumTextField.text
            shareVC.loadingAlbumInfo()
            self.dismiss(animated: true)
        }
    }

    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension AlbumRenameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if changedText.count <= 10 {
            self.wordCountLabel.text = "\(changedText.count) / 10"
            self.wordCountLabel.textColor = .white
        } else {
            self.wordCountLabel.textColor = .red
        }
        
        return changedText.count <= 10
    }
}
