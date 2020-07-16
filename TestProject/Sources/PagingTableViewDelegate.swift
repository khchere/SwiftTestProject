

import UIKit

@objc public protocol PagingTableViewDelegate {

  @objc optional func didPaginate(_ tableView: PagingTableView, to page: Int)
  func paginate(_ tableView: PagingTableView, to page: Int)

}
