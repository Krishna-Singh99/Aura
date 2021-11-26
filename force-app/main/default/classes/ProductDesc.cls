public class ProductDesc {
    public static void OppDes(){
        list<Product2> opds= new  list<Product2>();
        opds = [SELECT Name,Description from Product2 where Description LIKE '%E%' ];
        if(opds!=null){
            for(Product2 acc:opds){
                system.debug('Result<<<<<<'+acc.Name+'<<'+acc.Description);
            }         
        }
        else{
            system.debug('Sorry, no data to show');
        }
    }
}