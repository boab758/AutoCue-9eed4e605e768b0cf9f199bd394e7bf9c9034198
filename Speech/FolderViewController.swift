//
//  FolderViewController.swift
//  Speech
//
//  Created by Samuel on 14/8/18.
//  Copyright © 2018 Google. All rights reserved.
//

import UIKit
import SwiftyDropbox

class FolderViewController: UITableViewController {
    
    var folderArr = [Files.Metadata]()
    var fileArr = [Files.Metadata]()

    func folderView(pathos: String) {
        if let dropboxClient = DropboxClientsManager.authorizedClient {
            folderArr.removeAll()
            fileArr.removeAll()
            let listFolders = dropboxClient.files.listFolder(path: pathos)
            listFolders.response{ response, error in
                guard let result = response else {
                    return
                }
                for entry in result.entries {
                    if let meta = entry as? Files.FolderMetadata {
                        self.folderArr.append(entry)
                        print (entry)
                    } else {
                        self.fileArr.append(entry)
                        print("2")
                    }
                }
                print("QWERT")
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TIMEM")
        folderView(pathos: "")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("THE ARRAYS COUNT IS \(folderArr.count+fileArr.count)")
        return folderArr.count+fileArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        if indexPath.row < folderArr.count {
            cell.textLabel?.text = folderArr[indexPath.row].name
            cell.detailTextLabel?.text = "Folder"
        } else {
            cell.textLabel?.text = fileArr[indexPath.row - folderArr.count].name
            cell.detailTextLabel?.text = ""
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.detailTextLabel?.text == "Folder" {
            let folder = folderArr[indexPath.row]
            let path = folder.pathLower
            folderView(pathos: path!)
        } else {
            //download the file
            //pop this view
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
