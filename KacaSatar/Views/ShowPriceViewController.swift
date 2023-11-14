//
//  ShowPriceViewController.swift
//  KacaSatar
//
//  Created by Ahmet Fahri Yener on 13.11.2023.
//

import SwiftUI

struct ShowPriceViewController: View {
    
    var carInfo = DataManager.shared.carInfo
    
    @ObservedObject var viewModel = ResultListViewModel()
    @State private var isLoading = false
    @State private var resultText = "Teklifimiz Hazırlanıyor..."
    
    init(viewModel: ResultListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .frame(alignment: .center)
                    .scaleEffect(2)
            }
            Section {
                VStack(alignment: .leading, spacing: 16.0, content: {
                    HStack(alignment: .top, spacing: 16.0, content: {
                        Text("Model Yılı:")
                        Text(carInfo.model ?? "-")
                    })
                    Divider().background(Color.primary)
                    HStack(alignment: .top, spacing: 21.0, content: {
                        Text("Marka ve \nKasa Tipi:")
                        Text(carInfo.makeAndModel)
                    })
                    Divider().background(Color.primary)
                    HStack(alignment: .top, spacing: 22.0, content: {
                        Text("Yakıt Tipi:")
                        Text(String(describing: carInfo.engine?.name ?? "-"))
                    })
                    Divider().background(Color.primary)
                    HStack(alignment: .top, spacing: 20.0, content: {
                        Text("Vites Tipi:")
                        Text(String(describing: carInfo.transmission?.name ?? "-"))
                    })
                    Divider().background(Color.primary)
                    HStack(alignment: .top, spacing: 52.0, content: {
                        Text("Renk:")
                        Text(String(describing: carInfo.color?.name ?? "-"))
                    })
                    Divider().background(Color.primary)
                    HStack(alignment: .top, spacing: 17.0, content: {
                        Text("Kilometre:")
                        Text(carInfo.kilometerage?.formatAsNumber() ?? "-")
                    })
                })
            }
            Section {
                VStack(alignment: .center, spacing: 16.0, content: {
                    Text("Teklifimiz")
                    Divider().background(Color.primary)
                    Text(resultText)
                })
            }
        }.onAppear {
            loadData()
        }
    }
    
    func loadData() {
        isLoading = true
        
        self.viewModel.fetchData { result in
            self.isLoading = false
            switch result {
            case .success(let data):
                if let price = data.price {
                    self.resultText = price.formattedString() + " TL"
                } else {
                    self.resultText = "Teklif bulunamadı :("
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
