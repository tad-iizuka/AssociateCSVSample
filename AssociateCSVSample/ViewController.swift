//
//  ViewController.swift
//  AssociateCSVSample
//
//  Created by Tadashi on 2016/10/04.
//  Copyright © 2016 T@d. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet var tableView: UITableView!

	var items: [[String]] = []

	func initWithURL(fileURL: URL) {

		self.items = []

		let str = fileURL.absoluteString
		let file = str.components(separatedBy: "Documents")
		let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
		let csvPath = documentsPath + (file[1])
		do {
			let contents = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)
				contents.enumerateLines(invoking: { (line, stop) in
					self.items.append(line.components(separatedBy: (",")))
				})
		} catch {
			print(error)
		}
		if self.tableView != nil {
			self.tableView.reloadData()
		}
    }

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		var str = String()
		for i in 0..<items[indexPath.row].count {
			str = str + items[indexPath.row][i] + " "
		}
		cell.textLabel!.text = String(indexPath.row + 1) + " "
		cell.detailTextLabel!.text = str

        return cell
    }
}
