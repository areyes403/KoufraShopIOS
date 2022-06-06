

import UIKit
import SafariServices

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableNews: UITableView!
    //override metods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableNews.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NewsTableViewCell
        celda.lblTitle.text=itemsNews[indexPath.row].title
        celda.lblDescription.text=itemsNews[indexPath.row].description
        celda.lblAuth.text=itemsNews[indexPath.row].source
        let urlimagen = itemsNews[indexPath.row].image ?? ""
        celda.imgPhoto.cargarDesdeSitio(direcciones: urlimagen)
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemsNews[indexPath.row].url)
        urlMandar = itemsNews[indexPath.row].url
        tableNews.deselectRow(at: indexPath, animated: true)
        let url = URL(string: urlMandar ?? "")!
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        performSegue(withIdentifier: "goToShowNew", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToShowNew"{
            let objDestino = segue.destination as! ShowNewViewController
            objDestino.recibirUrl = urlMandar
            
        }
    }
    
    var news = [New]()
    var itemsNews: [New] = []
    var urlMandar :String?


    override func viewDidLoad() {
        super.viewDidLoad()
        tableNews.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tableNews.delegate=self
        tableNews.dataSource=self
        let urlString="http://api.mediastack.com/v1/news?access_key=829d5d596227383b51d44778fc0e5dc6"
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                //print(data)
                analizarJSON(json: data)
            }
        }
    }

    
    // Do any additional setup after loading the view.
    func analizarJSON(json:Data){
        print("Estoy en analizar json")
        let decodificador = JSONDecoder()
        print(decodificador)
        if let datosDecodificados = try? decodificador.decode(News.self, from: json){
            itemsNews = datosDecodificados.data
            //print("Los articulos son: \(datosDecodificados.data.count)")
            //print("Los articulos son: \(datosDecodificados.data)")
        }
    }
    
    
    
    //Structs to create a table
    struct News: Codable {
        var data: [New]
    }

    struct New: Codable {
        var title: String?
        var description: String?
        var image: String?
        var url: String?
        var source: String?
    }

}


extension UIImageView{
    func cargarDesdeSitio(direcciones: String) {
        guard let url = URL(string: direcciones) else {return}
        
        DispatchQueue.main.async {
            if let imagenData = try? Data(contentsOf: url){
                if let imagenCargada = UIImage(data: imagenData){
                    self.image = imagenCargada
                }
            }
        }
    }
}
