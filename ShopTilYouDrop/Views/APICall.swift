import SwiftUI

struct APICall: View {
    
    @EnvironmentObject var productDataQuery: ProductQueryController
    
    var body: some View {
            NavigationView {
//                List(productDataQuery.productDataQuery.search_results, id: \.title) { search_result in
//                    Text(search_result.title)
//                }
//                .navigationBarTitle("Product List")
            }
        }
    }


struct APICallView_Previews: PreviewProvider {
    static var previews: some View {
        APICall()
    }
}
