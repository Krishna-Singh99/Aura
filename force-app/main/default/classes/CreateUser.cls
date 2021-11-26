public class CreateUser {
//Write a program in Salesforce to create another System admin user in your dev org with your email. Register the user manually.
    public static void addUser(){
        try{
        Profile proId = new Profile();
        proId = [Select Id from Profile where Name = 'System Administrator' Limit 1];
        User usr = new User();
        usr.Alias = 'User2';
        usr.Email = 'krishna.kumar@cloudanalogy.com';
        usr.LastName = 'Singh';
        usr.DefaultGroupNotificationFrequency = 'N';
        usr.EmailEncodingKey = 'ISO-8859-1';
        usr.LanguageLocaleKey = 'en_Us';
        usr.LocaleSidKey = 'en_Us';
        usr.ProfileId = proId.id;
        usr.Username = 'karan6789@gmail.com';
        usr.UserPermissionsCallCenterAutoLogin = False;
        usr.UserPermissionsOfflineUser = False;
        usr.UserPermissionsMarketingUser = true;
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        insert usr;
        }
        catch(Exception e){
            system.debug(e.getCause());
        }
    }
}