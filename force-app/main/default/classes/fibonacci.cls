public class fibonacci {
    public  fibonacci()
    {
        integer first=0,second=1,sum=0;
        system.debug(first);
        system.debug(second);
        for(integer i=1;i<=5;i++){
            sum=first+second;
            first=second;
            second=sum;
            system.debug(sum);
        }
    }
    
}