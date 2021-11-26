public class Number_Reverse {
public static void reverse(){
integer num=1786;
    integer dublicate=num;
    integer rev = 0;
    while(num>0){
        rev=(rev*10)+math.mod(num,10);
        num/=10;
    }
    system.debug('Original number '+dublicate);
    system.debug('Reverse of it '+rev);
}
}