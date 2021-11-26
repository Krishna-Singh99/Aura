public class DifferenceInDateAndTime {
	public static void difference()
    {
        Datetime BegDateTime = DateTime.newInstance(2016,1,2,6,7,55);
        
        Datetime EndDateTime = DateTime.newInstance(2016,2,5,7,8,55);
        
        decimal minutes = Integer.valueOf((EndDateTime.getTime() - BegDateTime.getTime())/(1000*60));
        
        decimal Seconds = Integer.valueOf(minutes*60);
        
        decimal Hours = Integer.valueOf((EndDateTime.getTime() - BegDateTime.getTime())/(1000*60*60));
        
        decimal Days = Integer.valueOf((EndDateTime.getTime() - BegDateTime.getTime())/(1000*60*60*24));
        
        decimal Month = Integer.valueOf(Days/30);
        
        decimal Year = Integer.valueOf(Month/12);
        
        
		System.debug('Difference :- '+Year+' year '+Month+' months '+Days+' Days '+Hours+' Hours '+minutes+' minutes '+Seconds+' Seconds');
    }
}