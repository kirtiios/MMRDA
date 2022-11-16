//
//  LanguageSelectCell.swift
//  MMRDA
//
//  Created by Sandip Patel on 01/09/22.
//

import UIKit

class LanguageSelectCell: UITableViewCell {

    
    var completionBlock:c2V?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnMarathi: UIButton!
    @IBOutlet weak var btnHindi: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnHindi.isSelected = false
        btnEnglish.isSelected = false
        btnMarathi.isSelected = false
        if let selectedLanguage = languageCode as? String {
            if selectedLanguage  ==  LanguageCode.Marathi.rawValue {
                
               // btnHindi.isSelected = false
                btnMarathi.isSelected = true
//                btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
//                btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
//                btnMarathi.setImage(UIImage(named: "radioSelected"), for:.normal)
            }else if selectedLanguage  ==  LanguageCode.Hindi.rawValue {
                btnHindi.isSelected = true
//                btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
//                btnHindi.setImage(UIImage(named: "radioSelected"), for:.normal)
//                btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
            }else{
                btnEnglish.isSelected = true
//                btnEnglish.setImage(UIImage(named: "radioSelected"), for:.normal)
//                btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
//                btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func actionlanguageChnage(_ sender: UIButton) {
        
        btnHindi.isSelected = false
        btnEnglish.isSelected = false
        btnMarathi.isSelected = false
        sender.isSelected = true
        
        if sender.tag == 101{
            languageCode = LanguageCode.English.rawValue
//            btnEnglish.setImage(UIImage(named: "radioSelected"), for:.normal)
//            btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
//            btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
        }else if sender.tag == 102{
            languageCode = LanguageCode.Hindi.rawValue
//            btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
//            btnHindi.setImage(UIImage(named: "radioSelected"), for:.normal)
//            btnMarathi.setImage(UIImage(named: "radioUnselected"), for:.normal)
        }else {
            languageCode = LanguageCode.Marathi.rawValue
//            btnEnglish.setImage(UIImage(named: "radioUnselected"), for:.normal)
//            btnHindi.setImage(UIImage(named: "radioUnselected"), for:.normal)
//            btnMarathi.setImage(UIImage(named: "radioSelected"), for:.normal)
        }
        guard let cb = completionBlock else {return}
            cb()
    }
    
}
