import SwiftUI

struct ContentView: View {
    @StateObject var gameState = GameState()
    var body: some View {
        var borderSize = CGFloat(5)
        
        VStack (spacing: borderSize)
        {
            
            ForEach(0...2, id: \.self)
            {
                row in
                HStack(spacing: borderSize){
                    ForEach(0...2, id: \.self)
                    {
                        column in
                        
                        let cell = gameState.board[row][column] //finding the position by passing it throught the row and the column
                        Text(cell.displayTile())
                            .font(.system(size: 60))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture
                            {
                                gameState.placeTile(row, column)
                            }

                    }

                }
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert)
        {
            Alert(
                title: Text(.gameState.alertMessage)
                dismissButton: .default(Text("Okay"))
            )
            {
                gameState.resetBoard()
            }
        }
}

#Preview {
    ContentView()
}
    
