# swiftProj
## get php server data through Http
```
<?php
$arr = array(array("id" => "1", "name" => "fanlj"),
	array("id" => "2", "name" => "fanlm"));
$ja = json_encode($arr, true);
echo $ja;
```
this is the php code, can be used as a http server throuh 
- php -S 0.0.0.0:8080

Firstly, define a struct to store the data,then use the Load function to get data from PHP server
```
struct Person: Identifiable, Codable {
    let id: String
    var name: String
}
func load() {
        guard let url = URL(string: "http://127.0.0.1:8080/pj.php") else {return}
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
```
