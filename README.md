
# Kaça Satar?

Bu Proje Kaçasatar API ile geliştirilmiş bir otomobil değeri hesaplama uygulamasıdır.

  
## Teknolojiler

- Swift UIKit
- SwiftUI
- MVVM
- RxSwift
- RxCocoa

## Detaylar
- Uygulama genel olarak UIKit ile geliştirildi sadece son sayfada SwiftUI Kullanıldı.
- MVVM mimari ile geliştirildi.
- Network Layer oluşturulurken Swagger Editor kullanıldı.
- TrimsListViewController da RxSwift ile değil Delegate ve Datasource ile ilerlendi.
- TrimsListViewController da her özellik seçildiğinde bir alt özelliği güncelliyor ve karşısına ona göre dataları çıkartıyor.
- Dark/Light moda uygun geliştirildi.
- Gösterimlerde KM ve Fiyat verileri formatlandı.
- Extensionlar kullanıldı.
- BaseViewController ve BaseViewModel kullanıldı.
- Custom Objeler kullanıldı.

### Not 
- "expertise" datası için gerekli response'u kopyalayacak yer bulamadım ama true gönderince kabul ediyordu ben de o şekilde kullandım.


  
