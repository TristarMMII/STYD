import SwiftUI

struct APICall: View {
    
    @EnvironmentObject var productDataQuery: ProductQueryController
    
    var body: some View {
            NavigationView {
                List(productDataQuery.productDataQuery.search_results, id: \.title) { searchResult in
                    Text(searchResult.title)
                }
                .navigationBarTitle("Product List")
            }
        }
    }


struct APICallView_Previews: PreviewProvider {
    static var previews: some View {
        APICall()
    }
}
