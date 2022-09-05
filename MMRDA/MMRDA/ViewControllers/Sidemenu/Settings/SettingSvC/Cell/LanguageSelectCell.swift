//
//  LanguageSelectCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class LanguageSelectCell: UITableViewCell {

    
    var completionBlock:c2V?
    
    
    @IBOutlet weak var btnMarathi: UIButton!
    @IBOutlet weak var btnHindi: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let selectedLanguage = languageCode as? String {
            if selectedLanguage  ==  LanguageCode.Marathi.rawValue {
                btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
                btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
                btnMarathi.setImage(UIImage(named: "radioSelected"), for:.normal)
            }else if selectedLanguage  ==  LanguageCode.Hindi.rawValue {
                btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
                btnHindi.setImage(UIImage(named: "radioSelected"), for:.normal)
                btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
            }else{
                btnEnglish.setImage(UIImage(named: "radioSelected"), for:.normal)
                btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
                btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func actionlanguageChnage(_ sender: UIButton) {
        if sender.tag == 101{
            languageCode = LanguageCode.English.rawValue
            btnEnglish.setImage(UIImage(named: "radioSelected"), for:.normal)
            btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
            btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
        }else if sender.tag == 102{
            languageCode = LanguageCode.Hindi.rawValue
            btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
            btnHindi.setImage(UIImage(named: "radioSelected"), for:.normal)
            btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
        }else {
            languageCode = LanguageCode.Marathi.rawValue
            btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
            btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
            btnMarathi.setImage(UIImage(named: "radioSelected"), for:.normal)
        }
        guard let cb = completionBlock else {return}
            cb()
    }
    
}
