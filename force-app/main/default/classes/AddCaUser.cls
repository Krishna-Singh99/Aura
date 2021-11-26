public class AddCaUser {
    public static void addUser(){
      list<Ca_User__c> causr = new list<Ca_User__c>();
        causr = [Select id,Joining_Date__c from  Ca_User__c limit 1];
        for(integer i=0;i<50;i++){
       
          Ca_User__c ur = new Ca_User__c();
        ur.Email__c = 'abcd'+i+'@gmail.com'; 
            ur.Name = 'User'+i;
            if(causr[0].Joining_Date__c == system.today()){
                ur.Active__c = True;
            }
            else{
                ur.Active__c = False;        
       }
            insert ur;
    }
    }
}