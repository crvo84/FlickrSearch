//
//  SearchCell.swift
//  FlickrSearch
//
//  Created by Carlos Villanueva Ousset on 14/01/21.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var searchTermLabel: UILabel!
    @IBOutlet weak var resultCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        initialSetup()
    }

    private func initialSetup() {
        selectionStyle = .none

        searchTermLabel.applyTheme(font: .body, color: .primaryLabel)
        resultCountLabel.applyTheme(font: .body, color: .secondaryLabel)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        searchTermLabel.text = nil
        resultCountLabel.text = nil
        accessoryType = .none
    }
}

extension SearchCell {
    func prepare(with search: Search) {
        accessoryType = search.totalResults == 0 ? .none : .disclosureIndicator
        searchTermLabel.text = search.text
        resultCountLabel.text = "(\(search.totalResults))"
    }
}
