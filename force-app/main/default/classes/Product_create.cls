public class Product_create {
    public static void createPro(){
 list<Product2> opt= new list<Product2>();
    
        for(integer i=0;i<10;i++){
         //  Product Names, Discrption & Family 
            Product2 pro = new Product2();
            pro.Name='Electronics';
            pro.Description='Offer is on';
            pro.Family='Hardware';
            opt.add(pro);
        }
        insert opt;
        system.debug(opt);
    }
    }