//
//  ContentView.swift
//  getPhp
//
//  Created by fanlj on 2024/3/1.
//

import SwiftUI
//import SwiftData

struct Person: Identifiable, Codable {
    let id: String
    var name: String
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State var personList = [Person]()
    
    var body: some View {
        VStack{
            Text("asdasd")
            
            List {
                ForEach (personList) { person in
                    HStack() {
                        Text(person.id )
                            .font(.title)
                        Text("\(person.name)")
                            .font(.title)
                    }
                }
            }.onAppear(perform: load)
        }
    }
    
    func load() {
        guard let url = URL(string: "http://127.0.0.1:8080/pj.php") else {return}
        //        <?php
        //        $arr = array(array("id" => "1", "name" => "fanlj"),
        //            array("id" => "2", "name" => "fanlm"));
        //        $ja = json_encode($arr, true);
        //        echo $ja;
        //返回的是数组
        //[{"id":"1","name":"fanlj"},{"id":"2","name":"fanlm"}]
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
               let result = try? jsonDecoder.decode([Person].self, from: data) {
                DispatchQueue.main.async{ //optiona ,可以去掉
                    self.personList = result
                }
            }
        }
        task.resume()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
