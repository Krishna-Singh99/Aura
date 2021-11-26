/**
* @description      An apex class controller that exposes the signup functionality
*/
public without sharing class SignUpController {
    
    public static String accountId =''; 
    /**
* @description              An apex class controller that exposes password match functionality
*  @param password          password entered by user
*  @param confirmPassword   Confirmation password entered by user.
*  @return                  return a boolean value on the matching conditions of the two passwords.
*/
    @AuraEnabled
    public static boolean isValidPassword(String password, String confirmPassword) {
        return password == confirmPassword;
    }
    /**
* @description              An apex class controller that exposes password match functionality
*  @param u                 User trying to login
*  @param password          password entered by user
*  @param confirmPassword   Confirmation password entered by user.
*/
    @AuraEnabled 
    public static void validatePassword(User u, String password, String confirmPassword) {
        Site.validatePassword(u, password, confirmPassword);
    }
    /**
* @description              An apex class controller that register a new user
*  @param firstName         FirstName of the user.
*  @param lastName          lastName of the user.
*  @param email             email of the user.    
*  @param password          password entered by user
*  @param confirmPassword   Confirmation password entered by user.
*  @return                  A string based on the condition matched.
*/
    @AuraEnabled
    public static String registerUser(String firstName, String lastName, String email, String password, String confirmPassword){
        try {
            String response='',contactRole='';
            Boolean Primary=false;
            list<Contact> conList = [SELECT Id,AccountId,Account.Email_Domain__c,Contact_Role__c,Primary_Contact__c from Contact where Email=: email order by CreatedDate limit 1];
            System.debug('conList>>>>>'+conList);
            list<User> userList = [SELECT Id,Username from User where Username=: email WITH SECURITY_ENFORCED];
            System.debug('userList>>>>>'+userList);
            if(userList.isEmpty())
            {
                if(!conList.isEmpty())
                {
                    if(conList[0].Contact_Role__c != null){
                        contactRole = conList[0].Contact_Role__c;
                        Primary = conList[0].Primary_Contact__c;                      
                    }
                    String userName = email;
                    String extractEmail = email.split('@').get(1);
                    String emailDomainName = extractEmail.substringBeforeLast('.');
                    String nickname = ((firstname != null && firstname.length() > 0) ? firstname.substring(0,1) : '' ) + lastname.substring(0,1);
                    nickname += String.valueOf(Crypto.getRandomInteger()).substring(1,7);         
                    String contAccountName = conList[0].Account.Email_Domain__c;
                    if(emailDomainName == contAccountName)
                    {
                        accountId = conList[0].AccountId;
                    }
                    else {
                        list<Account> accList = [SELECT Id,Name,Email_Domain__c from Account where Email_Domain__c=: emailDomainName Limit 1];
                        if(!accList.isEmpty())
                        {
                            accountId = accList[0].Id;
                            conList[0].AccountId = accList[0].Id;
                            update conList;
                        }  
                    }
                    if(String.isNotBlank(accountId))
                    {
                        User u = new User();
                        u.Username = userName;
                        u.Email = email;
                        u.FirstName = firstName;
                        u.LastName = lastName;
                        u.CommunityNickname = nickname;
                        u.ContactId = conList[0].Id;    
                        if(contactRole.contains('Business') && Primary == True)
                        {
                            Profile prfId = [SELECT Id, Name FROM Profile where Name = 'Customer Community Plus Login User'];
                            u.ProfileID = prfId.Id;
                        }else{
                             Profile prfId = [SELECT Id, Name FROM Profile where Name = 'Customer Community Plus User'];
                            u.ProfileID = prfId.Id;
                        }
                        
                        if (!isValidPassword(password, confirmPassword)) {
                            return 'Password Do Not Match';
                        }
                        if(test.isRunningTest()){
                            String userId = Site.createPortalUser(u, accountId, password);
                            if (userId != null) 
                            { 
                                response = 'Valid';
                            }
                        }
                        else{
                            validatePassword(u, password, confirmPassword);  
                            String userId = Site.createPortalUser(u, accountId, password);
                            if (userId != null) 
                            { 
                                response = 'Valid';
                            }
                        }
                    }
                    else {
                        response ='Account Name Does Not exist for Contact';
                    }       
                }
                else {
                    response = 'No Contact';
                }
            }
            else {
                response = 'User Exist';
            }
            System.debug('response>>>Line 114>>>'+response);
            return response;
        } catch (Exception e) {
            System.debug('Erorr:::'+ e + e.getLineNumber());
            return null;
        }   
    }
    
}