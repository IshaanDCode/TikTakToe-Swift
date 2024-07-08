import Foundation

class GameState: ObservableObject {
    @Published var board = [[Cell]]() // 2Dimensional array of cell objects representing the game board
    @Published var turn = Tile.Cross // Current turn, initially set to Cross (X)(First turn will always be X)
    @Published var noughtsScore = 0 // Score count for Noughts ("O")
    @Published var crossesScore = 0 // Score count for Crosses ('X')
    @Published var showAlert = false // Controls whether to show an alert the iphone alers kinda when you get low power alert
    @Published var alertMessage = "Draw" // Message to display in the alert what the messsage will display
    
    // Initialize the game board and reset scores
    init() { //Swift init() Initialization is the process of preparing an instance of a class, structure, or enumeration for use.-----> Source Digital Ocean
        resetBoard()
    }
    
    // Returns a string indicating wheter whos  turn it is ("Turn: X" or "Turn: O")
    func turnText() -> String {
        return turn == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    // Places a tile (Cross or Nought) on the board at the specified row and column whicj the user clocks
    func placeTile(_ row: Int, _ column: Int) { // if there is a tile there it wont work
        // Check if the cell is already occupied
        if board[row][column].tile != Tile.Empty {
            return // If occupied, do absolutley nothing nothing
        }
        
        // Place the current player's tile (Cross or Nought) in the cell
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        // Check for victory
        if checkForVictory() {
            // If there is a winner, update scores and show an alert
            if turn == Tile.Cross {
                crossesScore += 1
            } else {
                noughtsScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = "\(winner) Win!"
            showAlert = true
        } else {
            // If no winner, switch turns
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        
        // Check for draw
        if checkForDraw() {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    // Checks if the game board is full (no more empty cells)
    func checkForDraw() -> Bool {
        for row in board {
            for cell in row {
                if cell.tile == Tile.Empty {
                    return false // Found an empty cell, game is not a draw
                }
            }
        }
        return true // No empty cells found, game is a draw
    }
    
    // Checks if the current player has won the game
    func checkForVictory() -> Bool {
        // Vertical victory
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0) {
            return true
        }
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1) {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2) {
            return true
        }
        
        // Horizontal victory
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2) {
            return true
        }
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2) {
            return true
        }
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2) {
            return true
        }
        
        // Diagonal victory
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2) {
            return true
        }
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0) {
            return true
        }
        
        return false // No victory condition met
    }
    
    // Helper function to check if a specific cell matches the current turn
    func isTurnTile(_ row: Int, _ column: Int) -> Bool {
        return board[row][column].tile == turn
    }
    
    // Resets the game board to empty cells
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...2 {
            var row = [Cell]()
            for _ in 0...2 {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        
        board = newBoard
    }
}
