import SwiftUI

// Define a structure ContentView that cronforms to the View protocol
struct ContentView: View {
    // Create a state object gameState of daya type GameState
    @StateObject var gameState = GameState()
    
    // Define the body of the view
    var body: some View {
        
        // Define a constant borderSize with a CGFloat value of 5
        let borderSize = CGFloat(5)
//        A CGFloat is a floating point however it deals with the User Interface or graphics relatied calculations
        
        // Display the text showing whose turn it is
        Text(gameState.turnText())
            .font(.title)
            .bold()
            .padding()
        
        Spacer() // Add a spacer to separate UI elements
        
        // Display the score for Crosses
        Text(String(format: "Crosses: %d", gameState.crossesScore))
            .font(.title)
            .bold()
            .padding()
        
        // VStack to display the game board
        //Vstack positions them in a vertical line
        VStack(spacing: borderSize) {
            // Loop through rows
            ForEach(0...2, id: \.self) { row in
                // HStack to display each row of the board
                HStack(spacing: borderSize) {
                    // Loop through columns
                    ForEach(0...2, id: \.self) { column in
                        // Get the current cell from the gameState
                        let cell = gameState.board[row][column]
                        
                        // Display the cell's content
                        Text(cell.displayTile())
                            .font(.system(size: 60))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile(row, column)
                                //YOutube tutorioal
                            }
                    }
                }
            }
        }
        .background(Color.black) // Set the background color of VStack
        .padding() // Add padding around the VStack
        
        // Show an alert if showAlert is true
        .alert(isPresented: $gameState.showAlert) {
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton: .default(Text("Okay")) {
                    gameState.resetBoard()
                }
            )
        }
        
        // Display the score for Noughts
        Text(String(format: "Noughts: %d", gameState.noughtsScore))
            .font(.title)
            .bold()
            .padding()
        
        Spacer() // Add another spacer to separate UI elements
    }
}

// PreviewProvider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
