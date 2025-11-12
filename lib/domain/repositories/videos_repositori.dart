
import '../entities/Video.dart';


// Classe de repositori: Aquesta és la part a la que l'aplicació accedeix
// per consultar les dades.

// Generalment, el repositori es divideix en dues parts:
//  * Una a la capa de domini (aquesta), que defineix una classe abstracta
//    que descriu el comportament (els mètodes), i
//  * Una altra a la capa d'infrastructura, que serà on fem la implementació
//    d'aqueseta classe, segons la representació que tinguen les dades.

abstract class VideoRepository {
  
  Future<List<Video>> getVideos();


}
