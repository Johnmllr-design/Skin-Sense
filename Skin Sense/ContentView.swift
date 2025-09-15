//
//  ContentView.swift
//  Skin Sense
//
//  Created by John Miller on 9/9/25.
//

import SwiftUI





// post_user_info for posting the user information to the backend for
// verification, and then returns an error or
func post_user_info(user_name: String, pass_word: String) {
    
    print(user_name)
    print(pass_word)
    
    // make a dictionary of values and keys
    let JSON_dictionary: [String: Any] = ["username" : user_name, "password" : pass_word]
    
    // Convert dictionary to JSON object
    let json_data = try! JSONSerialization.data(withJSONObject: JSON_dictionary)
    guard let url = URL(string: "") else { return }
            
    
}

struct ContentView: View {
    @State var username:String = ""
    @State var password:String = ""
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.2))
            RoundedRectangle(cornerRadius: 15).fill(Color.red).frame(width: 400, height: 100)
            
            VStack{
                TextField("provide username", text:$username).padding()
                TextField("provide password", text:$password).padding()
                Button("login button"){
                    post_user_info(user_name : username, pass_word : password)
                }
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
