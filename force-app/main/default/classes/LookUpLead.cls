public class LookUpLead {
    public static void lookUplead(){
        try{
        list<lead> ld = new list<lead>();
        for(integer i=0;i<3;i++){
            
            lead crtlead = new lead();
  
            crtlead.Company = 'LookupLead'+i;
            crtlead.LastName = 'Purwa'+i;
            ld.add(crtlead);
        }
        insert ld;
        list<Product2> pro = new list<Product2>();
        for(integer i=0;i<5;i++){
            Product2 proCrt = new Product2();
            proCrt.Name = 'LookupProduct'+i;
            proCrt.Lead__c = ld.get(0).id;
            pro.add(proCrt);
        }
        insert pro;
        }catch(Exception e){
            system.debug(e.getCause());
            system.debug(e.getLineNumber());
        }
    }
}