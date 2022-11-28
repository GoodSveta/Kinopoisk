//
//  TypeFilmTableViewCell.swift
//  kinopoisk
//
//  Created by mac on 6.03.22.
//

import UIKit

class TypeFilmTableViewCell: UITableViewCell {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var currentTypeLabel: UILabel!
    
    private let types: [String] = ["Все", "Боевик", "Драма", "Ужасы", "Триллер", "Детектив"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        contentView.layer.cornerRadius = 16.0
        pickerView.setValue(UIColor.white, forKeyPath: "textColor")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension TypeFilmTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
}

extension TypeFilmTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentTypeLabel.text = types[row]
    }
}
