import Foundation
import SwiftUI

// Define a struct `Cell` representing a single cell in the Tic-Tac-Toe game board
struct Cell {
    var tile: Tile // Represents the current state of the cell: Nought, Cross, or Empty
    
    // Function to display the content of the cell based on its `tile` value
    func displayTile() -> String {
        switch tile {
        case .Nought:
            return "O" // Display "O" if the cell contains a Nought
        case .Cross:
            return "X" // Display "X" if the cell contains a Cross
        case .Empty:
            return "" // Display an empty string if the cell is empty
        }
    }
    
    // Function to determine the color of the tile based on its `tile` value
    func tileColor() -> Color {
        switch tile {
        case .Nought:
            return Color.red // Set color to red for Noughts
        case .Cross:
            return Color.black // Set color to black for Crosses
        case .Empty:
            return Color.black // Default color (black) for empty cells
        }
    }
}

// Enum `Tile` represents the possible states of a cell: Nought, Cross, or Empty
enum Tile {
    case Nought
    case Cross
    case Empty
}
