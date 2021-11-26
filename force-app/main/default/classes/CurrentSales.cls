public class CurrentSales {
    public static void displayCurrSF(){ 
       user usr=[Select Name,MobilePhone,Email from user where Email=:UserInfo.getUserEmail() limit 1];
       system.debug(usr.Name + ' '+ usr.Email + ' '+ usr.MobilePhone);
    }

}