import Foundation

class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var Turn = Tile.Cross
    @Published var noughtScore = 0
    @Published var crossScore = 0
    @Published var showAlert = false
    @Published var alertMessage  = "Draw"
    
    
    
    init()
    {
        resetBoard()
    }
    func placeTile(_ row: Int,_ column: Int)
    {
        if (board[row][column].tile != Tile.Empty)
        {
            return
        }
        board[row][column].tile = Turn == Tile.Cross ? Tile.Cross : Tile.Nought
        Turn = Turn == Tile.Cross ? Tile.Nought : Tile.Cross
        
        if(checkForVictory())
        {
            if(Turn == Tile.Cross)
            {
                crossScore += 1
            }
            else
            {
                noughtScore += 1
            }
            let winner = Turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            showAlert = true
        }
        
        else
        {
            Turn = Turn == Tile.Cross ? Tile.Nought : Tile.Cross

        }
        
    }
    
    
    
    func checkForVictory() -> Bool
    {
        // Vertical Victory
        if isturnTile(0, 0) && isturnTile(1, 0) && isturnTile(2, 0)
        {
            return true
        }
        
        if isturnTile(0, 0) && isturnTile(1, 0) && isturnTile(2, 0)
        {
            return true
        }

        if isturnTile(0, 2) && isturnTile(1, 2) && isturnTile(2, 2)
        {
            return true
        }
        //Horizontal Victory
        if isturnTile(0, 0) && isturnTile(0, 1) && isturnTile(0, 2)
        {
            return true
        }
        
        if isturnTile(1, 0) && isturnTile(1, 1) && isturnTile(1, 2)
        {
            return true
        }

        if isturnTile(2, 0) && isturnTile(2, 1) && isturnTile(2, 2)
        {
            return true
        }
        
        //Diagonal Victory
        if isturnTile(0, 0) && isturnTile(1, 1) && isturnTile(2, 2)
        {
            return true
        }
        
        if isturnTile(1, 2) && isturnTile(1, 1) && isturnTile(2, 0)
        {
            return true
        }

        if isturnTile(2, 0) && isturnTile(2, 1) && isturnTile(2, 2)
        {
            return true
        }
        
        
        
        return false
    }
    
    func isturnTile(_ row: Int,_ column: Int) -> Bool
    {
        return board[row][column].tile == Turn
    }
    
    func resetBoard()
    {
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2
            {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
