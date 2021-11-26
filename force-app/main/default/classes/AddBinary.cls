public class AddBinary {
    public static void binaryAddition(){
       //WAP to add two binary nos. '100101' & '0101101' which are in text format. 
        string str1 = '100101', str2 = '0101101' ;
        Integer num1 = Integer.valueOf(str1);
        list<Integer> num3 = new list<Integer>(num1);
       Integer num2 = Integer.valueOf(str2);
        list<Integer> num4 = new list<Integer>(num2);
        system.debug(num1+ ' ' + num2);
            Integer i = 0, carry=0;
        integer[] sum = new integer[20];
      //  try{
        while(num1 != 0 || num2 != 0){
            sum[i++] = Integer.valueOf(math.mod((math.mod(num1, 10)+ math.mod(num2, 10) + carry),2));
            carry = ((math.mod(num1, 10)+ math.mod(num2, 10) + carry)/2);
            num1 = num1/10;
            num2 = num2/10;
        }
   
        if(carry != 0 ){
            sum[i++] = carry;
        }
               i--;
        while(i>=0){
            system.debug('Output '+ sum[i--]);
        }
             //}
       // catch(Exception e) {
         //system.debug(e.getCause());
        // system.debug('Some error occured');     
   // }
    }        
}