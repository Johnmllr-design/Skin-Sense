//
//  ContentView.swift
//  Skin Sense
//
//  Created by John Miller on 9/9/25.
//

import SwiftUI





// post_user_info for posting the user information to the backend for
// verification, and then returns an error or



func post_user_info(user_name: String, pass_word: String) async -> Bool {
    
    let endpoint = "http://127.0.0.1:8000/login"   // or "http://localhost:8000/login"

    // make a URL object from the endpoint string
    guard let url = URL(string: endpoint) else {
        print("Bad url")
        return false
    }

    // make a body dictionary with the key information
    let body: [String: Any] = ["username": user_name, "password": pass_word]

    // convert the dictionary to a JSONserialization
    guard let json = try? JSONSerialization.data(withJSONObject: body) else {
        print("json serialization failed")
        return false
    }

    // make a request objectfrom the url object
    var req = URLRequest(url: url)

    // establish the request hyperparameters
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = json

    // send and recieve API data
    guard let (data, _) = try? await URLSession.shared.data(for: req) else {return false}
    // decode the Data object into a dictionary with optionals
    guard let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
        return false
    }
    let result = (dict["result"] as? Int) == 1
    print("the resulting login request is ", result)
    return result
    
}

struct ContentView: View {
    @State var username:String = ""
    @State var password:String = ""
    @State var login_result:Bool = true
    @State var login_error:Bool = false
    @State private var path:NavigationPath = NavigationPath()
    
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                Rectangle().fill(Color.black)
                RoundedRectangle(cornerRadius: 15).fill(Color.white).frame(width: 370, height: 270) // Specifies the size
                VStack{
                    TextField("provide a username", text:$username).frame(width:300, height: 100)
                    TextField("provide a password", text:$password).frame(width:300, height: 100)
                    Button("Log in"){
                        Task{
                            login_result = await post_user_info(user_name: username, pass_word: password)
                            // if the login returns properly, log in
                            if login_result == true {
                                print("login result is ", login_result, " entering homescreen")
                                path.append("HomeScreen")
                                login_error = false
                            }else{
                                login_error = true
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: String.self){value in
                if value == "HomeScreen"{
                    HomeScreen()
                }
            }
            VStack{
                if login_error{
                    Text("erroneous login info")
                }
            }
        }
    }
}

struct HomeScreen: View {
    var body: some View{
        VStack{
            Text("Welcome to skin sense!!!")
        }
    }
}


#Preview {
    ContentView()
}
