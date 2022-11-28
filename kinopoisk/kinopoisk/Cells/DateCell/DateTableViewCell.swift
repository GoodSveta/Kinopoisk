//
//  DateTableViewCell.swift
//  kinopoisk
//
//  Created by mac on 28.02.22.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    var resetButtonDidClick: (() -> ())?
    var dateDidChange: ((Date) -> ())?
    
    private lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        return df
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 16.0
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.minimumDate = Date()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        dateLabel.text = "Все будущие"
        resetButtonDidClick?()
    }
    
    @IBAction func dateDidChange(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: sender.date)
        dateDidChange?(sender.date)
    }
}
